// Copyright 2012 Twitter, Inc
// http://www.apache.org/licenses/LICENSE-2.0

var TwitterCldr = require('../../../lib/assets/javascripts/twitter_cldr/en.js');

describe("TimespanFormatter", function() {
  beforeEach(function() {
    formatter = new TwitterCldr.TimespanFormatter();
  });

  describe("#format", function() {
    it("works for a variety of units for a non-directional timespan", function() {
      expect(formatter.format(3273932, {
        unit: "year",
        direction: "none"
      })).toEqual('0 years');
      expect(formatter.format(3273932, {
        unit: "month",
        direction: "none",
      })).toEqual('1 month');
      expect(formatter.format(3273932, {
        unit: "week",
        direction: "none"
      })).toEqual('5 weeks');
      expect(formatter.format(3273932, {
        unit: "day",
        direction: "none"
      })).toEqual('38 days');
      expect(formatter.format(3273932, {
        unit: "hour",
        direction: "none"
      })).toEqual('909 hours');
      expect(formatter.format(3273932, {
        unit: "minute",
        direction: "none"
      })).toEqual('54566 minutes');
      expect(formatter.format(3273932, {
        unit: "second",
        direction: "none"
      })).toEqual('3273932 seconds');
    });

    it("works for a variety of units in the past", function() {
      expect(formatter.format(-3273932, {
        unit: "year"
      })).toEqual('0 years ago');
      expect(formatter.format(-3273932, {
        unit: "month"
      })).toEqual('1 month ago');
      expect(formatter.format(-3273932, {
        unit: "week"
      })).toEqual('5 weeks ago');
      expect(formatter.format(-3273932, {
        unit: "day"
      })).toEqual('38 days ago');
      expect(formatter.format(-3273932, {
        unit: "hour"
      })).toEqual('909 hours ago');
      expect(formatter.format(-3273932, {
        unit: "minute"
      })).toEqual('54566 minutes ago');
      expect(formatter.format(-3273932, {
        unit: "second"
      })).toEqual('3273932 seconds ago');
    });

    it("works for a variety of units in the future", function() {
      expect(formatter.format(3273932, {
        unit: "year"
      })).toEqual('In 0 years');
      expect(formatter.format(3273932, {
        unit: "month"
      })).toEqual('In 1 month');
      expect(formatter.format(3273932, {
        unit: "week"
      })).toEqual('In 5 weeks');
      expect(formatter.format(3273932, {
        unit: "day"
      })).toEqual('In 38 days');
      expect(formatter.format(3273932, {
        unit: "hour"
      })).toEqual('In 909 hours');
      expect(formatter.format(3273932, {
        unit: "minute"
      })).toEqual('In 54566 minutes');
      expect(formatter.format(3273932, {
        unit: "second"
      })).toEqual('In 3273932 seconds');
    });
  });
});
