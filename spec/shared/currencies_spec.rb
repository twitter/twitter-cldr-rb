# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

TEST_COUNTRIES = ["Australia", "Thailand", "Russia", "China", "Japan", "Peru", "South Africa", "India", "South Korea", "United Kingdom"]
TEST_CODES     = %w[AUD THB RUB CNY JPY PEN ZAR INR KRW GBP]

describe TwitterCldr::Shared::Currencies do
  describe "#currency_codes" do
    it "should list all supported country codes" do
      codes = described_class.currency_codes

      expect(codes.size).to eq(307)
      expect(codes).to include(*TEST_CODES)
    end
  end

  describe "#for_code" do
    it "should return all information for PEN" do
      data = described_class.for_code("PEN")
      expect(data).to be_a(Hash)
      expect(data).to include(
        name:        "Peruvian Sol",
        currency:    :PEN,
        symbol:      "PEN",
        cldr_symbol: "PEN",
        code_points: [80, 69, 78]
      )
    end

    it "should return all information for CAD, a currency code with multiple possible symbols" do
      data = described_class.for_code("CAD")
      expect(data).to be_a(Hash)
      expect(data).to include(
        name:        "Canadian Dollar",
        currency:    :CAD,
        symbol:      "CA$",
        cldr_symbol: "CA$",
        code_points: [67, 65, 36]
      )
    end

    it "verifies that all code_points values are equivalent to their corresponding symbols" do
      described_class.currency_codes.select do |code|
        data = described_class.for_code(code)
        expect(data[:code_points].pack("U*")).to eq(data[:symbol])
      end
    end
  end
end
