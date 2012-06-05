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

      def sort_key(string_or_code_points)
        sort_key_for_code_points(integer_code_points(string_or_code_points))
      end

      private

      def sort_key_for_code_points(integer_code_points)
        form_sort_key(build_collation_elements(get_fractional_elements(integer_code_points)))
      end

      def collation_elements_trie
        @collation_elements_trie ||= self.class.collation_elements_trie
      end

      def integer_code_points(str_or_code_points)
        code_points = str_or_code_points.is_a?(String) ? TwitterCldr::Utils::CodePoints.from_string(str_or_code_points) : str_or_code_points
        code_points.map { |cp| cp.to_i(16) }
      end

      def get_fractional_elements(integer_code_points)
        result = []

        until integer_code_points.empty?
          fractional_elements, offset = get_fractional_element(integer_code_points)

          if fractional_elements
            result.concat(fractional_elements)
            integer_code_points.shift(offset)
          else
            raise CollationElementNotFound.new("Fractional collation elements for the prefix of #{integer_code_points.inspect} not found.")
          end
        end

        result
      end

      def get_fractional_element(integer_code_points)
        code_point = integer_code_points.first

        # ignore all values xxFFFE and xxFFFF and all unpaired surrogates (high: D800–DBFF, and low: DC00–DFFF)
        if (code_point & 0xFFFE) == 0xFFFE || code_point.between?(0xD800, 0xDFFF)
          [[[0]] * LEVELS_NUMBER, 1]
        else
          collation_elements_trie.find_prefix(integer_code_points)
        end
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

      def fractional_element_to_wydes(fractional_element)
        fractional_element.map do |level_weight|
          fixnum_to_wydes_array(level_weight)
        end
      end

      def fixnum_to_wydes_array(number)
        bytes = fixnum_to_bytes_array(number)
        bytes << LEVEL_FILLER if bytes.size.odd?
        bytes.each_slice(2).map { |two_bytes| (two_bytes[0] << 8) + two_bytes[1] }
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

    class CollationElementNotFound < ArgumentError; end

  end
end