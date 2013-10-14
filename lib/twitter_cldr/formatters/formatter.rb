# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    class Formatter

      def format(tokens, obj, options = {})
        tokens.each_with_index.inject("") do |ret, (token, index)|
          method_sym = :"format_#{token.type}"

          ret << if respond_to?(method_sym)
            send(method_sym, token, index, obj, options)
          else
            if token.value.size > 0 && token.value[0].chr == "'" && token.value[-1].chr == "'"
              token.value[1..-2]
            else
              token.value
            end
          end
        end
      end

      protected

      def format_composite(token, index, obj, options)
        eval(format(token.tokens, obj)).to_s
      end

    end
  end
end