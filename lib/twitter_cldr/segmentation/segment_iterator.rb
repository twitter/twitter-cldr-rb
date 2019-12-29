# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Segmentation
    class SegmentIterator
      attr_reader :rule_set, :cursor

      def initialize(rule_set, str)
        @rule_set = rule_set
        @cursor = Cursor.new(str)
      end

      def each_segment
        return to_enum(__method__) unless block_given?

        each_boundary.each_cons(2) do |start, stop|
          yield cursor.text[start...stop], start, stop
        end
      end

      def each_boundary(&block)
        return to_enum(__method__) unless block_given?

        # implicit start of text boundary
        yield 0

        rule_set.each_boundary(cursor, &block)
      end
    end
  end
end
