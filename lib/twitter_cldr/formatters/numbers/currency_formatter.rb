# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    class CurrencyFormatter < NumberFormatter
      DEFAULT_CURRENCY_SYMBOL = "$"
      DEFAULT_PRECISION = 2

      def format(number, options = {})
        options[:currency] ||= "USD"
        currency = TwitterCldr::Shared::Currencies.for_code(options[:currency])
        currency ||= {
          :currency    => options[:currency],
          :symbol      => options[:currency],
          :cldr_symbol => options[:currency]
        }

        # overwrite with explicit symbol if given
        currency[:symbol] = options[:symbol] if options[:symbol]

        digits_and_rounding = resource(options[:currency])
        options[:precision] ||= digits_and_rounding[:digits]
        options[:rounding] ||= digits_and_rounding[:rounding]

        symbol = options[:use_cldr_symbol] ? currency[:cldr_symbol] : currency[:symbol]
        symbol ||= currency[:currency].to_s
        super(number, options).gsub('¤', symbol)
      end

      private

      def resource(code)
        @resource ||= TwitterCldr.get_resource(:shared, :currency_digits_and_rounding)
        @resource[code.to_sym] || @resource[:DEFAULT]
      end

      def get_tokens(obj, options = {})
        opts = options.dup.merge(
          :sign => obj.abs == obj ? :positive : :negative,
          :type => :currency
        )
        @tokenizer.tokens(opts)
      end
    end
  end
end
