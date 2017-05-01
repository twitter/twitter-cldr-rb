# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Versions
    CLDR_VERSION    = '31'
    ICU_VERSION     = '59.1'
    UNICODE_VERSION = '9.0.0'
    EMOJI_VERSION   = '4.0'

    class << self
      def cldr_version
        CLDR_VERSION
      end

      def icu_version
        ICU_VERSION
      end

      def unicode_version
        UNICODE_VERSION
      end

      def emoji_version
        EMOJI_VERSION
      end
    end
  end
end
