# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Normalizers

describe Hangul do

  describe ".decompose" do
    it 'decomposes precomposed Hangul syllable without a trailing consonant' do
      Hangul.decompose(0xAEF4).should == [0x1101, 0x1167]
    end

    it 'decomposes precomposed Hangul syllable with a trailing consonant' do
      Hangul.decompose(0xD4DB).should == [0x1111, 0x1171, 0x11B6]
    end
  end

end