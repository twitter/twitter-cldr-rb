# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Localized

describe LocalizedSymbol do

  describe "#as_language_code" do
    it "returns the correct localized language from the symbol" do
      expect(:es.localize.as_language_code).to eq("Spanish")
      TwitterCldr.locale = :es
      expect(:es.localize.as_language_code).to eq("español")
    end

    it "returns nil if the symbol doesn't correspond to a language code" do
      expect(:blarg.localize.as_language_code).to eq(nil)
    end

    it "returns the correct value for mapped as well as CLDR language codes" do
      expect(:'zh-cn'.localize.as_language_code).to eq("Chinese")
      expect(:'zh-tw'.localize.as_language_code).to eq("Traditional Chinese")
      expect(:'zh-Hant'.localize.as_language_code).to eq("Traditional Chinese")
      expect(:'zh'.localize.as_language_code).to eq("Chinese")
    end
  end

  describe "#is_rtl?" do
    it "should return true or false depending on the locale" do
      expect(:es.localize.is_rtl?).to be_false
      expect(:ar.localize.is_rtl?).to be_true
    end
  end

end