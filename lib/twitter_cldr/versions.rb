# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Versions
    CLDR_VERSION    = '36'
    ICU_VERSION     = '65.1'
    UNICODE_VERSION = '12.0.0'
    EMOJI_VERSION   = '12.1'

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
