module TwitterCldr
  module Tokenizers
    class DateTimeTokenizer < Base
      attr_reader :placeholders, :calendar_type

      DEFAULT_CALENDAR_TYPE = :gregorian

      def initialize(options = {})
        super(options)
        @calendar_type = options[:calendar_type] || DEFAULT_CALENDAR_TYPE
        @token_splitter_regex = //
        @token_type_regexes = [{ :type => :plaintext, :regex => // }]
        @paths = { :default => "calendars.gregorian.formats.datetime.default",
                   :full => "calendars.gregorian.formats.datetime.full",
                   :long => "calendars.gregorian.formats.datetime.long",
                   :medium => "calendars.gregorian.formats.datetime.medium",
                   :short => "calendars.gregorian.formats.datetime.short" }
      end

      def tokens(options = {})
        type = options[:type] || :default
        self.tokens_for(self.paths[type], type)
      end

      def calendar
        @resource[:calendars][@calendar_type]
      end

      protected

      def init_resources
        @resource = TwitterCldr.resources.resource_for(@locale, "calendars")[TwitterCldr.convert_locale(@locale)]
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