# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

describe TwitterCldr::Parsers::UnicodeRegexParser::CharacterSet do
  describe "#to_set" do
    it "should return a set containing codepoints for the given general property" do
      char_set = described_class.new("Zs")
      expect(char_set.to_set.to_a(true)).to eq([
        32, 160, 5760, 8192..8202, 8239, 8287, 12288
      ])
    end

    it "should return a set containing codepoints for the given named property" do
      char_set = described_class.new("Sentence_Break=Sp")
      expect(char_set.to_set.to_a(true)).to eq([
        9, 11..12, 32, 160, 5760, 8192..8202, 8239, 8287, 12288
      ])
    end

    it "should return a set containing codepoints for the given script" do
      char_set = described_class.new('Katakana')
      expect(char_set.to_set.to_a(true)).to eq([
        12449..12538, 12541..12543, 12784..12799, 13008..13054, 13056..13143,
        65382..65391, 65393..65437, 110592, 110948..110951
      ])
    end

    it "should raise an exception when given an invalid property name or value" do
      expect do
        described_class.new("Foobar=Sp").to_set
      end.to raise_error(TwitterCldr::Parsers::UnicodeRegexParserError)

      expect do
        described_class.new("Sentence_Break=Foo").to_set
      end.to raise_error(TwitterCldr::Parsers::UnicodeRegexParserError)
    end
  end
end
