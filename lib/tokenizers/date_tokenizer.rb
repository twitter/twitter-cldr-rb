module TwitterCldr
  module Tokenizers
    class DateTokenizer < TwitterCldr::Tokenizers::DateTimeTokenizer
      PATHS = { :default => "calendars.gregorian.formats.date.default",
                :full => "calendars.gregorian.formats.date.full",
                :long => "calendars.gregorian.formats.date.long", 
                :medium => "calendars.gregorian.formats.date.medium",
                :short => "calendars.gregorian.formats.date.short" }

      def apply(obj)
        cldr_formatter = Cldr::Format::Date.new(self.format_string, @resource[:calendars][@calendar_type])
        cldr_formatter.apply(obj)
      end

      def tokens
        self.tokens_for(PATHS[@type])
      end

      def init_placeholders
        @placeholders = {}
      end
    end
  end
end