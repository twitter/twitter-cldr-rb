# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Shared
    class Calendar

      DEFAULT_FORMAT = :'stand-alone'

      NAMES_FORMS = [:wide, :narrow, :abbreviated]

      attr_reader :locale, :calendar_type

      def initialize(locale = TwitterCldr.get_locale, calendar_type = TwitterCldr::DEFAULT_CALENDAR_TYPE)
        @locale = TwitterCldr.convert_locale(locale)
        @calendar_type = calendar_type
      end

      def months(names_form = :wide)
        data = get_with_names_form(:months, names_form)
        data && data.sort_by{ |m| m.first }.map { |m| m.last }
      end

      def weekdays(names_form = :wide)
        get_with_names_form(:days, names_form)
      end

      private

      def get_with_names_form(data_type, names_form)
        get_data(data_type, DEFAULT_FORMAT, names_form) if NAMES_FORMS.include?(names_form.to_sym)
      end

      def get_data(*path)
        data = TwitterCldr::Utils.traverse_hash(calendar_data, path)
        redirect = parse_redirect(data)
        redirect ? get_data(*redirect) : data
      end

      def parse_redirect(data)
        $1.split('.').map(&:to_sym) if data.is_a?(Symbol) && data.to_s =~ redirect_regexp
      end

      def redirect_regexp
        Regexp.new("^calendars\.#{calendar_type}\.(.*)$")
      end

      def calendar_data
        @calendar_data ||= TwitterCldr::Utils.traverse_hash(resource, [locale, :calendars, calendar_type])
      end

      def resource
        TwitterCldr.get_locale_resource(@locale, :calendars)
      end

    end
  end
end