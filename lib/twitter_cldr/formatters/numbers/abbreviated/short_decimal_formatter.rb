# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    class ShortDecimalFormatter < AbbreviatedNumberFormatter

      protected

      def get_type
        :short_decimal
      end

    end
  end
end