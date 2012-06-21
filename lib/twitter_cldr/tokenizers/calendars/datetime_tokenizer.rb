# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Tokenizers
    class DateTimeTokenizer < Base
      attr_reader :placeholders, :calendar_type

      VALID_TYPES = [:default, :full, :long, :medium, :short]

      def initialize(options = {})
        @calendar_type = options[:calendar_type] || TwitterCldr::DEFAULT_CALENDAR_TYPE

        @token_splitter_regex = //
        @token_type_regexes   = [{ :type => :plaintext, :regex => // }]

        @base_path = [:calendars]

        @paths = {
            :default => [:formats, :datetime, :default],
            :full    => [:formats, :datetime, :full],
            :long    => [:formats, :datetime, :long],
            :medium  => [:formats, :datetime, :medium],
            :short   => [:formats, :datetime, :short]
        }

        super(options)
      end

      def tokens(options = {})
        type = options[:type] || :default
        tokens_for(full_path_for(paths[type]), type)
      end

      def calendar
        @resource[:calendars][@calendar_type]
      end

      protected

      def full_path_for(path, calendar_type = @calendar_type)
        @base_path + [calendar_type] + path
      end

      def init_resources
        @resource = TwitterCldr.get_locale_resource(@locale, :calendars)[@locale]
        @resource = expand(@resource, @resource)

        @resource[:calendars].each_pair do |calendar_type, options|
          next if calendar_type == DEFAULT_CALENDAR_TYPE
          mirror_resource(:from => @resource[:calendars][DEFAULT_CALENDAR_TYPE], :to => @resource[:calendars][calendar_type])
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

      def init_placeholders
        @placeholders = [
            { :name => :time, :object => TwitterCldr::Tokenizers::TimeTokenizer.new(:locale => @locale, :calendar_type => @calendar_type) },
            { :name => :date, :object => TwitterCldr::Tokenizers::DateTokenizer.new(:locale => @locale, :calendar_type => @calendar_type) }
        ]
      end

      def pattern_for(resource)
        resource.is_a?(Hash) ? resource[:pattern] : resource
      end

      def path_map
        PATH_MAP
      end
    end
  end
end