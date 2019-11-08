module TwitterCldr
  module Timezones
    class ZoneMeta
      WORLD = '001'.freeze

      class << self
        def normalize(tz_id)
          if found = aliases[tz_id]
            found
          else
            tz_id
          end
        end

        def canonical_country_for(tz_id)
          region = region_for(tz_id)
          return nil if region == WORLD
          region
        end

        def is_primary_region?(region_code)
          primary_zones.include?(region_code)
        end

        def region_for(tz_id)
          region_map[tz_id]
        end

        private

        def region_map
          @region_map ||= TZInfo::Country.all_codes.each_with_object({}) do |region_code, ret|
            TZInfo::Country.get(region_code).zone_identifiers.each do |zone_id|
              # should only be one country code per zone (empirically true although
              # maybe not theoretically true)
              ret[zone_id] = region_code
            end
          end
        end

        def aliases
          aliases_resource[:zone].each_with_object({}) do |(_, zones), ret|
            ret.merge!(zones)
          end
        end

        def primary_zones
          metazones_resource[:primaryzones]
        end

        def mapzones
          metazones_resource[:mapzones]
        end

        def metazones_resource
          @metazones_resource ||= TwitterCldr.get_resource(:shared, :metazones)
        end

        def aliases_resource
          @aliases_resource ||= TwitterCldr.get_resource(:shared, :aliases)[:aliases]
        end
      end
    end
  end
end
