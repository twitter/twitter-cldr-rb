# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Transforms

    class NotInvertibleError < StandardError; end

    # Base class for all transform rules
    class Rule
      STRING_TYPES = [
        :quoted_string, :escaped_char,
        :escaped_backslash, :doubled_quote
      ]

      class << self
        def preprocess_tokens(tokens)
          tokens.map do |token|
            case token.type
              when *STRING_TYPES
                TwitterCldr::Tokenizers::Token.new.tap do |t|
                  t.type = :string
                  t.value = token_value(token)
                end
              else
                token
            end
          end
        end

        def token_value(token)
          case token.type
            when :quoted_string
              token.value[1..-2]
            # when :escaped_char
            #   token.value.sub(/\A\\/, '')
            # when :escaped_backslash
            #   '\\'
            when :doubled_quote
              "'"
            else
              token.value
          end
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

      def is_filter_rule?
        false
      end

      def is_transform_rule?
        false
      end

      def is_conversion_rule?
        false
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
