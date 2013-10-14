# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    class DateFormatter < DateTimeFormatter
      def initialize(options = {})
        locale = extract_locale(options)
        cache_key = TwitterCldr::Utils.compute_cache_key("date", locale, options[:calendar_type])
        @tokenizer = tokenizer_cache[cache_key] ||= TwitterCldr::Tokenizers::DateTokenizer.new(
          :locale => locale,
          :calendar_type => options[:calendar_type]
        )
      end
    end
  end
end