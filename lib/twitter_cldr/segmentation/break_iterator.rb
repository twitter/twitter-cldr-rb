# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Segmentation
    class BreakIterator

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
          @dictionary_set ||= TwitterCldr::Shared::UnicodeSet.new.tap do |set|
            DICTIONARY_BREAK_ENGINES.each do |break_engine|
              set.add_set(break_engine.word_set)
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

      attr_reader :locale, :options

      def initialize(locale = TwitterCldr.locale, options = {})
        @locale = locale
        @options = options
      end

      def each_sentence(str, &block)
        rule_set = rule_set_for('sentence')
        each_boundary(rule_set, str, &block)
      end

      def each_word(str, &block)
        unless TwitterCldr::Normalization.normalized?(str, using: :nfkc)
          raise NonNormalizedStringError, 'string must be normalized using the NFKC '\
            'normalization form in order for the segmentation engine to function correctly'
        end

        each_boundary(each_word_boundary(str))
      end

      def each_grapheme_cluster(str, &block)
        rule_set = rule_set_for('grapheme')
        each_boundary(rule_set.each_boundary(str), &block)
      end

      def each_line(str, &block)
        rule_set = rule_set_for('line')
        each_boundary(rule_set.each_boundary(str), str, &block)
      end

      private

      def is_dictionary_codepoint?(codepoint)
        self.class.dictionary_set.include?(codepoint)
      end

      def each_boundary(enum)
        return to_enum(__method__, enum) unless block_given?

        enum.each_cons(2) do |start, stop|
          yield str[start...stop], start, stop
        end
      end

      def each_word_boundary(str, &block)
        return to_enum(__method__, str) unless block_given?

        rule_set = rule_set_for('word')
        cursor = cursor_for(str)

        # implicit start of text boundary
        last_boundary = 0

        until cursor.eos?
          stop = cursor.position

          # loop until we find a dictionary character
          until stop >= cursor.length || is_dictionary_codepoint?(cursor.codepoint(stop)
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
