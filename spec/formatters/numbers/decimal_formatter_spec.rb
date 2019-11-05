# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

describe TwitterCldr::Formatters::DecimalFormatter do
  let(:data_reader) { TwitterCldr::DataReaders::NumberDataReader.new(:nl, type: :decimal) }
  let(:formatter) { data_reader.formatter }
  let(:tokenizer) { data_reader.tokenizer }
  let(:negative_number) { -12 }
  let(:number) { 12 }

  def format_number(number, options = {})
    data_reader.format_number(number, options)
  end

  describe "#format" do
    it "should format positive decimals correctly" do
      expect(format_number(number)).to eq("12")
    end

    it "should format negative decimals correctly" do
      expect(format_number(negative_number)).to eq("-12")
    end

    it "should respect the :precision option" do
      { number => "12,000", negative_number => "-12,000" }.each_pair do |num, formatted|
        expect(format_number(num, precision: 3)).to eq(formatted)
      end
    end
  end

  context 'short decimals' do
    let(:data_reader) do
      TwitterCldr::DataReaders::NumberDataReader.new(locale, type: :decimal, format: :short)
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
  end

  context 'long decimals' do
    let(:data_reader) do
      TwitterCldr::DataReaders::NumberDataReader.new(locale, type: :decimal, format: :long)
    end

    context "with English locale" do
      let (:locale) { :en }

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
        expect(format_number(12345, precision: 3)).to match_normalized("12.345 thousand")
      end

      it "respects the :precision option for negative numbers" do
        expect(format_number(-12345, precision: 3)).to match_normalized("-12.345 thousand")
      end
    end

    context "with Russian locale" do
      let(:locale) { :ru }

      it "respects pluralization rules" do
        expect(format_number(1123)).to match_normalized("1 тысяча")
        expect(format_number(1123, precision: 3)).to match_normalized("1,123 тысячи")
      end

      it 'works with :few in Russian' do
        expect(format_number(7123, precision: 3)).to match_normalized("7,123 тысячи")
        expect(format_number(7123)).to match_normalized("7 тысяч") # different pluralization when precision is 0
      end
    end

    context 'with Korean locale' do
      let(:locale) { :ko }

      it 'works for Korean' do
        expect(format_number(1_000_000)).to match_normalized("100만")
      end
    end

    context 'with BE locale' do
      let(:locale) { :be }

      it 'handles redirects' do
        expect(format_number(1_000_000)).to match_normalized("1 мільён")
      end
    end
  end
end
