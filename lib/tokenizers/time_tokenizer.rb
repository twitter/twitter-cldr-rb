module TwitterCldr
  module Tokenizers
    class TimeTokenizer < TwitterCldr::Tokenizers::DateTimeTokenizer
      PATHS = { :default => "calendars.gregorian.formats.time.default",
                :full => "calendars.gregorian.formats.time.full",
                :long => "calendars.gregorian.formats.time.long", 
                :medium => "calendars.gregorian.formats.time.medium",
                :short => "calendars.gregorian.formats.time.short" }

      def apply(obj)
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