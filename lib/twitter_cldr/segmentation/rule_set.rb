# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Segmentation
    class RuleSet

      class << self
        def load(*args)
          RuleSetBuilder.load(*args)
        end
      end

      attr_reader :locale, :rules, :boundary_type
      attr_accessor :use_uli_exceptions

      alias_method :use_uli_exceptions?, :use_uli_exceptions

      def initialize(locale, rules, boundary_type, options)
        @locale = locale
        @rules = rules
        @boundary_type = boundary_type
        @use_uli_exceptions = options.fetch(
          :use_uli_exceptions, false
        )
      end

      def each_boundary(str)
        if block_given?
          cursor = Cursor.new(str)
          last_boundary = 0

          # implicit start of text boundary
          yield 0

          until cursor.eof?
            match = find_match(cursor)
            rule = match.rule

            if rule.break?
              yield match.boundary_position
              last_boundary = match.boundary_position
            end

            if match.boundary_position == cursor.position
              cursor.advance
            else
              cursor.advance(
                match.boundary_position - cursor.position
              )
            end
          end

          # implicit end of text boundary
          yield str.size unless last_boundary == str.size
        else
          to_enum(__method__, str)
        end
      end

      private

      def each_rule(&block)
        if block_given?
          if use_uli_exceptions? && supports_exceptions?
            yield exception_rule
          end

          rules.each(&block)
        else
          to_enum(__method__)
        end
      end

      def exception_rule
        @exception_rule ||= RuleSetBuilder.exception_rule_for(
          locale, boundary_type
        )
      end

      def supports_exceptions?
        boundary_type == 'sentence'
      end

      def find_match(cursor)
        match = find_cached_match(cursor)

        match || if cursor.eos?
          RuleSetBuilder.implicit_end_of_text_rule.match(cursor)
        else
          RuleSetBuilder.implicit_final_rule.match(cursor)
        end
      end

      def find_cached_match(cursor)
        cursor.match_cache.fetch(cursor.position) do
          matches = match_all(cursor)
          matches.each do |m|
            cursor.match_cache[m.boundary_position - 1] = m
          end
          matches.first
        end
      end

      def match_all(cursor)
        each_rule.each_with_object([]) do |rule, ret|
          if match = rule.match(cursor)
            ret << match
          end
        end
      end
    end
  end
end
