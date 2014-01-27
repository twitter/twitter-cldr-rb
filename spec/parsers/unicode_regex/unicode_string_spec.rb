# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Parsers

describe UnicodeRegexParser::UnicodeString do
  describe "#to_set" do
    it "should return a zero-length range when representing a single codepoint" do
      str = UnicodeRegexParser::UnicodeString.new([97])
      str.to_set.to_a.should == [97..97]
    end

    it "should return a range containing the codepoint array as both the first and last elements" do
      str = UnicodeRegexParser::UnicodeString.new([97, 98, 99])
      str.to_set.to_a.should == [[97, 98, 99]..[97, 98, 99]]
    end
  end
end
