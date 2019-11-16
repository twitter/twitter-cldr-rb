# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Timezones
    autoload :GmtLocation,             'twitter_cldr/timezones/gmt_location'
    # autoload :Iso8601Timezone,         'twitter_cldr/timezones/iso8601_timezone'
    autoload :GenericLocation,         'twitter_cldr/timezones/generic_location'
    # autoload :NonLocationTimezone, 'twitter_cldr/timezones/non_location_timezone'
    autoload :Location,                'twitter_cldr/timezones/location'
    autoload :Timezone,                'twitter_cldr/timezones/timezone'
    autoload :ZoneMeta,                'twitter_cldr/timezones/zone_meta'

    class << self
      # def generic_non_location(tz_id, locale = TwitterCldr.locale)
      #   NonLocationTimezone.new(tz_id, locale)
      # end

      # def specific_non_location(tz_id, locale = TwitterCldr.locale)
      #   NonLocationTimezone.new(tz_id, locale)
      # end

      # def generic_partial_location(tz_id, locale = TwitterCldr.locale)
      #   # @TODO: what is this?
      # end

      def generic_location(tz_id, locale = TwitterCldr.locale)
        GenericLocationTimezone.new(tz_id, locale)
      end

      def gmt(tz_id, locale = TwitterCldr.locale)
        GmtTimezone.new(tz_id, locale)
      end

      def iso_8601(tz_id, locale = TwitterCldr.locale)
        Iso8601Timezone.new(tz_id, locale)
      end
    end
  end
end
