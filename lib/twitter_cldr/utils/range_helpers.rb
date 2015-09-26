# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'set'

module TwitterCldr
  module Utils

    module RangeHelpers
      def overlap?(range1, range2)
        is_numeric_range?(range1) && is_numeric_range?(range2) && (
          front_overlap?(range1, range2) ||
            rear_overlap?(range1, range2) ||
            full_overlap?(range1, range2)
        )
      end

      def front_overlap?(range1, range2)
        range1.last >= range2.first && range1.last <= range2.last
      end

      def rear_overlap?(range1, range2)
        range1.first >= range2.first && range1.first <= range2.last
      end

      def full_overlap?(range1, range2)
        range1.first <= range2.first && range1.last >= range2.last
      end

      def exact_overlap?(range1, range2)
        range1.first == range2.first && range1.last == range2.last
      end

      # returns true if range1 and range2 are within 1 of each other
      def adjacent?(range1, range2)
        is_numeric_range?(range1) && is_numeric_range?(range2) &&
          (range1.last == range2.first - 1 || range2.first == range1.last + 1)
      end

      def is_numeric_range?(range)
        range.first.is_a?(Numeric) && range.last.is_a?(Numeric)
      end
    end

  end
end
