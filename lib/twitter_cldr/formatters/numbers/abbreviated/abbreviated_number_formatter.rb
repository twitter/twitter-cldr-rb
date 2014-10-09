# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    class AbbreviatedNumberFormatter < NumberFormatter

      def truncate_number(number, decimal_digits)
        if TwitterCldr::DataReaders::NumberDataReader.within_abbreviation_range?(number)
          factor = [0, number.to_i.abs.to_s.length - decimal_digits].max
          number / (10.0 ** factor)
        else
          number
        end
      end

    end
  end
end