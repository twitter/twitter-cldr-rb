# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Localized

describe LocalizedObject do

  class LocalizedFormatter
    def initialize(options); end
  end

  class LocalizedClass < LocalizedObject
    def formatter_const
      LocalizedFormatter
    end
  end

  describe '#initialize' do
    let(:base_object) { 'base-object' }
    let(:locale) { :fr }
    let(:localized_object) { LocalizedClass.new(base_object, locale) }
    let(:options) { { :foobar => 'value' } }

    it 'sets base object' do
      expect(localized_object.base_obj).to eq(base_object)
    end

    it 'sets locale' do
      expect(localized_object.locale).to eq(locale)
    end

    it 'converts locale' do
      expect(LocalizedClass.new(base_object, :msa).locale).to eq(:ms)
    end

    it 'falls back to default locale if unsupported locale is passed' do
      expect(LocalizedClass.new(base_object, :foobar).locale).to eq(TwitterCldr::DEFAULT_LOCALE)
    end

    it "doesn't change original options hash" do
      expect { LocalizedClass.new(base_object, locale, options) }.not_to change { options }
    end
  end

  describe '.localize' do
    it 'defines #localize method on a class' do
      some_class = Class.new

      expect(some_class.new).not_to respond_to(:localize)
      LocalizedClass.localize(some_class)
      expect(some_class.new).to respond_to(:localize)
    end
  end

  describe '#localize' do
    let(:locale)  { :ru }
    let(:options) { { :option => 'value' } }

    let(:localizable_object) do
      some_class = Class.new
      LocalizedClass.localize(some_class)
      some_class.new
    end

    it 'returns localized object' do
      expect(localizable_object.localize).to be_a(LocalizedClass)
    end

    it 'accepts locale and options and pass them to the localized class constructor' do
      mock(LocalizedClass).new(localizable_object, locale, options)
      localizable_object.localize(locale, options)
    end

    it 'uses default locale and empty options hash by default' do
      mock(LocalizedClass).new(localizable_object, TwitterCldr.locale, {})
      localizable_object.localize
    end
  end

end