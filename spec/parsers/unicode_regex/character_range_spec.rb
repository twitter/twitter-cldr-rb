# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Parsers

describe UnicodeRegexParser::CharacterRange do
  describe "#to_set" do
    it "should return a range between the initial and the final values" do
      range = UnicodeRegexParser::CharacterRange.new(
        UnicodeRegexParser::UnicodeString.new([97]),
        UnicodeRegexParser::UnicodeString.new([98])
      )

      expect(range.to_set.to_a(true)).to eq([97..98])
    end
  end
end
