class Date
  def localize(locale = TwitterCldr.get_locale)
    TwitterCldr::LocalizedDate.new(self, locale)
  end
end

module TwitterCldr
  class LocalizedDate
    def initialize(date, locale)
      @base_obj = date
      @tokenizer = TwitterCldr::Tokenizers::DateTokenizer.new(:locale => locale.to_sym)
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
  end
end