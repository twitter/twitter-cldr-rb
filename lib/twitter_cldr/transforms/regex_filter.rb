# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Transforms

    class RegexFilter < Rule
      class << self
        def parse(rule_text)
          new(
            TwitterCldr::Shared::UnicodeRegex.compile(
              unescape(rule_text[2..-2].strip)
            ).to_regexp
          )
        end
      end

      attr_reader :regexp

      def initialize(regexp)
        @regexp = regexp
      end

      def resolve(symbol_table)
        self
      end

      def apply_to(cursor)
        new_text = cursor.text.scan(regexp).each_with_object('') do |match, ret|
          ret << match
        end

        cursor.set_text(new_text)
        cursor.reset_position
      end
    end

  end
end
