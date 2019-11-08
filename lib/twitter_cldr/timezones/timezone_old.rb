# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'tzinfo'

module TwitterCldr
  module Timezones
    class Timezone
      class << self
        private :new

        def from_id(tz_id, locale = TwitterCldr.locale)
          new(canonicalize_tz_id(tz_id), locale)
        end

        def from_territory(territory, locale = TwitterCldr.locale, metazone = '001')
          zone = resource[:mapzones].find do |zone|
            zone[:territory] == territory && zone[:other] == metazone
          end

          from_id(zone[:type], locale) if zone
        end

        def from_metazone(locale = TwitterCldr.locale, metazone = '001')
          zone = resource[:mapzones].find do |zone|
            zone[:other] == metazone
          end

          from_id(zone[:type], locale) if zone
        end

        private

        def zone_country_code_map
          @zone_country_code_map ||= TZInfo::Country.all_codes.each_with_object({}) do |country_code, ret|
            TZInfo::Country.get(country_code).zone_identifiers.each do |zone_id|
              # should only be one country code per zone (empirically true although
              # maybe not theoretically true)
              ret[zone_id] = country_code
            end
          end
        end

        def canonicalize_tz_id(tz_id)
          aliases_resource.fetch(tz_id.to_sym, tz_id)
        end

        def resource
          @resource ||= TwitterCldr.get_resource(:shared, :metazones)
        end

        def aliases_resource
          @aliases_resource ||= TwitterCldr.get_resource(:shared, :aliases)[:aliases][:zone][:deprecated]
        end
      end

      FORMATS = [:short, :long]
      TYPES = [:generic, :standard, :daylight]

      DEFAULT_FORMAT = :long
      DEFAULT_TYPE = :generic

      attr_reader :tz_id, :locale

      def initialize(tz_id, locale = TwitterCldr.locale)
        @tz_id = tz_id
        @locale = locale
      end

      def metazone
        # @TODO: eventually take date ranges into account
        @metazone ||= self.class.send(:resource)[:timezones]
          .fetch(tz_id.to_sym, [])
          .last[:metazone]
      end

      def territory
        @territory ||= begin
          mapzone = self.class.send(:resource)[:mapzones].find do |zone|
            zone[:type] == tz_id
          end

          mapzone ? mapzone[:territory] : '001'
        end
      end

      def city
        resource[:timezones].fetch(tz_id.to_sym, {}).fetch(:city) do
          tz_id.split('/').last.gsub('_', ' ')
        end
      end

      def country_code
        zone_country_code_map[tz_id] || aliases.each do |alias_tz_id|
          if code = zone_country_code_map[alias_tz_id]
            break code
          end
        end
      end

      def country
        @country ||= TwitterCldr::Shared::Territories.from_territory_code_for_locale(
          country_code, locale
        )
      end

      def aliases
        self.class.send(:aliases_resource).each_with_object([]) do |(alias_tz_id, canonical_tz_id), ret|
          if canonical_tz_id == tz_id
            ret << alias_tz_id.to_s
          end
        end
      end

      private

      def zone_country_code_map
        self.class.send(:zone_country_code_map)
      end

      def tzinfo
        @tzinfo ||= TZInfo::Timezone.get(tz_id)
      end

      def offset_minute
        (offset.utc_offset.abs % 3600) / 60
      end

      def offset_hour
        offset.utc_offset.abs / 3600
      end

      def offset
        @offset ||= offsets.first
      end

      def daylight_offset
        offsets.find(&:dst?)
      end

      def offsets
        @offsets ||= begin
          tzinfo.offsets_up_to(time_to_use, one_year_ago)
        end
      end

      # @TODO: eventually allow user to supply a time
      def time_to_use
        Time.now.utc
      end

      def one_year_ago
        time_to_use - (365 * 24 * 60 * 60)
      end

      def resource
        @resource ||= TwitterCldr.get_locale_resource(locale, :timezones)[locale]
      end
    end
  end
end
