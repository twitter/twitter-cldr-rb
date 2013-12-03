# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Formatters

describe ShortDecimalFormatter do
  let(:data_reader) { NumberDataReader.new(:en, :type => :short_decimal) }
  let(:formatter) { data_reader.formatter }
  let(:tokenizer) { data_reader.tokenizer }

  it "formats valid numbers correctly (from 10^3 - 10^15)" do
    expected = {
      10 ** 3 => "1K",
      10 ** 4 => "10K",
      10 ** 5 => "100K",
      10 ** 6 => "1M",
      10 ** 7 => "10M",
      10 ** 8 => "100M",
      10 ** 9 => "1B",
      10 ** 10 => "10B",
      10 ** 11 => "100B",
      10 ** 12 => "1T",
      10 ** 13 => "10T",
      10 ** 14 => "100T"
    }

    expected.each do |num, text|
      pattern = data_reader.pattern(num)
      formatter.format(tokenizer.tokenize(pattern), num).should == text
    end
  end

  it "formats the number as if it were a straight decimal if it exceeds 10^15" do
    number = 10**15
    pattern = data_reader.pattern(number)
    formatter.format(tokenizer.tokenize(pattern), number).should == "1,000,000,000,000,000"
  end

  it "formats the number as if it were a straight decimal if it's less than 1000" do
    number = 500
    pattern = data_reader.pattern(number)
    formatter.format(tokenizer.tokenize(pattern), number).should == "500"
  end

  it "respects the :precision option" do
    number = 12345
    pattern = data_reader.pattern(number)
    formatter.format(tokenizer.tokenize(pattern), number, :precision => 3).should match_normalized("12.345K")
  end
end