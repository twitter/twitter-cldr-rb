# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

describe TwitterCldr::Shared::Territories do
  describe "#translate_territory" do
    it "should translate country names from one locale to another" do
      expect(described_class.translate_territory("Russia", :en, :es)).to match_normalized("Rusia")
      expect(described_class.translate_territory("Rusia", :es, :en)).to match_normalized("Russia")
      expect(described_class.translate_territory("Spain", :en, :es)).to match_normalized("España")
      expect(described_class.translate_territory("España", :es, :ru)).to match_normalized("Испания")
    end

    it "should use alternate/short names" do
      expect(described_class.translate_territory("Switzerland", :en, :es)).to match_normalized("Suiza")
      expect(described_class.translate_territory("Hong Kong SAR China", :en, :es)).to match_normalized("RAE de Hong Kong (China)")
      expect(described_class.translate_territory("North Macedonia", :en, :es)).to match_normalized("Macedonia del Norte")
    end

    it "should be capitalization agnostic" do
      expect(described_class.translate_territory("russia", :en, :es)).to match_normalized("Rusia")
      expect(described_class.translate_territory("RUSSIA", :en, :es)).to match_normalized("Rusia")
    end

    it "defaults the destination language to English (or whatever the global locale is)" do
      expect(described_class.translate_territory("Rusia", :es)).to match_normalized("Russia")
      expect(described_class.translate_territory("Россия", :ru)).to match_normalized("Russia")
    end

    it "defaults source and destination language to English if not given" do
      expect(described_class.translate_territory("Russia")).to match_normalized("Russia")
      TwitterCldr.locale = :es
      expect(described_class.translate_territory("Russia")).to match_normalized("Rusia")
    end

    it "successfully translates locale codes that are and are not in the CLDR using the locale map" do
      expect(described_class.translate_territory("Russia", :en, :'zh-cn')).to match_normalized("俄罗斯")
      expect(described_class.translate_territory("Russia", :en, :'zh')).to match_normalized("俄罗斯")
    end

    it "should return nil if no translation was found" do
      expect(described_class.translate_territory("Russia", :en, :blarg)).to eq(nil)
    end
  end

  describe "#from_territory_code_for_locale" do
    it "should return the territory in the correct locale for the given locale code (i.e. RU in English should be Russia)" do
      expect(described_class.from_territory_code_for_locale(:ES, :en)).to match_normalized("Spain")
      expect(described_class.from_territory_code_for_locale(:GB, :es)).to match_normalized("Reino Unido")
    end

    it "should work with lower-case country codes as well" do
      expect(described_class.from_territory_code_for_locale(:es, :en)).to match_normalized("Spain")
      expect(described_class.from_territory_code_for_locale(:gb, :es)).to match_normalized("Reino Unido")
    end

    it "should work with Traditional Chinese" do
      expect(described_class.from_territory_code_for_locale(:US, :"zh-Hant")).to match_normalized("美國")
    end
  end

  describe "#from_territory_code" do
    it "should return the language in the default locale for the given locale code" do
      expect(described_class.from_territory_code(:ES)).to match_normalized("Spain")
      expect(described_class.from_territory_code(:RU)).to match_normalized("Russia")
      TwitterCldr.locale = :es
      expect(described_class.from_territory_code(:ES)).to match_normalized("España")
    end
  end

  describe "#all_for" do
    it "should return a hash of all languages for the given language code" do
      territories = described_class.all_for(:es)
      expect(territories).to be_a(Hash)
      expect(territories[:ru]).to match_normalized("Rusia")
    end

    it "should return an empty hash for an invalid language" do
      territories = described_class.all_for(:blarg)
      expect(territories).to eq({})
    end
  end

  describe "#all" do
    it "should use the default language to get the language hash" do
      territories = described_class.all
      expect(territories).to be_a(Hash)
      expect(territories[:ru]).to match_normalized("Russia")
      expect(territories[:de]).to match_normalized("Germany")

      TwitterCldr.locale = :es
      territories = described_class.all
      expect(territories).to be_a(Hash)
      expect(territories[:ru]).to match_normalized("Rusia")
      expect(territories[:de]).to match_normalized("Alemania")
    end
  end

  describe "the lack of knowledge about three-digit UN area codes" do
    it "should not be able to translate three-digit UN area codes" do
      expect(described_class.translate_territory("Southern Africa", :en, :es)).to eq(nil)
    end

    it "should not be able to name three-digit UN area codes" do
      expect(described_class.from_territory_code_for_locale(:"18", :es)).to eq(nil)
    end
  end

  describe "#deep_normalize_territory_code_keys" do
    it 'normalizes correctly' do
      normalized = described_class.deep_normalize_territory_code_keys({
        "is" => [
          { "US" => "United States", 5 => "Suður-Ameríka" },
          { "009" => "Eyjaálfa" }
        ]
      })

      expect(normalized).to eq({ is: [{ us: "United States" }, {}] })
    end
  end
end
