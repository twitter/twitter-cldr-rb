# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Versions
    CLDR_VERSION    = '40'
    ICU_VERSION     = '70.0'
    UNICODE_VERSION = '14.0.0'

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
    end
  end
end
