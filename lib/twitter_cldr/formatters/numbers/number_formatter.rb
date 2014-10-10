# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    class NumberFormatter < Formatter

      attr_reader :data_reader

      def initialize(data_reader)
        @data_reader = data_reader
      end

      def format(tokens, number, options = {})
        options[:precision] ||= precision_from(number)
        options[:type] ||= :decimal

        prefix, suffix, integer_format, fraction_format = *partition_tokens(tokens)
        number = truncate_number(number, integer_format.format.length)

        int, fraction = parse_number(number, options)
        result =  integer_format.apply(int, options)
        result << fraction_format.apply(fraction, options) if fraction

        numbering_system(options[:type]).transliterate(
          "#{prefix.to_s}#{result}#{suffix.to_s}"
        )
      end

      def truncate_number(number, decimal_digits)
        number # noop for base class
      end

      protected

      # data readers should encapsulate formatting options, and when they do, this "type"
      # argument will no longer be necessary (accessible via `data_reader.type` instead)
      def numbering_system(type)
        @numbering_system ||= TwitterCldr::Shared::NumberingSystem.for_name(
          data_reader.number_system_for(type)
        )
      end

      def partition_tokens(tokens)
        [
          token_val_from(tokens[0]),
          token_val_from(tokens[2]),
          Numbers::Integer.new(
            tokens[1],
            data_reader.symbols
          ),
          Numbers::Fraction.new(
            tokens[1],
            data_reader.symbols
          )
        ]
      end

      def token_val_from(token)
        token ? token.value : ""
      end

      def parse_number(number, options = {})
        precision = options[:precision] || precision_from(number)
        rounding = options[:rounding] || 0

        number = "%.#{precision}f" % round_to(number, precision, rounding).abs
        number.split(".")
      end

      def round_to(number, precision, rounding = 0)
        factor = 10 ** precision
        result = (number * factor).round.to_f / factor
        if rounding > 0
          rounding = rounding.to_f / factor
          result = (result *  (1.0 / rounding)).round.to_f / (1.0 / rounding)
        end

        result
      end

      def precision_from(num)
        parts = num.to_s.split(".")
        parts.size == 2 ? parts[1].size : 0
      end

    end
  end
end
