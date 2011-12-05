module TwitterCldr
  module Tokenizers
    class DateTokenizer < TwitterCldr::Tokenizers::DateTimeTokenizer
      TOKEN_SPLITTER_REGEX = /(\'[\w\s-]+\'|G{1,5}|y+|Y+|Q{1,4}|q{1,5}|M{1,5}|L{1,5}|d{1,2}|F{1}|E{1,5}|e{1,5}|c{1,5})/
      TOKEN_TYPE_REGEXES = [{ :type => :pattern, :regex => /^[G{1,5}|y+|Y+|Q{1,4}|q{1,5}|M{1,5}|L{1,5}|d{1,2}|F{1}|E{1,5}|e{1,5}|c{1,5}]/ },
                            { :type => :plaintext, :regex => // }]
      PATHS = { :default => "calendars.gregorian.formats.date.default",
                :full => "calendars.gregorian.formats.date.full",
                :long => "calendars.gregorian.formats.date.long", 
                :medium => "calendars.gregorian.formats.date.medium",
                :short => "calendars.gregorian.formats.date.short" }

      def tokens(options = {})
        type = options[:type] || :default
        self.tokens_for(PATHS[type])
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