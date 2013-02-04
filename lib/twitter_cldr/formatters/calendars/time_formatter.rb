# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    class TimeFormatter < DateTimeFormatter
      def initialize(options = {})
        locale = extract_locale(options)
        cache_key = TwitterCldr::Utils.compute_cache_key("time", locale, options[:calendar_type])
        @tokenizer = tokenizer_cache[cache_key] ||= TwitterCldr::Tokenizers::TimeTokenizer.new(
          :locale => locale,
          :calendar_type => options[:calendar_type]
        )
      end
    end
  end
end