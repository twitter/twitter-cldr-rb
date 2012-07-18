# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Tokenizers
    class TimespanTokenizer < Base
      VALID_UNITS = [:second, :minute, :hour, :day, :week, :month, :year]

      def initialize(options = {})
        super(options)

        @token_splitter_regex = /([^0*#,\.]*)([0#,\.]+)([^0*#,\.]*)$/ # creates spaces
        @token_type_regexes   = [
            { :type => :pattern, :regex => /[0?#,\.]*/ }, # splits token at right places
            { :type => :plaintext, :regex => // }
        ]
        @base_path = [:units]
        @paths = {
            :ago => {
                :default => :'hour-past',
                :second  => :'second-past',
                :minute  => :'minute-past',
                :hour    => :'hour-past',
                :day     => :'day-past',
                :week    => :'week-past',
                :month   => :'month-past',
                :year    => :'year-past'
            },
            :until => {
                :default => :'hour-future',
                :second  => :'second-future',
                :minute  => :'minute-future',
                :hour    => :'hour-future',
                :day     => :'day-future',
                :week    => :'week-future',
                :month   => :'month-future',
                :year    => :'year-future'
            },
            :none => {
                :default => :second,
                :second  => :second,
                :minute  => :minute,
                :hour    => :hour,
                :day     => :day,
                :week    => :week,
                :month   => :month,
                :year    => :year
            }
        }
      end

      def tokens(options = {})
        path = full_path(options[:direction], options[:unit], options[:type])
        pluralization = options[:rule] || TwitterCldr::Formatters::Plurals::Rules.rule_for(options[:number], @locale)

        case pluralization # sometimes the plural rule will return ":one" when the resource only contains a path with "1"
          when :zero
            pluralization = 0 if token_exists(path + [0])
          when :one
            pluralization = 1 if token_exists(path + [1])
          when :two
            pluralization = 2 if token_exists(path + [2])
        end
        path << pluralization
        tokens_with_placeholders_for(path) if token_exists(path)
      end

      def token_exists(path)
        @@token_cache ||= {}
        cache_key = compute_cache_key(@locale, path.join('.'))
        true if @@token_cache.include?(cache_key) || traverse(path)
      end

      def all_types_for(unit, direction)
        traverse(@base_path + [@paths[direction][unit]]).keys
      end

      protected

      def full_path(direction, unit, type)
        @base_path + [@paths[direction][unit], type]
      end

      def init_resources
        @resource = TwitterCldr.get_locale_resource(@locale, :units)[TwitterCldr.convert_locale(@locale)]
      end

      def pattern_for(resource)
        # can't go any deeper, so return original pattern (which should NOT be a hash, by the way)
        resource
      end
    end
  end
end