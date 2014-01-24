# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Shared

describe Territories do
  describe "#translate_territory" do
    it "should translate country names from one locale to another" do
      Territories.translate_territory("Russia", :en, :es).should match_normalized("Rusia")
      Territories.translate_territory("Rusia", :es, :en).should match_normalized("Russia")
      Territories.translate_territory("Spain", :en, :es).should match_normalized("España")
      Territories.translate_territory("España", :es, :ru).should match_normalized("Испания")
    end

    it "should use alternate/short names" do
      Territories.translate_territory("Congo (DRC)", :en, :es).should match_normalized("Congo (República Democrática del Congo)")
      Territories.translate_territory("Congo (Republic)", :en, :es).should match_normalized("Congo (República)")
      Territories.translate_territory("East Timor", :en, :es).should match_normalized("Timor Oriental")
      Territories.translate_territory("Falkland Islands (Islas Malvinas)", :en, :es).should match_normalized("Islas Malvinas (Islas Falkland)")
      Territories.translate_territory("Hong Kong", :en, :es).should match_normalized("Hong Kong")
      Territories.translate_territory("Ivory Coast", :en, :es).should match_normalized("Costa de Marfil")
      Territories.translate_territory("Macau", :en, :es).should match_normalized("Macao")
      Territories.translate_territory("Macedonia (FYROM)", :en, :es).should match_normalized("Macedonia (ERYM)")
    end

    it "should be capitalization agnostic" do
      Territories.translate_territory("russia", :en, :es).should match_normalized("Rusia")
      Territories.translate_territory("RUSSIA", :en, :es).should match_normalized("Rusia")
    end

    it "defaults the destination language to English (or whatever the global locale is)" do
      Territories.translate_territory("Rusia", :es).should match_normalized("Russia")
      Territories.translate_territory("Россия", :ru).should match_normalized("Russia")
    end

    it "defaults source and destination language to English if not given" do
      Territories.translate_territory("Russia").should match_normalized("Russia")
      TwitterCldr.locale = :es
      Territories.translate_territory("Russia").should match_normalized("Rusia")
    end

    it "successfully translates locale codes that are and are not in the CLDR using the locale map" do
      Territories.translate_territory("Russia", :en, :'zh-cn').should match_normalized("俄罗斯")
      Territories.translate_territory("Russia", :en, :'zh').should match_normalized("俄罗斯")
    end

    it "should return nil if no translation was found" do
      Territories.translate_territory("Russia", :en, :blarg).should == nil
    end
  end

  describe "#from_territory_code_for_locale" do
    it "should return the territory in the correct locale for the given locale code (i.e. RU in English should be Russia)" do
      Territories.from_territory_code_for_locale(:ES, :en).should match_normalized("Spain")
      Territories.from_territory_code_for_locale(:GB, :es).should match_normalized("UK")
    end

    it "should work with lower-case country codes as well" do
      Territories.from_territory_code_for_locale(:es, :en).should match_normalized("Spain")
      Territories.from_territory_code_for_locale(:gb, :es).should match_normalized("UK")
    end

    it "should work with Traditional Chinese" do
      Territories.from_territory_code_for_locale(:US, :"zh-Hant").should match_normalized("美國")
    end
  end

  describe "#from_territory_code" do
    it "should return the language in the default locale for the given locale code" do
      Territories.from_territory_code(:ES).should match_normalized("Spain")
      Territories.from_territory_code(:RU).should match_normalized("Russia")
      TwitterCldr.locale = :es
      Territories.from_territory_code(:ES).should match_normalized("España")
    end
  end

  describe "#all_for" do
    it "should return a hash of all languages for the given language code" do
      territories = Territories.all_for(:es)
      territories.should be_a(Hash)
      territories[:ru].should match_normalized("Rusia")
    end

    it "should return an empty hash for an invalid language" do
      territories = Territories.all_for(:blarg)
      territories.should == {}
    end
  end

  describe "#all" do
    it "should use the default language to get the language hash" do
      territories = Territories.all
      territories.should be_a(Hash)
      territories[:ru].should match_normalized("Russia")
      territories[:de].should match_normalized("Germany")

      TwitterCldr.locale = :es
      territories = Territories.all
      territories.should be_a(Hash)
      territories[:ru].should match_normalized("Rusia")
      territories[:de].should match_normalized("Alemania")
    end
  end

  describe "the lack of knowledge about three-digit UN area codes" do
    it "should not be able to translate three-digit UN area codes" do
      Territories.translate_territory("Southern Africa", :en, :es).should == nil
    end

    it "should not be able to name three-digit UN area codes" do
      Territories.from_territory_code_for_locale(:"18", :es).should == nil
    end
  end

  describe "#deep_normalize_territory_code_keys" do
    Territories.deep_normalize_territory_code_keys(
      { "is" => [ { "US" => "United States",
                    5 => "Suður-Ameríka" },
                  { "009" => "Eyjaálfa" } ] }
    ).should == { :is => [ { :us => "United States" }, { } ] }
  end

end

