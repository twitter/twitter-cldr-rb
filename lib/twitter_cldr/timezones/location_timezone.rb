# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Timezones
    class LocationTimezone < Timezone
      def to_s
        if use_region_format?
          region_format.sub('{0}', country)
        else
          region_format.sub('{0}', city)
        end
      end

      private

      def use_region_format?
        tz_country.zone_identifiers.size > 1 ||
          primary_zones.values.include?(tz_id)
      end

      def tz_country
        @tz_country ||= TZInfo::Country.get(country_code)
      end

      def region_format
        resource[:formats][:region_format]
      end

      def primary_zones
        self.class.send(:resource)[:primaryzones]
      end
    end
  end
end
