class Date
  def localize(locale = TwitterCldr.get_locale)
    TwitterCldr::LocalizedDate.new(self, locale)
  end
end

module TwitterCldr
  class LocalizedDate < LocalizedDateTime
    protected

    def formatter_const
      TwitterCldr::Formatters::DateFormatter
    end
  end
end