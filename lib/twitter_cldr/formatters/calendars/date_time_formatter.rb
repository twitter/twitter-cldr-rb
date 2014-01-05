# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

# This class has been adapted from Sven Fuch's ruby-cldr gem
# See LICENSE for the accompanying license for his contributions

require 'tzinfo'

module TwitterCldr
  module Formatters
    class DateTimeFormatter < Formatter

      WEEKDAY_KEYS = [:sun, :mon, :tue, :wed, :thu, :fri, :sat]
      METHODS = { # ignoring u, l, g, j, A
        'G' => :era,
        'y' => :year,
        'Y' => :year_of_week_of_year,
        'Q' => :quarter,
        'q' => :quarter_stand_alone,
        'M' => :month,
        'L' => :month_stand_alone,
        'w' => :week_of_year,
        'W' => :week_of_month,
        'd' => :day,
        'D' => :day_of_month,
        'F' => :day_of_week_in_month,
        'E' => :weekday,
        'e' => :weekday_local,
        'c' => :weekday_local_stand_alone,
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

      protected

      def format_pattern(token, index, obj, options)
        send(METHODS[token.value[0].chr], obj, token.value, token.value.size, options)
      end

      def calendar
        data_reader.calendar
      end

      # There is incomplete era data in CLDR for certain locales like Hindi.
      # Fall back if that happens.
      def era(date, pattern, length, options = {})
        choices = case length
          when 0
            ["", ""]
          when 1..3
            calendar.eras(:abbr)
          else
            calendar.eras(:name)
        end

        if result = choices[date.year < 0 ? 0 : 1]
          result
        else
          era(date, pattern[0..-2], length - 1)
        end
      end

      def year(date, pattern, length, options = {})
        year = date.year.to_s
        year = year.length == 1 ? year : year[-2, 2] if length == 2
        year = year.rjust(length, '0') if length > 1
        year
      end

      def year_of_week_of_year(date, pattern, length, options = {})
        raise NotImplementedError
      end

      def day_of_week_in_month(date, pattern, length, options = {}) # e.g. 2nd Wed in July
        raise NotImplementedError
      end

      def quarter(date, pattern, length, options = {})
        quarter = (date.month.to_i - 1) / 3 + 1
        case length
          when 1
            quarter.to_s
          when 2
            quarter.to_s.rjust(length, '0')
          when 3
            calendar.quarters(:abbreviated, :format)[quarter]
          when 4
            calendar.quarters(:wide, :format)[quarter]
        end
      end

      def quarter_stand_alone(date, pattern, length, options = {})
        quarter = (date.month.to_i - 1) / 3 + 1
        case length
          when 1
            quarter.to_s
          when 2
            quarter.to_s.rjust(length, '0')
          when 3
            raise NotImplementedError, 'requires cldr\'s "multiple inheritance"'
            # calendar[:quarters][:'stand-alone'][:abbreviated][key]
          when 4
            raise NotImplementedError, 'requires cldr\'s "multiple inheritance"'
            # calendar[:quarters][:'stand-alone'][:wide][key]
          when 5
            calendar.quarters(:narrow)[quarter]
        end
      end

      def month(date, pattern, length, options = {})
        case length
          when 1
            date.month.to_s
          when 2
            date.month.to_s.rjust(length, '0')
          when 3
            calendar.months(:abbreviated, :format)[date.month - 1]
          when 4
            calendar.months(:wide, :format)[date.month - 1]
          when 5
            raise NotImplementedError, 'requires cldr\'s "multiple inheritance"'
            # calendar[:months][:format][:narrow][date.month]
          else
            # raise unknown date format
        end
      end

      def month_stand_alone(date, pattern, length, options = {})
        case length
          when 1
            date.month.to_s
          when 2
            date.month.to_s.rjust(length, '0')
          when 3
            calendar.months(:abbreviated)[date.month - 1]
          when 4
            calendar.months(:wide)[date.month - 1]
          when 5
            calendar.months(:narrow)[date.month - 1]
          else
            # raise unknown date format
        end
      end

      def day(date, pattern, length, options = {})
        case length
          when 1
            date.day.to_s
          when 2
            date.day.to_s.rjust(length, '0')
        end
      end

      def weekday(date, pattern, length, options = {})
        key = WEEKDAY_KEYS[date.wday]
        case length
          when 1..3
            calendar.weekdays(:abbreviated, :format)[key]
          when 4
            calendar.weekdays(:wide, :format)[key]
          when 5
            calendar.weekdays(:narrow)[key]
        end
      end

      def weekday_local(date, pattern, length, options = {})
        # "Like E except adds a numeric value depending on the local starting day of the week"
        # CLDR does not contain data as to which day is the first day of the week, so we will assume Monday (Ruby default)
        case length
          when 1..2
            date.cwday.to_s
          else
            weekday(date, pattern, length)
        end
      end

      def weekday_local_stand_alone(date, pattern, length, options = {})
        case length
          when 1
            weekday_local(date, pattern, length)
          else
            weekday(date, pattern, length)
        end
      end

      def period(time, pattern, length, options = {})
        # Always use :wide form. Day-period design was changed in CLDR -
        # http://cldr.unicode.org/development/development-process/design-proposals/day-period-design that means some
        # major changes are required for a full support of day periods.
        calendar.periods(:wide)[time.strftime('%p').downcase.to_sym]
      end

      def hour(time, pattern, length, options = {})
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

      def minute(time, pattern, length, options = {})
        length == 1 ? time.min.to_s : time.min.to_s.rjust(length, '0')
      end

      def second(time, pattern, length, options = {})
        length == 1 ? time.sec.to_s : time.sec.to_s.rjust(length, '0')
      end

      def second_fraction(time, pattern, length, options = {})
        raise ArgumentError.new('can not use the S format with more than 6 digits') if length > 6
        (time.usec.to_f / 10 ** (6 - length)).round.to_s.rjust(length, '0')
      end

      def timezone(time, pattern, length, options = {})
        # ruby is dumb and doesn't let you set non-UTC timezones in dates/times, so we have to pass it as an option instead
        timezone_info = TZInfo::Timezone.get(options[:timezone] || "UTC")

        case length
          when 1..3
            timezone_info.current_period.abbreviation.to_s
          else
            hours = (timezone_info.current_period.utc_offset.to_f / 60 ** 2).abs
            divisor = hours.to_i
            minutes = (hours % (divisor == 0 ? 1 : divisor)) * 60
            sign = timezone_info.current_period.utc_offset < 0 ? "-" : "+"
            "UTC #{sign}#{divisor.to_s.rjust(2, "0")}:#{minutes.floor.to_s.rjust(2, "0")}"
        end
      end

      def timezone_generic_non_location(time, pattern, length, options = {})
        raise NotImplementedError, 'requires timezone translation data'
      end

    end
  end
end