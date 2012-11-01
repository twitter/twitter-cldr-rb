# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Shared

TEST_COUNTRIES = ["Australia", "Thailand", "Russia", "China", "Japan", "Peru", "South Africa", "India", "South Korea", "United Kingdom"]
TEST_CODES     = %w[AUD THB RUB CNY JPY PEN ZAR INR KRW GBP]

describe Currencies do
  describe "#countries" do
    it "should list all supported countries" do
      countries = Currencies.countries

      countries.size.should == 112
      countries.should include(*TEST_COUNTRIES)
    end
  end

  describe "#currency_codes" do
    it "should list all supported country codes" do
      codes = Currencies.currency_codes

      codes.size.should == 296
      codes.should include(*TEST_CODES)
    end
  end

  describe "#for_country" do
    it "should return all information for the given country" do
      data = Currencies.for_country("Peru")

      data.should be_a(Hash)
      data.should_not include(:country)
      data.should include(
        :currency => :PEN,
        :name => "Peruvian Nuevo Sol",
        :symbol   => nil
      )
    end
  end

  describe "#for_code" do
    it "should return all information for the given currency code" do
      data = Currencies.for_code("PEN")

      data.should be_a(Hash)
      data.should_not include(:code)
      data.should include(
          :name => "Peruvian Nuevo Sol",
          :currency => :PEN,
          :symbol => nil
      )
    end
  end
end