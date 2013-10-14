# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module DataReaders
    class DateTimeDataReader < CalendarDataReader

      def date_reader
        @date_reader ||= DateDataReader.new(locale)
      end

      def time_reader
        @time_reader ||= TimeDataReader.new(locale)
      end

      protected

      def path_for(type, calendar_type)
        [:calendars, calendar_type, :formats, :datetime]
      end

    end
  end
end