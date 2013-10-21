# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module DataReaders
    class CalendarDataReader < DataReader

      DEFAULT_TYPE = :medium

      TYPE_PATHS = {
        :full       => [:full, :pattern],
        :long       => [:long, :pattern],
        :medium     => [:medium, :pattern],
        :short      => [:short, :pattern],
        :additional => [:additional_formats]
      }

      attr_reader :calendar_type, :type

      def initialize(locale, options = {})
        super(locale)
        @calendar_type = options[:calendar_type] || TwitterCldr::DEFAULT_CALENDAR_TYPE
        @type = options[:type] || type || :default
        @type = DEFAULT_TYPE if type == :default
      end

      def pattern
        traverse(path_for(type, calendar_type) + TYPE_PATHS[type])
      end

      def calendar
        resource[:calendars][calendar_type]
      end

      protected

      def path_for(type, calendar_type)
        raise NotImplementedError
      end

      def resource
        @resource ||= begin
          resource = TwitterCldr.get_locale_resource(locale, :calendars)[locale]
          resource[:calendars].each_pair do |calendar_type, options|
            next if calendar_type == TwitterCldr::DEFAULT_CALENDAR_TYPE
            mirror_resource(
              :from => resource[:calendars][TwitterCldr::DEFAULT_CALENDAR_TYPE],
              :to   => resource[:calendars][calendar_type]
            )
          end
          resource
        end
      end

      def mirror_resource(options)
        from = options[:from]
        to = options[:to]

        from.each_pair do |key, value|
          if !to[key]
            to[key] = from[key]
          else
            if to[key].is_a?(Hash) and from[key].is_a?(Hash)
              mirror_resource(:from => from[key], :to => to[key])
            end
          end
        end
      end

    end
  end
end