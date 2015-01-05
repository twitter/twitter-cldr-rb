# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Transforms

    class Cursor
      attr_reader :text, :direction, :position, :ranges

      def initialize(text, direction = :forward)
        set_text(text)
        @direction = direction
        reset_position

        @ranges = TwitterCldr::Utils::RangeSet.new(
          [0..(text.length - 1)]
        )
      end

      def advance(amount = 1)
        @position += amount
      end

      def set_text(new_text)
        @text = new_text
      end

      def set_ranges(range_set)
        @ranges = range_set
      end

      def each_range(&block)
        if block_given?
          ranges.ranges.each(&block)
        else
          to_enum(__method__)
        end
      end

      def reset_position
        @position = 0
      end

      def eos?
        position >= text.size
      end
    end

  end
end
