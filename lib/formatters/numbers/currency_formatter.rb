module TwitterCldr
  module Formatters
    class CurrencyFormatter < NumberFormatter
      DEFAULT_FORMAT_OPTIONS = { :precision => 2 }
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

        super(number, DEFAULT_FORMAT_OPTIONS.merge(options)).gsub('¤', currency[:symbol])
      end
    end
  end
end