# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Shared

BIDI_TEST_PATH = File.join(File.dirname(__FILE__), 'classpath_bidi_test.txt')
DIRECTIONS = [nil, :LTR, :RTL]

def expand_bitset_str(bitset)
  bitset.to_i.to_s(2).rjust(3, "0").chars.to_a.map { |i| i == "1" }.reverse
end

describe Bidi do
  it "should pass the derived tests in classpath_bidi_test.txt" do
    expected_level_data = []
    expected_reorder_data = []
    num_succeeded = 0
    num_failed = 0

    File.open(BIDI_TEST_PATH, 'r').each_line do |s|
      cur_line = s.strip
      first_char = cur_line[0]
      first_char = first_char.chr if first_char.is_a?(Fixnum)  # conversion for ruby 1.8

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
              bidi = TwitterCldr::Shared::Bidi.from_type_array(types, :direction => DIRECTIONS[index], :default_direction => :LTR)

              passed = bidi.levels.each_with_index.all? do |level, idx|
                level == expected_level_data[idx]
              end

              bidi.instance_variable_set(:'@string_arr', (0..5).to_a[0...types.size])
              bidi.reorder_visually!

              passed &&= bidi.string_arr.each_with_index.all? do |position, idx|
                position == expected_reorder_data[idx]
              end

              passed ? num_succeeded += 1 : num_failed += 1
            end
          end

          $stdout.write("\rSucceeded: #{num_succeeded}, Failed: #{num_failed}")
      end
    end

    $stdout.write("\n")
    num_failed.should == 0
  end
end