# -*- encoding : utf-8 -*-
module TwitterCldr
  module Formatters
    class TimeFormatter < DateTimeFormatter
      def initialize(options = {})
        @tokenizer = TwitterCldr::Tokenizers::TimeTokenizer.new(:locale => extract_locale(options))
      end
    end
  end
end
