# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

# This class has been adapted from Sven Fuch's ruby-cldr gem
# See LICENSE for the accompanying license for his contributions

module TwitterCldr
  module Formatters
    class DateTimeFormatter < Base
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

      def initialize(options = {})
        @tokenizer = TwitterCldr::Tokenizers::DateTimeTokenizer.new(:locale => extract_locale(options), :calendar_type => options[:calendar_type])
      end

      def result_for_token(token, index, date)
        self.send(METHODS[token.value[0].chr], date, token.value, token.value.size)
      end

      protected

      def era(date, pattern, length)
        choices = case length
          when 1..3
            @tokenizer.calendar[:eras][:abbr]
          else
            @tokenizer.calendar[:eras][:name]
        end
        choices[date.year < 0 ? 0 : 1]
      end

      def year(date, pattern, length)
        year = date.year.to_s
        year = year.length == 1 ? year : year[-2, 2] if length == 2
        year = year.rjust(length, '0') if length > 1
        year
      end

      def year_of_week_of_year(date, pattern, length)
        raise NotImplementedError
      end

      def day_of_week_in_month(date, pattern, length) # e.g. 2nd Wed in July
        raise NotImplementedError
      end

      def quarter(date, pattern, length)
        quarter = (date.month.to_i - 1) / 3 + 1
        case length
          when 1
            quarter.to_s
          when 2
            quarter.to_s.rjust(length, '0')
          when 3
            @tokenizer.calendar[:quarters][:format][:abbreviated][quarter]
          when 4
            @tokenizer.calendar[:quarters][:format][:wide][quarter]
        end
      end

      def quarter_stand_alone(date, pattern, length)
        quarter = (date.month.to_i - 1) / 3 + 1
        case length
          when 1
            quarter.to_s
          when 2
            quarter.to_s.rjust(length, '0')
          when 3
            raise NotImplementedError, 'requires cldr\'s "multiple inheritance"'
            # @tokenizer.calendar[:quarters][:'stand-alone'][:abbreviated][key]
          when 4
            raise NotImplementedError, 'requires cldr\'s "multiple inheritance"'
            # @tokenizer.calendar[:quarters][:'stand-alone'][:wide][key]
          when 5
            @tokenizer.calendar[:quarters][:'stand-alone'][:narrow][quarter]
        end
      end

      def month(date, pattern, length)
        case length
          when 1
            date.month.to_s
          when 2
            date.month.to_s.rjust(length, '0')
          when 3
            @tokenizer.calendar[:months][:format][:abbreviated][date.month]
          when 4
            @tokenizer.calendar[:months][:format][:wide][date.month]
          when 5
            raise NotImplementedError, 'requires cldr\'s "multiple inheritance"'
            # @tokenizer.calendar[:months][:format][:narrow][date.month]
          else
            # raise unknown date format
        end
      end

      def month_stand_alone(date, pattern, length)
        case length
          when 1
            date.month.to_s
          when 2
            date.month.to_s.rjust(length, '0')
          when 3
            raise NotImplementedError, 'requires cldr\'s "multiple inheritance"'
            @tokenizer.calendar[:months][:'stand-alone'][:abbreviated][date.month]
          when 4
            raise NotImplementedError, 'requires cldr\'s "multiple inheritance"'
            @tokenizer.calendar[:months][:'stand-alone'][:wide][date.month]
          when 5
            @tokenizer.calendar[:months][:'stand-alone'][:narrow][date.month]
          else
            # raise unknown date format
        end
      end

      def day(date, pattern, length)
        case length
          when 1
            date.day.to_s
          when 2
            date.day.to_s.rjust(length, '0')
        end
      end

      def weekday(date, pattern, length)
        key = WEEKDAY_KEYS[date.wday]
        case length
          when 1..3
            @tokenizer.calendar[:days][:format][:abbreviated][key]
          when 4
            @tokenizer.calendar[:days][:format][:wide][key]
          when 5
            @tokenizer.calendar[:days][:'stand-alone'][:narrow][key]
        end
      end

      def weekday_local(date, pattern, length)
        # "Like E except adds a numeric value depending on the local starting day of the week"
        # CLDR does not contain data as to which day is the first day of the week, so we will assume Monday (Ruby default)
        case length
          when 1..2
            date.cwday.to_s
          else
            weekday(date, pattern, length)
        end
      end

      def weekday_local_stand_alone(date, pattern, length)
        case length
          when 1
            weekday_local(date, pattern, length)
          else
            weekday(date, pattern, length)
        end
      end

      def period(time, pattern, length)
        # Always use :wide form. Day-period design was changed in CLDR -
        # http://cldr.unicode.org/development/development-process/design-proposals/day-period-design that means some
        # major changes are required for a full support of day periods.
        @tokenizer.calendar[:periods][:format][:wide][time.strftime('%p').downcase.to_sym]
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
        raise ArgumentError.new('can not use the S format with more than 6 digits') if length > 6
        (time.usec.to_f / 10 ** (6 - length)).round.to_s.rjust(length, '0')
      end

      def timezone(time, pattern, length)
        case length
          when 1..3
            time.zone
          else
            "UTC #{time.strftime("%z")}"
        end
      end

      def timezone_generic_non_location(time, pattern, length)
        raise NotImplementedError, 'requires timezone translation data'
      end
    end
  end
end