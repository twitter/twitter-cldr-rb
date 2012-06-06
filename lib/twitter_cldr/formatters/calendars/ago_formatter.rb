module TwitterCldr
  module Formatters
    class AgoFormatter < Base
      def initialize(options = {})
        @tokenizer = TwitterCldr::Tokenizers::AgoTokenizer.new(:locale => extract_locale(options))
      end

      def format(seconds, direction, unit)
        if direction == :ago and seconds > 0
          raise ArgumentError.new('Start date is after end date. Consider using "until" function.')
        elsif direction == :until and seconds < 0
          raise ArgumentError.new('End date is before start date. Consider using "ago" function.')
        end

        seconds = seconds.abs() #we no longer need the sign here to know whether the timespan is in the future or past
        number = calculate_time(seconds, unit)

        tokens = @tokenizer.tokens({:direction => direction, :unit => unit, :number => number})
        prefix, suffix = *partition_tokens(tokens)

        #This is pretty hacky and doesn't apply to all languages.
        if prefix != "" and suffix != ""
          "#{prefix.to_s}#{number}#{suffix.to_s}"
        else
          "#{number}#{prefix.to_s}"
        end
      end

      def partition_tokens(tokens)
        [tokens[0] || "",
         tokens[1] || ""]
      end

      def calculate_time(seconds, unit) #could be done more intelligently.
        if unit == :default
          if seconds < 60
            unit = :second
          elsif seconds < 3600
            unit = :minute
          elsif seconds < 86400
            unit = :hour
          elsif seconds < 604800
            unit = :day
          elsif seconds < 2629743.83
            unit = :week
          elsif seconds < 31556926
            unit = :month
          else
            unit = :year
          end
        end

        case unit  #also could be improved. Right now it always rounds down.
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