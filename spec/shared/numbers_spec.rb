# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Shared

describe Numbers do
  describe "#symbols" do
    let(:symbols) { { nan: 'NaN', minus_sign: '-' } }

    it 'returns numerical symbols for default locale' do
      allow(TwitterCldr).to receive(:locale).and_return(:jp)
      allow(TwitterCldr).to receive(:get_locale_resource).with(:jp, :numbers).and_return(jp: { numbers: { symbols: symbols } })
      expect(TwitterCldr::Shared::Numbers.symbols).to eq(symbols)
    end

    it 'returns numerical symbols for default locale' do
      allow(TwitterCldr).to receive(:get_locale_resource).with(:np, :numbers).and_return(np: { numbers: { symbols: symbols } })
      expect(TwitterCldr::Shared::Numbers.symbols(:np)).to eq(symbols)
    end

    it 'converts locale' do
      allow(TwitterCldr).to receive(:get_locale_resource).with(:'zh-Hant', :numbers).and_return(:'zh-Hant' => { numbers: { symbols: symbols } })
      expect(TwitterCldr::Shared::Numbers.symbols('zh-tw')).to eq(symbols)
    end

    it 'returns nil if the resource is missing' do
      allow(TwitterCldr).to receive(:get_locale_resource).with(:nop, :numbers).and_return(nil)
      expect(TwitterCldr::Shared::Numbers.symbols(:nop)).to be_nil
    end
  end
end
