# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

describe TwitterCldr::Shared::Languages do
  describe "#translate_language" do
    it "should translate a language from one locale to another" do
      expect(described_class.translate_language("Russian", :en, :es)).to match_normalized("ruso")
      expect(described_class.translate_language("ruso", :es, :en)).to match_normalized("Russian")
      expect(described_class.translate_language("Spanish", :en, :es)).to match_normalized("español")
      expect(described_class.translate_language("ruso", :es, :ru)).to match_normalized("русский")
    end

    it "should be capitalization agnostic" do
      expect(described_class.translate_language("russian", :en, :es)).to match_normalized("ruso")
      expect(described_class.translate_language("RUSSIAN", :en, :es)).to match_normalized("ruso")
    end

    it "defaults the destination language to English (or whatever the global locale is)" do
      expect(described_class.translate_language("Ruso", :es)).to match_normalized("Russian")
      expect(described_class.translate_language("русский", :ru)).to match_normalized("Russian")
    end

    it "defaults source and destination language to English if not given" do
      expect(described_class.translate_language("Russian")).to match_normalized("Russian")
      TwitterCldr.locale = :es
      expect(described_class.translate_language("Russian")).to match_normalized("ruso")
    end

    it "successfully translates locale codes that are and are not in the CLDR using the locale map" do
      expect(described_class.translate_language("Russian", :en, :'zh-cn')).to match_normalized("俄语")
      expect(described_class.translate_language("Russian", :en, :'zh')).to match_normalized("俄语")
    end

    it "should return nil if no translation was found" do
      expect(described_class.translate_language("Russian", :en, :blarg)).to eq(nil)
    end
  end

  describe "#from_code_for_locale" do
    it "should return the language in the correct locale for the given locale code (i.e. es in English should be Spanish)" do
      expect(described_class.from_code_for_locale(:es, :en)).to match_normalized("Spanish")
      expect(described_class.from_code_for_locale(:en, :es)).to match_normalized("inglés")
    end
  end

  describe "#from_code" do
    it "should return the language in the default locale for the given locale code" do
      expect(described_class.from_code(:es)).to match_normalized("Spanish")
      expect(described_class.from_code(:ru)).to match_normalized("Russian")
      TwitterCldr.locale = :es
      expect(described_class.from_code(:es)).to match_normalized("español")
    end
  end

  describe "#all_for" do
    it "should return a hash of all languages for the given language code" do
      langs = described_class.all_for(:es)
      expect(langs).to be_a(Hash)
      expect(langs[:ru]).to match_normalized("ruso")
    end

    it "should return an empty hash for an invalid language" do
      langs = described_class.all_for(:blarg)
      expect(langs).to eq({})
    end
  end

  describe "#all" do
    it "should use the default language to get the language hash" do
      langs = described_class.all
      expect(langs).to be_a(Hash)
      expect(langs[:ru]).to match_normalized("Russian")
      expect(langs[:de]).to match_normalized("German")

      TwitterCldr.locale = :es
      langs = described_class.all
      expect(langs).to be_a(Hash)
      expect(langs[:ru]).to match_normalized("ruso")
      expect(langs[:de]).to match_normalized("alemán")
    end
  end

  describe "#is_rtl?" do
    it "should return true for certain locales" do
      [:ar, :he, :ur, :fa].each do |locale|
        expect(described_class.is_rtl?(locale)).to eq(true)
      end
    end

    it "should return false for certain locales" do
      [:en, :es, :hu, :ja].each do |locale|
        expect(described_class.is_rtl?(locale)).to eq(false)
      end
    end

    it "should not raise errors for any locale" do
      TwitterCldr.supported_locales.each do |locale|
        expect { described_class.is_rtl?(locale) }.not_to raise_error
      end
    end
  end

end
