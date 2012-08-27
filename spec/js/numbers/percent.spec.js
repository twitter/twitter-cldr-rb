// Copyright 2012 Twitter, Inc
// http://www.apache.org/licenses/LICENSE-2.0

var TwitterCldr = require('../../../lib/assets/javascripts/twitter_cldr/en.js');

describe("PercentFormatter", function() {
  beforeEach(function() {
    formatter = new TwitterCldr.PercentFormatter();
  });

  it("should format the number correctly", function() {
    expect(formatter.format(12)).toEqual("12%");
  });

  it("should format negative numbers correctly", function() {
    expect(formatter.format(-12)).toEqual("-12%");
  });

  it("should respect the precision option", function() {
    expect(formatter.format(-12, {precision: 3})).toEqual("-12.000%");
  });
});