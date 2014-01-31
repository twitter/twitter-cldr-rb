# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Parsers
include TwitterCldr::Tokenizers

describe "Segmentation" do
  let(:tokenizer) { SegmentationTokenizer.new }
  let(:parser) { SegmentationParser.new }

  def tokenize(str)
    tokenizer.tokenize(str)
  end

  def parse(tokens, options = {})
    parser.parse(tokens, options)
  end

  describe SegmentationParser do
    let(:symbol_table) do
      SymbolTable.new({
        "$FOO" => tokenize("[abc]")
      })
    end

    describe "#parse" do
      it "should parse a rule with a break" do
        rule = parse(tokenize("[a-z] ÷ [0-9]"))
        rule.left.to_regexp_str.should == "\\A(?:[\\141-\\172])"
        rule.right.to_regexp_str.should == "\\A(?:[\\60-\\71])"
        rule.boundary_symbol.should == :break
      end

      it "should parse a rule with a non-break" do
        rule = parse(tokenize("[a-z] × [0-9]"))
        rule.regex.to_regexp_str.should == "\\A(?:[\\141-\\172])(?:[\\60-\\71])"
        rule.boundary_symbol.should == :no_break
      end

      it "should parse a rule containing a variable" do
        rule = parse(tokenize("$FOO × bar"), :symbol_table => symbol_table)
        rule.regex.to_regexp_str.should == "\\A(?:[\\141-\\143])(?:\\142)(?:\\141)(?:\\162)"
        rule.boundary_symbol.should == :no_break
      end
    end
  end

  describe SegmentationParser::BreakRule do
    describe "#match" do
      let(:rule) { parse(tokenize("[a-z] ÷ [0-9]")) }

      it "rule should be the right type" do
        rule.should be_a(SegmentationParser::BreakRule)
      end

      it "should match and return the right offset and text" do
        match = rule.match("c7")
        match.boundary_offset.should == 1
        match.text.should == "c7"
      end

      it "should not match if the input string doesn't contain a matching right- and/or left-hand side" do
        rule.match("C7").should be_nil
        rule.match("cc").should be_nil
        rule.match("CC").should be_nil
      end
    end
  end

  describe SegmentationParser::NoBreakRule do
    describe "#match" do
      let(:rule) { parse(tokenize("[a-z] × [0-9]")) }

      it "rule should be the right type" do
        rule.should be_a(SegmentationParser::NoBreakRule)
      end

      it "should match and return the right offset and text" do
        match = rule.match("c7")
        # non-break rules send you to the end of the match (maybe that's wrong?)
        match.boundary_offset.should == 2
        match.text.should == "c7"
      end

      it "should not match if the input string doesn't contain matching text" do
        rule.match("C7").should be_nil
        rule.match("cc").should be_nil
        rule.match("CC").should be_nil
      end
    end
  end
end
