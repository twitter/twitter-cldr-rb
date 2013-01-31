# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Tokenizers
    class DateTimeTokenizer < Base
      attr_reader :placeholders, :calendar_type

      VALID_TYPES = [:default, :full, :long, :medium, :short, :additional]

      def initialize(options = {})
        @calendar_type = options[:calendar_type] || TwitterCldr::DEFAULT_CALENDAR_TYPE
        @type = options[:type] || :default
        @format = options[:format]

        @token_splitter_regexes = {
          :additional => Regexp.union(
            DateTokenizer::TOKEN_SPLITTER_REGEX,
            TimeTokenizer::TOKEN_SPLITTER_REGEX
          ),
          :else => //
        }

        @token_type_regexes = {
          :additional => merge_token_type_regexes(DateTokenizer::TOKEN_TYPE_REGEXES, TimeTokenizer::TOKEN_TYPE_REGEXES),
          :else => {
            :plaintext => { :regex => // }
          }
        }

        @base_path = [:calendars]

        @paths = {
          :default    => [:formats, :datetime, :default],
          :full       => [:formats, :datetime, :full],
          :long       => [:formats, :datetime, :long],
          :medium     => [:formats, :datetime, :medium],
          :short      => [:formats, :datetime, :short],
          :additional => [:additional_formats]
        }

        super(options)
      end

      def tokens(options = {})
        @type = options[:type] || @type || :default
        @format = options[:format] || @format
        tokens_for(full_path_for(paths[@type]))
      end

      def calendar
        @resource[:calendars][@calendar_type]
      end

      def additional_format_selector
        cache_key = TwitterCldr::Utils.compute_cache_key(@locale, @calendar_type)
        @additional_format_selector = format_selector_cache[cache_key] ||= AdditionalDateFormatSelector.new(
          @resource[:calendars][@calendar_type][:additional_formats]
        )
      end

      protected

      def format_selector_cache
        @@format_selector_cache ||= {}
      end

      def merge_token_type_regexes(first, second)
        TwitterCldr::Utils.deep_merge_hash(first, second) do |left, right|
          if right.is_a?(Regexp) && left.is_a?(Regexp)
            Regexp.union(left, right)
          else
            left
          end
        end
      end

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
        case type
          when :additional
            resource[additional_format_selector.find_closest(format).to_sym]
          else
            resource.is_a?(Hash) ? resource[:pattern] : resource
        end
      end

      def pattern_cache
        @@pattern_cache ||= {}
      end
    end
  end
end