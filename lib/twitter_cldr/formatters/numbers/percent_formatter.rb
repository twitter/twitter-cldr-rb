# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    class PercentFormatter < NumberFormatter
      DEFAULT_PERCENT_SIGN = "%"

      def initialize(options = {})
        @tokenizer = TwitterCldr::Tokenizers::NumberTokenizer.new(:locale => self.extract_locale(options), :type => :percent)
        super
      end

      def format(number, options = {})
        super(number, options).gsub('¤', @tokenizer.symbols[:percent_sign] || DEFAULT_PERCENT_SIGN)
      end
    end
  end
end