# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Shared

describe Territories do
  describe "#translate_territory" do
    it "should translate a territory name from one locale to another" do
      Territories.translate_territory("Russia", :en, :es).should == "Rusia"
      Territories.translate_territory("Rusia", :es, :en).should == "Russia"
      Territories.translate_territory("Spain", :en, :es).should == "España"
      Territories.translate_territory("España", :es, :ru).should == "Испания"
    end

    it "should use alternate/short names" do
      Territories.translate_territory("Congo [DRC]", :en, :es).should == "Congo [República Democrática del Congo]"
      Territories.translate_territory("Congo [Republic]", :en, :es).should == "Congo [República]"
      Territories.translate_territory("East Timor", :en, :es).should == "Timor Oriental"
      Territories.translate_territory("Falkland Islands [Islas Malvinas]", :en, :es).should == "Islas Malvinas [Islas Falkland]"
      Territories.translate_territory("Hong Kong", :en, :es).should == "Hong Kong"
      Territories.translate_territory("Ivory Coast", :en, :es).should == "Costa de Marfil"
      Territories.translate_territory("Macau", :en, :es).should == "Macao"
      Territories.translate_territory("Macedona [FYROM]", :en, :es).should == "Macedonia [ERYM]"
    end

    it "should be capitalization agnostic" do
      Territories.translate_territory("russia", :en, :es).should == "Rusia"
      Territories.translate_territory("RUSSIA", :en, :es).should == "Rusia"
    end

    it "defaults the destination language to English (or whatever FastGettext.locale is)" do
      Territories.translate_territory("Rusia", :es).should == "Russia"
      Territories.translate_territory("Россия", :ru).should == "Russia"
    end

    it "defaults source and destination language to English if not given" do
      Territories.translate_territory("Russia").should == "Russia"
      FastGettext.locale = :es
      Territories.translate_territory("Russia").should == "Rusia"
    end

    it "successfully translates locale codes that are and are not in the CLDR using the locale map" do
      Territories.translate_territory("Russia", :en, :'zh-cn').should == "俄罗斯"
      Territories.translate_territory("Russia", :en, :'zh').should == "俄罗斯"
    end

    it "should return nil if no translation was found" do
      Territories.translate_territory("Russia", :en, :blarg).should == nil
    end
  end

  describe "#from_code_for_locale" do
    it "should return the territory in the correct locale for the given locale code (i.e. RU in English should be Russia)" do
      Territories.from_code_for_locale(:ES, :en).should == "Spain"
      Territories.from_code_for_locale(:GB, :es).should == "Reino Unido"
    end
  end

  describe "#from_code" do
    it "should return the language in the default locale for the given locale code" do
      Territories.from_code(:ES).should == "Spain"
      Territories.from_code(:RU).should == "Russia"
      FastGettext.locale = :es
      Territories.from_code(:ES).should == "España"
    end
  end

  describe "#all_for" do
    it "should return a hash of all languages for the given language code" do
      territories = Territories.all_for(:es)
      territories.should be_a(Hash)
      territories[:RU].should == "Rusia"
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
      territories[:RU].should == "Russia"
      territories[:DE].should == "Germany"

      FastGettext.locale = :es
      territories = Territories.all
      territories.should be_a(Hash)
      territories[:RU].should == "Rusia"
      territories[:DE].should == "Alemania"
    end
  end

end

