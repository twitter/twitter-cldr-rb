# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    class AbbreviatedNumberFormatter < NumberFormatter
      NUMBER_MAX = (10 ** 15)
      NUMBER_MIN = 1000

      def default_format_options_for(number)
        { :precision => 0 }
      end

      def get_tokens(obj, options = {})
        type = (obj < NUMBER_MAX) && (obj >= NUMBER_MIN) ? get_type : :decimal
        format = type == get_type ? get_key(obj) : nil
        opts = options.merge(
          :sign => obj.abs == obj ? :positive : :negative,
          :type => type,
          :format => format
        )
        @tokenizer.tokens(opts)
      end

      protected

      def get_type
        :decimal
      end

      def get_key(number)
        "1#{"0" * (number.to_i.to_s.size - 1)}".to_i
      end

      def transform_number(number)
        if (number < NUMBER_MAX) && (number >= NUMBER_MIN)
          sig_figs = ((number.to_i.to_s.size - 1) % 3)
          number.to_s[0..sig_figs].to_i
        else
          number
        end
      end
    end
  end
end