# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    class CurrencyFormatter < NumberFormatter
      DEFAULT_CURRENCY_SYMBOL = "$"
      DEFAULT_PRECISION = 2
      DEFAULT_ROUNDING = 0

      def initialize(options = {})
        @tokenizer = TwitterCldr::Tokenizers::NumberTokenizer.new(:locale => self.extract_locale(options), :type => :currency)
        super
      end

      def format(number, options = {})
        currency = nil
        
        if options[:currency]
          currency ||= TwitterCldr::Shared::Currencies.for_code(options[:currency])
          currency ||= TwitterCldr::Shared::Currencies.for_country(options[:currency])   
        end
        
        currency ||= { 
          :symbol => (options[:currency] || DEFAULT_CURRENCY_SYMBOL),
          :precision => DEFAULT_PRECISION,
          :rounding => DEFAULT_ROUNDING
        }
        
        options.merge!(currency) { |key, v1, v2| (v1 || v2) }

        super(number, options).gsub('¤', currency[:symbol])
      end

      def default_format_options_for(number)
        precision = precision_from(number)
        { :precision => precision }
      end
    end
  end
end