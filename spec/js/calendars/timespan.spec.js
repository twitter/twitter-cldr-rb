// Copyright 2012 Twitter, Inc
// http://www.apache.org/licenses/LICENSE-2.0

var TwitterCldr = require('../../../lib/assets/javascripts/twitter_cldr/en.js');

describe("TimespanFormatter", function() {
  beforeEach(function() {
    formatter = new TwitterCldr.TimespanFormatter();
  });

  describe("#format", function() {
    it("approximates timespans accurately if explicity asked to", function() {
      var options = {direction: "none", approximate: true}
      expect(formatter.format(44, options)).toEqual("44 seconds");
      expect(formatter.format(45, options)).toEqual("1 minute");

      expect(formatter.format(2699, options)).toEqual("45 minutes");
      expect(formatter.format(2700, options)).toEqual("1 hour");

      expect(formatter.format(64799, options)).toEqual("18 hours");
      expect(formatter.format(64800, options)).toEqual("1 day");

      expect(formatter.format(453599, options)).toEqual("5 days");
      expect(formatter.format(453600, options)).toEqual("1 week");

      expect(formatter.format(1972307, options)).toEqual("3 weeks");
      expect(formatter.format(1972308, options)).toEqual("1 month");

      expect(formatter.format(23667694, options)).toEqual("9 months");
      expect(formatter.format(23667695, options)).toEqual("1 year");
    });

    it("doesn't approximate timespans by default", function() {
      var options = {direction: "none"}
      expect(formatter.format(44, options)).toEqual("44 seconds");
      expect(formatter.format(45, options)).toEqual("45 seconds");

      expect(formatter.format(2699, options)).toEqual("45 minutes");
      expect(formatter.format(2700, options)).toEqual("45 minutes");

      expect(formatter.format(64799, options)).toEqual("18 hours");
      expect(formatter.format(64800, options)).toEqual("18 hours");

      expect(formatter.format(453599, options)).toEqual("5 days");
      expect(formatter.format(453600, options)).toEqual("5 days");

      expect(formatter.format(1972307, options)).toEqual("3 weeks");
      expect(formatter.format(1972308, options)).toEqual("3 weeks");

      expect(formatter.format(23667694, options)).toEqual("9 months");
      expect(formatter.format(23667695, options)).toEqual("9 months");

      expect(formatter.format(31556926, options)).toEqual("1 year");
    });

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
