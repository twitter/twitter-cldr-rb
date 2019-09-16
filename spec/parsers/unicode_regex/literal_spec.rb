# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

describe TwitterCldr::Parsers::UnicodeRegexParser::Literal do
  describe "#to_set" do
    it "should return literal characters as codepoints" do
      literal = described_class.new("a")
      expect(literal.to_set.to_a(true)).to eq([97])
    end

    it "should return escaped characters with no special meaning as codepoints" do
      literal = described_class.new("\\a")
      expect(literal.to_set.to_a(true)).to eq([97])
    end

    it "should convert special regex switches to their range equivalents" do
      literal = described_class.new("\\d")  # digit
      expect(literal.to_set.to_a(true)).to eq([48..57])
    end

    it "should convert negated special regex switches to their range equivalents" do
      literal = described_class.new("\\D")  # NOT digit
      expect(literal.to_set.to_a(true)).to eq([
        0..1, 8..47, 58..55295, 57344..1114111
      ])
    end
  end
end
