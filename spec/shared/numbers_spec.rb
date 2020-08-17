# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

describe TwitterCldr::Shared::Numbers do
  describe "#symbols" do
    let(:symbols) { { nan: 'NaN', minus_sign: '-' } }

    it 'returns numerical symbols for default locale' do
      allow(TwitterCldr).to receive(:locale).and_return(:ja)
      allow(TwitterCldr).to receive(:get_locale_resource).with(:ja, :numbers).and_return(ja: { numbers: { symbols: symbols } })
      expect(described_class.symbols).to eq(symbols)
    end

    it 'returns numerical symbols for default locale' do
      allow(TwitterCldr).to receive(:get_locale_resource).with(:np, :numbers).and_return(np: { numbers: { symbols: symbols } })
      expect(described_class.symbols(:np)).to eq(symbols)
    end

    it 'converts locale' do
      allow(TwitterCldr).to receive(:get_locale_resource).with(:'zh-Hant', :numbers).and_return(:'zh-Hant' => { numbers: { symbols: symbols } })
      expect(described_class.symbols('zh-tw')).to eq(symbols)
    end

    it 'returns nil if the resource is missing' do
      allow(TwitterCldr).to receive(:get_locale_resource).with(:nop, :numbers).and_return(nil)
      expect(described_class.symbols(:nop)).to be_nil
    end
  end
end
