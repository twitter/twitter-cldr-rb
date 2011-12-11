module TwitterCldr
  module Formatters
    class PercentFormatter < NumberFormatter
      DEFAULT_PERCENT_SIGN = "%"

      def initialize(options = {})
        @tokenizer = TwitterCldr::Tokenizers::NumberTokenizer.new(:locale => self.extract_locale(options), :type => :percent)
        super
      end

      def format(number, options = {})
        super.gsub('¤', @tokenizer.symbols[:percent_sign] || DEFAULT_PERCENT_SIGN)
      end
    end
  end
end