# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Transforms

    class Variable < Rule
      class Parser < TwitterCldr::Parsers::Parser
        private

        def do_parse(options)
          var_name = name
          next_token(:equals)
          var_value = value
          Variable.new(var_name, var_value)
        end

        def name
          current_token.value.tap do
            next_token(:variable)
          end
        end

        def value
          [].tap do |value_parts|
            until current_token.type == :semicolon
              value_parts << current_token
              next_token(current_token.type)
            end
          end
        end
      end

      class << self
        def parse(rule_text)
          tokens = tokenizer.tokenize(
            unescape(rule_text)
          )

          parser.parse(tokens)
        end

        protected

        # Warning: not thread-safe
        def parser
          @parser ||= Parser.new
        end

        def tokenizer
          @tokenizer ||= begin
            recognizers = [
              TwitterCldr::Tokenizers::TokenRecognizer.new(:variable, /\$\w[\w\d]*/),
              TwitterCldr::Tokenizers::TokenRecognizer.new(:equals, /=/),
              TwitterCldr::Tokenizers::TokenRecognizer.new(:semicolon, /;/),
              TwitterCldr::Tokenizers::TokenRecognizer.new(:string, //)
            ]

            TwitterCldr::Tokenizers::Tokenizer.new(recognizers)
          end
        end
      end

      include Resolvable
      attr_reader :name, :value_tokens

      def initialize(name, value_tokens)
        @name = name
        @value_tokens = value_tokens
      end

      def resolve(symbol_table)
        @resolved ||=
          ResolvedVariable.new(
            name, resolve_token_group(
              value_tokens, symbol_table
            )
          )
      end
    end

    class ResolvedVariable
      attr_reader :name, :value

      def initialize(name, value)
        @name = name
        @value = value
      end
    end

  end
end
