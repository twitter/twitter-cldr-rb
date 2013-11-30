# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Formatters

describe LongDecimalFormatter do
  let(:data_reader) { NumberDataReader.new(:en, :type => :long_decimal) }
  let(:formatter) { data_reader.formatter }
  let(:tokenizer) { data_reader.tokenizer }

  it "formats valid numbers correctly (from 10^3 - 10^15)" do
    expected = {
      10 ** 3 => "1 thousand",
      10 ** 4 => "10 thousand",
      10 ** 5 => "100 thousand",
      10 ** 6 => "1 million",
      10 ** 7 => "10 million",
      10 ** 8 => "100 million",
      10 ** 9 => "1 billion",
      10 ** 10 => "10 billion",
      10 ** 11 => "100 billion",
      10 ** 12 => "1 trillion",
      10 ** 13 => "10 trillion",
      10 ** 14 => "100 trillion"
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
    formatter.format(500).should == "500"
  end

  it "respects the :precision option" do
    @formatter.format(12345, :precision => 3).should match_normalized("12.345 thousand")
  end
end