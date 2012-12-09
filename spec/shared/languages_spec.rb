# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Shared

describe Languages do
  describe "#translate_language" do
    it "should translate a language from one locale to another" do
      Languages.translate_language("Russian", :en, :es).should == "ruso"
      Languages.translate_language("ruso", :es, :en).should == "Russian"
      Languages.translate_language("Spanish", :en, :es).should == "español"
      Languages.translate_language("ruso", :es, :ru).should == "русский"
    end

    it "should be capitalization agnostic" do
      Languages.translate_language("russian", :en, :es).should == "ruso"
      Languages.translate_language("RUSSIAN", :en, :es).should == "ruso"
    end

    it "defaults the destination language to English (or whatever FastGettext.locale is)" do
      Languages.translate_language("Ruso", :es).should == "Russian"
      Languages.translate_language("русский", :ru).should == "Russian"
    end

    it "defaults source and destination language to English if not given" do
      Languages.translate_language("Russian").should == "Russian"
      TwitterCldr.locale = :es
      Languages.translate_language("Russian").should == "ruso"
    end

    it "successfully translates locale codes that are and are not in the CLDR using the locale map" do
      Languages.translate_language("Russian", :en, :'zh-cn').should == "俄文"
      Languages.translate_language("Russian", :en, :'zh').should == "俄文"
    end

    it "should return nil if no translation was found" do
      Languages.translate_language("Russian", :en, :blarg).should == nil
    end
  end

  describe "#from_code_for_locale" do
    it "should return the language in the correct locale for the given locale code (i.e. es in English should be Spanish)" do
      Languages.from_code_for_locale(:es, :en).should == "Spanish"
      Languages.from_code_for_locale(:en, :es).should == "inglés"
    end
  end

  describe "#from_code" do
    it "should return the language in the default locale for the given locale code" do
      Languages.from_code(:es).should == "Spanish"
      Languages.from_code(:ru).should == "Russian"
      TwitterCldr.locale = :es
      Languages.from_code(:es).should == "español"
    end
  end

  describe "#all_for" do
    it "should return a hash of all languages for the given language code" do
      langs = Languages.all_for(:es)
      langs.should be_a(Hash)
      langs[:ru].should == "ruso"
    end

    it "should return an empty hash for an invalid language" do
      langs = Languages.all_for(:blarg)
      langs.should == {}
    end
  end

  describe "#all" do
    it "should use the default language to get the language hash" do
      langs = Languages.all
      langs.should be_a(Hash)
      langs[:ru].should == "Russian"
      langs[:de].should == "German"

      TwitterCldr.locale = :es
      langs = Languages.all
      langs.should be_a(Hash)
      langs[:ru].should == "ruso"
      langs[:de].should == "alemán"
    end
  end

  describe "#is_rtl?" do
    it "should return true for certain locales" do
      [:ar, :he, :ur, :fa].each do |locale|
        Languages.is_rtl?(locale).should be_true
      end
    end

    it "should return false for certain locales" do
      [:en, :es, :hu, :ja].each do |locale|
        Languages.is_rtl?(locale).should be_false
      end
    end

    it "should not raise errors for any locale" do
      TwitterCldr.supported_locales.each do |locale|
        lambda { Languages.is_rtl?(locale) }.should_not raise_error
      end
    end
  end

end