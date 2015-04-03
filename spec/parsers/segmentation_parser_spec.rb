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
        expect(rule.left.to_regexp_str).to eq("\\A(?:[\\u{0061}-\\u{007a}])")
        expect(rule.right.to_regexp_str).to eq("\\A(?:[\\u{0030}-\\u{0039}])")
        expect(rule.boundary_symbol).to eq(:break)
      end

      it "should parse a rule with a non-break" do
        rule = parse(tokenize("[a-z] × [0-9]"))
        expect(rule.regex.to_regexp_str).to eq(
          "\\A(?:[\\u{0061}-\\u{007a}])(?:[\\u{0030}-\\u{0039}])"
        )
        expect(rule.boundary_symbol).to eq(:no_break)
      end

      it "should parse a rule containing a variable" do
        rule = parse(tokenize("$FOO × bar"), :symbol_table => symbol_table)
        expect(rule.regex.to_regexp_str).to eq(
          "\\A(?:[\\u{0061}-\\u{0063}])(?:\\u{0062})(?:\\u{0061})(?:\\u{0072})"
        )
        expect(rule.boundary_symbol).to eq(:no_break)
      end
    end
  end

  describe SegmentationParser::BreakRule do
    describe "#match" do
      let(:rule) { parse(tokenize("[a-z] ÷ [0-9]")) }

      it "rule should be the right type" do
        expect(rule).to be_a(SegmentationParser::BreakRule)
      end

      it "should match and return the right offset and text" do
        match = rule.match("c7")
        expect(match.boundary_offset).to eq(1)
        expect(match.text).to eq("c7")
      end

      it "should not match if the input string doesn't contain a matching right- and/or left-hand side" do
        expect(rule.match("C7")).to be_nil
        expect(rule.match("cc")).to be_nil
        expect(rule.match("CC")).to be_nil
      end
    end
  end

  describe SegmentationParser::NoBreakRule do
    describe "#match" do
      let(:rule) { parse(tokenize("[a-z] × [0-9]")) }

      it "rule should be the right type" do
        expect(rule).to be_a(SegmentationParser::NoBreakRule)
      end

      it "should match and return the right offset and text" do
        match = rule.match("c7")
        # non-break rules send you to the end of the match (maybe that's wrong?)
        expect(match.boundary_offset).to eq(2)
        expect(match.text).to eq("c7")
      end

      it "should not match if the input string doesn't contain matching text" do
        expect(rule.match("C7")).to be_nil
        expect(rule.match("cc")).to be_nil
        expect(rule.match("CC")).to be_nil
      end
    end
  end
end
