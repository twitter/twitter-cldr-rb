// Copyright 2012 Twitter, Inc
// http://www.apache.org/licenses/LICENSE-2.0

var TwitterCldr = require('../../lib/assets/javascripts/twitter_cldr/en.js');

describe("Utilities", function() {
  beforeEach(function() {
  });

  describe("#is_even", function() {
    it("should return true if the given number is even", function() {
      for(var i = 0; i <= 1000; i += 2) {
        expect(TwitterCldr.Utilities.is_even(i)).toEqual(true);
      }
    });

    it("should return false if the given number is odd", function() {
      for(var i = 1; i < 1000; i += 2) {
        expect(TwitterCldr.Utilities.is_even(i)).toEqual(false);
      }
    });
  });

  describe("#is_odd", function() {
    it("should return true if the given number is odd", function() {
      for(var i = 1; i < 1000; i += 2) {
        expect(TwitterCldr.Utilities.is_odd(i)).toEqual(true);
      }
    });

    it("should return false if the given number is even", function() {
      for(var i = 0; i <= 1000; i += 2) {
        expect(TwitterCldr.Utilities.is_odd(i)).toEqual(false);
      }
    });
  });

  describe("#max", function() {
    it("should work for a basic array of integers", function() {
      expect(TwitterCldr.Utilities.max([100, 4, 81, 30, 122])).toEqual(122);
      expect(TwitterCldr.Utilities.max([100, 4, 122, 81, 30])).toEqual(122);
      expect(TwitterCldr.Utilities.max([122, 100, 4, 81, 30])).toEqual(122);
      expect(TwitterCldr.Utilities.max([5, 5, 5, 5, 5])).toEqual(5);
    });

    it("should work for an array that contains a few undefineds", function() {
      expect(TwitterCldr.Utilities.max([1, 2, undefined, 3, 4])).toEqual(4);
      expect(TwitterCldr.Utilities.max([undefined, 1, 2, 3, 4])).toEqual(4);
      expect(TwitterCldr.Utilities.max([1, 2, 3, 4, undefined])).toEqual(4);
    });
  });

  describe("#min", function() {
    it("should work for a basic array of integers", function() {
      expect(TwitterCldr.Utilities.min([100, 4, 81, 30, 122])).toEqual(4);
      expect(TwitterCldr.Utilities.min([100, 4, 122, 81, 30])).toEqual(4);
      expect(TwitterCldr.Utilities.min([122, 100, 4, 81, 30])).toEqual(4);
      expect(TwitterCldr.Utilities.min([5, 5, 5, 5, 5])).toEqual(5);
    });

    it("should work for an array that contains a few undefineds", function() {
      expect(TwitterCldr.Utilities.min([1, 2, undefined, 3, 4])).toEqual(1);
      expect(TwitterCldr.Utilities.min([undefined, 1, 2, 3, 4])).toEqual(1);
      expect(TwitterCldr.Utilities.min([1, 2, 3, 4, undefined])).toEqual(1);
    });
  });

  describe("#arraycopy", function() {
    it("should copy to and from a basic array", function() {
      var array = [1, 2, 3, 4, 5, 6];
      TwitterCldr.Utilities.arraycopy(array, 0, array, 3, 3);
      expect(array).toEqual([1, 2, 3, 1, 2, 3]);
    });

    it("should copy to and from two separate arrays", function() {
      var first_array  = [1, 2, 3, 4, 5, 6];
      var second_array = [7, 8, 9, 10, 11, 12];
      TwitterCldr.Utilities.arraycopy(first_array, 3, second_array, 3, 3);
      expect(second_array).toEqual([7, 8, 9, 4, 5, 6]);
      expect(first_array).toEqual([1, 2, 3, 4, 5, 6]);
    });
  });

  describe("#pack_array", function() {
    it("should convert code points to their string equivalent", function() {
      expect(TwitterCldr.Utilities.pack_array([7998])).toEqual("\u1f3e");
    });
  });

  describe("#unpack_string", function() {
    it("should convert a string to to an array of code points", function() {
      expect(TwitterCldr.Utilities.unpack_string("\u1f3e")).toEqual([7998]);
    });
  });

  describe("#from_char_code", function() {
    it("should be able to convert a code point less than 0xFFFF", function() {
      expect(TwitterCldr.Utilities.from_char_code(0x1ABC).length).toEqual(1);
    });

    it("should be able to convert a code point greater than 0xFFFF", function() {
      // NOTE: JavaScript stores strings in UTF-16 encoding, hence the 2 bytes here instead of 4.
      expect(TwitterCldr.Utilities.from_char_code(0x2F804).length).toEqual(2);
    });
  });

  describe("#char_code_at", function() {
    it("should be able to get the correct character in a string of single-byte characters", function() {
      expect(TwitterCldr.Utilities.char_code_at("ABC", 0)).toEqual(65);
      expect(TwitterCldr.Utilities.char_code_at("ABC", 1)).toEqual(66);
      expect(TwitterCldr.Utilities.char_code_at("ABC", 2)).toEqual(67);
    });

    it("should be able to get the correct character in a string of multi-byte characters", function() {
      var str = TwitterCldr.Utilities.pack_array([0x2F804, 0x1F3E9]);
      expect(TwitterCldr.Utilities.char_code_at(str, 0)).toEqual(194564);
      expect(TwitterCldr.Utilities.char_code_at(str, 1)).toEqual(127977);
    });
  });
});