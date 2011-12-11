class Fixnum
  def localize(locale = TwitterCldr.get_locale)
    TwitterCldr::LocalizedNumber.new(self, locale)
  end
end