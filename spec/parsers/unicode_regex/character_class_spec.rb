# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Parsers
include TwitterCldr::Tokenizers

describe UnicodeRegexParser::CharacterClass do
  let(:tokenizer) { UnicodeRegexTokenizer.new }
  let(:parser) { UnicodeRegexParser.new }

  def tokenize(str)
    tokenizer.tokenize(str)
  end

  def parse(tokens, options = {})
    parser.parse(tokens, options)
  end

  def char_class_from(elements)
    elements.first
  end

  describe "#to_set" do
    it "unions together char classes with no explicit operator" do
      char_class = char_class_from(parse(tokenize("[[a][b]]")))
      expect(char_class.to_set.to_a).to eq([97..98])
    end

    it "unions together other entities within char classes when operator is not explicit" do
      char_class = char_class_from(parse(tokenize("[a-z0-9\\u0123]")))
      expect(char_class.to_set.to_a(true)).to eq([48..57, 97..122, 291])
    end

    it "intersects correctly" do
      char_class = char_class_from(parse(tokenize("[[a-m]&[g-z]]")))
      expect(char_class.to_set.to_a).to eq([103..109])
    end

    it "finds symmetric differences correctly" do
      char_class = char_class_from(parse(tokenize("[[a-m]-[g-z]]")))
      expect(char_class.to_set.to_a).to eq([97..102, 110..122])
    end

    it "computes sets for nested expressions" do
      # (97..109) U (104..106)
      # = (104..106)
      # ((104..106) U (107..122)) subtr ((104..106) C (107..122))
      # = (104..122) subtr ()
      # = (104..122)
      char_class = char_class_from(parse(tokenize("[[[a-m]&[h-j]]-[k-z]]")))
      expect(char_class.to_set.to_a).to eq([104..122])
    end

    it "pulls in ranges for unicode character sets" do
      char_class = char_class_from(parse(tokenize("[\\p{Zs}]")))
      expect(char_class.to_set.to_a(true)).to eq([
        32, 160, 5760, 6158, 8192..8202, 8239, 8287, 12288
      ])
    end

    it "computes unions between unicode character sets" do
      char_class = char_class_from(parse(tokenize("[[\\p{Zs}][\\p{Cc}]]")))
      expect(char_class.to_set.to_a(true)).to eq([
        0..1, 8..32, 127..160, 5760, 6158, 8192..8202, 8239, 8287, 12288
      ])
    end

    it "computes intersections between unicode character sets" do
      char_class = char_class_from(parse(tokenize("[[\\p{Zs}]&[\\u2000-\\u202B]]")))
      expect(char_class.to_set.to_a(true)).to eq([8192..8202])
    end

    it "supports negating character sets" do
      char_class = char_class_from(parse(tokenize("[^\\u2000-\\u202B]")))
      expect(char_class.to_set.to_a(true)).to eq([
        0..1, 8..8191, 8236..55295, 57344..1114111
      ])
    end

    it "supports literal and escaped characters" do
      char_class = char_class_from(parse(tokenize("[abc\\edf\\g]")))
      expect(char_class.to_set.to_a(true)).to eq([97..103])
    end

    it "supports special switch characters" do
      char_class = char_class_from(parse(tokenize("[\\w]")))  # a-z, A-Z, 0-9, _
      expect(char_class.to_set.to_a(true)).to eq([48..57, 65..90, 95, 97..122])
    end

    it "supports negated switch characters" do
      char_class = char_class_from(parse(tokenize("[\\D]")))  # i.e. NOT \w
      expect(char_class.to_set.to_a(true)).to eq([
        0..1, 8..47, 58..55295, 57344..1114111
      ])
    end
  end

  describe "#to_regexp_str" do
    it "wraps ranges in square brackets" do
      char_class = char_class_from(parse(tokenize("[a-z]")))
      expect(char_class.to_regexp_str).to eq("(?:[\\u{0061}-\\u{007a}])")
    end

    it "octal-encodes and wraps sequential characters to isolate bytes" do
      char_class = char_class_from(parse(tokenize("[{foo}]")))
      expect(char_class.to_regexp_str).to eq("(?:(?:\\u{0066})(?:\\u{006f})(?:\\u{006f}))")
    end

    it "combines multiple components with 'or' pipe characters" do
      char_class = char_class_from(parse(tokenize("[{foo}abc]")))
      expect(char_class.to_regexp_str).to eq(
        "(?:(?:\\u{0066})(?:\\u{006f})(?:\\u{006f})|[\\u{0061}-\\u{0063}])"
      )
    end
  end

  describe "#codepoints" do
    it "lists all the codepoints in a range" do
      char_class = char_class_from(parse(tokenize("[a-z]")))
      expect(char_class.codepoints).to eq((97..122).to_a)
    end

    it "lists all the codepoints in a union" do
      char_class = char_class_from(parse(tokenize("[[abc][def]]")))
      expect(char_class.codepoints).to eq((97..102).to_a)
    end
  end
end
