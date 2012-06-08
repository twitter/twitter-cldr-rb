module TwitterCldr
  module Formatters
    class TimespanFormatter < Base
      def initialize(options = {})
        @tokenizer = TwitterCldr::Tokenizers::TimespanTokenizer.new(:locale => extract_locale(options))
      end

      def format(seconds, unit)
        seconds < 0 ? direction = :ago : direction = :until

        if unit.nil? or unit == :default
          unit = self.calculate_unit(seconds.abs)
        end

        number = calculate_time(seconds.abs, unit)
        tokens = @tokenizer.tokens({:direction => direction, :unit => unit, :number => number})

        strings = []
        tokens.each do |token|
          strings << token[:value]
        end

        strings.join.gsub(/\{[0-9]\}/, number.to_s)
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
        case unit
          when :year
            return round_to(seconds/31556926, 0)
          when :month
            return round_to(seconds/2629743.83, 0)
          when :week
            return round_to(seconds/604800, 0)
          when :day
            return round_to(seconds/86400, 0)
          when :hour
            return round_to(seconds/3600, 0)
          when :minute
            return round_to(seconds/60, 0)
          when :second
            return seconds
        end
      end


      def round_to(number, precision)
        factor = 10 ** precision
        (number * factor).round.to_i / factor
      end

    end
  end
end