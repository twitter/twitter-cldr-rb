# This class has been adapted from Sven Fuch's ruby-cldr gem
# See LICENSE for the accompanying license for this file

module TwitterCldr
  module Compilers
    class DateTimeCompiler < Base
      PATTERN = /G{1,5}|y+|Y+|Q{1,4}|q{1,5}|M{1,5}|L{1,5}|d{1,2}|F{1}|E{1,5}|e{1,5}|c{1,5}/
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
      }

      class << self
        def era(date, pattern, length)
          raise 'not implemented'
        end

        def year(date, pattern, length)
          year = date.year.to_s
          year = year.length == 1 ? year : year[-2, 2] if length == 2
          year = year.rjust(length, '0') if length > 1
          year
        end

        def year_of_week_of_year(date, pattern, length)
          raise 'not implemented'
        end

        def day_of_week_in_month(date, pattern, length) # e.g. 2nd Wed in July
          raise 'not implemented'
        end

        def quarter(date, pattern, length)
          quarter = (date.month.to_i - 1) / 3 + 1
          case length
          when 1
            quarter.to_s
          when 2
            quarter.to_s.rjust(length, '0')
          when 3
            calendar[:quarters][:format][:abbreviated][quarter]
          when 4
            calendar[:quarters][:format][:wide][quarter]
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
            raise 'not yet implemented (requires cldr\'s "multiple inheritance")'
            # calendar[:quarters][:'stand-alone'][:abbreviated][key]
          when 4
            raise 'not yet implemented (requires cldr\'s "multiple inheritance")'
            # calendar[:quarters][:'stand-alone'][:wide][key]
          when 5
            calendar[:quarters][:'stand-alone'][:narrow][quarter]
          end
        end

        def month(date, pattern, length)
          case length
          when 1
            date.month.to_s
          when 2
            date.month.to_s.rjust(length, '0')
          when 3
            calendar[:months][:format][:abbreviated][date.month]
          when 4
            calendar[:months][:format][:wide][date.month]
          when 5
            raise 'not yet implemented (requires cldr\'s "multiple inheritance")'
            calendar[:months][:format][:narrow][date.month]
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
            raise 'not yet implemented (requires cldr\'s "multiple inheritance")'
            calendar[:months][:'stand-alone'][:abbreviated][date.month]
          when 4
            raise 'not yet implemented (requires cldr\'s "multiple inheritance")'
            calendar[:months][:'stand-alone'][:wide][date.month]
          when 5
            calendar[:months][:'stand-alone'][:narrow][date.month]
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

        WEEKDAY_KEYS = [:sun, :mon, :tue, :wed, :thu, :fri, :sat]

        def weekday(date, pattern, length)
          key = WEEKDAY_KEYS[date.wday]
          case length
          when 1..3
            calendar[:days][:format][:abbreviated][key]
          when 4
            calendar[:days][:format][:wide][key]
          when 5
            calendar[:days][:'stand-alone'][:narrow][key]
          end
        end

        def weekday_local(date, pattern, length)
          # "Like E except adds a numeric value depending on the local starting day of the week"
          raise 'not implemented (need to defer a country to lookup the local first day of week from weekdata)'
        end

        def weekday_local_stand_alone(date, pattern, length)
          raise 'not implemented (need to defer a country to lookup the local first day of week from weekdata)'
        end
      end
    end
  end
end