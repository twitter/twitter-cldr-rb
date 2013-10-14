# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    class AbbreviatedNumberFormatter < NumberFormatter

      ABBREVIATED_MIN_POWER = 3
      ABBREVIATED_MAX_POWER = 14

      NUMBER_MAX = 10 ** (ABBREVIATED_MAX_POWER + 1)
      NUMBER_MIN = 10 ** ABBREVIATED_MIN_POWER

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

      def get_key(number)
        "1#{"0" * (number.to_i.to_s.size - 1)}".to_i
      end

      def transform_number(number)
        if (number < NUMBER_MAX) && (number >= NUMBER_MIN)
          power = (((number.to_s.length - 1) / 3) * 3).floor
          factor = (10 ** power).to_f
          number / factor
        else
          number
        end
      end

    end
  end
end