# encoding: UTF-8

class String
  def localize(locale = TwitterCldr.get_locale)
    TwitterCldr::LocalizedString.new(self, locale)
  end
end

module TwitterCldr
  class LocalizedString < LocalizedObject
    def %(args)
      if args.is_a?(Hash)
        @formatter.format(@base_obj, args)
      else
        @base_obj % args
      end
    end

    def formatter_const
      TwitterCldr::Formatters::PluralFormatter
    end
  end
end