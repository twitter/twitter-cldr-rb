# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  class LocalizedObject
    attr_reader :locale, :base_obj, :formatter

    def initialize(obj, locale, options={})
      @base_obj = obj
      @locale = locale

      options[:locale] ||= @locale
      @formatter = self.formatter_const.new(options) if self.formatter_const
    end

    def formatter_const
      raise NotImplementedError
    end
  end
end