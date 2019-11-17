# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'fileutils'
require 'time'
require 'tzinfo/data'

module TwitterCldr
  module Resources

    # This class should be used with JRuby in 1.9 mode
    class TimezoneTestsImporter < Importer
      requirement :icu, Versions.icu_version
      output_path File.join(TwitterCldr::SPEC_DIR, 'timezones', 'tests')
      locales TwitterCldr.supported_locales
      ruby_engine :jruby

      TYPE_MAP = {
        LONG_GMT: false,
        SHORT_GMT: false,
        GENERIC_LOCATION: false,
        LONG: true,
        LONG_GENERIC: false,
        SHORT: true,
        SHORT_GENERIC: false
      }

      def execute
        check_tzdata_versions

        output_path = params.fetch(:output_path)
        FileUtils.mkdir_p(output_path)

        params[:locales].each do |locale|
          output_file = File.join(output_path, "#{locale}.yml")

          File.write(
            output_file, YAML.dump(generate_test_cases_for_locale(locale))
          )
        end
      end

      private

      def check_tzdata_versions
        resource_bundle = requirements[:icu].get_class('com.ibm.icu.util.UResourceBundle')
        icu_data = requirements[:icu].get_class('com.ibm.icu.impl.ICUData')
        zone_info_res_field = requirements[:icu]
          .get_class('com.ibm.icu.impl.OlsonTimeZone')
          .java_class
          .declared_field(:ZONEINFORES)

        zone_info_res_field.accessible = true
        zone_info_res = zone_info_res_field.value(nil)

        bundle = resource_bundle.getBundleInstance(
          icu_data.const_get(:ICU_BASE_NAME), zone_info_res
        )

        icu_tz_version = bundle.get('TZVersion').getString
        tzinfo_version = TZInfo::Data::Version::TZDATA

        if icu_tz_version != tzinfo_version
          raise RuntimeError, 'Timezone database versions do not match. ICU is using '\
            "#{icu_tz_version} and the tzinfo-data gem is using #{tzinfo_version}."
        end
      end

      def generate_test_cases_for_locale(locale)
        ulocale = locale_class.new(locale.to_s)

        TZInfo::Timezone.all_identifiers.each_with_object({}) do |tz_id, ret|
          tz = tz_class.getTimeZone(tz_id)
          offset = tz.getRawOffset

          ret[tz_id] = {
            offset: offset,
            **test_cases_for_zone_and_locale(tz, ulocale)
          }
        end
      end

      def test_cases_for_zone_and_locale(tz, locale)
        TYPE_MAP.each_with_object({}) do |(const_name, consider_daylight), ret|
          type_const = tz_class.const_get(const_name)

          if consider_daylight
            ret[const_name] = {
              standard: tz.getDisplayName(false, type_const, locale),
              daylight: tz.getDisplayName(true, type_const, locale)
            }
          else
            ret[const_name] = {
              generic: tz.getDisplayName(false, type_const, locale)
            }
          end
        end
      end

      def tz_class
        @tz_class ||= requirements[:icu].get_class('com.ibm.icu.util.TimeZone')
      end

      def locale_class
        @locale_class ||= requirements[:icu].get_class('com.ibm.icu.util.ULocale')
      end
    end

  end
end
