# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

# What's going on here?
# It's a bit too complicated to pass all the original Unicode Bidi tests, so we build our own suite against
# the GNU classpath verison of the Bidi algorithm.  See lib/resources/bidi_test_importer.rb for the
# implementation of the test file generator.

require 'spec_helper'

include TwitterCldr::Shared

BIDI_TEST_PATH = File.join(File.dirname(__FILE__), 'classpath_bidi_test.txt')
DIRECTIONS = [nil, :LTR, :RTL]

def expand_bitset_str(bitset)
  bitset.to_i.to_s(2).rjust(3, "0").chars.to_a.map { |i| i == "1" }.reverse
end

describe Bidi do
  it "should pass the derived tests in classpath_bidi_test.txt", slow: true do
    expected_level_data = []
    expected_reorder_data = []
    num_failed = 0

    File.open(BIDI_TEST_PATH, 'r').each_line do |s|
      cur_line = s.strip
      first_char = cur_line[0]

      case first_char
        when "#"
          next
        when "@"
          if cur_line.include?("@Levels:")
            expected_level_data = cur_line.gsub("@Levels:", "").strip.split(" ").map(&:to_i)
          end

          if cur_line.include?("@Reorder:")
            expected_reorder_data = cur_line.gsub("@Reorder:", "").strip.split(" ").map(&:to_i)
          end
        else
          input, bitset = cur_line.split("; ")
          result_list = []

          expand_bitset_str(bitset).each_with_index do |check, index|
            if check
              types = input.split(" ").map(&:to_sym)
              bidi = TwitterCldr::Shared::Bidi.from_type_array(types, direction: DIRECTIONS[index], default_direction: :LTR)

              passed = bidi.levels.each_with_index.all? do |level, idx|
                level == expected_level_data[idx]
              end

              bidi.instance_variable_set(:'@string_arr', (0..5).to_a[0...types.size])
              bidi.reorder_visually!

              passed &&= bidi.string_arr.each_with_index.all? do |position, idx|
                position == expected_reorder_data[idx]
              end

              num_failed += 1 unless passed
            end
          end
      end
    end

    expect(num_failed).to eq(0)
  end
end