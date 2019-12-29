# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'set'

module TwitterCldr
  module Segmentation
    class DeormalizedStringError < StandardError; end

    class WordIterator < SegmentIterator
      DICTIONARY_BREAK_ENGINES = [
        CjBreakEngine,
        BurmeseBreakEngine,
        KhmerBreakEngine,
        LaoBreakEngine,
        ThaiBreakEngine
      ]

      class << self
        # all dictionary characters, i.e. characters that must be handled
        # by one of the dictionary-based break engines
        def dictionary_set
          @dictionary_set ||= Set.new.tap do |set|
            DICTIONARY_BREAK_ENGINES.each do |break_engine|
              set.merge(break_engine.word_set)
            end
          end
        end

        def dictionary_break_engine_for(codepoint)
          codepoint_to_engine_cache[codepoint] ||= begin
            engine = DICTIONARY_BREAK_ENGINES.find do |break_engine|
              break_engine.word_set.include?(codepoint)
            end

            engine || UnhandledBreakEngine.instance
          end
        end

        private

        def codepoint_to_engine_cache
          @codepoint_to_engine_cache ||= {}
        end
      end

      def initialize(rule_set, str)
        unless TwitterCldr::Normalization.normalized?(str, using: :nfkc)
          raise DeormalizedStringError, 'string must be normalized using the NFKC '\
            'normalization form in order for the segmentation engine to function correctly'
        end

        super
      end

      def each_boundary
        return to_enum(__method__) unless block_given?

        # implicit start of text boundary
        last_boundary = 0
        yield 0

        until cursor.eos?
          stop = cursor.position

          # loop until we find a dictionary character
          until stop >= cursor.length || is_dictionary_codepoint?(cursor.codepoint(stop))
            stop += 1
          end

          # break with normal, state-based break engine
          if stop > cursor.position
            rule_set.each_boundary(cursor, stop) do |boundary|
              last_boundary = boundary
              yield boundary
            end
          end

          # make sure we're not at the end of the road after breaking the
          # latest sequence of non-dictionary characters
          break if cursor.eos?

          # find appropriate dictionary-based break engine
          break_engine = self.class.dictionary_break_engine_for(cursor.codepoint)

          # break using dictionary-based engine
          break_engine.instance.each_boundary(cursor) do |boundary|
            last_boundary = boundary
            yield boundary
          end
        end

        # implicit end of text boundary
        yield cursor.length if last_boundary != cursor.length
      end

      private

      def is_dictionary_codepoint?(codepoint)
        self.class.dictionary_set.include?(codepoint)
      end
    end
  end
end
