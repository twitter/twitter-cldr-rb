# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr

  class LocalizedTime < LocalizedDateTime
    def to_datetime(date)
      date_obj = date.is_a?(LocalizedDate) ? date.base_obj : date
      LocalizedDateTime.new(DateTime.parse("#{date_obj.strftime("%Y-%m-%d")}T#{@base_obj.strftime("%H:%M:%S%z")}"), @locale, :calendar_type => @calendar_type)
    end

    protected

    def formatter_const
      TwitterCldr::Formatters::TimeFormatter
    end
  end

  LocalizedTime.localize(Time)

end