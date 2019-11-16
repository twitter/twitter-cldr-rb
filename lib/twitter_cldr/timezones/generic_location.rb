# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Timezones
    class GenericLocation < Location
      DEFAULT_CITY_EXCLUSION_PATTERN = /Etc\/.*|SystemV\/.*|.*\/Riyadh8[7-9]/
      DST_CHECK_RANGE = 184 * 24 * 60 * 60
      FORMATS = [:location, :short, :long].freeze

      Territories = TwitterCldr::Shared::Territories
      Utils = TwitterCldr::Utils

      def display_name_for(date, fmt = :location)
        case fmt
          when :location
            generic_location_display_name
          when :short
            generic_short_display_name(date) || generic_location_display_name
          when :long
            generic_long_display_name(date) || generic_location_display_name
          else
            raise ArgumentError, "'#{fmt}' is not a valid generic timezone format, "\
              "must be one of #{FORMATS.join(', ')}"
        end
      end

      private

      def generic_location_display_name
        if region_code = ZoneMeta.canonical_country_for(tz_id)
          if ZoneMeta.is_primary_region?(region_code)
            region_name = Territories.from_territory_code_for_locale(region_code, tz.locale)
            return region_formats[:generic].sub('{0}', region_name || region_code)
          else
            # From ICU source, TimeZoneGenericNames.java, getGenericLocationName():
            #
            # exemplar location should return non-empty String
            # if the time zone is associated with a location
            return region_formats[:generic].sub('{0}', exemplar_city || region_code)
          end
        end
      end

      def generic_short_display_name(date)
        generic_display_name(date, :short)
      end

      def generic_long_display_name(date)
        generic_display_name(date, :long)
      end

      # From ICU source, TimeZoneGenericNames.java, formatGenericNonLocationName():
      #
      # 1. If a generic non-location string is available for the zone, return it.
      # 2. If a generic non-location string is associated with a meta zone and
      #    the zone never use daylight time around the given date, use the standard
      #    string (if available).
      # 3. If a generic non-location string is associated with a meta zone and
      #    the offset at the given time is different from the preferred zone for the
      #    current locale, then return the generic partial location string (if available)
      # 4. If a generic non-location string is not available, use generic location
      #    string.
      #
      def generic_display_name(date, fmt)
        if generic = (timezone_data[fmt] || {})[:generic]
          return generic
        end

        date_int = date.strftime('%s').to_i
        period = tz.period_for_local(date)

        if tz_metazone = ZoneMeta.tz_metazone_for(tz_id, date)
          use_standard = use_standard?(date_int, period)

          if use_standard && std_name = std_name_for(fmt)
            return std_name
          end

          mz_name = mz_name_for(fmt, tz_metazone.mz_id, use_standard)
          golden_zone_id = tz_metazone.metazone.reference_tz_id

          if golden_zone_id != tz_id
            golden_zone = TZInfo::Timezone.get(golden_zone_id)
            golden_date = Time.at(date_int + period.base_utc_offset + period.std_offset)
            golden_period = golden_zone.period_for_local(golden_date)

            if period.base_utc_offset != golden_period.base_utc_offset || period.std_offset != golden_period.std_offset
              return partial_location_name_for(tz_metazone.metazone, mz_name)
            else
              return mz_name
            end
          else
            return mz_name
          end
        end
      end

      def partial_location_name_for(metazone, mz_name)
        region_code = ZoneMeta.canonical_country_for(tz_id)

        location = if region_code
          if region_code == metazone.reference_region_code
            Territories.from_territory_code_for_locale(region_code)
          else
            exemplar_city
          end
        else
          exemplar_city ? exemplar_city : tz_id
        end

        fallback_formats[:generic]
          .sub('{0}', location)
          .sub('{1}', mz_name || '')
      end

      def target_region_code
        @target_region_code ||= tz.orig_locale.region || tz.max_locale.region
      end

      def exemplar_city
        @exemplar_city ||= timezone_data[:city] || default_exemplar_city
      end

      def std_name_for(fmt)
        Utils.traverse_hash(timezone_data[:timezones], [tz_id.to_sym, fmt, :standard])
      end

      def mz_name_for(fmt, mz_id, use_standard)
        if use_standard
          if std = Utils.traverse_hash(metazone_data, [mz_id.to_sym, fmt, :standard])
            return std
          end
        end

        Utils.traverse_hash(metazone_data, [mz_id.to_sym, fmt, :generic])
      end

      def use_standard?(date_int, transition_offset)
        prev_trans = tz.transitions_up_to(Time.at(date_int - DST_CHECK_RANGE)).last
        next_trans = tz.transitions_up_to(Time.at(date_int + DST_CHECK_RANGE)).last

        return false if transition_offset.std_offset != 0
        return false if prev_trans && prev_trans.offset.std_offset != 0
        return false if next_trans && next_trans.offset.std_offset != 0

        true
      end

      def default_exemplar_city
        @default_exemplar_city ||= begin
          return nil if tz_id =~ DEFAULT_CITY_EXCLUSION_PATTERN

          sep = tz_id.rindex('/')

          if sep > 0 && sep + 1 < tz_id.length
            return tz_id[(sep + 1)..-1].gsub('_', ' ')
          end

          nil
        end
      end

      def timezone_data
        @timezone_data ||= (resource[:timezones][tz_id.to_sym] || {})
      end

      def metazone_data
        @metazone_data ||= resource[:metazones]
      end

      def region_formats
        @region_format ||= resource[:formats][:region_formats]
      end

      def fallback_formats
        @fallback_formats ||= resource[:formats][:fallback_formats]
      end
    end
  end
end
