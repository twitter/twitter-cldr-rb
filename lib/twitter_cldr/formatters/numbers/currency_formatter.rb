# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    class CurrencyFormatter < NumberFormatter
      DEFAULT_CURRENCY_SYMBOL = "$"

      def initialize(options = {})
        @tokenizer = TwitterCldr::Tokenizers::NumberTokenizer.new(:locale => self.extract_locale(options), :type => :currency)
        super
      end

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
        { :precision => precision == 0 ? 2 : precision }
      end
    end
  end
end