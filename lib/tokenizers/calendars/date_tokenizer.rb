module TwitterCldr
  module Tokenizers
    class DateTokenizer < TwitterCldr::Tokenizers::DateTimeTokenizer
      def initialize(options = {})
        super(options)
        @token_splitter_regex = /(\s*\'[\w\s-]+\'\s*|G{1,5}|y+|Y+|Q{1,4}|q{1,5}|M{1,5}|L{1,5}|d{1,2}|F{1}|E{1,5}|e{1,5}|c{1,5})/
        @token_type_regexes = [{ :type => :pattern, :regex => /^(?:G{1,5}|y+|Y+|Q{1,4}|q{1,5}|M{1,5}|L{1,5}|d{1,2}|F{1}|E{1,5}|e{1,5}|c{1,5})/ },
                               { :type => :plaintext, :regex => // }]
        @paths = { :default => "calendars.gregorian.formats.date.default",
                   :full => "calendars.gregorian.formats.date.full",
                   :long => "calendars.gregorian.formats.date.long", 
                   :medium => "calendars.gregorian.formats.date.medium",
                   :short => "calendars.gregorian.formats.date.short" }
      end

      protected

      # must override this because DateTimeTokenizer will set them otherwise
      def init_placeholders
        @placeholders = {}
      end
    end
  end
end