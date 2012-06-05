# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Shared

describe Numbers do
  describe "#symbols" do
    let(:symbols) { { :nan => 'NaN', :minus_sign => '-' } }

    it 'returns numerical symbols for default locale' do
      stub(TwitterCldr).get_locale { :jp }
      stub(TwitterCldr).get_locale_resource(:jp, :numbers) { { :jp => { :numbers => { :symbols => symbols } } } }
      Numbers.symbols.should == symbols
    end

    it 'returns numerical symbols for default locale' do
      stub(TwitterCldr).get_locale_resource(:np, :numbers) { { :np => { :numbers => { :symbols => symbols } } } }
      Numbers.symbols(:np).should == symbols
    end

    it 'converts locale' do
      stub(TwitterCldr).get_locale_resource(:'zh-Hant', :numbers) { { :'zh-Hant' => { :numbers => { :symbols => symbols } } } }
      Numbers.symbols('zh-tw').should == symbols
    end

    it 'returns nil if the resource is missing' do
      stub(TwitterCldr).get_locale_resource(:nop, :numbers) { nil }
      Numbers.symbols(:nop).should be_nil
    end
  end
end
