# encoding: UTF-8

require 'spec_helper'

include TwitterCldr::Shared

TEST_COUNTRIES = ["Australia", "Thailand", "Russia", "China", "Japan", "Peru", "South Africa", "India", "South Korea", "United Kingdom"]
TEST_CODES = ["AUD", "THB", "RUB", "CNY", "JPY", "PEN", "ZAR", "INR", "KRW", "GBP"]

describe Currencies do
  describe "#countries" do
    it "should list all supported countries" do
      countries = Currencies.countries
      countries.size.should == 112
      TEST_COUNTRIES.each { |country| countries.should include(country) }
    end
  end

  describe "#currency_codes" do
    it "should list all supported country codes" do
      codes = Currencies.currency_codes
      codes.size.should == 112
      TEST_CODES.each { |code| codes.should include(code) }
    end
  end

  describe "#for_country" do
    it "should return all information for the given country" do
      data = Currencies.for_country("Peru")
      data.should be_a(Hash)

      data.should include(:code)
      data[:code].should == "PEN"
      data.should include(:currency)
      data[:currency].should == "Nuevo Sol"
      data.should include(:symbol)
      data[:symbol].should == "S/."

      data.should_not include(:country)
    end
  end

  describe "#for_code" do
    it "should return all information for the given currency code" do
      data = Currencies.for_code("PEN")
      data.should be_a(Hash)

      data.should include(:country)
      data[:country].should == "Peru"
      data.should include(:currency)
      data[:currency].should == "Nuevo Sol"
      data.should include(:symbol)
      data[:symbol].should == "S/."

      data.should_not include(:code)
    end
  end
end