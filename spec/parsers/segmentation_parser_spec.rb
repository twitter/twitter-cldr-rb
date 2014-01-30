# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Parsers
include TwitterCldr::Tokenizers

describe SegmentationParser do
  let(:tokenizer) { SegmentationTokenizer.new }
  let(:parser) { SegmentationParser.new }
  let(:symbol_table) do
    SymbolTable.new({
      "$FOO" => tokenize("[abc]")
    })
  end

  def tokenize(str)
    tokenizer.tokenize(str)
  end

  def parse(tokens, options = {})
    parser.parse(tokens, options)
  end

  describe "#parse" do
    it "should parse a rule with a break" do
      seg = parse(tokenize("[a-z] ÷ [0-9]"))
      seg.left.to_regexp_str.should == "\\A(?:[\\141-\\172])"
      seg.right.to_regexp_str.should == "\\A(?:[\\60-\\71])"
      seg.boundary_symbol.should == :break
    end

    it "should parse a rule with a non-break" do
      seg = parse(tokenize("[a-z] × [0-9]"))
      seg.regex.to_regexp_str.should == "\\A(?:[\\141-\\172])(?:[\\60-\\71])"
      seg.boundary_symbol.should == :no_break
    end

    it "should parse a rule containing a variable" do
      seg = parse(tokenize("$FOO × bar"), :symbol_table => symbol_table)
      seg.regex.to_regexp_str.should == "\\A(?:[\\141-\\143])(?:\\142)(?:\\141)(?:\\162)"
      seg.boundary_symbol.should == :no_break
    end
  end
end
