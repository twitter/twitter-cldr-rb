# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    class TimeFormatter < DateTimeFormatter
      def initialize(options = {})
        @tokenizer = TwitterCldr::Tokenizers::TimeTokenizer.new(:locale => extract_locale(options))
      end
    end
  end
end