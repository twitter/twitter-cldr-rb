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
      regex = parse(tokenize("[a-z]"))
      regex.elements.first.should be_a(UnicodeRegexParser::CharacterClass)
      root = regex.elements.first.send(:root)
      root.should be_a(UnicodeRegexParser::CharacterRange)
      root.initial.codepoints.should == "a".unpack("U*")
      root.final.codepoints.should == "z".unpack("U*")
    end

    it "replaces variables" do
      symbol_table = SymbolTable.new("$VAR" => tokenize("\\p{L}"))
      regex = parse(tokenize("($VAR)?"), :symbol_table => symbol_table)
      regex.elements[1].should be_a(UnicodeRegexParser::CharacterSet)
      regex.elements[1].property_value.should == "L"
    end

    it "handles character and negated character sets" do
      regex = parse(tokenize("\\p{L}[:^P:]\\P{L}[:P:]"))

      element = regex.elements[0]
      element.should be_a(UnicodeRegexParser::CharacterSet)
      element.property_value.should == "L"

      element = regex.elements[1]
      element.should be_a(UnicodeRegexParser::CharacterClass)
      element.send(:root).child.property_value.should == "P"
      element.send(:root).operator.should == :negate

      element = regex.elements[2]
      element.should be_a(UnicodeRegexParser::CharacterClass)
      element.send(:root).child.property_value.should == "L"

      element = regex.elements[3]
      element.should be_a(UnicodeRegexParser::CharacterSet)
      element.property_value.should == "P"
    end

    it "handles unicode characters" do
      regex = parse(tokenize("\u0123"))
      regex.elements[0].should be_a(UnicodeRegexParser::UnicodeString)
      regex.elements[0].codepoints.should == [291]
    end

    it "handles multichar and escaped unicode strings" do
      regex = parse(tokenize("\\g{abc}"))
      regex.elements[0].should be_a(UnicodeRegexParser::Literal)
      regex.elements[0].text.should == "\\g"
      regex.elements[1].should be_a(UnicodeRegexParser::UnicodeString)
      regex.elements[1].codepoints.should == [97, 98, 99]
    end

    it "handles special chars" do
      regex = parse(tokenize("^(?:)$"))
      regex.elements.each { |elem| elem.should be_a(UnicodeRegexParser::Literal) }
      regex.elements[0].text.should == "^"
      regex.elements[1].text.should == "("
      regex.elements[2].text.should == "?"
      regex.elements[3].text.should == ":"
      regex.elements[4].text.should == ")"
      regex.elements[5].text.should == "$"
    end
  end
end
