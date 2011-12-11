module TwitterCldr
  module Formatters
    class DateFormatter < DateTimeFormatter
      def initialize(options = {})
        @tokenizer = TwitterCldr::Tokenizers::DateTokenizer.new(:locale => extract_locale(options))
      end
    end
  end
end