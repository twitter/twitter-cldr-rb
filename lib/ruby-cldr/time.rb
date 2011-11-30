class Cldr
  module Format
    class Time < Datetime::Base
      PATTERN = /a{1}|h{1,2}|H{1,2}|K{1,2}|k{1,2}|m{1,2}|s{1,2}|S+|z{1,4}|Z{1,4}/
      METHODS = { # ignoring u, l, g, j, A
        'a' => :period,
        'h' => :hour,
        'H' => :hour,
        'K' => :hour,
        'k' => :hour,
        'm' => :minute,
        's' => :second,
        'S' => :second_fraction,
        'z' => :timezone,
        'Z' => :timezone,
        'v' => :timezone_generic_non_location,
        'V' => :timezone_metazone
      }

      def period(time, pattern, length)
        calendar[:periods][time.strftime('%p').downcase.to_sym]
      end

      def hour(time, pattern, length)
        hour = time.hour
        hour = case pattern[0, 1]
        when 'h' # [1-12]
          hour > 12 ? (hour - 12) : (hour == 0 ? 12 : hour)
        when 'H' # [0-23]
          hour
        when 'K' # [0-11]
          hour > 11 ? hour - 12 : hour
        when 'k' # [1-24]
          hour == 0 ? 24 : hour
        end
        length == 1 ? hour.to_s : hour.to_s.rjust(length, '0')
      end

      def minute(time, pattern, length)
        length == 1 ? time.min.to_s : time.min.to_s.rjust(length, '0')
      end

      def second(time, pattern, length)
        length == 1 ? time.sec.to_s : time.sec.to_s.rjust(length, '0')
      end

      def second_fraction(time, pattern, length)
        raise 'can not use the S format with more than 6 digits' if length > 6
        (time.usec.to_f / 10 ** (6 - length)).round.to_s.rjust(length, '0')
      end

      def timezone(time, pattern, length)
        case length
        when 1..3
          time.zone
        else
          raise 'not yet implemented (requires timezone translation data")'
        end
      end

      def timezone_generic_non_location(time, pattern, length)
        raise 'not yet implemented (requires timezone translation data")'
      end

      def round_to(number, precision)
        factor = 10 ** precision
        (number * factor).round.to_f / factor
      end
    end
  end
end