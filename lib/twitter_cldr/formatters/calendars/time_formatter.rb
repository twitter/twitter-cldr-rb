# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    class TimeFormatter < DateTimeFormatter
      def initialize(options = {})
        @tokenizer = TwitterCldr::Tokenizers::TimeTokenizer.new(:locale => extract_locale(options), :calendar_type => options[:calendar_type])
      end
    end
  end
end