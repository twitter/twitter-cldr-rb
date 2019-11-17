# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Timezones
    class Timezone
      FORMATS = [
        :long,
        :short,
        :long_gmt,
        :short_gmt,
        :generic_location,
        :long_generic,
        :short_generic
      ].freeze

      GENERIC_LOCATION_MAP = {
        generic_location: :location,
        long_generic:     :long,
        short_generic:    :short
      }

      GMT_LOCATION_MAP = {
        generic_location: :long,
        long_generic:     :long,
        short_generic:    :short,
      }

      attr_reader :orig_tz, :canon_tz, :tz, :locale

      def initialize(tz_id, locale = TwitterCldr.locale)
        @orig_tz = TZInfo::Timezone.get(tz_id)
        @canon_tz = @orig_tz.canonical_zone
        @tz = TZInfo::Timezone.get(ZoneMeta.normalize(tz_id))
        @locale = locale
      end

      def display_name_for(date, format = :long_generic_location)
        case format
          when :generic_location, :long_generic, :short_generic
            generic_location.display_name_for(date, GENERIC_LOCATION_MAP[format]) ||
              gmt_location.display_name_for(date, GMT_LOCATION_MAP[format])
        end
      end

      def identifier
        tz.identifier
      end

      def period_for_local(date)
        tz.period_for_local(date)
      end

      def transitions_up_to(date)
        tz.transitions_up_to(date)
      end

      def orig_locale
        @orig_locale ||= TwitterCldr::Shared::Locale.new(locale)
      end

      def max_locale
        @max_locale ||= orig_locale.maximize
      end

      def generic_location
        @generic_location ||= GenericLocation.new(self)
      end

      def gmt_location
        @gmt_location = GmtLocation.new(self)
      end
    end
  end
end
