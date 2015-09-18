# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Transforms

    class NotInvertibleError < StandardError; end

    # Base class for all transform rules
    class Rule
      class << self
        def unescape(text)
          # For a real space in the rules, place quotes around it.
          # For a real backslash, either double it \\, or quote it '\'.
          # For a real single quote, double it '', or place a backslash before it \'.
          # (Remove superfluous spaces. spaces have no meaning unless they're escaped).
          text.
            gsub(/([^']) ([^'])/) { "#{$1}#{$2}" }.  # remove superfluous spaces
            gsub(/([^']) ([^'])/) { "#{$1}#{$2}" }.  # second time to get missed spaces
            gsub("' '", ' ').
            gsub('\\\\', '\\').
            gsub("'\\'", '\\').
            gsub("''", "'").
            gsub("\\'", "'")
        end

        def replace_symbols(tokens, symbol_table)
          tokens.inject([]) do |ret, token|
            ret + if token.type == :variable
              symbol_table[token.value].value_tokens
            else
              Array(token)
            end
          end
        end
      end

      def can_invert?
        raise NotImplementedError,
          "#{__method__} must be defined in derived classes"
      end

      def is_ct_rule?
        raise NotImplementedError,
          "#{__method__} must be defined in derived classes"
      end

      def forward?
        raise NotImplementedError,
          "#{__method__} must be defined in derived classes"
      end

      def backward?
        raise NotImplementedError,
          "#{__method__} must be defined in derived classes"
      end

      def invert
        raise NotImplementedError,
          "#{__method__} must be defined in derived classes"
      end
    end

  end
end
