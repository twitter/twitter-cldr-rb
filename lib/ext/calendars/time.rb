class Time
  def localize(locale = TwitterCldr.get_locale)
    TwitterCldr::LocalizedTime.new(self, locale)
  end
end

module TwitterCldr
  class LocalizedTime < LocalizedDateTime
    protected

    def formatter_const
      TwitterCldr::Formatters::TimeFormatter
    end
  end
end