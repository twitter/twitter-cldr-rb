# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Shared
    class Calendar

      DEFAULT_FORMAT = :'stand-alone'

      FORMS = [:wide, :narrow, :abbreviated]

      REDIRECT_REGEXP = /^c$/

      attr_reader :locale, :calendar_type

      def initialize(locale = TwitterCldr::DEFAULT_LOCALE, calendar_type = TwitterCldr::DEFAULT_CALENDAR_TYPE)
        @locale = locale
        @calendar_type = calendar_type
      end

      def months(form = :wide)
        get_data(:months, DEFAULT_FORMAT, form).sort_by{ |m| m.first }.map { |m| m.last }
      end

      private

      def get_data(*path)
        data = traverse_path(resource, path)
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
        Regexp.new("^calendars\.#{@calendar_type}\.(.*)$")
      end

      def resource
        @resource ||= TwitterCldr.get_resource(@locale, :calendars)[@locale][:calendars][@calendar_type]
      end

    end
  end
end