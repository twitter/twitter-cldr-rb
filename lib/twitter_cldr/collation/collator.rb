# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Collation

    class Collator

      FRACTIONAL_UCA_SHORT_RESOURCE = 'collation/FractionalUCA_SHORT.txt'

      UNMARKED = 3

      def sort_key(string_or_code_points)
        sort_key_for_code_points(get_integer_code_points(string_or_code_points))
      end

      def trie
        @trie ||= self.class.trie
      end

      def self.trie
        @trie ||= TwitterCldr::Collation::TrieBuilder.load_trie(FRACTIONAL_UCA_SHORT_RESOURCE)
      end

      private

      def sort_key_for_code_points(integer_code_points)
        TwitterCldr::Collation::SortKey.build(get_collation_elements(integer_code_points))
      end

      def get_integer_code_points(str_or_code_points)
        code_points = str_or_code_points.is_a?(String) ? TwitterCldr::Utils::CodePoints.from_string(str_or_code_points) : str_or_code_points

        # Normalization makes the collation process significantly slower (like seven times slower on the UCA
        # non-ignorable test from CollationTest_NON_IGNORABLE.txt). ICU uses some optimizations to apply normalization
        # only in special, rare cases. We need to investigate possible solutions and do normalization cleverly too.
        code_points = TwitterCldr::Normalizers::NFD.normalize_code_points(code_points)

        code_points.map { |cp| cp.to_i(16) }
      end

      def get_collation_elements(integer_code_points)
        result = []
        result.concat(code_point_collation_elements(integer_code_points)) until integer_code_points.empty?
        result
      end

      # Returns the first sequence of fractional collation elements for an array of integer code points. Returned value
      # is an array of well formed (including weights for all significant levels) integer arrays.
      #
      # All used code points are removed from the beginning of the input array.
      #
      def code_point_collation_elements(integer_code_points)
        collation_elements, offset = trie.find_prefix(integer_code_points)

        if collation_elements
          integer_code_points.shift(offset)
          collation_elements
        else
          [implicit_collation_element(integer_code_points.shift)]
        end
      end

      # Generates implicit weights for all code_points. Uses the approach described in
      # http://source.icu-project.org/repos/icu/icuhtml/trunk/design/collation/ICU_collation_design.htm#Implicit_CEs
      # but produces a single fractional collation element without any continuation.
      #
      def implicit_collation_element(code_point)
        # illegal values xxFFFE and xxFFFF are ignored ([] is equivalent to [0, 0, 0] if three levels are accounted)
        return [] if (code_point & 0xFFFE) == 0xFFFE

        code_point < 0xFFFF ? basic_collation_element(code_point) : supplementary_collation_element(code_point)
      end

      def basic_collation_element(code_point)
        # code point: xxxx yyyy yyyy yyyy
        x = code_point >> 12
        y = code_point & 0xFFF

        # fractional collation element: [1101 xxxx 1yyy yyyy yyyy y100, 11, 11]
        [0xD08004 | (x << 16) | (y << 3), UNMARKED, UNMARKED]
      end

      def supplementary_collation_element(code_point)
        code_point -= 0x10000

        # code point: xxxx xxxx xxxy yyyy yyyy
        x = code_point >> 9
        y = code_point & 0x1FF

        # fractional collation element: [1110 xxxx xxxx xxx1 1yyy yyyy yy10 0000]
        [0xE0018020 | (x << 17) | (y << 6), UNMARKED, UNMARKED]
      end

    end

  end
end