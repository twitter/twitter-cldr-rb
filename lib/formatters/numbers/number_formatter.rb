module TwitterCldr
  module Formatters
    class NumberFormatter < Base
      attr_reader :prefix, :suffix, :integer_format, :fraction_format, :symbols

      DEFAULT_SYMBOLS = { :group => ',', :decimal => '.', :plus_sign => '+', :minus_sign => '-' }

      def initialize(options = {})
        @symbols = DEFAULT_SYMBOLS.merge(@tokenizer.symbols)
        @prefix, @suffix, @integer_format, @fraction_format = *partition_tokens(@tokenizer.tokens)
      end

      def format(number, options = {})
        int, fraction = parse_number(number, options)

        result =  integer_format.apply(int, options)
        result << fraction_format.apply(fraction, options) if fraction
        "#{prefix.to_s}#{result}#{suffix.to_s}"
      end

      protected

      def partition_tokens(tokens)
        # tokens[0] is always blank (side effect of the regex)
        [tokens[1] || "",
         tokens[3] || "",
         Numbers::Integer.new(tokens[2], @tokenizer.symbols),
         Numbers::Fraction.new(tokens[2], @tokenizer.symbols)]
      end

      def parse_number(number, options = {})
        precision = options[:precision] || fraction_format.precision
        number = round_to(number, precision)
        number.abs.to_s.split('.')
      end

      def round_to(number, precision)
        factor = 10 ** precision
        (number * factor).round.to_f / factor
      end
    end
  end
end