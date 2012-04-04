# encoding: UTF-8

class Symbol
  def localize(locale = TwitterCldr.get_locale)
    TwitterCldr::LocalizedSymbol.new(self, locale)
  end
end

module TwitterCldr
  class LocalizedSymbol < LocalizedObject
    def as_language_code
      TwitterCldr::Shared::Languages.from_code_for_locale(@base_obj, @locale)
    end

    def formatter_const
      nil
    end
  end
end