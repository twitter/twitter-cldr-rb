# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Localized

    class LocalizedDate < LocalizedDateTime
      def to_datetime(time)
        time_obj = time.is_a?(LocalizedTime) ? time.base_obj : time
        LocalizedDateTime.new(DateTime.parse("#{@base_obj.strftime("%Y-%m-%d")}T#{time_obj.strftime("%H:%M:%S%z")}"), @locale, :calendar_type => @calendar_type)
      end

      def to_time(base = Time.now)
        time = Time.gm(
          @base_obj.year,
          @base_obj.month,
          @base_obj.day,
          base.hour,
          base.min,
          base.sec
        )

        LocalizedTime.new(time, @locale, :calendar_type => @calendar_type)
      end

      protected

      def formatter_const
        TwitterCldr::Formatters::DateFormatter
      end
    end

  end
end