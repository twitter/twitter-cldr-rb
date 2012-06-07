module TwitterCldr
  class LocalizedTimespan < LocalizedObject

    def initialize(seconds, locale)
      @formatter = TimespanFormatter.new({:locale => locale})
      @seconds = seconds
    end

    def to_s(unit = :default)
      @formatter.format(@seconds, unit)
    end

    protected

    def formatter_const
      TwitterCldr::Formatters::DateTimeFormatter
    end
  end
end