# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    class TimespanFormatter < Base
      DEFAULT_TYPE = :default

      TIME_IN_SECONDS = { 
        :second => 1,
        :minute => 60,
        :hour => 3600,
        :day => 86400,
        :week => 604800,
        :month => 2629743.83,
        :year => 31556926 
      }

      def initialize(options = {})
        @direction = options[:direction]
        @tokenizer = TwitterCldr::Tokenizers::TimespanTokenizer.new(:locale => extract_locale(options))
      end

      def format(seconds, options = {})
        options[:direction] ||= @direction || (seconds < 0 ? :ago : :until)
        options[:unit] ||= self.calculate_unit(seconds.abs)
        options[:number] = calculate_time(seconds.abs, options[:unit])
        options[:type] ||= DEFAULT_TYPE

        tokens = @tokenizer.tokens(options)
        strings = tokens.map { |token| token[:value]}
        strings.join.gsub(/\{[0-9]\}/, options[:number].to_s)
      end

      def calculate_unit(seconds)
        if seconds < 30
          :second
        elsif seconds < 2670
          :minute
        elsif seconds < 86369
          :hour
        elsif seconds < 604800
          :day
        elsif seconds < 2591969
          :week
        elsif seconds < 31556926
          :month
        else
          :year
        end
      end

      # 0 <-> 29 secs                                                   # => seconds
      # 30 secs <-> 44 mins, 29 secs                                    # => minutes
      # 44 mins, 30 secs <-> 23 hrs, 59 mins, 29 secs                   # => hours
      # 23 hrs, 59 mins, 29 secs <-> 29 days, 23 hrs, 59 mins, 29 secs  # => days
      # 29 days, 23 hrs, 59 mins, 29 secs <-> 1 yr minus 1 sec          # => months
      # 1 yr <-> max time or date                                       # => years
      def calculate_time(seconds, unit)
        (seconds / TIME_IN_SECONDS[unit]).round.to_i
      end

    end
  end
end