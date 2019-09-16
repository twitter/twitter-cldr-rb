# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

describe TwitterCldr::Parsers::UnicodeRegexParser do
  let(:tokenizer) { TwitterCldr::Tokenizers::UnicodeRegexTokenizer.new }
  let(:parser) { described_class.new }

  def tokenize(str)
    tokenizer.tokenize(str)
  end

  def parse(tokens, options = {})
    parser.parse(tokens, options)
  end

  describe "#parse" do
    it "identifies ranges" do
      elements = parse(tokenize("[a-z]"))
      expect(elements.first).to be_a(described_class::CharacterClass)
      root = elements.first.send(:root)
      expect(root).to be_a(described_class::CharacterRange)
      expect(root.initial.codepoints).to eq("a".unpack("U*"))
      expect(root.final.codepoints).to eq("z".unpack("U*"))
    end

    it "replaces variables" do
      symbol_table = TwitterCldr::Parsers::SymbolTable.new("$VAR" => tokenize("\\p{L}"))
      elements = parse(tokenize("($VAR)?"), symbol_table: symbol_table)
      expect(elements[1]).to be_a(described_class::CharacterSet)
      expect(elements[1].property_value).to eq("L")
    end

    it "handles character and negated character sets" do
      elements = parse(tokenize("\\p{L}[:^P:]\\P{L}[:P:]"))

      element = elements[0]
      expect(element).to be_a(described_class::CharacterSet)
      expect(element.property_value).to eq("L")

      element = elements[1]
      expect(element).to be_a(described_class::CharacterClass)
      expect(element.send(:root).child.property_value).to eq("P")
      expect(element.send(:root).operator).to eq(:negate)

      element = elements[2]
      expect(element).to be_a(described_class::CharacterClass)
      expect(element.send(:root).child.property_value).to eq("L")

      element = elements[3]
      expect(element).to be_a(described_class::CharacterSet)
      expect(element.property_value).to eq("P")
    end

    it "handles unicode characters" do
      elements = parse(tokenize("\\u0123"))
      expect(elements[0]).to be_a(described_class::UnicodeString)
      expect(elements[0].codepoints).to eq([291])
    end

    it "handles multichar and escaped unicode strings" do
      elements = parse(tokenize("\\g{abc}"))
      expect(elements[0]).to be_a(described_class::Literal)
      expect(elements[0].text).to eq("\\g")
      expect(elements[1]).to be_a(described_class::UnicodeString)
      expect(elements[1].codepoints).to eq([97, 98, 99])
    end

    it "handles special chars" do
      elements = parse(tokenize("^(?:)$"))
      elements.each { |elem| expect(elem).to be_a(described_class::Literal) }
      expect(elements[0].text).to eq("^")
      expect(elements[1].text).to eq("(")
      expect(elements[2].text).to eq("?")
      expect(elements[3].text).to eq(":")
      expect(elements[4].text).to eq(")")
      expect(elements[5].text).to eq("$")
    end
  end
end
