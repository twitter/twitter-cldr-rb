# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    class PercentFormatter < NumberFormatter
      DEFAULT_PERCENT_SIGN = "%"

      def format(number, options = {})
        super(number, options).gsub('¤', @tokenizer.symbols[:percent_sign] || DEFAULT_PERCENT_SIGN)
      end

      def default_format_options_for(number)
        { :precision => 0 }
      end

      def get_tokens(obj, options = {})
        opts = options.dup.merge(
          :sign => obj.abs == obj ? :positive : :negative,
          :type => :percent
        )
        @tokenizer.tokens(opts)
      end
    end
  end
end