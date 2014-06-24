# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    class AbbreviatedNumberFormatter < NumberFormatter

      FORMAT_REGEX = /^0+$/

      protected

      def truncate_number(number, integer_format)
        if TwitterCldr::DataReaders::NumberDataReader.within_abbreviation_range?(number)
          if integer_format.format =~ FORMAT_REGEX
            factor = [0, number.to_i.to_s.length - integer_format.format.length].max
            number / (10.0 ** factor)
          else
            raise ArgumentError.new("unexpected format string #{integer_format.inspect}")
          end
        else
          number
        end
      end

    end
  end
end