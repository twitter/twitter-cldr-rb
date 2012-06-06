module TwitterCldr
  module Formatters
    class AgoFormatter < Base
      def initialize(options = {})
        @tokenizer = TwitterCldr::Tokenizers::AgoTokenizer.new(:locale => extract_locale(options))  #hmmm...
      end

      #how do you know if it's before or after? what about arabic where there's no number?

      #maybe add optional starting date options, unit options, etc.
      def format(seconds, options)  #options should contain TimeSpanDirection
        direction = options[:direction]
        if direction == :ago and seconds > 0
          raise ArgumentError.new('Start date is after end date. Consider using "until" function.')
        elsif direction == :until and seconds < 0
          raise ArgumentError.new('End date is before start date. Consider using "ago" function.')
        end

        seconds = seconds.abs() #we no longer need the sign here to know whether the timespan is in the future or past
        number = calculate_time(seconds, options)

        tokens = @tokenizer.tokens({:direction => direction, :unit => options[:unit], :number => number})
        prefix, suffix = *partition_tokens(tokens) #Q: is there a better way to tell prefix from suffix?
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

      def calculate_time(seconds, options)
        unit = options[:unit]
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

        case unit
          when :year
            return round_to(seconds/31556926, 0)  #returns days
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