class Date
  def localize(locale = TwitterCldr.get_locale)
    TwitterCldr::LocalizedDate.new(self, locale)
  end
end

module TwitterCldr
  class LocalizedDate < LocalizedObject
    def method_missing(method, *args, &block)
      type = method.to_s.match(/to_(\w+)_s/)[1]
      if type && !type.empty?
        @formatter.format(@base_obj, :type => type.to_sym)
      else
        raise "Method not supported"
      end
    end

    def to_s
      self.to_default_s
    end

    protected

    def formatter_const
      TwitterCldr::Formatters::DateFormatter
    end
  end
end