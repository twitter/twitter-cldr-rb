# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Transforms

    module Resolvable
      protected

      def resolve_token_group(tokens, symbol_table)
        tokens.inject("") do |str, token|
          str + if token.type == :variable
            symbol_table[token.value].resolve(symbol_table).value
          else
            token.value
          end
        end
      end

      def resolve_child(child, symbol_table)
        case child
          when TwitterCldr::Transforms::Conversion::Node, TwitterCldr::Transforms::Conversion::Context
            child.resolve(symbol_table)
          when Array
            [resolve_token_group(child, symbol_table)]
        end
      end

    end
  end
end
