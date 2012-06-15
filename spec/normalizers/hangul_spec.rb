# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Normalizers

describe Hangul do

  describe ".compose" do
    it 'composes decomposed Hangul syllable without a trailing consonant' do
      Hangul.compose([0x1101, 0x1167]).should == 0xAEF4
    end

    it 'composes decomposed Hangul syllable with a trailing consonant' do
      Hangul.compose([0x1111, 0x1171, 0x11B6]).should == 0xD4DB
    end
  end

  describe ".decompose" do
    it 'decomposes precomposed Hangul syllable without a trailing consonant' do
      Hangul.decompose(0xAEF4).should == [0x1101, 0x1167]
    end

    it 'decomposes precomposed Hangul syllable with a trailing consonant' do
      Hangul.decompose(0xD4DB).should == [0x1111, 0x1171, 0x11B6]
    end
  end

  describe '.hangul_syllable?' do
    it 'returns true for code points from Hangul syllables range' do
      [0xAC00, 0xAC01, 0xBC9F, 0xD7A1, 0xD7A3].map { |code_point| Hangul.hangul_syllable?(code_point).should be_true }
    end

    it 'returns false for other code points' do
      [0xAB, 0xABFF, 0xD7A4, 0xFFCF].map { |code_point| Hangul.hangul_syllable?(code_point).should be_false }
    end
  end

end