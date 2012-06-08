# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Tokenizers
    class TimespanTokenizer < Base
      def initialize(options = {})
        super(options)

        @type = options[:type] || :decimal

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
            }
        }
      end

      def tokens(options = {})
        path = full_path(options[:direction], options[:unit] || :default)
        pluralization = TwitterCldr::Formatters::Plurals::Rules.rule_for(options[:number], @locale)

        case pluralization # sometimes the plural rule will return ":one" when the resource only contains a path with "1"
          when :zero
            pluralization = 0 if token_exists(path + [0])
          when :one
            pluralization = 1 if token_exists(path + [1])
          when :two
            pluralization = 2 if token_exists(path + [2])
        end

        path += [pluralization]

        tokens_for_incl_placeholders(path) if token_exists(path)
      end

      def token_exists(path)
        @@token_cache ||= {}
        cache_key = compute_cache_key(@locale, path.join('.'))
        true if @@token_cache.include?(cache_key) || traverse(path)
      end

      protected

      def full_path(direction, unit)
        @base_path + [@paths[direction][unit]]
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