# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

include TwitterCldr::Tokenizers
include TwitterCldr::Formatters

module TwitterCldr
  module DataReaders
    class TimespanDataReader < DataReader

      DEFAULT_DIRECTION = :none
      DEFAULT_TYPE = :default
      VALID_UNITS = [:second, :minute, :hour, :day, :week, :month, :year]
      BASE_PATH = [:units]

      PATHS = {
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

      attr_reader :direction, :unit, :type, :rule

      def initialize(locale, seconds, options = {})
        super(locale)

        @type = options[:type] || DEFAULT_TYPE
        @direction = options[:direction] || DEFAULT_DIRECTION
        @unit = options[:unit]

        @rule = options[:rule] ||
          TwitterCldr::Formatters::Plurals::Rules.rule_for(seconds, locale)
      end

      # type is stuff like :abbreviated, etc
      def pattern
        path = full_path_for(direction, unit, type)
        available = traverse(path)
        pluralization = pluralization_for(rule, available)

        if available.include?(pluralization)
          path << pluralization
        else
          return [] unless available.keys.first
          path << available.keys.first
        end

        traverse(path)
      end

      def tokenizer
        TimespanTokenizer.new(self)
      end

      def formatter
        TimespanFormatter.new(self)
      end

      def all_types
        traverse(BASE_PATH + [PATHS[direction][unit]]).keys
      end

      protected

      def default_type
        all_types.first
      end

      def pluralization_for(rule, available)
        # sometimes the plural rule will return ":one" when the resource only contains a path with "1"
        case rule
          when :zero
            available.include?(0) ? 0 : rule
          when :one
            available.include?(1) ? 1 : rule
          when :two
            available.include?(2) ? 2 : rule
          else
            rule
        end
      end

      def full_path_for(direction, unit, type)
        BASE_PATH + [PATHS[direction][unit], type]
      end

      def resource
        @resource = begin
          raw = TwitterCldr.get_locale_resource(locale, :units)
          raw[TwitterCldr.convert_locale(locale)]
        end
      end

    end
  end
end