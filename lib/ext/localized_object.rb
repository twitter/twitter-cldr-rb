# -*- encoding : utf-8 -*-
module TwitterCldr
  class LocalizedObject
    attr_reader :locale, :base_obj, :formatter

    def initialize(obj, locale)
      @base_obj = obj
      @locale = locale
      @formatter = self.formatter_const.new(:locale => @locale) if self.formatter_const
    end

    def formatter_const
      raise NotImplementedError
    end
  end
end
