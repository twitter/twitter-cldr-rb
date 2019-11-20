# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Timezones
    class Iso8601Location < Location
      def to_short_s
        "#{sign(offset)}#{offset_hour.to_s.rjust(2, '0')}"
      end

      def to_medium_s
        hour = offset_hour.to_s.rjust(2, '0')
        minute = offset_minute.to_s.ljust(2, '0')
        "#{sign(offset)}#{hour}#{minute}"
      end

      def to_long_s
        hour = offset_hour.to_s.rjust(2, '0')
        minute = offset_minute.to_s.ljust(2, '0')
        "#{sign(offset)}#{hour}:#{minute}"
      end

      alias_method :to_full_s, :to_long_s

      private

      def sign(num)
        num.positive? ? '+' : '-'
      end
    end
  end
end
