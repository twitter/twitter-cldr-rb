// Copyright 2012 Twitter, Inc
// http://www.apache.org/licenses/LICENSE-2.0

var TwitterCldr = require('../../../lib/assets/javascripts/twitter_cldr/en.js');

describe("DecimalFormatter", function() {
  beforeEach(function() {
    formatter = new TwitterCldr.DecimalFormatter();
  });

  describe("#format", function() {
    it("should format positive decimals correctly", function() {
      expect(formatter.format(12.1)).toEqual("12.1");
    });

    it("should format negative decimals correctly", function() {
      expect(formatter.format(-12.1)).toEqual("-12.1");
    });

    it("should respect the precision option", function() {
      expect(formatter.format(-12, {precision: 3})).toEqual("-12.000");
    });
  });
});