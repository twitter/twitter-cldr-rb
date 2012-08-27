// Copyright 2012 Twitter, Inc
// http://www.apache.org/licenses/LICENSE-2.0

var TwitterCldr = require('../../../lib/assets/javascripts/twitter_cldr/en.js');

describe("NumberFormatter", function() {
  beforeEach(function() {
    formatter = new TwitterCldr.DecimalFormatter();
  });

  describe("#precision_from", function() {
    it("should return the correct precision", function() {
      expect(formatter.precision_from(12.123)).toEqual(3);
    });

    it("should return zero precision if the number isn't a decimal", function() {
      expect(formatter.precision_from(12)).toEqual(0);
    });
  });

  describe("#round_to", function() {
    it("should round a number to the given precision", function() {
      expect(formatter.round_to(12, 0)).toEqual(12);
      expect(formatter.round_to(12.2, 0)).toEqual(12);
      expect(formatter.round_to(12.5, 0)).toEqual(13);
      expect(formatter.round_to(12.25, 1)).toEqual(12.3);
      expect(formatter.round_to(12.25, 2)).toEqual(12.25);
      expect(formatter.round_to(12.25, 3)).toEqual(12.25);
    });
  });

  describe("#parse_number", function() {
    it("should round and split the given number by decimal", function() {
      expect(formatter.parse_number(12, {precision: 0})).toEqual(["12"]);
      expect(formatter.parse_number(12.2, {precision: 0})).toEqual(["12"]);
      expect(formatter.parse_number(12.5, {precision: 0})).toEqual(["13"]);
      expect(formatter.parse_number(12.25, {precision: 1})).toEqual(["12", "3"]);
      expect(formatter.parse_number(12.25, {precision: 2})).toEqual(["12", "25"]);
      expect(formatter.parse_number(12.25, {precision: 3})).toEqual(["12", "250"]);
    });
  });

  describe("#format", function() {
    it("should format a basic integer", function() {
      expect(formatter.format(12)).toEqual("12");
    });

    describe("should respect the :precision option", function() {
      it("formats with precision of 0", function() {
        expect(formatter.format(12.1, {precision: 0})).toEqual("12");
      });

      it("rounds and formats with precision of 1", function() {
        expect(formatter.format(12.25, {precision: 1})).toEqual("12.3");
      });
    });

    it("uses the length of the original decimal as the precision", function() {
      expect(formatter.format(12.8543)).toEqual("12.8543");
    });

    it("formats an integer larger than 999", function() {
      expect(formatter.format(1337)).toEqual("1,337");
    });

    it("formats a decimal larger than 999.9", function() {
      expect(formatter.format(1337.37)).toEqual("1,337.37");
    });
  });
});