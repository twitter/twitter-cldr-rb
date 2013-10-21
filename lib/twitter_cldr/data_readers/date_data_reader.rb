# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

include TwitterCldr::Tokenizers
include TwitterCldr::Formatters

module TwitterCldr
  module DataReaders
    class DateDataReader < CalendarDataReader

      def tokenizer
        @tokenizer ||= DateTokenizer.new(self)
      end

      def formatter
        @formatter ||= DateTimeFormatter.new(self)
      end

      protected

      def path_for(type, calendar_type)
        [:calendars, calendar_type, :formats, :date]
      end

    end
  end
end