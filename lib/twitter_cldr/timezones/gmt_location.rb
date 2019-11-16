# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Timezones
    class GmtLocation < Location
      FORMATS = [:long, :short].freeze
      DEFAULT_FORMAT = :short

      def display_name_for(date, format = DEFAULT_FORMAT)
        offset = tz.period_for_local(date).offset
        offset_sec = offset.base_utc_offset + offset.std_offset
        offset_hour ||= offset_sec / 60 / 60
        offset_min ||= (offset_sec / 60) % 60

        case format
          when :short
            hour_fmt = offset_hour.abs.to_s.rjust(2, '0')
            minute_fmt = offset_min.abs.to_s.rjust(2, '0')
            sign = sign_for(offset_sec) == :positive ? '+' : '-'
            "#{sign}#{hour_fmt}#{minute_fmt}"

          when :long
            # TODO: this is broken, need special formatting rules
            if offset_hour == 0 && offset_minute == 0
              gmt_zero_format
            else
              gmt_format.sub('{0}', hour)
            end

          else
            # @TODO: raise error?
        end
      end

      private

      def sign_for(number)
        number.positive? || number.zero? ? :positive : :negative
      end

      def numbering_system
        @numbering_system ||= TwitterCldr::Shared::NumberingSystem.for_locale(locale)
      end

      def gmt_format
        resource[:formats][:gmt_format]
      end

      def gmt_zero_format
        resource[:formats][:gmt_zero_format]
      end

      def hour_format(type)
        case type
          when :positive
            hour_formats.first
          else
            hour_formats.last
        end
      end

      def hour_formats
        @hour_formats ||= resource[:formats][:hour_format].split(';')
      end
    end
  end
end
