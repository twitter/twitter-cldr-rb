module TwitterCldr
  module Tokenizers
    class DateTimeTokenizer < Base
      attr_reader :placeholders, :calendar_type

      DEFAULT_CALENDAR_TYPE = :gregorian
      PATHS = { :default => "calendars.gregorian.formats.datetime.default",
                :full => "calendars.gregorian.formats.datetime.full",
                :long => "calendars.gregorian.formats.datetime.long", 
                :medium => "calendars.gregorian.formats.datetime.medium",
                :short => "calendars.gregorian.formats.datetime.short" }

      def initialize(options = {})
        super(options)
        @calendar_type = options[:calendar_type] || DEFAULT_CALENDAR_TYPE
      end

      def tokens(options = {})
        type = options[:type] || :default
        self.tokens_for(PATHS[type], type)
      end

      def calendar
        @resource[:calendars][@calendar_type]
      end

      protected

      def tokenize_format(text)
        [Token.new(:value => text, :type => :plaintext)]
      end

      def init_resources
        @resource = TwitterCldr.resource_manager.resource_for(@locale, "calendars")[@locale]
      end

      def init_placeholders
        @placeholders = [{ :name => :date, :object => TwitterCldr::Tokenizers::DateTokenizer.new(:locale => @locale) },
                         { :name => :time, :object => TwitterCldr::Tokenizers::TimeTokenizer.new(:locale => @locale) }]
      end

      def pattern_for(resource)
        resource.is_a?(Hash) ? resource[:pattern] : resource
      end
    end
  end
end