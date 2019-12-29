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
        rule_set = rule_set_for('sentence')
        iter = SegmentIterator.new(rule_set, str)
        iter.each_segment(&block)
      end

      def each_word(str, &block)
        rule_set = rule_set_for('word')
        iter = WordIterator.new(rule_set, str)
        iter.each_segment(&block)
      end

      def each_grapheme_cluster(str, &block)
        rule_set = rule_set_for('grapheme')
        iter = SegmentIterator.new(rule_set, str)
        iter.each_segment(&block)
      end

      def each_line(str, &block)
        rule_set = rule_set_for('line')
        iter = LineIterator.new(rule_set, str)
        iter.each_segment(&block)
      end

      private

      def rule_set_for(boundary_type)
        rule_set_cache[boundary_type] ||= RuleSet.create(
          locale, boundary_type, options
        )
      end

      def rule_set_cache
        @rule_set_cache ||= {}
      end
    end
  end
end
