# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr

  class LocalizedDate < LocalizedDateTime
    def to_datetime(time)
      time_obj = time.is_a?(LocalizedTime) ? time.base_obj : time
      LocalizedDateTime.new(DateTime.parse("#{@base_obj.strftime("%Y-%m-%d")}T#{time_obj.strftime("%H:%M:%S%z")}"), @locale, :calendar_type => @calendar_type)
    end

    protected

    def formatter_const
      TwitterCldr::Formatters::DateFormatter
    end
  end

  LocalizedDate.localize(Date)

end