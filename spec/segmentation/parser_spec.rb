# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr
include TwitterCldr::Parsers

describe 'Segmentation' do
  let(:parser) { Segmentation::Parser.new }

  def parse(tokens, options = {})
    parser.parse(tokens, options)
  end

  describe Segmentation::Parser do
    let(:symbol_table) do
      SymbolTable.new({
        "$FOO" => parser.tokenize_regex("[abc]")
      })
    end

    describe "#parse" do
      it "should parse a rule with a break" do
        rule = parse("[a-z] ÷ [0-9]")
        expect(rule.left.to_regexp_str).to eq("(?:[\\u{0061}-\\u{007a}])")
        expect(rule.right.to_regexp_str).to eq("(?:[\\u{0030}-\\u{0039}])")
        expect(rule.boundary_symbol).to eq(:break)
      end

      it "should parse a rule with a non-break" do
        rule = parse("[a-z] × [0-9]")

        expect(rule.left.to_regexp_str).to eq(
          "(?:[\\u{0061}-\\u{007a}])"
        )

        expect(rule.right.to_regexp_str).to eq(
          "(?:[\\u{0030}-\\u{0039}])"
        )

        expect(rule.boundary_symbol).to eq(:no_break)
      end

      it "should parse a rule containing a variable" do
        rule = parse("$FOO × bar", symbol_table: symbol_table)

        expect(rule.left.to_regexp_str).to eq(
          "(?:[\\u{0061}-\\u{0063}])"
        )

        expect(rule.right.to_regexp_str).to eq(
          "(?:\\u{0062})(?:\\u{0061})(?:\\u{0072})"
        )

        expect(rule.boundary_symbol).to eq(:no_break)
      end
    end
  end

  describe Segmentation::BreakRule do
    describe "#match" do
      let(:rule) { parse("[a-z] ÷ [0-9]") }

      it "rule should be the right type" do
        expect(rule).to be_a(Segmentation::BreakRule)
      end

      it "should match and return the right offset and text" do
        cursor = Segmentation::Cursor.new("c7")
        match = rule.match(cursor)
        expect(match.boundary_offset).to eq([0, 2])
        expect(match.boundary_position).to eq(1)
      end

      it "should not match if the input string doesn't contain a matching right- and/or left-hand side" do
        expect(rule.match(Segmentation::Cursor.new("C7"))).to be_nil
        expect(rule.match(Segmentation::Cursor.new("cc"))).to be_nil
        expect(rule.match(Segmentation::Cursor.new("CC"))).to be_nil
      end
    end
  end

  describe Segmentation::NoBreakRule do
    describe "#match" do
      let(:rule) { parse("[a-z] × [0-9]") }

      it "rule should be the right type" do
        expect(rule).to be_a(Segmentation::NoBreakRule)
      end

      it "should match and return the right offset and text" do
        match = rule.match(Segmentation::Cursor.new("c7"))
        expect(match.boundary_offset).to eq([0, 2])
        expect(match.boundary_position).to eq(1)
      end

      it "should not match if the input string doesn't contain matching text" do
        expect(rule.match(Segmentation::Cursor.new("C7"))).to be_nil
        expect(rule.match(Segmentation::Cursor.new("cc"))).to be_nil
        expect(rule.match(Segmentation::Cursor.new("CC"))).to be_nil
      end
    end
  end
end
