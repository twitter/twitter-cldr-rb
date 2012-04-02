# encoding: UTF-8

class DateTime
  def localize(locale = TwitterCldr.get_locale)
    TwitterCldr::LocalizedDateTime.new(self, locale)
  end
end

module TwitterCldr
  class LocalizedDateTime < LocalizedObject
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
      LocalizedDate.new(Date.parse(@base_obj.strftime("%Y-%m-%dT%H:%M:%S%z")), @locale)
    end

    def to_time
      LocalizedTime.new(Time.parse(@base_obj.strftime("%Y-%m-%dT%H:%M:%S%z")), @locale)
    end

    protected

    def formatter_const
      TwitterCldr::Formatters::DateTimeFormatter
    end
  end
end