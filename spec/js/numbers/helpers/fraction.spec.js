// Copyright 2012 Twitter, Inc
// http://www.apache.org/licenses/LICENSE-2.0

var TwitterCldr = require('../../../../lib/assets/javascripts/twitter_cldr/en.js');

describe("FractionHelper", function() {
  describe("#apply", function() {
    it("test: formats a fraction", function() {
      var token = '###.##';
      expect(new TwitterCldr.NumberFormatter.FractionHelper(token).apply('45')).toEqual('.45');
    });

    it("test: pads zero digits on the right side", function() {
      var token = '###.0000#';
      expect(new TwitterCldr.NumberFormatter.FractionHelper(token).apply('45')).toEqual('.45000');
    });

    it("test: :precision option overrides format precision", function() {
      var token = '###.##';
      expect(new TwitterCldr.NumberFormatter.FractionHelper(token).apply('78901', {precision: 5})).toEqual('.78901');
    });
  });
});