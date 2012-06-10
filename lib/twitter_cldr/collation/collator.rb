# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Collation

    class Collator

      FRACTIONAL_UCA_SHORT_PATH = File.join(TwitterCldr::RESOURCES_DIR, 'collation/FractionalUCA_SHORT.txt')

      FRACTIONAL_UCA_REGEXP = /^((?:[0-9A-F]+)(?:\s[0-9A-F]+)*);\s((?:\[.*?\])(?:\[.*?\])*)$/

      LEVELS_NUMBER = 3

      LEVEL_SEPARATOR  = 0 # separate levels in a sort key '00' bytes
      LEVEL_FILLER     = 2 # fill missing level in a UCA collation element with '02' bytes
      LEVEL_SUBSTITUTE = 0 # fill missing bytes in a UCA collation element level with '00' bytes

      UNMARKED = 3

      def sort_key(string_or_code_points)
        sort_key_for_code_points(get_integer_code_points(string_or_code_points))
      end

      private

      def sort_key_for_code_points(integer_code_points)
        form_sort_key(build_collation_elements(get_fractional_elements(integer_code_points)))
      end

      def collation_elements_trie
        @collation_elements_trie ||= self.class.collation_elements_trie
      end

      def get_integer_code_points(str_or_code_points)
        code_points = str_or_code_points.is_a?(String) ? TwitterCldr::Utils::CodePoints.from_string(str_or_code_points) : str_or_code_points

        # Normalization makes the collation process significantly slower (like seven times slower on the UCA
        # non-ignorable test from CollationTest_NON_IGNORABLE.txt). ICU uses some optimizations to apply normalization
        # only in special, rare cases. We need to investigate possible solutions and do normalization cleverly too.
        code_points = TwitterCldr::Normalizers::NFD.normalize_code_points(code_points)

        code_points.map { |cp| cp.to_i(16) }
      end

      def get_fractional_elements(integer_code_points)
        result = []
        result.concat(fractional_element(integer_code_points)) until integer_code_points.empty?
        result
      end

      def fractional_element(integer_code_points)
        fractional_elements, offset = collation_elements_trie.find_prefix(integer_code_points)

        if fractional_elements
          integer_code_points.shift(offset)
          fractional_elements
        else
          [implicit_fractional_element(integer_code_points.shift)]
        end
      end

      # Generates implicit weights for all code_points. Uses the approach described in
      # http://source.icu-project.org/repos/icu/icuhtml/trunk/design/collation/ICU_collation_design.htm#Implicit_CEs
      # but produces a single fractional collation element without any continuation.
      #
      def implicit_fractional_element(code_point)
        code_point < 0xFFFF ? basic_fractional_element(code_point) : supplementary_fractional_element(code_point)
      end

      def basic_fractional_element(code_point)
        # code point: xxxx yyyy yyyy yyyy
        x = code_point >> 12
        y = code_point & 0xFFF

        # fractional collation element: [1101 xxxx 1yyy yyyy yyyy y100, 11, 11]
        [0xD08004 | (x << 16) | (y << 3), UNMARKED, UNMARKED]
      end

      def supplementary_fractional_element(code_point)
        code_point -= 0x10000

        # code point: xxxx xxxx xxxy yyyy yyyy
        x = code_point >> 9
        y = code_point & 0x1FF

        # fractional collation element: [1110 xxxx xxxx xxx1 1yyy yyyy yy10 0000]
        [0xE0018020 | (x << 17) | (y << 6), UNMARKED, UNMARKED]
      end

      def build_collation_elements(fractional_elements)
        collation_elements = []

        fractional_elements.each do |fractional_element|
          # convert weight on every level to an array of wydes (two bytes): [1180356, 120, 3] => [[4610, 50178], [30722], [770]]
          wydes = fractional_element_to_wydes(fractional_element)

          # transpose wydes arrays: [[4610, 50178], [30722], [770]] => [[4610, 30722, 770], [50178, nil, nil]]
          # i-th element of the resulting array is composed of i-th wydes from every level
          transposed = wydes.shift.zip(*wydes)

          transposed.each do |collation_element|
            # use only LEVELS_NUMBER levels from the collation element
            # fill missing levels with LEVEL_SUBSTITUTE (e.g., 0): [50178, nil, nil] => [50178, 0, 0]
            collation_elements << LEVELS_NUMBER.times.map { |level| collation_element[level] || LEVEL_SUBSTITUTE }
          end
        end

        collation_elements
      end

      # Converts weight on every level of a fractional collation element into an array of wydes (pairs of bytes).
      #
      def fractional_element_to_wydes(fractional_element)
        fractional_element.map do |level_weight|
          fixnum_to_wydes_array(level_weight)
        end
      end

      # Converts an integer into an array of wydes (pairs of bytes). Bytes are paired from left to right and are
      # represented as integers in the returned array.
      #
      def fixnum_to_wydes_array(number)
        return [0] if number.zero?

        bytes = fixnum_to_bytes_array(number)
        bytes << LEVEL_FILLER if bytes.size.odd?
        bytes.each_slice(2).map { |two_bytes| (two_bytes[0] << 8) | two_bytes[1] }
      end

      def fixnum_to_bytes_array(number)
        bytes = []

        while number > 0
          bytes.unshift(number & 0xFF)
          number >>= 8
        end

        bytes
      end

      def form_sort_key(collation_elements)
        result = []

        LEVELS_NUMBER.times do |level|
          result << 0 if level > 0
          collation_elements.each do |collation_element|
            level_weight = collation_element[level]
            result << level_weight if level_weight > 0
          end
        end

        result
      end

      class << self

        def collation_elements_trie
          @collation_elements_trie ||= init_collation_elements_trie
        end

        private

        def init_collation_elements_trie
          parse_collation_elements_trie(load_collation_elements_trie)
        end

        def load_collation_elements_trie
          open(FRACTIONAL_UCA_SHORT_PATH, 'r')
        end

        def parse_collation_elements_trie(table)
          trie = TwitterCldr::Collation::Trie.new

          table.lines.each do |line|
            trie.add(parse_code_points($1), parse_collation_element($2)) if FRACTIONAL_UCA_REGEXP =~ line
          end

          trie
        end

        def parse_code_points(string)
          string.split.map { |cp| cp.to_i(16) }
        end

        def parse_collation_element(string)
          string.scan(/\[.*?\]/).map do |match|
            match[1..-2].gsub(/\s/, '').split(',', -1).map { |bytes| bytes.to_i(16) }
          end
        end

      end

    end

  end
end