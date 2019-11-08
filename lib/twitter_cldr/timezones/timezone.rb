# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Timezones
    class Timezone
      attr_reader :tz_id, :locale

      def initialize(tz_id, locale = TwitterCldr.locale)
        @tz_id = ZoneMeta.normalize(tz_id)
        @locale = locale
      end

      private

      def resource
        @resource ||= TwitterCldr.get_locale_resource(locale, :timezones)[locale]
      end
    end
  end
end
