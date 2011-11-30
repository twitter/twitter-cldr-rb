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

      # default
      def tokens
        self.tokens_for(PATHS[@type])
      end

      def apply(obj)
        #what. the. fuck.
        #cldr_formatter = Cldr::Format::Datetime.new(self.format_string, @resource["calendars"][@calendar_type])
        Cldr::Format::Datetime.new(self.format_string, obj, obj)
      end

      protected

      def init_resources
        @resource = TwitterCldr.resource_manager.resource_for(@locale, "calendars")[@locale.to_sym]
      end

      def init_placeholders
        @placeholders = { :date => TwitterCldr::Tokenizers::DateTokenizer.new(:locale => @locale, :type => @type),
                          :time => TwitterCldr::Tokenizers::TimeTokenizer.new(:locale => @locale, :type => @type) }
      end

      def pattern_for(resource)
        resource.is_a?(Hash) ? resource[:pattern] : resource
      end
    end
  end
end