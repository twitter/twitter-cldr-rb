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
        rule_set.each_boundary(str, &block)
      end

      def each_word(str, &block)
        rule_set = rule_set_for('word')
        rule_set.each_boundary(str, &block)
      end

      def each_grapheme_cluster(str, &block)
        raise NotImplementedError,
          "Grapheme segmentation is not currently supported."
      end

      def each_line(str, &block)
        raise NotImplementedError,
          "Line segmentation is not currently supported."
      end

      private

      def rule_set_for(boundary_type)
        RuleSet.load(locale, boundary_type, options)
      end
    end
  end
end
