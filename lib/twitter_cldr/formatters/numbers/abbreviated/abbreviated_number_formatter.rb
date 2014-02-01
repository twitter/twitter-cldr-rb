# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    class AbbreviatedNumberFormatter < NumberFormatter

      protected

      def transform_number(number)
        within = number < TwitterCldr::DataReaders::NumberDataReader::NUMBER_MAX &&
          number >= TwitterCldr::DataReaders::NumberDataReader::NUMBER_MIN

        if within
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