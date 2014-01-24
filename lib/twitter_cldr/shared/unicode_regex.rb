# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

include TwitterCldr::Utils

module TwitterCldr
  module Shared
    class UnicodeRegex

      class << self

        # All unicode characters
        def all_unicode
          @all_unicode ||= RangeSet.new([0..0x10FFFF])
        end

        # A few <control> characters (2..7) and public/private surrogates (55296..57343).
        # These don't play nicely with Ruby's regular expression engine, and I think we
        # can safely disregard them.
        def invalid_regexp_chars
          @invalid_regexp_chars ||= RangeSet.new([2..7, 55296..57343])
        end

        def valid_regexp_chars
          @valid_regexp_chars ||= all_unicode.subtract(invalid_regexp_chars)
        end

      end

      attr_reader :elements

      def initialize(elements)
        @elements = elements
      end

      def to_regexp(modifiers = nil)
        Regexp.new(to_regexp_str, modifiers)
      end

      def to_regexp_str
        @regexp_str ||= @elements.map(&:to_regexp_str).join
      end

    end
  end
end