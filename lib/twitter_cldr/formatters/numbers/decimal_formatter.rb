# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    class DecimalFormatter < NumberFormatter
      def format(number, options = {})
        super(number, options)
      rescue TypeError, ArgumentError
        number
      end

      def default_format_options_for(number)
        { :precision => precision_from(number) }
      end
    end
  end
end