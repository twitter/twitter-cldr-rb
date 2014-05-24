# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

describe TwitterCldr::Utils::CodePoints do

  describe '#to_char' do
    it 'converts unicode code points to the actual character' do
      expect(TwitterCldr::Utils::CodePoints.to_char(0x221E)).to eq('∞')
    end
  end

  describe '#from_char' do
    it 'converts a character to a unicode code point' do
      expect(TwitterCldr::Utils::CodePoints.from_char('∞')).to eq(0x221E)
    end
  end

  describe '#to_chars' do
    it 'should handle an empty array' do
      expect(TwitterCldr::Utils::CodePoints.to_chars([])).to eq([])
    end

    it 'converts an array of unicode code points to an array of chars' do
      expect(TwitterCldr::Utils::CodePoints.to_chars([0x65, 0x73, 0x70])).to eq(%w[e s p])
    end
  end

  describe '#from_chars' do
    it 'should handle an empty array' do
      expect(TwitterCldr::Utils::CodePoints.from_chars([])).to eq([])
    end

    it 'converts an array of chars to an array of unicode code points' do
      expect(TwitterCldr::Utils::CodePoints.from_chars(%w[e s p])).to eq([0x65, 0x73, 0x70])
    end
  end

  describe '#to_string' do
    it 'should handle an empty array' do
      expect(TwitterCldr::Utils::CodePoints.to_string([])).to eq('')
    end

    it 'converts an array of unicode code points to a string' do
      expect(TwitterCldr::Utils::CodePoints.to_string([0x65, 0x73, 0x70, 0x61, 0xF1, 0x6F, 0x6C])).to eq('español')
    end
  end

  describe '#from_string' do
    it 'should handle an empty string' do
      expect(TwitterCldr::Utils::CodePoints.from_string('')).to eq([])
    end

    it 'converts a string into an array of unicode code points' do
      expect(TwitterCldr::Utils::CodePoints.from_string('español')).to eq([0x65, 0x73, 0x70, 0x61, 0xF1, 0x6F, 0x6C])
    end
  end

end