# encoding: utf-8

module TwitterCldr
  module Formatters
    class PercentFormatter < NumberFormatter
      DEFAULT_PERCENT_SIGN = "%"
      DEFAULT_FORMAT_OPTIONS = { :precision => 0 }

      def initialize(options = {})
        @tokenizer = TwitterCldr::Tokenizers::NumberTokenizer.new(:locale => self.extract_locale(options), :type => :percent)
        super
      end

      def format(number, options = {})
        opts = DEFAULT_FORMAT_OPTIONS.merge(options)
        super(number, opts).gsub('¤', @tokenizer.symbols[:percent_sign] || DEFAULT_PERCENT_SIGN)
      end
    end
  end
end
