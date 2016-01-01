# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Versions
    CLDR_VERSION    = '26'
    ICU_VERSION     = '54.1'
    UNICODE_VERSION = '6.3.0'

    # Use these instead to update collation and tailoring data
    # CLDR_VERSION = '23.1'
    # ICU_VERSION = '51.2'

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
