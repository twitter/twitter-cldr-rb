// Copyright 2012 Twitter, Inc
// http://www.apache.org/licenses/LICENSE-2.0

var TwitterCldr = require('../../../lib/assets/javascripts/twitter_cldr/en.js');

describe("Calendar", function() {
  describe("#months", function() {
    it("should return wide day names by default", function() {
      expect(TwitterCldr.Calendar.months()).toEqual([
        "January", "February", "March", "April", "May",
        "June", "July", "August", "September", "October",
        "November", "December"
      ]);
    });

    it("should return narrow or abbreviated day names when asked", function() {
      expect(TwitterCldr.Calendar.months({names_form: "abbreviated"})).toEqual([
        "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul",
        "Aug", "Sep", "Oct", "Nov", "Dec"
      ]);

      expect(TwitterCldr.Calendar.months({names_form: "narrow"})).toEqual([
        "J", "F", "M", "A", "M", "J", "J", "A", "S", "O", "N", "D"
      ]);
    });
  });

  describe("#weekdays", function() {
    it("should return wide weekdays by default", function() {
      expect(TwitterCldr.Calendar.weekdays()).toEqual({
        "mon": "Monday",   "tue": "Tuesday", "wed": "Wednesday",
        "thu": "Thursday", "fri": "Friday",  "sat": "Saturday",
        "sun": "Sunday"
      });
    });

    it("should return narrow or abbreviated weekdays when asked", function() {
      expect(TwitterCldr.Calendar.weekdays({names_form: "abbreviated"})).toEqual({
        "mon": "Mon", "tue": "Tue", "wed": "Wed",
        "thu": "Thu", "fri": "Fri", "sat": "Sat",
        "sun": "Sun"
      });

      expect(TwitterCldr.Calendar.weekdays({names_form: "narrow"})).toEqual({
        "mon": "M", "tue": "T", "wed": "W",
        "thu": "T", "fri": "F", "sat": "S",
        "sun": "S"
      });
    });
  });
});