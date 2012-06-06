module TwitterCldr
  class LocalizedTimespan < LocalizedObject

    def initialize(object_time, base_time, direction, locale)
      @formatter = AgoFormatter.new({:locale => locale})
      @seconds = object_time - base_time
      @direction = direction
    end

    def to_s(unit = :default)
      @formatter.format(@seconds, @direction, unit)
    end

    protected

    def formatter_const
      TwitterCldr::Formatters::DateTimeFormatter
    end
  end
end