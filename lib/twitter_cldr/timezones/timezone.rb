# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'tzinfo'

module TwitterCldr
  module Timezones
    class Timezone
      class << self
        def from_id(tz_id)
          new(tz_id)
        end

        def from_offset(offset)
        end
      end

      FORMATS = [:short, :long]
      TYPES = [:generic, :standard, :daylight]

      attr_reader :tz_id, :locale

      def initialize(tz_id, locale = TwitterCldr.locale)
        @tz_id = tz_id
        @locale = locale
      end

      def generic_non_location(format = :short)
      end

      def generic_partial_location(format = :short)
      end

      def generic_location
      end

      def specific_non_location(format = :short)
      end

      def gmt
      end

      def iso_8601
      end

      private

      def resource
        @resource ||= TwitterCldr.get_locale_resource(locale, 'timezones')
      end
    end
  end
end
