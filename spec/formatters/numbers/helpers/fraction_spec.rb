# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Formatters::Numbers
include TwitterCldr::Tokenizers

describe Fraction do
  describe "#apply" do
    it "test: formats a fraction" do
      token = Token.new(value: '###.##', type: :pattern)
      expect(Fraction.new(token).apply('45')).to eq('.45')
    end

    it "test: pads zero digits on the right side" do
      token = Token.new(value: '###.0000#', type: :pattern)
      expect(Fraction.new(token).apply('45')).to eq('.45000')
    end

    it "test: :precision option overrides format precision" do
      token = Token.new(value: '###.##', type: :pattern)
      expect(Fraction.new(token).apply('78901', precision: 5)).to eq('.78901')
    end
  end
end