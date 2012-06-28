# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  class LocalizedObject
    attr_reader :locale, :base_obj, :formatter

    def initialize(obj, locale, options = {})
      @base_obj = obj
      @locale = TwitterCldr.convert_locale(locale)
      @locale = TwitterCldr::DEFAULT_LOCALE unless TwitterCldr.supported_locale?(@locale)

      options = options.dup
      options[:locale] = @locale

      @formatter = formatter_const.new(options) if formatter_const
    end

    def formatter_const
      raise NotImplementedError
    end
  end
end