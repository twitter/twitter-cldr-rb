module TwitterCldr
  class LocalizedTimespan < LocalizedObject
    attr_reader :calendar_type

    def initialize(object_time, base_time, direction, locale, options = {})
      @formatter = AgoFormatter.new({:locale => locale})
      @seconds = object_time - base_time   #don't make this abs
      @direction = direction
    end

    def to_s(unit = :default)
      @formatter.format(@seconds, {:unit => unit.to_sym, :direction => @direction})
    end

    protected

    def formatter_const
      TwitterCldr::Formatters::DateTimeFormatter
    end
  end
end