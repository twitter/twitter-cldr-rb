module TwitterCldr
  module Tokenizers
    class TimeTokenizer < TwitterCldr::Tokenizers::DateTimeTokenizer
      TOKEN_SPLITTER_REGEX = /(\'[\w\s-]+\'|a{1}|h{1,2}|H{1,2}|K{1,2}|k{1,2}|m{1,2}|s{1,2}|S+|z{1,4}|Z{1,4})/
      TOKEN_TYPE_REGEXES = [{ :type => :pattern, :regex => /^a{1}|h{1,2}|H{1,2}|K{1,2}|k{1,2}|m{1,2}|s{1,2}|S+|z{1,4}|Z{1,4}/ },
                            { :type => :plaintext, :regex => // }]
      PATHS = { :default => "calendars.gregorian.formats.time.default",
                :full => "calendars.gregorian.formats.time.full",
                :long => "calendars.gregorian.formats.time.long", 
                :medium => "calendars.gregorian.formats.time.medium",
                :short => "calendars.gregorian.formats.time.short" }

      def tokens(options = {})
        type = options[:type] || :default
        self.tokens_for(PATHS[type], type)
      end

      protected

      def tokenize_format(text)
        final = []
        text.split(TOKEN_SPLITTER_REGEX).each do |token|
          unless token.empty?
            TOKEN_TYPE_REGEXES.each do |token_type|
              if token =~ token_type[:regex]
                final << Token.new(:value => token, :type => token_type[:type])
                break
              end
            end
          end
        end
        final
      end

      def init_placeholders
        @placeholders = {}
      end
    end
  end
end