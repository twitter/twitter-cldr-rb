# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

class Hash
  def localize(locale = TwitterCldr.get_locale)
    TwitterCldr::LocalizedHash.new(self, locale)
  end
end

module TwitterCldr
  class LocalizedHash < LocalizedObject
    def to_yaml(options = {})
      TwitterCldr::Utils::YAML.dump(@base_obj, options)
    end

    def formatter_const
      nil
    end
  end
end