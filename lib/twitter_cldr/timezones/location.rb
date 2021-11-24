module TwitterCldr
  module Timezones
    class Location
      attr_reader :tz

      def initialize(tz)
        @tz = tz
      end

      def tz_id
        tz.identifier
      end

      def resource
        @resource ||= TwitterCldr.get_locale_resource(tz.locale, :timezones)[tz.locale]
      end

      private

      def get_period_for_naming(date)
        tz.orig_tz.period_for_utc(date.utc)
      end
    end
  end
end
