module TwitterCldr
  module Tokenizers
    class TimeTokenizer < TwitterCldr::Tokenizers::DateTimeTokenizer
      def initialize(options = {})
        super(options)
        @token_splitter_regex = /(\'[\w\s-]+\'|a{1}|h{1,2}|H{1,2}|K{1,2}|k{1,2}|m{1,2}|s{1,2}|S+|z{1,4}|Z{1,4})/
        @token_type_regexes = [{ :type => :pattern, :regex => /^a{1}|h{1,2}|H{1,2}|K{1,2}|k{1,2}|m{1,2}|s{1,2}|S+|z{1,4}|Z{1,4}/ },
                               { :type => :plaintext, :regex => // }]
        @paths = { :default => "calendars.gregorian.formats.time.default",
                   :full => "calendars.gregorian.formats.time.full",
                   :long => "calendars.gregorian.formats.time.long",
                   :medium => "calendars.gregorian.formats.time.medium",
                   :short => "calendars.gregorian.formats.time.short" }
      end

      protected

      # must override this because DateTimeTokenizer will set them otherwise
      def init_placeholders
        @placeholders = {}
      end
    end
  end
end