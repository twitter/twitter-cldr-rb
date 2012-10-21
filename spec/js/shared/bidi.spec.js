// Copyright 2012 Twitter, Inc
// http://www.apache.org/licenses/LICENSE-2.0

var TwitterCldr = require('../../../lib/assets/javascripts/twitter_cldr/en.js');
var fs = require('fs');

var BIDI_TEST_PATH = __dirname + '/classpath_bidi_test.txt';
var DIRECTIONS = [null, "LTR", "RTL"];

expand_bitset_str = function(bitset) {
  var padded_str = ("0000" + parseInt(bitset).toString(2)).slice(-3);
  var result = [], idx;

  for (idx in padded_str) {
    result.push(padded_str[idx] == "1");
  }

  return result.reverse();
};

describe("Bidi", function() {
  it("should pass the derived tests in classpath_bidi_test.txt", function() {
    var data = fs.readFileSync(BIDI_TEST_PATH, "ASCII").split("\n");

    var expected_level_data = [];
    var expected_reorder_data = [];
    var num_failed = 0;
    var num_succeeded = 0;

    var input_bitset, input, bitset, result_list, bitset_arr, index, check;
    var types, bidi, passed, idx, level, levels, level_idx, string_arr, i;
    var position, positions, pos_idx, line_idx, cur_line, first_char;

    for (line_idx in data) {
      cur_line = data[line_idx].trim();
      first_char = cur_line[0];

      switch (first_char) {
        case "#":
          continue;

        case "@":
          if (cur_line.indexOf("@Levels:") > -1) {
            expected_level_data = [];
            levels = cur_line.replace("@Levels:", "").trim().split(" ");
            for (level_idx in levels) { expected_level_data.push(parseInt(levels[level_idx])); }
          }

          if (cur_line.indexOf("@Reorder:") > -1) {
            expected_reorder_data = [];
            positions = cur_line.replace("@Reorder:", "").trim().split(" ");
            for (pos_idx in positions) { expected_reorder_data.push(parseInt(positions[pos_idx])); }
          }

          break;

        default:
          input_bitset = cur_line.split("; ");
          input = input_bitset[0];
          bitset = input_bitset[1];
          result_list = [];
          bitset_arr = expand_bitset_str(bitset);

          for (index in bitset_arr) {
            check = bitset_arr[index];

            if (check) {
              types = input.split(" ");
              bidi = TwitterCldr.Bidi.from_type_array(types, {direction: DIRECTIONS[index], default_direction: "LTR"});
              passed = true;

              for (idx in bidi.levels) {
                level = bidi.levels[idx];
                passed = passed && (level === expected_level_data[idx]);
              }

              string_arr = [];

              for (i = 0; i < types.length; i ++) {
                string_arr.push(i);
              }

              bidi.string_arr = string_arr;
              bidi.reorder_visually();

              for (idx in bidi.string_arr) {
                position = bidi.string_arr[idx];
                passed = passed && (position === expected_reorder_data[idx]);
              }

              if (passed) {
                num_succeeded += 1;
              } else {
                num_failed += 1;
              }
            }
          }

          break;
      }
    }

    expect(num_failed).toEqual(0);
  });
});