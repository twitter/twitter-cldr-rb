# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    class CurrencyFormatter < NumberFormatter
      DEFAULT_CURRENCY_SYMBOL = "$"
      DEFAULT_PRECISION = 2

      def format(number, options = {})
        if options[:currency]
          currency ||= TwitterCldr::Shared::Currencies.for_code(options[:currency])
          currency ||= TwitterCldr::Shared::Currencies.for_country(options[:currency])
          currency ||= { :symbol => options[:currency] }
        else
          currency = { :symbol => DEFAULT_CURRENCY_SYMBOL }
        end

        super(number, options).gsub('¤', currency[:symbol])
      end

      def default_format_options_for(number)
        precision = precision_from(number)
        { :precision => precision == 0 ? DEFAULT_PRECISION : precision }
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