# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Parsers
include TwitterCldr::Tokenizers

describe UnicodeRegexParser do
  let(:tokenizer) { UnicodeRegexTokenizer.new }
  let(:parser) { UnicodeRegexParser.new }

  def tokenize(str)
    tokenizer.tokenize(str)
  end

  def parse(tokens, options = {})
    parser.parse(tokens, options)
  end

  describe "#parse" do
    it "identifies ranges" do
      elements = parse(tokenize("[a-z]"))
      elements.first.should be_a(UnicodeRegexParser::CharacterClass)
      root = elements.first.send(:root)
      root.should be_a(UnicodeRegexParser::CharacterRange)
      root.initial.codepoints.should == "a".unpack("U*")
      root.final.codepoints.should == "z".unpack("U*")
    end

    it "replaces variables" do
      symbol_table = SymbolTable.new("$VAR" => tokenize("\\p{L}"))
      elements = parse(tokenize("($VAR)?"), :symbol_table => symbol_table)
      elements[1].should be_a(UnicodeRegexParser::CharacterSet)
      elements[1].property_value.should == "L"
    end

    it "handles character and negated character sets" do
      elements = parse(tokenize("\\p{L}[:^P:]\\P{L}[:P:]"))

      element = elements[0]
      element.should be_a(UnicodeRegexParser::CharacterSet)
      element.property_value.should == "L"

      element = elements[1]
      element.should be_a(UnicodeRegexParser::CharacterClass)
      element.send(:root).child.property_value.should == "P"
      element.send(:root).operator.should == :negate

      element = elements[2]
      element.should be_a(UnicodeRegexParser::CharacterClass)
      element.send(:root).child.property_value.should == "L"

      element = elements[3]
      element.should be_a(UnicodeRegexParser::CharacterSet)
      element.property_value.should == "P"
    end

    it "handles unicode characters" do
      elements = parse(tokenize("\\u0123"))
      elements[0].should be_a(UnicodeRegexParser::UnicodeString)
      elements[0].codepoints.should == [291]
    end

    it "handles multichar and escaped unicode strings" do
      elements = parse(tokenize("\\g{abc}"))
      elements[0].should be_a(UnicodeRegexParser::Literal)
      elements[0].text.should == "\\g"
      elements[1].should be_a(UnicodeRegexParser::UnicodeString)
      elements[1].codepoints.should == [97, 98, 99]
    end

    it "handles special chars" do
      elements = parse(tokenize("^(?:)$"))
      elements.each { |elem| elem.should be_a(UnicodeRegexParser::Literal) }
      elements[0].text.should == "^"
      elements[1].text.should == "("
      elements[2].text.should == "?"
      elements[3].text.should == ":"
      elements[4].text.should == ")"
      elements[5].text.should == "$"
    end
  end
end
