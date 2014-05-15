# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Formatters

describe AbbreviatedNumberFormatter do
  let(:formatter) { AbbreviatedNumberFormatter.new(:locale => :en) }

  describe "#transform_number" do
    it "chops off the number to the necessary number of sig figs" do
      expect(formatter.send(:transform_number, 10 ** 3)).to eq(1)
      expect(formatter.send(:transform_number, 10 ** 4)).to eq(10)
      expect(formatter.send(:transform_number, 10 ** 5)).to eq(100)
      expect(formatter.send(:transform_number, 10 ** 6)).to eq(1)
      expect(formatter.send(:transform_number, 10 ** 7)).to eq(10)
      expect(formatter.send(:transform_number, 10 ** 8)).to eq(100)
      expect(formatter.send(:transform_number, 10 ** 9)).to eq(1)
      expect(formatter.send(:transform_number, 10 ** 10)).to eq(10)
      expect(formatter.send(:transform_number, 10 ** 11)).to eq(100)
      expect(formatter.send(:transform_number, 10 ** 12)).to eq(1)
      expect(formatter.send(:transform_number, 10 ** 13)).to eq(10)
      expect(formatter.send(:transform_number, 10 ** 14)).to eq(100)
    end

    it "returns the original number if greater than 10^15" do
      expect(formatter.send(:transform_number, 10 ** 15)).to eq(10 ** 15)
    end

    it "returns the original number if less than 10^3" do
      expect(formatter.send(:transform_number, 999)).to eq(999)
    end
  end
end