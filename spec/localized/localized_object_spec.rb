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
      localized_object.base_obj.should == base_object
    end

    it 'sets locale' do
      localized_object.locale.should == locale
    end

    it 'converts locale' do
      LocalizedClass.new(base_object, :msa).locale.should == :ms
    end

    it 'falls back to default locale if unsupported locale is passed' do
      LocalizedClass.new(base_object, :foobar).locale.should == TwitterCldr::DEFAULT_LOCALE
    end

    it 'passes options (including locale) to formatter' do
      mock(LocalizedFormatter).new(options.merge(:locale => locale))
      LocalizedClass.new(base_object, locale, options)
    end

    it "doesn't change original options hash" do
      lambda { LocalizedClass.new(base_object, locale, options) }.should_not change { options }
    end
  end

  describe '.localize' do
    it 'defines #localize method on a class' do
      some_class = Class.new

      some_class.new.should_not respond_to(:localize)
      LocalizedClass.localize(some_class)
      some_class.new.should respond_to(:localize)
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
      localizable_object.localize.should be_a(LocalizedClass)
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