// Copyright 2012 Twitter, Inc
// http://www.apache.org/licenses/LICENSE-2.0

var TwitterCldr = require('../../../../lib/assets/javascripts/twitter_cldr/en.js');

describe("IntegerHelper", function() {
  describe("#apply", function() {
    describe("with the ### format", function() {
      beforeEach(function() {
        token = "###";
      });

      it("test: interpolates a number", function() {
        expect(new TwitterCldr.NumberFormatter.IntegerHelper(token).apply(123)).toEqual('123');
      });

      it("test: does not include a fraction for a float", function() {
        expect(new TwitterCldr.NumberFormatter.IntegerHelper(token).apply(123.45)).toEqual('123');
      });

      it("test: does not round when given a float", function() {
        expect(new TwitterCldr.NumberFormatter.IntegerHelper(token).apply(123.55)).toEqual('123');
      });

      it("test: does not round with :precision => 1", function() {
        expect(new TwitterCldr.NumberFormatter.IntegerHelper(token).apply(123.55, {precision: 1})).toEqual('123');
      });
    });

    describe("with the #,## format", function() {
      beforeEach(function() {
        token = "#,##";
      });

      it("test: single group", function() {
        expect(new TwitterCldr.NumberFormatter.IntegerHelper(token).apply(123)).toEqual('1,23');
      });

      it("test: multiple groups with a primary group size", function() {
        expect(new TwitterCldr.NumberFormatter.IntegerHelper(token).apply(123456789)).toEqual('1,23,45,67,89');
      });
    });

    describe("with the #,##0.## format", function() {
      beforeEach(function() {
        token = "#,##0.##";
      });

      it("test: ignores a fraction part given in the format string", function() {
        expect(new TwitterCldr.NumberFormatter.IntegerHelper(token).apply(1234.567)).toEqual('1,234');
      });

      it("test: cldr example #,##0.## => 1 234", function() {
        expect(new TwitterCldr.NumberFormatter.IntegerHelper(token).apply(1234.567)).toEqual('1,234');
      });
    });

    describe("miscellaneous formats", function() {
      it("test: interpolates a number on the right side", function () {
        token = "0###";
        expect(new TwitterCldr.NumberFormatter.IntegerHelper(token).apply(123)).toEqual('0123');
      });

      it("test: strips optional digits", function() {
        token = "######";
        expect(new TwitterCldr.NumberFormatter.IntegerHelper(token).apply(123)).toEqual('123');
      });

      it("test: multiple groups with a primary and secondary group size", function() {
        token = "#,##,##0";
        expect(new TwitterCldr.NumberFormatter.IntegerHelper(token).apply(123456789)).toEqual('12,34,56,789');
      });

      it("test: does not group when no digits left of the grouping position", function() {
        token = "#,###";
        expect(new TwitterCldr.NumberFormatter.IntegerHelper(token).apply(123)).toEqual('123');
      });

      it("test: cldr example #,##0.### => 1 234", function() {
        token = "#,##0.###";
        expect(new TwitterCldr.NumberFormatter.IntegerHelper(token, {group: ' '}).apply(1234.567)).toEqual('1 234');
      });

      it("test: cldr example ###0.##### => 1234", function() {
        token = "###0.#####";
        expect(new TwitterCldr.NumberFormatter.IntegerHelper(token, {group: ' '}).apply(1234.567)).toEqual('1234');
      });

      it("test: cldr example ###0.0000# => 1234", function() {
        token = "###0.0000#";
        expect(new TwitterCldr.NumberFormatter.IntegerHelper(token, {group: ' '}).apply(1234.567)).toEqual('1234');
      });

      it("test: cldr example 00000.0000 => 01234", function() {
        token = "00000.0000";
        expect(new TwitterCldr.NumberFormatter.IntegerHelper(token, {group: ' '}).apply(1234.567)).toEqual('01234');
      });
    });
  });
});