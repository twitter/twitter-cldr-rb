# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    class TimespanFormatter < Base

      DEFAULT_TYPE = :default
      APPROXIMATE_MULTIPLIER = 0.75

      TIME_IN_SECONDS = {
        :second => 1,
        :minute => 60,
        :hour   => 3600,
        :day    => 86400,
        :week   => 604800,
        :month  => 2629743.83,
        :year   => 31556926
      }

      def initialize(options = {})
        @direction = options[:direction]
        @tokenizer = TwitterCldr::Tokenizers::TimespanTokenizer.new(:locale => extract_locale(options))
      end

      def format(seconds, fmt_options = {})
        options = fmt_options.dup
        options[:type]      ||= DEFAULT_TYPE
        options[:direction] ||= @direction || (seconds < 0 ? :ago : :until)
        options[:unit]      ||= calculate_unit(seconds.abs, options)

        options[:number] = calculate_time(seconds.abs, options[:unit])

        tokens = @tokenizer.tokens(options)
        strings = tokens.map { |token| token[:value] }
        strings.join.gsub(/\{[0-9]\}/, options[:number].to_s)
      end

      def calculate_unit(seconds, unit_options = {})
        options = unit_options.dup
        options[:approximate] = true if options[:approximate].nil?
        multiplier = options[:approximate] ? APPROXIMATE_MULTIPLIER : 1

        if seconds < (TIME_IN_SECONDS[:minute] * multiplier) then :second
        elsif seconds < (TIME_IN_SECONDS[:hour] * multiplier) then :minute
        elsif seconds < (TIME_IN_SECONDS[:day] * multiplier) then :hour
        elsif seconds < (TIME_IN_SECONDS[:week] * multiplier) then :day
        elsif seconds < (TIME_IN_SECONDS[:month] * multiplier) then :week
        elsif seconds < (TIME_IN_SECONDS[:year] * multiplier) then :month
        else :year end
      end

      # 0 <-> 29 secs                                                   # => seconds
      # 30 secs <-> 44 mins, 29 secs                                    # => minutes
      # 44 mins, 30 secs <-> 23 hrs, 59 mins, 29 secs                   # => hours
      # 23 hrs, 59 mins, 29 secs <-> 29 days, 23 hrs, 59 mins, 29 secs  # => days
      # 29 days, 23 hrs, 59 mins, 29 secs <-> 1 yr minus 1 sec          # => months
      # 1 yr <-> max time or date                                       # => years
      def calculate_time(seconds, unit)
        (seconds.to_f / TIME_IN_SECONDS[unit].to_f).round.to_i
      end

    end
  end
end