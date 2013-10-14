# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module DataReaders
    class TimeDataReader < CalendarDataReader

      protected

      def path_for(type, calendar_type)
        [:calendars, calendar_type, :formats, :time]
      end

    end
  end
end