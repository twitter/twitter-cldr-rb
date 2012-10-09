// Copyright 2012 Twitter, Inc
// http://www.apache.org/licenses/LICENSE-2.0

var TwitterCldr = require('../../lib/assets/javascripts/twitter_cldr/en.js');

describe("ListFormatter", function() {
  beforeEach(function() {
    formatter = new TwitterCldr.ListFormatter();
  });

  describe("with an initialized list formatter", function() {
    describe("#compose", function() {
      it("should format a variable number of elements correctly", function() {
        var list = ["larry", "curly", "moe"];
        expect(formatter.compose("{0} - {1} - {2}", list)).toEqual("larry - curly - moe");
        expect(formatter.compose("{0} - {1}", list)).toEqual("larry - curly");
        expect(formatter.compose("{0}", list)).toEqual("larry");
        expect(formatter.compose("", list)).toEqual("");
      });

      it("should return the first element if the list only contains a single element", function() {
        expect(formatter.compose("{0} - {1}", ["larry"])).toEqual("larry");
      });

      it("should return an empty string if the list is empty", function() {
        expect(formatter.compose("{0} - {1}", [])).toEqual("");
      });
    });

    describe("with a standard resource", function() {
      beforeEach(function() {
        formatter.formats = {
          2        : "{0} $ {1}",
          "middle" : "{0}; {1}",
          "start"  : "{0}< {1}",
          "end"    : "{0}> {1}"
        }
      });

      describe("#compose_list", function() {
        it("should compose a list with two elements using the 'end' format", function() {
          expect(formatter.compose_list(["larry", "curly"])).toEqual("larry> curly");
        });

        it("should compose a list with three elements using the 'start' and 'end' formats", function() {
          expect(formatter.compose_list(["larry", "curly", "moe"])).toEqual("larry< curly> moe");
        });

        it("should compose a list with four elements using all the formats ('start', 'middle', and 'end')", function() {
          expect(formatter.compose_list(["larry", "curly", "moe", "jerry"])).toEqual("larry< curly; moe> jerry");
        });

        it("should compose a list of five elements just for the hell of it", function() {
          expect(formatter.compose_list(["larry", "curly", "moe", "jerry", "helga"])).toEqual("larry< curly; moe; jerry> helga");
        });
      });

      describe("#format", function() {
        it("should format correctly using the integer index if it exists", function() {
          expect(formatter.format(["larry", "curly"])).toEqual("larry $ curly");
        });

        it("should format correctly if no corresponding integer index exists", function() {
          expect(formatter.format(["larry", "curly", "moe"])).toEqual("larry< curly> moe");
        });
      });
    });

    describe("with a resource that doesn't contain a start or end", function() {
      beforeEach(function() {
        formatter.formats = { "middle": "{0}; {1}" };
      });

      describe("#compose_list", function() {
        it("should correctly compose a list with four elements, falling back to 'middle' for the beginning and end", function() {
          expect(formatter.compose_list(["larry", "curly", "moe", "jerry"])).toEqual("larry; curly; moe; jerry");
        });
      });
    });

    describe("with an empty resource", function() {
      beforeEach(function() {
        formatter.formats = {}
      });

      describe("#compose_list", function() {
        it("should return a blank string since no formats are available", function() {
          expect(formatter.compose_list(["larry", "curly", "moe"])).toEqual("");
        });
      });
    });
  });
});