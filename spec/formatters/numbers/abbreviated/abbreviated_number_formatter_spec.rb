# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Formatters
include TwitterCldr::Tokenizers

describe AbbreviatedNumberFormatter do
  let(:formatter) { AbbreviatedNumberFormatter.new(locale: :en) }
  let(:number) { 123456 }

  describe "#truncate_number" do
    let(:number) { 1234 }

    def truncate(number, decimal_digits)
      formatter.send(:truncate_number, number, decimal_digits)
    end

    it "truncates the number based on number of decimal digits requested" do
      expect(truncate(number, 1)).to eq(1.234)
      expect(truncate(number, 2)).to eq(12.34)
      expect(truncate(number, 3)).to eq(123.4)
      expect(truncate(number, 4)).to eq(1234)
      expect(truncate(number, 5)).to eq(1234)
      expect(truncate(number, 6)).to eq(1234)
    end

    it "returns the original number if less than 10^3" do
      expect(truncate(999, 3)).to eq(999)
    end

    it "returns the original number if greater than 10^15" do
      expect(truncate(10 ** 15, 3)).to eq(10 ** 15)
    end
  end
end