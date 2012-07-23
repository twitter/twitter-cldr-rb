# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

describe TwitterCldr::Utils::CodePoints do

  describe '#to_char' do
    it 'converts unicode code points to the actual character' do
      TwitterCldr::Utils::CodePoints.to_char(0x221E).should == '∞'
    end
  end

  describe '#from_char' do
    it 'converts a character to a unicode code point' do
      TwitterCldr::Utils::CodePoints.from_char('∞').should == 0x221E
    end
  end

  describe '#to_chars' do
    it 'should handle an empty array' do
      TwitterCldr::Utils::CodePoints.to_chars([]).should == []
    end

    it 'converts an array of unicode code points to an array of chars' do
      TwitterCldr::Utils::CodePoints.to_chars([0x65, 0x73, 0x70]).should == %w[e s p]
    end
  end

  describe '#from_chars' do
    it 'should handle an empty array' do
      TwitterCldr::Utils::CodePoints.from_chars([]).should == []
    end

    it 'converts an array of chars to an array of unicode code points' do
      TwitterCldr::Utils::CodePoints.from_chars(%w[e s p]).should == [0x65, 0x73, 0x70]
    end
  end

  describe '#to_string' do
    it 'should handle an empty array' do
      TwitterCldr::Utils::CodePoints.to_string([]).should == ''
    end

    it 'converts an array of unicode code points to a string' do
      TwitterCldr::Utils::CodePoints.to_string([0x65, 0x73, 0x70, 0x61, 0xF1, 0x6F, 0x6C]).should == 'español'
    end
  end

  describe '#from_string' do
    it 'should handle an empty string' do
      TwitterCldr::Utils::CodePoints.from_string('').should == []
    end

    it 'converts a string into an array of unicode code points' do
      TwitterCldr::Utils::CodePoints.from_string('español').should == [0x65, 0x73, 0x70, 0x61, 0xF1, 0x6F, 0x6C]
    end
  end

end