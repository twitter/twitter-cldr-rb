# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Timezones
    autoload :GmtTimezone, 'twitter_cldr/timezones/gmt_timezone'
    autoload :Timezone,    'twitter_cldr/timezones/timezone'

    class << self
      def generic_non_location(tz_id, locale, options = {})
      end

      def generic_partial_location(tz_id, locale, options = {})
      end

      def generic_location(tz_id, locale, options = {})
      end

      def specific_non_location(tz_id, locale, options = {})
      end

      def gmt(tz_id, locale, options = {})
        GmtTimezone.new(tz_id, locale, options)
      end

      def iso_8601(tz_id, locale, options = {})
      end
    end
  end
end
