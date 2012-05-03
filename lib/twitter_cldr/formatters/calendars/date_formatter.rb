# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    class DateFormatter < DateTimeFormatter
      def initialize(options = {})
        @tokenizer = TwitterCldr::Tokenizers::DateTokenizer.new(:locale => extract_locale(options), :calendar_type => options[:calendar_type])
      end
    end
  end
end