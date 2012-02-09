module TwitterCldr
  module LocalizedNumberMixin
    def localize(locale = TwitterCldr.get_locale)
      TwitterCldr::LocalizedNumber.new(self, locale)
    end
  end

  class LocalizedNumber < LocalizedObject
    DEFAULT_TYPE = :decimal
    attr_reader :type

    def to_decimal(options = {})
      self.setup_for(:decimal)
      self
    end

    def to_currency(options = {})
      self.setup_for(:currency)
      self
    end

    def to_percent(options = {})
      self.setup_for(:percent)
      self
    end

    def to_s(options = {})
      opts = options
      opts = { :precision => 0 }.merge(opts) if @base_obj.is_a?(Fixnum)
      @formatter.format(@base_obj, opts)
    end

    protected

    def formatter_const
      TwitterCldr::Formatters::DecimalFormatter
    end

    def setup_for(type)
      @type = type
      fmt_class = TwitterCldr::Formatters.const_get("#{(@type || DEFAULT_TYPE).to_s.capitalize}Formatter".to_sym)
      @formatter = fmt_class.new(:locale => locale.to_sym)
    end
  end
end