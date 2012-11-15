// Copyright 2012 Twitter, Inc
// http://www.apache.org/licenses/LICENSE-2.0

var TwitterCldr = require('../../../../lib/assets/javascripts/twitter_cldr/en.js');

describe("AbbreviatedNumberFormatter", function() {
  beforeEach(function() {
    formatter = new TwitterCldr.AbbreviatedNumberFormatter();
  });

  describe("#transform_number", function() {
    it("chops off the number to the necessary number of sig figs", function() {
      expect(formatter.transform_number(Math.pow(10, 3))).toEqual(1);
      expect(formatter.transform_number(Math.pow(10, 4))).toEqual(10);
      expect(formatter.transform_number(Math.pow(10, 5))).toEqual(100);
      expect(formatter.transform_number(Math.pow(10, 6))).toEqual(1);
      expect(formatter.transform_number(Math.pow(10, 7))).toEqual(10);
      expect(formatter.transform_number(Math.pow(10, 8))).toEqual(100);
      expect(formatter.transform_number(Math.pow(10, 9))).toEqual(1);
      expect(formatter.transform_number(Math.pow(10, 10))).toEqual(10);
      expect(formatter.transform_number(Math.pow(10, 11))).toEqual(100);
      expect(formatter.transform_number(Math.pow(10, 12))).toEqual(1);
      expect(formatter.transform_number(Math.pow(10, 13))).toEqual(10);
      expect(formatter.transform_number(Math.pow(10, 14))).toEqual(100);
    });

    it("returns the original number if greater than 10^15", function() {
      expect(formatter.transform_number(Math.pow(10, 15))).toEqual(Math.pow(10, 15));
    });

    it("returns the original number if less than 10^3", function() {
      expect(formatter.transform_number(999)).toEqual(999);
    });
  });

  describe("#get_key", function() {
    it("builds a power-of-ten key based on the number of digits in the input", function() {
      for(var i = 3; i < 15; i ++) {
        var zeroes = "";
        for(var j = 0; j < (i - 3); j ++) {
          zeroes += "0";
        }
        expect(formatter.get_key(parseInt("1337" + zeroes))).toEqual(Math.pow(10, i).toString());
      }
    });
  });
});