# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Localized

describe LocalizedSymbol do

  describe "#as_language_code" do
    it "calculates the correct localized language from the symbol" do
      expect(:es.localize.as_language_code).to eq("Spanish")
      TwitterCldr.locale = :es
      expect(:es.localize.as_language_code).to eq("español")
    end

    it "returns nil if the symbol doesn't correspond to a language code" do
      expect(:blarg.localize.as_language_code).to eq(nil)
    end

    it "calculates the correct value for mapped as well as CLDR language codes" do
      expect(:'zh-cn'.localize.as_language_code).to eq("Chinese")
      expect(:'zh-tw'.localize.as_language_code).to eq("Traditional Chinese")
      expect(:'zh-Hant'.localize.as_language_code).to eq("Traditional Chinese")
      expect(:'zh'.localize.as_language_code).to eq("Chinese")
    end
  end

  describe "#as_territory" do
    it "calculates the correct localized territory from the symbol" do
      expect(:gb.localize.as_territory).to eq("U.K.")
      TwitterCldr.locale = :pt
      expect(:gb.localize.as_territory).to eq("Reino Unido")
    end

    it "returns nil if the symbol doesn't correspond to a territory code" do
      expect(:blarg.localize.as_territory).to eq(nil)
    end

    it "calculates the correct value for mapped as well as CLDR language codes" do
      expect(:gb.localize(:'en-au').as_territory).to eq("U.K.")
      expect(:gb.localize(:'en-ca').as_territory).to eq("U.K.")
      expect(:gb.localize(:'en-gb').as_territory).to eq("UK")
      expect(:gb.localize(:'en').as_territory).to eq("U.K.")
    end
  end

  describe "#is_rtl?" do
    it "returns true or false depending on the locale" do
      expect(:es.localize.is_rtl?).to be_false
      expect(:ar.localize.is_rtl?).to be_true
    end
  end

  describe "#as_locale" do
    it "parses the symbol as a locale and returns a Locale instance" do
      locale = :ru.localize.as_locale
      expect(locale).to be_a(TwitterCldr::Shared::Locale)
      expect(locale.language).to eq('ru')
    end
  end

end
