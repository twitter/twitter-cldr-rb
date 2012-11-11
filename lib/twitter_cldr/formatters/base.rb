# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    class Base
      attr_reader :tokenizer

      def format(obj, options = {})
        process_tokens(self.get_tokens(obj, options), obj)
      end

      protected

      def process_tokens(tokens, obj)
        result = ""

        tokens.each_with_index do |token, index|
          case token.type
            when :composite
              result << eval(process_tokens(token.tokens, obj)).to_s
            when :pattern
              result << self.result_for_token(token, index, obj)
            else
              if token.value.size > 0 && token.value[0].chr == "'" && token.value[-1].chr == "'"
                result << token.value[1..-2]
              else
                result << token.value
              end
          end
        end

        result
      end

      def get_tokens(obj, options = {})
        @tokenizer.tokens(options)
      end

      def extract_locale(options)
        options[:locale] || TwitterCldr::DEFAULT_LOCALE
      end
    end
  end
end