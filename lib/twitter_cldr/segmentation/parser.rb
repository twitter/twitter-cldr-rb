# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Segmentation
    class Parser

      def parse(text, options = {})
        left_str, boundary_symbol_str, right_str = text.split(/([÷×])/)
        boundary_symbol = boundary_symbol_for(boundary_symbol_str)
        left = compile_token_list(tokenize_regex(left_str || ''), options)
        right = compile_token_list(tokenize_regex(right_str || ''), options)
        klass = class_for(boundary_symbol)
        klass.new(left, right)
      end

      def tokenize_regex(text)
        regex_tokenizer.tokenize(text).reject do |token|
          token.value.strip.empty?
        end
      end

      private

      def boundary_symbol_for(str)
        case str
          when '÷' then :break
          when '×' then :no_break
        end
      end

      def class_for(boundary_symbol)
        case boundary_symbol
          when :break
            BreakRule
          when :no_break
            NoBreakRule
        end
      end

      def compile_token_list(token_list, options)
        if token_list.empty?
          TwitterCldr::Shared::UnicodeRegex.compile('')
        else
          parse_regex(token_list, options)
        end
      end

      def parse_regex(tokens, options)
        unless tokens.empty?
          TwitterCldr::Shared::UnicodeRegex.new(
            regex_parser.parse(tokens, options), 'm'
          )
        end
      end

      def regex_tokenizer
        @tokenizer ||=
          TwitterCldr::Tokenizers::UnicodeRegexTokenizer.new
      end

      def regex_parser
        @regex_parser ||=
          TwitterCldr::Parsers::UnicodeRegexParser.new
      end

    end
  end
end
