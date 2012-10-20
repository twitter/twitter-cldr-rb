// Copyright 2012 Twitter, Inc
// http://www.apache.org/licenses/LICENSE-2.0

var TwitterCldr = require('../../lib/assets/javascripts/twitter_cldr/en.js');
var fs = require('fs');

var BIDI_TEST_PATH = 'classpath_bidi_test.txt';
var DIRECTIONS = [null, "LTR", "RTL"];

expand_bitset_str = function(bitset) {
  var padded_str = ("0000" + parseInt(bitset).toString(2)).slice(-3);
  var result = [];

  for (idx in padded_str) {
    result.push(padded_str[idx] == "1");
  }

  return result.reverse();
}

describe("Bidi", function() {
  it("should pass the derived tests in classpath_bidi_test.txt", function() {
    expected_level_data = [];
    expected_reorder_data = [];
    num_failed = 0;
    num_succeeded = 0;

    data = fs.readFileSync(BIDI_TEST_PATH, "ASCII").split("\n");

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
            for (level_idx in levels) { expected_level_data.push(parseInt(levels[level_idx])) }
          }

          if (cur_line.indexOf("@Reorder:") > -1) {
            expected_reorder_data = [];
            positions = cur_line.replace("@Reorder:", "").trim().split(" ");
            for (pos_idx in positions) { expected_reorder_data.push(parseInt(positions[pos_idx])) }
          }

          break;

        default:
          input_bitset = cur_line.split("; ");
          input = input_bitset[0];
          bitset = input_bitset[1];
          result_list = [];

          for check, index in expand_bitset_str(bitset)
            if check
              types = input.split(" ")
              bidi = TwitterCldr.Bidi.from_type_array(types, {direction: DIRECTIONS[index], default_direction: "LTR"})

              passed = true

              for level, idx in bidi.levels
                passed = passed && (level is expected_level_data[idx])

              bidi.string_arr = (i for i in [0..5])[0...types.length]
              bidi.reorder_visually()

              for position, idx in bidi.string_arr
                passed = passed && (position is expected_reorder_data[idx])

              if passed
                num_succeeded += 1
              else
                num_failed += 1

              process.stdout.write("\rSucceeded: #{num_succeeded} Failed: #{num_failed}")
          }
      }
    }
  });
});