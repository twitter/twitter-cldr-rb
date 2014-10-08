# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Formatters

describe LongDecimalFormatter do
  let(:data_reader) do
    TwitterCldr::DataReaders::NumberDataReader.new(:en, :type => :long_decimal)
  end

  let(:formatter) { data_reader.formatter }
  let(:tokenizer) { data_reader.tokenizer }

  def format_number(number, options = {})
    pattern = data_reader.pattern(number)
    formatter.format(tokenizer.tokenize(pattern), number, options)
  end

  let(:expected) {
    {
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
  }

  it "formats valid numbers correctly (from 10^3 - 10^15)" do
    expected.each do |num, text|
      expect(format_number(num)).to eq(text)
    end
  end

  it "formats valid negative numbers correctly (from -10^15 - -10^3)" do
    expected.each do |num, text|
      expect(format_number(-num)).to eq("-#{text}")
    end
  end

  it "formats the number as if it were a straight decimal if it's >= 10^15" do
    expect(format_number(10**15)).to eq("1,000,000,000,000,000")
  end

  it "formats the number as if it were a straight decimal if it <= -10^15" do
    expect(format_number(- 10**15)).to eq("-1,000,000,000,000,000")
  end

  it "formats the number as if it were a straight decimal if it's < 1000" do
    expect(format_number(500)).to eq("500")
  end

  it "formats the number as if it were a straight decimal if it's > -1000" do
    expect(format_number(-500)).to eq("-500")
  end

  it "respects the :precision option" do
    expect(format_number(12345, :precision => 3)).to match_normalized("12.345 thousand")
  end

  it "respects the :precision option for negative numbers" do
    expect(format_number(-12345, :precision => 3)).to match_normalized("-12.345 thousand")
  end
end