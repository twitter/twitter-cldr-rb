# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Collation

    # SortKeyBuilder builds a collation sort key from an array of collation elements.
    #
    # Weights compression algorithms for every level are described in http://source.icu-project.org/repos/icu/icuhtml/trunk/design/collation/ICU_collation_design.htm
    #
    class SortKeyBuilder

      PRIMARY_LEVEL, SECONDARY_LEVEL, TERTIARY_LEVEL = 0, 1, 2

      LEVEL_SEPARATOR = 1 # separate levels in a sort key '01' bytes

      TERTIARY_LEVEL_MASK = 0x3F # mask for removing case bits or continuation flag from a tertiary weight

      PRIMARY_BYTE_MIN = 0x3
      PRIMARY_BYTE_MAX = 0xFF

      MIN_NON_LATIN_PRIMARY = 0x5B
      MAX_REGULAR_PRIMARY   = 0x7A

      attr_reader :collation_elements

      # Returns a sort key as an array of bytes.
      #
      # Arguments:
      #
      #   collation_elements - an array of collation elements, represented as arrays of integer weights.
      #
      # An instance of the class is created only to prevent passing of @collation_elements and @bytes_array from one
      # method into another while forming the sort key.
      #
      def self.build(collation_elements)
        new(collation_elements).bytes_array
      end

      # Arguments:
      #
      #   collation_elements - an array of collation elements, represented as arrays of integer weights.
      #
      def initialize(collation_elements)
        @collation_elements = collation_elements
      end

      def bytes_array
        @bytes_array ||= build_bytes_array
      end

      private

      def build_bytes_array
        @bytes_array = []

        append_primary_bytes
        append_secondary_bytes
        append_tertiary_bytes

        @bytes_array
      end

      def append_primary_bytes
        @last_leading_byte = nil

        @collation_elements.each do |collation_element|
          bytes = fixnum_to_bytes_array(level_weight(collation_element, PRIMARY_LEVEL))

          unless bytes.empty?
            leading_byte = bytes.shift

            if leading_byte != @last_leading_byte
              @bytes_array << (leading_byte < @last_leading_byte ? PRIMARY_BYTE_MIN : PRIMARY_BYTE_MAX) if @last_leading_byte
              @bytes_array << leading_byte

              @last_leading_byte = !bytes.empty? && compressible_primary?(leading_byte) ? leading_byte : nil
            end

            @bytes_array.concat(bytes)
          end
        end
      end

      def compressible_primary?(leading_byte)
        (MIN_NON_LATIN_PRIMARY..MAX_REGULAR_PRIMARY).include?(leading_byte)
      end

      def append_secondary_bytes
        @bytes_array << LEVEL_SEPARATOR

        @common_count = 0

        @collation_elements.each do |collation_element|
          fixnum_to_bytes_array(level_weight(collation_element, SECONDARY_LEVEL)).each do |byte|
            append_secondary_byte(byte)
          end
        end

        # append compressed trailing common bytes
        append_common_bytes(SECONDARY_BOTTOM, SECONDARY_BOTTOM_COUNT, false) if @common_count > 0
      end

      def append_tertiary_bytes
        @bytes_array << LEVEL_SEPARATOR

        @common_count = 0

        @collation_elements.each do |collation_element|
          fixnum_to_bytes_array(tertiary_weight(collation_element)).each do |byte|
            append_tertiary_byte(byte)
          end
        end

        # append compressed trailing common bytes
        append_common_bytes(TERTIARY_BOTTOM, TERTIARY_BOTTOM_COUNT, false) if @common_count > 0
      end

      def append_secondary_byte(secondary)
        if secondary == SECONDARY_COMMON
          @common_count += 1
        else
          append_with_common_bytes(secondary, SECONDARY_COMMON_SPACE)
        end
      end

      def append_tertiary_byte(tertiary)
        if tertiary == TERTIARY_COMMON
          @common_count += 1
        else
          tertiary += TERTIARY_TOP_ADDITION if tertiary > TERTIARY_COMMON # create a gap above TERTIARY_COMMON
          append_with_common_bytes(tertiary, TERTIARY_COMMON_SPACE)
        end
      end

      def append_with_common_bytes(byte, options)
        if @common_count > 0
          if byte < options[:common]
            append_common_bytes(options[:bottom], options[:bottom_count], false)
          else
            append_common_bytes(options[:top], options[:top_count], true)
          end
        end

        @bytes_array << byte
      end

      def append_common_bytes(boundary, count_limit, top)
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

      # Secondary level compression constants

      SECONDARY_BOTTOM       = 0x05
      SECONDARY_TOP          = 0x86
      SECONDARY_PROPORTION   = 0.5
      SECONDARY_COMMON       = SECONDARY_BOTTOM
      SECONDARY_TOTAL_COUNT  = SECONDARY_TOP - SECONDARY_BOTTOM - 1
      SECONDARY_TOP_COUNT    = (SECONDARY_PROPORTION * SECONDARY_TOTAL_COUNT).to_i
      SECONDARY_BOTTOM_COUNT = SECONDARY_TOTAL_COUNT - SECONDARY_TOP_COUNT

      SECONDARY_COMMON_SPACE = {
          :common       => SECONDARY_COMMON,
          :bottom       => SECONDARY_BOTTOM,
          :bottom_count => SECONDARY_BOTTOM_COUNT,
          :top          => SECONDARY_TOP,
          :top_count    => SECONDARY_TOP_COUNT
      }

      # Tertiary level compression constants

      TERTIARY_TOP_ADDITION = 0x80

      TERTIARY_BOTTOM       = 0x05
      TERTIARY_TOP          = 0x85
      TERTIARY_PROPORTION   = 0.667
      TERTIARY_COMMON       = TERTIARY_BOTTOM
      TERTIARY_TOTAL_COUNT  = TERTIARY_TOP - TERTIARY_BOTTOM - 1
      TERTIARY_TOP_COUNT    = (TERTIARY_PROPORTION * TERTIARY_TOTAL_COUNT).to_i
      TERTIARY_BOTTOM_COUNT = TERTIARY_TOTAL_COUNT - TERTIARY_TOP_COUNT

      TERTIARY_COMMON_SPACE = {
          :common       => TERTIARY_COMMON,
          :bottom       => TERTIARY_BOTTOM,
          :bottom_count => TERTIARY_BOTTOM_COUNT,
          :top          => TERTIARY_TOP,
          :top_count    => TERTIARY_TOP_COUNT
      }

    end

  end
end