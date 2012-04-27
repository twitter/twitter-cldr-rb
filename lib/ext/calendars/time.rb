# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

class Time
  def localize(locale = TwitterCldr.get_locale)
    TwitterCldr::LocalizedTime.new(self, locale)
  end
end

module TwitterCldr
  class LocalizedTime < LocalizedDateTime
    def to_datetime(date)
      date_obj = date.is_a?(LocalizedDate) ? date.base_obj : date
      LocalizedDateTime.new(DateTime.parse("#{date_obj.strftime("%Y-%m-%d")}T#{@base_obj.strftime("%H:%M:%S%z")}"), @locale)
    end

    protected

    def formatter_const
      TwitterCldr::Formatters::TimeFormatter
    end
  end
end