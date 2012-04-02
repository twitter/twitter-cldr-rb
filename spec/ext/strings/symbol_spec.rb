# coding: utf-8

require File.join(File.dirname(File.dirname(File.dirname(__FILE__))), "spec_helper")
include TwitterCldr

describe LocalizedSymbol do
  describe "#as_language_code" do
    it "returns the correct localized language from the symbol" do
      :es.localize.as_language_code.should == "Spanish"
      FastGettext.locale = :es
      :es.localize.as_language_code.should == "español"
    end

    it "returns nil if the symbol doesn't correspond to a language code" do
      :blarg.localize.as_language_code.should == nil
    end

    it "returns the correct value for mapped as well as CLDR language codes" do
      :'zh-cn'.localize.as_language_code.should == "Chinese"
      :'zh-tw'.localize.as_language_code.should == "Traditional Chinese"
      :'zh-Hant'.localize.as_language_code.should == "Traditional Chinese"
      :'zh'.localize.as_language_code.should == "Chinese"
    end
  end
end
