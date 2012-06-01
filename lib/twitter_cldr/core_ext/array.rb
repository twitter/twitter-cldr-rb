# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

class Array
  def localize(locale = TwitterCldr.get_locale)
    TwitterCldr::LocalizedArray.new(self, locale)
  end
end

module TwitterCldr
  class LocalizedArray < LocalizedObject
    def code_points_to_string
      TwitterCldr::Utils::CodePoints.to_string(self.base_obj)
    end

    def formatter_const
      nil
    end
  end
end