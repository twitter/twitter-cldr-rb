# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Timezones
    class LocationTimezone < Timezone
      def to_s(type = DEFAULT_TYPE)
        if country && is_primary?
          region_format(type).sub('{0}', country)
        else
          region_format(type).sub('{0}', city)
        end
      end

      private

      def is_primary?
        tz_country.zone_identifiers.size == 1 || primary_zones.values.include?(tz_id)
      end

      def tz_country
        @tz_country ||= TZInfo::Country.get(country_code)
      end

      # @TODO do that crazy 184 day thing, bring over from NonLocationTimezone
      def region_format(type)
        region_formats[type] ||
          region_formats[:generic] ||
          region_formats[:standard]
      end

      def region_formats
        resource[:formats][:region_format]
      end

      def primary_zones
        self.class.send(:resource)[:primaryzones]
      end
    end
  end
end
