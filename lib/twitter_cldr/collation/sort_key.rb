# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Collation

    class SortKey

      PRIMARY_LEVEL, SECONDARY_LEVEL, TERTIARY_LEVEL = 0, 1, 2

      LEVEL_SEPARATOR = 1 # separate levels in a sort key '01' bytes

      TERTIARY_LEVEL_MASK = 0x3F # mask for removing case bits from tertiary weight ('CC' bits in 'CC00 0000')

      # Tertiary level compression constants
      TERTIARY_TOP_ADDITION = 0x80
      TERTIARY_BOTTOM       = 0x05
      TERTIARY_TOP          = 0x85
      TERTIARY_PROPORTION   = 0.667
      TERTIARY_COMMON       = TERTIARY_BOTTOM
      TERTIARY_TOTAL_COUNT  = TERTIARY_TOP - TERTIARY_BOTTOM - 1
      TERTIARY_TOP_COUNT    = TERTIARY_PROPORTION * TERTIARY_TOTAL_COUNT
      TERTIARY_BOTTOM_COUNT = TERTIARY_TOTAL_COUNT - TERTIARY_TOP_COUNT

      attr_reader :collation_elements

      # Returns a sort key as an array of bytes.
      #
      #   collation_elements - an array of collation elements, represented as arrays of integer weights.
      #
      def self.build(collation_elements)
        new(collation_elements).bytes_array
      end

      # Params:
      #
      #   collation_elements - an array of collation elements, represented as arrays of integer weights.
      #
      def initialize(collation_elements)
        @collation_elements = collation_elements
      end

      def bytes_array
        @bytes_array ||= build
      end

      private

      def build
        @bytes_array = []

        append_primary_bytes
        append_secondary_bytes
        append_tertiary_bytes

        @bytes_array
      end

      def append_primary_bytes
        @collation_elements.each do |collation_element|
          append_weight(level_weight(collation_element, PRIMARY_LEVEL))
        end
      end

      def append_secondary_bytes
        @bytes_array << LEVEL_SEPARATOR

        @collation_elements.each do |collation_element|
          append_weight(level_weight(collation_element, SECONDARY_LEVEL))
        end
      end

      def append_tertiary_bytes
        @bytes_array << LEVEL_SEPARATOR
        @common_count = 0

        @collation_elements.each do |collation_element|
          fixnum_to_bytes_array(tertiary_weight(collation_element)).each { |byte| append_tertiary_byte(byte) }
        end

        # append compressed trailing common bytes
        append_compressed_common_bytes(TERTIARY_BOTTOM, TERTIARY_BOTTOM_COUNT, false) if @common_count > 0
      end

      def append_tertiary_byte(tertiary)
        if tertiary == TERTIARY_COMMON
          @common_count += 1
        else
          tertiary += TERTIARY_TOP_ADDITION if tertiary > TERTIARY_COMMON # create a gap above TERTIARY_COMMON

          if @common_count > 0
            if tertiary > TERTIARY_COMMON
              append_compressed_common_bytes(TERTIARY_TOP, TERTIARY_TOP_COUNT, true)
            else
              append_compressed_common_bytes(TERTIARY_BOTTOM, TERTIARY_BOTTOM_COUNT, false)
            end
          end

          @bytes_array << tertiary
        end
      end

      def append_compressed_common_bytes(boundary, count_limit, top)
        sign = top ? -1 : +1

        while @common_count > count_limit
          @bytes_array << boundary + sign * count_limit
          @common_count -= count_limit
        end

        @bytes_array << boundary + sign * (@common_count - 1)
        @common_count = 0
      end

      def tertiary_weight(collation_element)
        level_weight(collation_element, TERTIARY_LEVEL) & TERTIARY_LEVEL_MASK
      end

      def append_weight(weight)
        @bytes_array.concat(fixnum_to_bytes_array(weight))
      end

      def level_weight(collation_element, level)
        collation_element[level] || 0
      end

      def fixnum_to_bytes_array(number)
        bytes = []

        while number > 0
          bytes.unshift(number & 0xFF)
          number >>= 8
        end

        bytes
      end

    end

  end
end