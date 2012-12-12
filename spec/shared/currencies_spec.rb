# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Shared

TEST_COUNTRIES = ["Australia", "Thailand", "Russia", "China", "Japan", "Peru", "South Africa", "India", "South Korea", "United Kingdom"]
TEST_CODES     = %w[AUD THB RUB CNY JPY PEN ZAR INR KRW GBP]

describe Currencies do
  describe "#currency_codes" do
    it "should list all supported country codes" do
      codes = Currencies.currency_codes

      codes.size.should == 296
      codes.should include(*TEST_CODES)
    end
  end

  describe "#for_code" do
    it "should return all information for PEN" do
      data = Currencies.for_code("PEN")
      data.should be_a(Hash)
      data.should include(
        :name        => "Peruvian nuevo sol",
        :currency    => :PEN,
        :symbol      => "S/.",
        :cldr_symbol => nil
      )
    end

    it "should return all information for CAD, a currency code with multiple possible symbols" do
      data = Currencies.for_code("CAD")
      data.should be_a(Hash)
      data.should include(
        :name        => "Canadian dollar",
        :currency    => :CAD,
        :symbol      => "$",
        :cldr_symbol => "CA$"
      )
    end
  end
end