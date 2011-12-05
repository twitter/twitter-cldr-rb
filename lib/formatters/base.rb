module TwitterCldr
  module Formatters
    class Base
      attr_reader :tokenizer

      def initialize(options = {})
        @tokenizer = options[:tokenizer]
      end

      def format(obj, options = {})
        result = @tokenizer.tokens(options).map do |token|
          case token.type
            when :pattern
              self.result_for_token(token, obj)
            else
              if token.value[0].chr == "'" && token.value[-1].chr == "'"
                token.value[1..-2]
              else
                token.value
              end
          end
        end

        result.join("")
      end
    end
  end
end