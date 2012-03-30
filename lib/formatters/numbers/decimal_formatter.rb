# -*- encoding : utf-8 -*-
module TwitterCldr
  module Formatters
    class DecimalFormatter < NumberFormatter
      def initialize(options = {})
        @tokenizer = TwitterCldr::Tokenizers::NumberTokenizer.new(:locale => self.extract_locale(options), :type => :decimal)
        super
      end

      def format(number, options = {})
        super(Float(number), options)
      rescue TypeError, ArgumentError
        number
      end

      protected

      def get_tokens(obj, options = {})
        obj.abs == obj ? @tokenizer.tokens(:sign => :positive) : @tokenizer.tokens(:sign => :negative)
      end
    end
  end
end
