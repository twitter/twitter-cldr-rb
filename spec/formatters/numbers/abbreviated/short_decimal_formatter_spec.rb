# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Formatters

describe ShortDecimalFormatter do
  let(:data_reader) do
    TwitterCldr::DataReaders::NumberDataReader.new(locale, type: :short_decimal)
  end

  def format_number(number, options = {})
    data_reader.format_number(number, options)
  end

  context "with English locale" do
    let(:locale) { :en }
    let(:expected) {
      {
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
    }

    it "formats valid numbers correctly (from 10^3 - 10^15)" do
      expected.each do |num, text|
        expect(format_number(num)).to eq(text)
        expect(format_number(-num)).to eq("-#{text}")
      end
    end

    it "formats valid negative numbers correctly (from -10^15 - -10^3)" do
      expected.each do |num, text|
        expect(format_number(-num)).to eq("-#{text}")
      end
    end

    it "formats the number as if it were a straight decimal if it's >= 10^15" do
      number = 10 ** 15
      expect(format_number(number)).to eq("1,000,000,000,000,000")
    end

    it "formats the number as if it were a straight decimal if it's <= -10^15" do
      number = - 10 ** 15
      expect(format_number(number)).to eq("-1,000,000,000,000,000")
    end

    it "formats the number as if it were a straight decimal if it's < 1000" do
      number = 500
      expect(format_number(number)).to eq("500")
    end

    it "formats the number as if it were a straight decimal if it's > -1000" do
      number = -500
      expect(format_number(number)).to eq("-500")
    end

    it "respects the :precision option" do
      number = 12345
      expect(format_number(number, precision: 3)).to match_normalized("12.345K")
    end

    it "respects the :precision option for negative numbers" do
      number = -12345
      expect(format_number(number, precision: 3)).to match_normalized("-12.345K")
    end
  end

  context "with Japanese locale" do
    let(:locale) { :ja }

    it "formats numbers in terms of 'ten thousands'" do
      number = 93_000_000
      expect(format_number(number)).to match_normalized("9300万")
    end
  end

  context "with Russian locale" do
    let(:locale) { :ru }

    it "formats a number with a literal period" do
      number = 1_000
      expect(format_number(number)).to match_normalized("1 тыс.")
    end
  end

  context "with IT locale" do
    let(:locale) { :it }

    it "works when the pattern is 0" do
      expect(format_number(100_000)).to match_normalized("100000")
      expect(format_number(700_000)).to match_normalized("700000")
    end
  end

  xit 'respects pluralization rules'
end
