// Copyright 2012 Twitter, Inc
// http://www.apache.org/licenses/LICENSE-2.0

var TwitterCldr = require('../../../../lib/assets/javascripts/twitter_cldr/en.js');

describe("ShortDecimalFormatter", function() {
  beforeEach(function() {
    formatter = new TwitterCldr.ShortDecimalFormatter();
  });

  describe("#get_tokens", function() {
    it("gets tokens for a valid number (between 10^3 and 10^15)", function() {
      expect(formatter.get_tokens(12345)).toEqual(formatter.all_tokens.short_decimal.positive[10000]);
    });

    it("returns tokens for decimals if the number is too large", function() {
      expect(formatter.get_tokens(1234567891011122)).toEqual(formatter.all_tokens.decimal.positive);
    });

    it("returns tokens for decimals if the number is too small", function() {
      expect(formatter.get_tokens(123)).toEqual(formatter.all_tokens.decimal.positive);
    });
  });

  describe("#format", function() {
    it("should default to a precision of 0", function() {
      expect(formatter.format(1000)).toEqual("1K");
    });

    it("should not overwrite precision when explicitly passed", function() {
      expect(formatter.format(1000, {precision: 1})).toEqual("1.0K");
    });

    it("formats valid numbers correctly (from 10^3 - 10^15)", function() {
      expect(formatter.format(Math.pow(10, 3))).toEqual("1K");
      expect(formatter.format(Math.pow(10, 4))).toEqual("10K");
      expect(formatter.format(Math.pow(10, 5))).toEqual("100K");
      expect(formatter.format(Math.pow(10, 6))).toEqual("1M");
      expect(formatter.format(Math.pow(10, 7))).toEqual("10M");
      expect(formatter.format(Math.pow(10, 8))).toEqual("100M");
      expect(formatter.format(Math.pow(10, 9))).toEqual("1B");
      expect(formatter.format(Math.pow(10, 10))).toEqual("10B");
      expect(formatter.format(Math.pow(10, 11))).toEqual("100B");
      expect(formatter.format(Math.pow(10, 12))).toEqual("1T");
      expect(formatter.format(Math.pow(10, 13))).toEqual("10T");
      expect(formatter.format(Math.pow(10, 14))).toEqual("100T");
    });

    it("formats the number as if it were a straight decimal if it exceeds 10^15", function() {
      expect(formatter.format(Math.pow(10, 15))).toEqual("1,000,000,000,000,000");
    });

    it("formats the number as if it were a straight decimal if it's less than 1000", function() {
      expect(formatter.format(500)).toEqual("500");
    });
  });
});