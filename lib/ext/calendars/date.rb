class Date
  def localize(locale = TwitterCldr.get_locale)
    TwitterCldr::LocalizedDate.new(self, locale)
  end
end

module TwitterCldr
  class LocalizedDate < LocalizedDateTime
    def to_datetime(time)
      time_obj = time.is_a?(LocalizedTime) ? time.base_obj : time
      LocalizedDateTime.new(DateTime.parse("#{@base_obj.strftime("%Y-%m-%d")}T#{time_obj.strftime("%H:%M:%S%z")}"), @locale)
    end

    protected

    def formatter_const
      TwitterCldr::Formatters::DateFormatter
    end
  end
end