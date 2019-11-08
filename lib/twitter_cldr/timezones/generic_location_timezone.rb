# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Timezones
    class GenericLocationTimezone < Timezone
      def to_s
        if region_code = ZoneMeta.canonical_country_for(tz_id)
          if ZoneMeta.is_primary_region?(region_code)
            # String country = getLocaleDisplayNames().regionDisplayName(countryCode);
            # name = formatPattern(Pattern.REGION_FORMAT, country);
          else
            # String city = _tznames.getExemplarLocationName(canonicalTzID);
            # name = formatPattern(Pattern.REGION_FORMAT, city);
          end
        end
      end
    end
  end
end
