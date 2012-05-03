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

    def initialize(obj, locale, options={})
      super(obj, locale, options)
      @calendar_type = options[:calendar_type] || TwitterCldr::DEFAULT_CALENDAR_TYPE
    end

    def method_missing(method, *args, &block)
      type = method.to_s.match(/to_(\w+)_s/)[1]
      if type && !type.empty? && TwitterCldr::Tokenizers::DateTimeTokenizer::VALID_TYPES.include?(type.to_sym)
        @formatter.format(@base_obj, :type => type.to_sym)
      else
        raise "Method not supported"
      end
    end

    def to_s
      self.to_default_s
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