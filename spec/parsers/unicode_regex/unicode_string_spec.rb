# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Parsers

describe UnicodeRegexParser::UnicodeString do
  describe "#to_set" do
    it "should return a zero-length range when representing a single codepoint" do
      str = UnicodeRegexParser::UnicodeString.new([97])
      expect(str.to_set.to_a).to eq([97..97])
    end

    it "should return a range containing the codepoint array as both the first and last elements" do
      str = UnicodeRegexParser::UnicodeString.new([97, 98, 99])
      expect(str.to_set.to_a).to eq([[97, 98, 99]..[97, 98, 99]])
    end

    it "should covert the codepoints to a valid regex" do
      str = UnicodeRegexParser::UnicodeString.new(97)
      expect(str.to_regexp_str).to eq("(?:\\u{0061})")
    end
  end
end
