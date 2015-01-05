# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Transforms

    class RegexFilter < Filter
      class << self
        def parse(rule_text, symbol_table)
          rule_text = unescape(rule_text[2..-2].strip)
          inverse = inverse?(rule_text)

          str = TwitterCldr::Shared::UnicodeRegex.compile(
            clean_rule(rule_text, inverse)
          ).to_regexp_str

          new(/#{str}/n)
        end

        protected

        def inverse?(rule_text)
          rule_text.start_with?('(')
        end

        def clean_rule(rule_text, inverse)
          if inverse
            rule_text[1..-2]
          else
            rule_text
          end
        end
      end

      attr_reader :regexp, :inverse
      alias :inverse? :inverse

      def initialize(regexp, inverse = false)
        @regexp = regexp
        @inverse = inverse
      end

      def resolve(symbol_table)
        self
      end

      def apply_to(cursor)
        cursor.set_ranges(
          cursor.ranges.intersection(
            ranges_for(cursor)
          )
        )
      end

      protected

      def ranges_for(cursor)
        TwitterCldr::Utils::RangeSet.new(
          [].tap do |ranges|
            cursor.text.scan(regexp) do
              start, finish = Regexp.last_match.offset(0)
              ranges << (start..(finish - 1))
            end
          end
        )
      end
    end

  end
end
