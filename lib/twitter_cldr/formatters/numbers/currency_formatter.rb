# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    class CurrencyFormatter < NumberFormatter
      def initialize(options = {})
        @tokenizer = TwitterCldr::Tokenizers::NumberTokenizer.new(:locale => self.extract_locale(options), :type => :currency)
        super
      end

      def format(number, options = {})
        options[:currency] ||= "USD"
        currency = TwitterCldr::Shared::Currencies.for_code(options[:currency])
        currency ||= TwitterCldr::Shared::Currencies.for_country(options[:currency])

        digits_and_rounding = resource(options[:currency])
        options[:precision] ||= digits_and_rounding[:digits]
        options[:rounding] ||= digits_and_rounding[:rounding]

        super(number, options).gsub('¤', (currency[:symbol] || currency[:currency].to_s))
      end

      private
      def resource(code)
        @resource ||= TwitterCldr.get_resource(:shared, :currency_digits_and_rounding)
        (@resource[code.to_sym] || @resource[:DEFAULT])
      end
    end
  end
end