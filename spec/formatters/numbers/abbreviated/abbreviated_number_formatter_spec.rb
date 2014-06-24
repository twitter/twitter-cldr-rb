# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Formatters
include TwitterCldr::Tokenizers

describe AbbreviatedNumberFormatter do
  let(:formatter) { AbbreviatedNumberFormatter.new(:locale => :en) }
  let(:number) { 123456 }

  describe "#truncate_number" do
    let(:number) { 1234 }

    def truncate(number, integer_format)
      integer_formatter = Object.new
      stub(integer_formatter).format { integer_format }
      formatter.send(:truncate_number, number, integer_formatter)
    end

    it "truncates the number based on the integer format string" do
      expect(truncate(number, "0")).to eq(1.234)
      expect(truncate(number, "00")).to eq(12.34)
      expect(truncate(number, "000")).to eq(123.4)
      expect(truncate(number, "0000")).to eq(1234)
      expect(truncate(number, "00000")).to eq(1234)
      expect(truncate(number, "000000")).to eq(1234)
    end

    it "raises an exception if the format string is invalid" do
      expect { truncate(number, "00.00") }.to raise_error(ArgumentError)
    end

    it "returns the original number if less than 10^3" do
      expect(truncate(999, "000")).to eq(999)
    end

    it "returns the original number if greater than 10^15" do
      expect(truncate(10 ** 15, "000")).to eq(10 ** 15)
    end
  end
end