# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

class String
  def localize(locale = TwitterCldr.get_locale)
    TwitterCldr::LocalizedString.new(self, locale)
  end
end

module TwitterCldr
  class LocalizedString < LocalizedObject

    # Uses wrapped string object as a format specification and returns the result of applying it to +args+ (see
    # +TwitterCldr::Utils.interpolate+ method for interpolation syntax).
    #
    # If +args+ is a Hash than pluralization is performed before interpolation (see +PluralFormatter+ class for
    # pluralization specification).
    #
    def %(args)
      pluralized = args.is_a?(Hash) ? @formatter.format(@base_obj, args) : @base_obj
      TwitterCldr::Utils.interpolate(pluralized, args)
    end

    def formatter_const
      TwitterCldr::Formatters::PluralFormatter
    end

    def normalize
      LocalizedString.new(TwitterCldr::Normalizers::NFD.normalize(@base_obj), @locale)
    end

    def code_points
      TwitterCldr::Utils::CodePoints.from_string(@base_obj)
    end

    def to_s
      @base_obj.dup
    end

  end
end