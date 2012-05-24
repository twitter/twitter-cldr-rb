# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Shared
    class Calendar

      DEFAULT_FORM = :'stand-alone'

      NAMES_FORMS = [:wide, :narrow, :abbreviated]

      REDIRECT_REGEXP = /^c$/

      attr_reader :locale, :calendar_type

      def initialize(locale = TwitterCldr::DEFAULT_LOCALE, calendar_type = TwitterCldr::DEFAULT_CALENDAR_TYPE)
        @locale = locale
        @calendar_type = calendar_type
      end

      def months(names_form = :wide)
        return unless NAMES_FORMS.include?(names_form.to_sym)

        data = get_data(:months, DEFAULT_FORM, names_form)
        data && data.sort_by{ |m| m.first }.map { |m| m.last }
      end

      private

      def get_data(*path)
        data = traverse_path(calendar_data, path)
        redirect = parse_redirect(data)
        redirect ? get_data(*redirect) : data
      end

      def traverse_path(tree, path)
        !path.empty? && tree.is_a?(Hash) ? traverse_path(tree[path.first], path[1..-1]) : tree
      end

      def parse_redirect(data)
        $1.split('.').map(&:to_sym) if data.is_a?(Symbol) && data.to_s =~ redirect_regexp
      end

      def redirect_regexp
        Regexp.new("^calendars\.#{calendar_type}\.(.*)$")
      end

      def calendar_data
        @calendar_data ||= traverse_path(resource, [locale, :calendars, calendar_type])
      end

      def resource
        TwitterCldr.get_resource(@locale, :calendars)
      end

    end
  end
end