class Time
  def localize(locale = TwitterCldr.get_locale)
    TwitterCldr::LocalizedTime.new(self, locale)
  end
end

module TwitterCldr
  class LocalizedTime
    def initialize(time, locale)
      @base_obj = time
      @tokenizer = TwitterCldr::Tokenizers::TimeTokenizer.new(:locale => locale.to_sym)
      @formatter = TwitterCldr::Formatters::DateTimeFormatter.new(:tokenizer => @tokenizer)
    end

    def method_missing(method, *args, &block)
      type = method.to_s.match(/to_(\w+)_s/)[1]
      if type && type.size > 0
        @formatter.format(@base_obj, :type => type.to_sym)
      else
        raise "Method not supported"
      end
    end

    def to_s
      self.to_default_s
    end
  end
end