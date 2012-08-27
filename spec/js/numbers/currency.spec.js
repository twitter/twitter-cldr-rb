// Copyright 2012 Twitter, Inc
// http://www.apache.org/licenses/LICENSE-2.0

var TwitterCldr = require('../../../lib/assets/javascripts/twitter_cldr/en.js');

describe("CurrencyFormatter", function() {
  describe("#format", function() {
    beforeEach(function() {
      formatter = new TwitterCldr.CurrencyFormatter();
    });

    it("should use a dollar sign when no other currency symbol is given (and default to a precision of 2)", function() {
      expect(formatter.format(12)).toEqual("$12.00");
    });

    it("handles negative numbers", function() {
      // yes, the parentheses really are part of the format, don't worry about it
      expect(formatter.format(-12)).toEqual("-($12.00)");
    });

    it("should use the specified currency symbol when specified", function() {
      // S/. is the symbol for the Peruvian Nuevo Sol, just in case you were curious
      expect(formatter.format(12, {currency: "S/."})).toEqual("S/.12.00");
    });

    it("should use the currency symbol for the corresponding currency code", function() {
      expect(formatter.format(12, {currency: "PEN"})).toEqual("S/.12.00");
    });

    it("overrides the default precision", function() {
      expect(formatter.format(12, {precision: 3})).toEqual("$12.000");
    });
  });
});