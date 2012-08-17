# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr

describe LocalizedObject do

  class LocalizedClass < LocalizedObject
    def formatter_const; end
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
      mock(LocalizedClass).new(localizable_object, TwitterCldr.get_locale, {})
      localizable_object.localize
    end
  end

end