# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'tzinfo'

module TwitterCldr
  module Timezones
    class Timezone
      class << self
        def from_id(tz_id, locale = TwitterCldr.locale)
          new(tz_id, locale)
        end

        def from_territory(territory, locale = TwitterCldr.locale, metazone = '001')
          zone = resource[:mapzones].find do |zone|
            zone[:territory] == territory && zone[:other] == metazone
          end

          new(zone[:type], locale) if zone
        end

        def from_metazone(locale = TwitterCldr.locale, metazone = '001')
          zone = resource[:mapzones].find do |zone|
            zone[:other] == metazone
          end

          new(zone[:type], locale) if zone
        end

        private

        def resource
          @resource ||= TwitterCldr.get_resource(:shared, :metazones)
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
        # no direct way to get country from zone id, so we have to do this
        # (fortunately it's pretty fast)
        TZInfo::Country.all_codes.find do |code|
          TZInfo::Country.get(code).zone_identifiers.include?(tz_id)
        end
      end

      def country
        TwitterCldr::Shared::Territories.from_territory_code(country_code)
      end

      private

      def tzinfo
        @tzinfo ||= TZInfo::Timezone.get(tz_id)
      end

      def offset_minute
        offset.abs % 3600
      end

      def offset_hour
        offset.abs / 3600
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
        @resource ||= TwitterCldr.get_locale_resource(locale, 'timezones')[locale]
      end
    end
  end
end
