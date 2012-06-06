# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    class NumberFormatter < Base
      attr_reader :symbols

      DEFAULT_SYMBOLS = { :group => ',', :decimal => '.', :plus_sign => '+', :minus_sign => '-' }

      def initialize(options = {})
        @symbols = DEFAULT_SYMBOLS.merge(tokenizer.symbols)
      end

      def format(number, options = {})
        opts = self.default_format_options_for(number).merge(options)
        prefix, suffix, integer_format, fraction_format = *partition_tokens(self.get_tokens(number, opts))
        int, fraction = parse_number(number, opts)
        result =  integer_format.apply(int, opts)
        result << fraction_format.apply(fraction, opts) if fraction
        "#{prefix.to_s}#{result}#{suffix.to_s}"
      end

      protected

      def partition_tokens(tokens)
        [tokens[0] || "",
         tokens[2] || "",
         Numbers::Integer.new(tokens[1], @tokenizer.symbols),
         Numbers::Fraction.new(tokens[1], @tokenizer.symbols)]
      end

      def parse_number(number, options = {})
        precision = options[:precision] || self.precision_from(number)
        number = round_to(number, precision)
        number.abs.to_s.split(".")
      end

      def round_to(number, precision)
        factor = 10 ** precision
        (number * factor).round.to_f / factor
      end

      def precision_from(num)
        parts = num.to_s.split(".")
        parts.size == 2 ? parts[1].size : 0
      end
    end
  end
end