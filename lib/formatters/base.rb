module TwitterCldr
  module Formatters
    class Base
      attr_reader :tokenizer

      def format(obj, options = {})
        final = StringIO.new

        result = self.get_tokens(obj, options).each_with_index do |token, index|
          case token.type
            when :pattern
              final << self.result_for_token(token, index, obj)
            else
              if token.value.size > 0 && token.value[0].chr == "'" && token.value[-1].chr == "'"
                final << token.value[1..-2]
              else
                final << token.value
              end
          end
        end

        final.string
      end

      protected

      def get_tokens(obj, options = {})
        @tokenizer.tokens(options)
      end

      def extract_locale(options)
        options[:locale] || TwitterCldr::DEFAULT_LOCALE
      end
    end
  end
end