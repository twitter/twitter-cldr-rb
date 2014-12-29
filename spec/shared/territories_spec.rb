# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Shared

describe Territories do
  describe "#translate_territory" do
    it "should translate country names from one locale to another" do
      expect(Territories.translate_territory("Russia", :en, :es)).to match_normalized("Rusia")
      expect(Territories.translate_territory("Rusia", :es, :en)).to match_normalized("Russia")
      expect(Territories.translate_territory("Spain", :en, :es)).to match_normalized("España")
      expect(Territories.translate_territory("España", :es, :ru)).to match_normalized("Испания")
    end

    it "should use alternate/short names" do
      expect(Territories.translate_territory("Congo (DRC)", :en, :es)).to match_normalized("Congo (República Democrática del Congo)")
      expect(Territories.translate_territory("Congo (Republic)", :en, :es)).to match_normalized("Congo (República)")
      expect(Territories.translate_territory("East Timor", :en, :es)).to match_normalized("Timor Oriental")
      expect(Territories.translate_territory("Falkland Islands (Islas Malvinas)", :en, :es)).to match_normalized("Islas Malvinas (Islas Falkland)")
      expect(Territories.translate_territory("Hong Kong", :en, :es)).to match_normalized("Hong Kong")
      expect(Territories.translate_territory("Ivory Coast", :en, :es)).to match_normalized("Costa de Marfil")
      expect(Territories.translate_territory("Macau", :en, :es)).to match_normalized("Macao")
      expect(Territories.translate_territory("Macedonia (FYROM)", :en, :es)).to match_normalized("Macedonia (ERYM)")
    end

    it "should be capitalization agnostic" do
      expect(Territories.translate_territory("russia", :en, :es)).to match_normalized("Rusia")
      expect(Territories.translate_territory("RUSSIA", :en, :es)).to match_normalized("Rusia")
    end

    it "defaults the destination language to English (or whatever the global locale is)" do
      expect(Territories.translate_territory("Rusia", :es)).to match_normalized("Russia")
      expect(Territories.translate_territory("Россия", :ru)).to match_normalized("Russia")
    end

    it "defaults source and destination language to English if not given" do
      expect(Territories.translate_territory("Russia")).to match_normalized("Russia")
      TwitterCldr.locale = :es
      expect(Territories.translate_territory("Russia")).to match_normalized("Rusia")
    end

    it "successfully translates locale codes that are and are not in the CLDR using the locale map" do
      expect(Territories.translate_territory("Russia", :en, :'zh-cn')).to match_normalized("俄罗斯")
      expect(Territories.translate_territory("Russia", :en, :'zh')).to match_normalized("俄罗斯")
    end

    it "should return nil if no translation was found" do
      expect(Territories.translate_territory("Russia", :en, :blarg)).to eq(nil)
    end
  end

  describe "#from_territory_code_for_locale" do
    it "should return the territory in the correct locale for the given locale code (i.e. RU in English should be Russia)" do
      expect(Territories.from_territory_code_for_locale(:ES, :en)).to match_normalized("Spain")
      expect(Territories.from_territory_code_for_locale(:GB, :es)).to match_normalized("RU") # reino unido
    end

    it "should work with lower-case country codes as well" do
      expect(Territories.from_territory_code_for_locale(:es, :en)).to match_normalized("Spain")
      expect(Territories.from_territory_code_for_locale(:gb, :es)).to match_normalized("RU") # reino unido
    end

    it "should work with Traditional Chinese" do
      expect(Territories.from_territory_code_for_locale(:US, :"zh-Hant")).to match_normalized("美國")
    end
  end

  describe "#from_territory_code" do
    it "should return the language in the default locale for the given locale code" do
      expect(Territories.from_territory_code(:ES)).to match_normalized("Spain")
      expect(Territories.from_territory_code(:RU)).to match_normalized("Russia")
      TwitterCldr.locale = :es
      expect(Territories.from_territory_code(:ES)).to match_normalized("España")
    end
  end

  describe "#all_for" do
    it "should return a hash of all languages for the given language code" do
      territories = Territories.all_for(:es)
      expect(territories).to be_a(Hash)
      expect(territories[:ru]).to match_normalized("Rusia")
    end

    it "should return an empty hash for an invalid language" do
      territories = Territories.all_for(:blarg)
      expect(territories).to eq({})
    end
  end

  describe "#all" do
    it "should use the default language to get the language hash" do
      territories = Territories.all
      expect(territories).to be_a(Hash)
      expect(territories[:ru]).to match_normalized("Russia")
      expect(territories[:de]).to match_normalized("Germany")

      TwitterCldr.locale = :es
      territories = Territories.all
      expect(territories).to be_a(Hash)
      expect(territories[:ru]).to match_normalized("Rusia")
      expect(territories[:de]).to match_normalized("Alemania")
    end
  end

  describe "the lack of knowledge about three-digit UN area codes" do
    it "should not be able to translate three-digit UN area codes" do
      expect(Territories.translate_territory("Southern Africa", :en, :es)).to eq(nil)
    end

    it "should not be able to name three-digit UN area codes" do
      expect(Territories.from_territory_code_for_locale(:"18", :es)).to eq(nil)
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

