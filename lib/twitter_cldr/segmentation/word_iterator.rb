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

      def each_boundary(str, &block)
        return to_enum(__method__, str) unless block_given?

        last_boundary = nil

        each_boundary_helper(str) do |boundary|
          if boundary != last_boundary
            yield boundary
          end

          last_boundary = boundary
        end
      end

      private

      def each_boundary_helper(str, &block)
        dict_cursor = create_cursor(str)
        rule_cursor = dict_cursor.dup

        # implicit start of text boundary
        yield 0

        # advance to next dictionary position
        until dict_cursor.eos? || rule_cursor.eos?
          m = dictionary_re.match(dict_cursor.text, dict_cursor.position)
          break unless m

          dict_cursor.position = m.begin(0)
          dict_break_engine = dictionary_break_engine_for(dict_cursor.codepoint)
          dict_enum = dict_break_engine.each_boundary(dict_cursor)

          dict_boundary = begin
            dict_enum.peek
          rescue StopIteration
            nil
          end

          if dict_boundary
            if rule_cursor.position < m.begin(0)
              rule_set.each_boundary(rule_cursor, m.begin(0), &block)
            end

            loop do
              yield dict_enum.next
            end

            yield dict_cursor.position

            rule_cursor.position = dict_cursor.position
          else
            dict_cursor.advance
          end
        end

        unless rule_cursor.eos?
          rule_set.each_boundary(rule_cursor, &block)
        end

        # implicit end of text boundary
        yield rule_cursor.length
      end

      # all dictionary characters, i.e. characters that must be handled
      # by one of the dictionary-based break engines
      def dictionary_set
        @@dictionary_set ||= Set.new.tap do |set|
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

          (engine || UnhandledBreakEngine).instance
        end
      end

      def dictionary_re
        @@dictionary_re ||= begin
          ranges = TwitterCldr::Utils::RangeSet.from_array(dictionary_set).ranges.map do |r|
            "\\u{#{r.first.to_s(16)}}-\\u{#{r.last.to_s(16)}}"
          end

          /[#{ranges.join}]/
        end
      end

      private

      def codepoint_to_engine_cache
        @@codepoint_to_engine_cache ||= {}
      end
    end
  end
end
