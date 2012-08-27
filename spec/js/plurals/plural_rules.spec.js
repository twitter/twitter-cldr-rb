// Copyright 2012 Twitter, Inc
// http://www.apache.org/licenses/LICENSE-2.0

var TwitterCldr = require('../../../lib/assets/javascripts/twitter_cldr/en.js');

describe("PluralRules", function() {
  describe("#all", function() {
    it("returns an array of all English plural rules", function() {
      expect(TwitterCldr.PluralRules.all()).toEqual(["one", "other"]);
    });
  });

  describe("#rule_for", function() {
    it("returns 'one' for the number 1", function() {
      expect(TwitterCldr.PluralRules.rule_for(1)).toEqual("one");
    });

    it("returns 'other' for any number greater than 1", function() {
      for (var i = 2; i < 10; i ++) {
        expect(TwitterCldr.PluralRules.rule_for(i)).toEqual("other");
      }
    });

    it("returns 'other' for the number 0", function() {
      expect(TwitterCldr.PluralRules.rule_for(0)).toEqual("other");
    });
  });
});
