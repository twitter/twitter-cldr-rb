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

      def implicit_collation_element(code_point)
        # illegal values xxFFFE and xxFFFF are ignored ([] is equivalent to [0, 0, 0])
        return [] if (code_point & 0xFFFE) == 0xFFFE

        implicit_ce_generator.get_collation_element(code_point)
      end

      def implicit_ce_generator
        @implicit_ce_generator ||= TwitterCldr::Collation::ImplicitCEGenerator.new
      end

    end

  end
end