# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::DataReaders

describe NumberDataReader do
  let(:data_reader) { NumberDataReader.new(:en) }

  describe "#get_key_for" do
    it "builds a power-of-ten key based on the number of digits in the input" do
      (3..15).each do |i|
        value = data_reader.send(:get_key_for, "1337#{"0" * (i - 3)}")
        expect(value).to eq((10 ** i).to_s.to_sym)
      end
    end
  end

  describe '#format_number' do
    it 'works with options' do
      expect(data_reader.format_number(1000, precision: 2)).to eq('1,000.00')
    end

    it "works when options aren't specified" do
      expect(data_reader.format_number(1000)).to eq('1,000')
    end
  end

  describe "#pattern" do
    let(:symbols) { { nan: 'NaN', minus_sign: '<->' } } # unique locale-specific minus sign

    before(:each) do
      stub(TwitterCldr).get_locale_resource(:en, :numbers) {
        {
          en: {
            numbers: {
              formats: { decimal: { patterns: { default: "#,##0.###" } } },
              symbols: symbols
            }
          }
        }
      }
    end

    it "returns pattern for a number" do
      expect(data_reader.pattern(2)).to eq("#,##0.###")
    end

    it "returns pattern for a negative number" do
      expect(data_reader.pattern(-2)).to eq("<->#,##0.###")
    end
  end
end
