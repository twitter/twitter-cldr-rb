# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

describe TwitterCldr::DataReaders::NumberDataReader do
  let(:data_reader) { described_class.new(:en) }

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
      allow(TwitterCldr).to receive(:get_locale_resource).with(:en, :numbers) {
        {
          en: {
            numbers: {
              default_number_systems: {
                default: 'latn'
              },
              formats: { decimal: { latn: { default: "#,##0.###" } } },
              symbols: {
                latn: symbols
              }
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
