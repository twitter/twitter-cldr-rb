# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Localized

describe LocalizedNumber do

  describe '#initialize' do
    let(:decimal)  { LocalizedNumber.new(10, :en) }
    let(:currency) { LocalizedNumber.new(10, :en, :type => :currency) }

    it 'uses nil type by default (defers decision to data reader)' do
      expect(decimal.type).to eq(nil)
    end

    it 'uses provided type if there is one' do
      expect(currency.type).to eq(:currency)
    end

    it 'sets up object with correct locale, falls back to default locale' do
      expect(LocalizedNumber.new(10, :es).locale).to eq(:es)
      expect(LocalizedNumber.new(10, :blarg).locale).to eq(TwitterCldr::DEFAULT_LOCALE)
    end
  end

  describe 'type conversion methods' do
    let(:number)   { LocalizedNumber.new(10, :en) }
    let(:currency) { LocalizedNumber.new(10, :en, :type => :currency) }

    LocalizedNumber.types.each do |type|
      describe "#to_#{type}" do
        let(:method) { "to_#{type}" }

        it 'creates a new object' do
          expect(number.send(method).object_id).not_to eq(number.object_id)
        end

        it 'creates an object of the appropriate type, but does not change the type of the original object' do
          new_number = currency.send(method)
          expect(new_number.type).to eq(type)
          expect(currency.type).to eq(:currency)
        end

        it 'creates a new object with the same base object and locale' do
          percent = LocalizedNumber.new(42, :fr, :type => :percent)
          new_percent = percent.send(method)
          expect(new_percent.locale).to eq(:fr)
          expect(new_percent.base_obj).to eq(42)
        end
      end
    end

    describe "to_short_decimal" do
      context "when the patter is missing" do
        it "returns the number as is" do
          expect(LocalizedNumber.new(7000, :af, :type => :short_decimal).to_s).to eq("7000")
        end
      end

      context "when the patter uses 'ten thousands' abbreviation" do
        it "formats the number properly" do
          expect(LocalizedNumber.new(93_000_000, :ja, :type => :short_decimal).to_s).to match_normalized("9300万")
        end
      end
    end

    describe "to_long_decimal" do
      context "when the patter is missing" do
        it "returns the number as is" do
          expect(LocalizedNumber.new(7000, :ko, :type => :long_decimal).to_s).to eq("7000")
        end
      end

      context "when the patter uses 'ten thousands' abbreviation" do
        it "formats the number properly" do
          expect(LocalizedNumber.new(93_000_000, :'zh-Hant', :type => :long_decimal).to_s).to match_normalized("9300萬")
        end
      end
    end
  end

  describe '#to_s' do
    it 'raises ArguemntError if unsupported type is passed' do
      expect do
        LocalizedNumber.new(10, :en, :type => :foo).to_s
      end.to raise_error(ArgumentError, 'Type foo is not supported')
    end

    context 'decimals' do
      let(:number) { LocalizedNumber.new(10, :en) }

      it 'should default precision to zero' do
        expect(number.to_s).to eq("10")
      end

      it 'should not overwrite precision when explicitly passed' do
        expect(number.to_s(:precision => 2)).to eq("10.00")
      end
    end

    context 'currencies' do
      let(:number) { LocalizedNumber.new(10, :en, :type => :currency) }

      it "should default to a precision of 2" do
        expect(number.to_s(:precision => 2)).to eq("$10.00")
      end

      it 'should not overwrite precision when explicitly passed' do
        expect(number.to_s(:precision => 1)).to eq("$10.0")
      end
    end

    context 'percentages' do
      let(:number) { LocalizedNumber.new(10, :en, :type => :percent) }

      it "should default to a precision of 0" do
        expect(number.to_s).to eq("10%")
      end

      it 'should not overwrite precision when explicitly passed' do
        expect(number.to_s(:precision => 1)).to eq("10.0%")
      end
    end

    context 'short decimals' do
      let(:number) { LocalizedNumber.new(1000, :en, :type => :short_decimal) }

      it "should default to a precision of 0" do
        expect(number.to_s).to eq("1K")
      end

      it 'should not overwrite precision when explicitly passed' do
        expect(number.to_s(:precision => 1)).to eq("1.0K")
      end
    end

    context 'long decimals' do
      let(:number) { LocalizedNumber.new(1000, :en, :type => :long_decimal) }

      it "should default to a precision of 0" do
        expect(number.to_s).to eq("1 thousand")
      end

      it 'should not overwrite precision when explicitly passed' do
        expect(number.to_s(:precision => 1)).to eq("1.0 thousand")
      end
    end
  end

  describe '#plural_rule' do
    it 'returns the appropriate plural rule for the number' do
      expect(1.localize(:ru).plural_rule).to eq(:one)
      expect(2.localize(:ru).plural_rule).to eq(:few)
      expect(5.localize(:ru).plural_rule).to eq(:many)
      expect(10.0.localize(:ru).plural_rule).to eq(:other)
    end

    it 'takes FastGettext.locale into account' do
      FastGettext.locale = :es
      expect(1.localize.plural_rule).to eq(:one)
      expect(2.localize.plural_rule).to eq(:other)
      expect(5.localize.plural_rule).to eq(:other)
    end
  end

  describe 'formatters for every locale' do
    it "makes sure currency formatters for every locale don't raise errors" do
      TwitterCldr.supported_locales.each do |locale|
        expect { 1337.localize(locale).to_currency.to_s }.not_to raise_error
        expect { 1337.localize(locale).to_currency.to_s(:precision => 3) }.not_to raise_error
        expect { 1337.localize(locale).to_currency.to_s(:precision => 3, :currency => "EUR") }.not_to raise_error
      end
    end

    it "makes sure decimal formatters for every locale don't raise errors" do
      TwitterCldr.supported_locales.each do |locale|
        expect { 1337.localize(locale).to_decimal.to_s }.not_to raise_error
        expect { 1337.localize(locale).to_decimal.to_s(:precision => 3) }.not_to raise_error
      end
    end

    it "makes sure percentage formatters for every locale don't raise errors" do
      TwitterCldr.supported_locales.each do |locale|
        expect { 1337.localize(locale).to_percent.to_s }.not_to raise_error
        expect { 1337.localize(locale).to_percent.to_s(:precision => 3) }.not_to raise_error
      end
    end

    it "makes sure basic number formatters for every locale don't raise errors" do
      TwitterCldr.supported_locales.each do |locale|
        expect { 1337.localize(locale).to_s }.not_to raise_error
        expect { 1337.localize(locale).to_s(:precision => 3) }.not_to raise_error
      end
    end
  end

end