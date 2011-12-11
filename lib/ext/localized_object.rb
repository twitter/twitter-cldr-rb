module TwitterCldr
  class LocalizedObject
    attr_reader :locale, :base_obj

    def initialize(obj, locale)
      @base_obj = obj
      @locale = locale
      @formatter = self.formatter_const.new(:locale => @locale) if self.formatter_const
    end
  end
end