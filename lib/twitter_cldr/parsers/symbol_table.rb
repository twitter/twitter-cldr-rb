# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

include TwitterCldr::Utils

module TwitterCldr
  module Parsers

    class SymbolTable

      attr_reader :symbols

      def initialize(symbols = {})
        @symbols = symbols
      end

      def fetch(symbol)
        symbols[symbol]
      end

      def add(symbol, value)
        symbols[symbol] = value
      end

    end

  end
end
