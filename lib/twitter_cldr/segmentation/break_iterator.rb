# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Segmentation
    class BreakIterator
      attr_reader :locale, :options

      def initialize(locale = TwitterCldr.locale, options = {})
        @locale = locale
        @options = options
      end

      def each_sentence(str, &block)
        iter = iterator_for('sentence')
        iter.each_segment(str, &block)
      end

      def each_word(str, &block)
        iter = iterator_for('word')
        iter.each_segment(str, &block)
      end

      def each_grapheme_cluster(str, &block)
        iter = iterator_for('grapheme')
        iter.each_segment(str, &block)
      end

      def each_line(str, &block)
        iter = iterator_for('line')
        iter.each_segment(str, &block)
      end

      private

      def iterator_for(boundary_type)
        iterator_cache[boundary_type] ||= begin
          rule_set = RuleSet.create(locale, boundary_type, options)

          case boundary_type
            when 'line'
              LineIterator.new(rule_set)
            when 'word'
              WordIterator.new(rule_set)
            else
              SegmentIterator.new(rule_set)
          end
        end
      end

      def iterator_cache
        @iterator_cache ||= {}
      end
    end
  end
end
