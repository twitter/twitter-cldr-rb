# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Collation

    class SortKey

      PRIMARY_LEVEL, SECONDARY_LEVEL, TERTIARY_LEVEL = 0, 1, 2

      LEVEL_SEPARATOR = 1 # separate levels in a sort key '01' bytes

      TERTIARY_LEVEL_MASK = 0x3F # mask for removing case bits from tertiary weight ('CC' bits in 'CC00 0000')

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

        @collation_elements.each do |collation_element|
          append_weight(level_weight(collation_element, TERTIARY_LEVEL) & TERTIARY_LEVEL_MASK)
        end
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