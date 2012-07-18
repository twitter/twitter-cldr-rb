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

    def to_timespan(options = {})
      base_time = options[:base_time] || Time.now
      seconds = (self.to_time.base_obj.to_i - base_time.to_i).abs
      TwitterCldr::LocalizedTimespan.new(seconds, options.merge(:locale => @locale, :direction => :none))
    end

    def ago(options = {})
      base_time = options[:base_time] || Time.now
      seconds = self.to_time.base_obj.to_i - base_time.to_i
      raise ArgumentError.new('Start date is after end date. Consider using "until" function.') if seconds > 0
      TwitterCldr::LocalizedTimespan.new(seconds, options.merge(:locale => @locale))
    end

    def until(options = {})
      base_time = options[:base_time] || Time.now
      seconds = self.to_time.base_obj.to_i - base_time.to_i
      raise ArgumentError.new('End date is before start date. Consider using "ago" function.') if seconds < 0
      TwitterCldr::LocalizedTimespan.new(seconds, options.merge(:locale => @locale))
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