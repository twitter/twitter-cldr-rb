# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Timezones
    class NonLocationTimezone < Timezone
      STANDARD_INTERVAL = 184 * 24 * 60 * 60

      def to_s(type = DEFAULT_TYPE, format = DEFAULT_FORMAT)
        if timezone_exists?(type, format)
          explicit_tz_id(type, format) || implicit_tz_id(type, format)
        else
          explicit_metazone(type, format) ||
            implicit_metazone(type, format) ||
            preferred_zone(type, format)
        end
      end

      private

      def explicit_tz_id(type, format)
        timezone_resource.fetch(format, {}).fetch(type)
      end

      def implicit_tz_id(type, format)
        type_fallback(timezone_resource, type, format)
      end

      def type_fallback(resource, type, format)
        types = resource.fetch(format, {})

        if types.include?(:daylight)
          types[:generic] || begin
            start_offsets = tzinfo.offsets_up_to(time_to_use, time_to_use - STANDARD_INTERVAL)
            finish_offsets = tzinfo.offsets_up_to(time_to_use + STANDARD_INTERVAL, time_to_use)
            start = start_offsets.find { |os| !os.dst? }
            start_dst = start_offsets.find(&:dst?)
            finish = finish_offsets.find { |os| !os.dst? }
            finish_dst = finish_offsets.find(&:dst?)

            can_use_standard = start.utc_offset == finish.utc_offset &&
              start_dst.utc_offset == finish_dst.utc_offset

            types[:standard] if can_use_standard
          end
        else
          types[:generic] || types[:standard]
        end
      end

      def explicit_metazone(type, format)
        metazone_resource.fetch(format, {})[type]
      end

      def implicit_metazone(type, format)
        type_fallback(metazone_resource, type, format)
      end

      def preferred_zone(type, format)
        max_locale = TwitterCldr::Shared::Locale.parse(locale).maximize
        region = max_locale.region
        zone = Timezone.from_territory(region, locale, metazone)

        unless zone
          region = '001'
          zone = Timezone.from_territory(region, locale, metazone)
        end

        metazone_fmt = resource[:metazones]
          .fetch(zone.metazone.to_sym, {})
          .fetch(format, {})[type]

        if zone.tz_id == tz_id
          metazone_fmt
        else
          if region == territory
            # Otherwise, use the metazone format + city in the fallbackFormat.
            fallback_format
              .sub('{0}', city || inferred_city)
              .sub('{1}', metazone_fmt)
          else
            # Otherwise, if the zone is the preferred zone for its country but not
            # for the country of the locale, use the metazone format + country in
            # the fallbackFormat.
            fallback_format
              .sub('{0}', country || country_code)
              .sub('{1}', metazone_fmt)
          end
        end
      end

      def inferred_city
        tz_id.split('/').last.gsub('_', ' ')
      end

      def timezone_exists?(type, format)
        !!timezone_resource.fetch(format, {})[type]
      end

      def fallback_format
        resource[:formats][:fallback_format]
      end

      def timezone_resource
        resource[:timezones].fetch(tz_id, {})
      end

      def metazone_resource
        resource[:metazones].fetch(metazone, {})
      end
    end
  end
end
