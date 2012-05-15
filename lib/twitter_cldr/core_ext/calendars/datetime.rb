# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

class DateTime
  def localize(locale = TwitterCldr.get_locale, options = {})
    TwitterCldr::LocalizedDateTime.new(self, locale, options)
  end
end

module TwitterCldr
  class LocalizedDateTime < LocalizedObject
    attr_reader :calendar_type

    def initialize(obj, locale, options = {})
      super
      @calendar_type = options[:calendar_type] || TwitterCldr::DEFAULT_CALENDAR_TYPE
    end

    TwitterCldr::Tokenizers::DateTimeTokenizer::VALID_TYPES.each do |format_type|
      define_method "to_#{format_type}_s" do
        @formatter.format(@base_obj, :type => format_type.to_sym)
      end
    end

    def to_s
      to_default_s
    end

    def to_date
      LocalizedDate.new(Date.parse(@base_obj.strftime("%Y-%m-%dT%H:%M:%S%z")), @locale, :calendar_type => @calendar_type)
    end

    def to_time
      LocalizedTime.new(Time.parse(@base_obj.strftime("%Y-%m-%dT%H:%M:%S%z")), @locale, :calendar_type => @calendar_type)
    end

    protected

    def formatter_const
      TwitterCldr::Formatters::DateTimeFormatter
    end
  end
end