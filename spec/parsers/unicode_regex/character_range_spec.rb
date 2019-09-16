# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

describe TwitterCldr::Parsers::UnicodeRegexParser::CharacterRange do
  let(:tokenizer) { TwitterCldr::Tokenizers::UnicodeRegexTokenizer.new }
  let(:parser) { TwitterCldr::Parsers::UnicodeRegexParser.new }

  def tokenize(str)
    tokenizer.tokenize(str)
  end

  def parse(tokens, options = {})
    parser.parse(tokens, options)
  end

  def char_range_from(elements)
    elements.first
  end

  describe "#to_set" do
    it "should return a range between the initial and the final values" do
      range = char_range_from(parse(tokenize("a-b")))
      expect(range.to_set.to_a(true)).to eq([97..98])
    end
  end

  describe "#codepoints" do
    it "lists all the codepoints in the range" do
      range = char_range_from(parse(tokenize("a-z")))
      expect(range.codepoints).to eq((97..122).to_a)
    end
  end
end
