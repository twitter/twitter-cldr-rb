# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:be] = Belarusian = Module.new { }
      
      class Belarusian::Spellout
        class << self
          def format_spellout_numbering_year(n)
            is_fractional = (n != n.floor)
            return n.to_s if is_fractional and (n > 1)
            return format_spellout_numbering(n) if (n >= 0)
          end
          def format_spellout_numbering(n)
            return format_spellout_cardinal_masculine(n) if (n >= 0)
          end
          def format_spellout_cardinal_masculine(n)
            is_fractional = (n != n.floor)
            return ("мінус " + format_spellout_cardinal_masculine(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_cardinal_masculine(n.floor) + " коска ") + format_spellout_cardinal_masculine((n % 10)))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 5000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000000000).floor) + " квадрыльёнаў") + (if ((n == 5000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 10000000000000000)))
              end))
            end
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000000000).floor) + " квадрыльёны") + (if ((n == 2000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 10000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000000000).floor) + " квадрыльён") + (if ((n == 1000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000000000000)))
              end))
            end
            if (n >= 5000000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000000).floor) + " трылёнаў") + (if ((n == 5000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 10000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000000).floor) + " трыльёны") + (if ((n == 2000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 10000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000000).floor) + " трыльён") + (if ((n == 1000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000000000)))
              end))
            end
            if (n >= 5000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000).floor) + " мільярдаў") + (if ((n == 5000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 10000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000).floor) + " мільярды") + (if ((n == 2000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 10000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000).floor) + " мільярд") + (if ((n == 1000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000000)))
              end))
            end
            if (n >= 5000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000).floor) + " мільёнаў") + (if ((n == 5000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 10000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000).floor) + " мільёны") + (if ((n == 2000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 10000000)))
              end))
            end
            if (n >= 1000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000).floor) + " мільён") + (if ((n == 1000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000)))
              end))
            end
            if (n >= 5000) then
              return ((format_spellout_cardinal_feminine((n / 10000).floor) + " тысяч") + (if ((n == 5000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 10000)))
              end))
            end
            if (n >= 2000) then
              return ((format_spellout_cardinal_feminine((n / 10000).floor) + " тысячы") + (if ((n == 2000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 10000)))
              end))
            end
            if (n >= 1000) then
              return ((format_spellout_cardinal_feminine((n / 1000).floor) + " тысяча") + (if ((n == 1000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000)))
              end))
            end
            if (n >= 900) then
              return ("дзевяцьсот" + (if ((n == 900) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000)))
              end))
            end
            if (n >= 800) then
              return ("восемсот" + (if ((n == 800) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000)))
              end))
            end
            if (n >= 700) then
              return ("семсот" + (if ((n == 700) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000)))
              end))
            end
            if (n >= 600) then
              return ("шэсцьсот" + (if ((n == 600) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000)))
              end))
            end
            if (n >= 500) then
              return ("пяцьсот" + (if ((n == 500) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000)))
              end))
            end
            if (n >= 400) then
              return ("чатырыста" + (if ((n == 400) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000)))
              end))
            end
            if (n >= 300) then
              return ("трыста" + (if ((n == 300) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000)))
              end))
            end
            if (n >= 200) then
              return ("дзвесце" + (if ((n == 200) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000)))
              end))
            end
            if (n >= 100) then
              return ("сто" + (if ((n == 100) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100)))
              end))
            end
            if (n >= 90) then
              return ("дзевяноста" + (if ((n == 90) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100)))
              end))
            end
            if (n >= 80) then
              return ("восемдзесят" + (if ((n == 80) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100)))
              end))
            end
            if (n >= 70) then
              return ("семдзесят" + (if ((n == 70) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100)))
              end))
            end
            if (n >= 60) then
              return ("шэсцьдзесят" + (if ((n == 60) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100)))
              end))
            end
            if (n >= 50) then
              return ("пяцьдзесят" + (if ((n == 50) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100)))
              end))
            end
            if (n >= 40) then
              return ("сорак" + (if ((n == 40) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100)))
              end))
            end
            if (n >= 30) then
              return ("трыццаць" + (if ((n == 30) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100)))
              end))
            end
            if (n >= 20) then
              return ("дваццаць" + (if ((n == 20) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100)))
              end))
            end
            return "дзевятнаццаць" if (n >= 19)
            return "васямнаццаць" if (n >= 18)
            return "сямнаццаць" if (n >= 17)
            return "шаснаццаць" if (n >= 16)
            return "пятнаццаць" if (n >= 15)
            return "чатырнаццаць" if (n >= 14)
            return "трынаццаць" if (n >= 13)
            return "дванаццаць" if (n >= 12)
            return "адзінаццаць" if (n >= 11)
            return "дзесяць" if (n >= 10)
            return "дзевяць" if (n >= 9)
            return "восем" if (n >= 8)
            return "сем" if (n >= 7)
            return "шэсць" if (n >= 6)
            return "пяць" if (n >= 5)
            return "чатыры" if (n >= 4)
            return "тры" if (n >= 3)
            return "два" if (n >= 2)
            return "адзiн" if (n >= 1)
            return "нуль" if (n >= 0)
          end
          def format_spellout_cardinal_neuter(n)
            is_fractional = (n != n.floor)
            return ("мінус " + format_spellout_cardinal_neuter(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_cardinal_neuter(n.floor) + " коска ") + format_spellout_cardinal_neuter((n % 10)))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 5000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000000000).floor) + " квадрыльёнаў") + (if ((n == 5000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 10000000000000000)))
              end))
            end
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000000000).floor) + " квадрыльёны") + (if ((n == 2000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 10000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000000000).floor) + " квадрыльён") + (if ((n == 1000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000000000000000)))
              end))
            end
            if (n >= 5000000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000000).floor) + " трылёнаў") + (if ((n == 5000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 10000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000000).floor) + " трыльёны") + (if ((n == 2000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 10000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000000).floor) + " трыльён") + (if ((n == 1000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000000000000)))
              end))
            end
            if (n >= 5000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000).floor) + " мільярдаў") + (if ((n == 5000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 10000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000).floor) + " мільярды") + (if ((n == 2000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 10000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000).floor) + " мільярд") + (if ((n == 1000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000000000)))
              end))
            end
            if (n >= 5000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000).floor) + " мільёнаў") + (if ((n == 5000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 10000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000).floor) + " мільёны") + (if ((n == 2000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 10000000)))
              end))
            end
            if (n >= 1000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000).floor) + " мільён") + (if ((n == 1000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000000)))
              end))
            end
            if (n >= 5000) then
              return ((format_spellout_cardinal_feminine((n / 10000).floor) + " тысяч") + (if ((n == 5000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 10000)))
              end))
            end
            if (n >= 2000) then
              return ((format_spellout_cardinal_feminine((n / 10000).floor) + " тысячы") + (if ((n == 2000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 10000)))
              end))
            end
            if (n >= 1000) then
              return ((format_spellout_cardinal_feminine((n / 1000).floor) + " тысяча") + (if ((n == 1000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000)))
              end))
            end
            if (n >= 900) then
              return ("дзевяцьсот" + (if ((n == 900) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000)))
              end))
            end
            if (n >= 800) then
              return ("васямсот" + (if ((n == 800) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000)))
              end))
            end
            if (n >= 700) then
              return ("сямсот" + (if ((n == 700) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000)))
              end))
            end
            if (n >= 600) then
              return ("шэсцьсот" + (if ((n == 600) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000)))
              end))
            end
            if (n >= 500) then
              return ("пяцьсот" + (if ((n == 500) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000)))
              end))
            end
            if (n >= 400) then
              return ("чатырыста" + (if ((n == 400) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000)))
              end))
            end
            if (n >= 300) then
              return ("трыста" + (if ((n == 300) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000)))
              end))
            end
            if (n >= 200) then
              return ("дзвесце" + (if ((n == 200) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000)))
              end))
            end
            if (n >= 100) then
              return ("сто" + (if ((n == 100) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 100)))
              end))
            end
            if (n >= 90) then
              return ("дзевяноста" + (if ((n == 90) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 100)))
              end))
            end
            if (n >= 80) then
              return ("восемдзесят" + (if ((n == 80) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 100)))
              end))
            end
            if (n >= 70) then
              return ("семдзесят" + (if ((n == 70) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 100)))
              end))
            end
            if (n >= 60) then
              return ("шэсцьдзесят" + (if ((n == 60) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 100)))
              end))
            end
            if (n >= 50) then
              return ("пяцьдзесят" + (if ((n == 50) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 100)))
              end))
            end
            if (n >= 40) then
              return ("сорак" + (if ((n == 40) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 100)))
              end))
            end
            if (n >= 30) then
              return ("трыццаць" + (if ((n == 30) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 100)))
              end))
            end
            if (n >= 20) then
              return ("дваццаць" + (if ((n == 20) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 100)))
              end))
            end
            return format_spellout_cardinal_masculine(n) if (n >= 3)
            return "два" if (n >= 2)
            return "адно" if (n >= 1)
            return "нуль" if (n >= 0)
          end
          def format_spellout_cardinal_feminine(n)
            is_fractional = (n != n.floor)
            return ("мінус " + format_spellout_cardinal_feminine(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_cardinal_feminine(n.floor) + " коска ") + format_spellout_cardinal_feminine((n % 10)))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 5000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000000000).floor) + " квадрыльёнаў") + (if ((n == 5000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 10000000000000000)))
              end))
            end
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000000000).floor) + " квадрыльёны") + (if ((n == 2000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 10000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000000000).floor) + " квадрыльён") + (if ((n == 1000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000000000000)))
              end))
            end
            if (n >= 5000000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000000).floor) + " трылёнаў") + (if ((n == 5000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 10000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000000).floor) + " трыльёны") + (if ((n == 2000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 10000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000000).floor) + " трыльён") + (if ((n == 1000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000000000)))
              end))
            end
            if (n >= 5000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000).floor) + " мільярдаў") + (if ((n == 5000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 10000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000).floor) + " мільярды") + (if ((n == 2000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 10000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000).floor) + " мільярд") + (if ((n == 1000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000000)))
              end))
            end
            if (n >= 5000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000).floor) + " мільёнаў") + (if ((n == 5000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 10000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000).floor) + " мільёны") + (if ((n == 2000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 10000000)))
              end))
            end
            if (n >= 1000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000).floor) + " мільён") + (if ((n == 1000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000)))
              end))
            end
            if (n >= 5000) then
              return ((format_spellout_cardinal_feminine((n / 10000).floor) + " тысяч") + (if ((n == 5000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 10000)))
              end))
            end
            if (n >= 2000) then
              return ((format_spellout_cardinal_feminine((n / 10000).floor) + " тысячы") + (if ((n == 2000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 10000)))
              end))
            end
            if (n >= 1000) then
              return ((format_spellout_cardinal_feminine((n / 1000).floor) + " тысяча") + (if ((n == 1000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000)))
              end))
            end
            if (n >= 900) then
              return ("дзевяцьсот" + (if ((n == 900) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000)))
              end))
            end
            if (n >= 800) then
              return ("васямсот" + (if ((n == 800) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000)))
              end))
            end
            if (n >= 700) then
              return ("семсот" + (if ((n == 700) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000)))
              end))
            end
            if (n >= 600) then
              return ("шэсцьсот" + (if ((n == 600) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000)))
              end))
            end
            if (n >= 500) then
              return ("пяцьсот" + (if ((n == 500) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000)))
              end))
            end
            if (n >= 400) then
              return ("чатырыста" + (if ((n == 400) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000)))
              end))
            end
            if (n >= 300) then
              return ("трыста" + (if ((n == 300) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000)))
              end))
            end
            if (n >= 200) then
              return ("дзвесце" + (if ((n == 200) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000)))
              end))
            end
            if (n >= 100) then
              return ("сто" + (if ((n == 100) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100)))
              end))
            end
            if (n >= 90) then
              return ("дзевяноста" + (if ((n == 90) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100)))
              end))
            end
            if (n >= 80) then
              return ("восемдзесят" + (if ((n == 80) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100)))
              end))
            end
            if (n >= 70) then
              return ("семдзесят" + (if ((n == 70) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100)))
              end))
            end
            if (n >= 60) then
              return ("шэсцьдзесят" + (if ((n == 60) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100)))
              end))
            end
            if (n >= 50) then
              return ("пяцьдзясят" + (if ((n == 50) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100)))
              end))
            end
            if (n >= 40) then
              return ("сорак" + (if ((n == 40) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100)))
              end))
            end
            if (n >= 30) then
              return ("трыццаць" + (if ((n == 30) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100)))
              end))
            end
            if (n >= 20) then
              return ("дваццаць" + (if ((n == 20) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100)))
              end))
            end
            return format_spellout_cardinal_masculine(n) if (n >= 3)
            return "дзве" if (n >= 2)
            return "адна" if (n >= 1)
            return "нуль" if (n >= 0)
          end
          def format_spellout_ordinal_masculine(n)
            is_fractional = (n != n.floor)
            return ("мінус " + format_spellout_ordinal_masculine(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 5000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000000000).floor) + " квадрыльёнаў") + (if ((n == 5000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 10000000000000000)))
              end))
            end
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000000000).floor) + " квадрыльёны") + (if ((n == 2000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 10000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000000000).floor) + " квадрыльён") + (if ((n == 1000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 1000000000000000)))
              end))
            end
            if (n >= 5000000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000000).floor) + " трылёнаў") + (if ((n == 5000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 10000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000000).floor) + " трыльёны") + (if ((n == 2000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 10000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000000).floor) + " трыльён") + (if ((n == 1000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 1000000000000)))
              end))
            end
            if (n >= 5000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000).floor) + " мільярдаў") + (if ((n == 5000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 10000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000).floor) + " мільярды") + (if ((n == 2000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 10000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000).floor) + " мільярд") + (if ((n == 1000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 1000000000)))
              end))
            end
            if (n >= 5000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000).floor) + " мільёнаў") + (if ((n == 5000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 10000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000).floor) + " мільёны") + (if ((n == 2000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 10000000)))
              end))
            end
            if (n >= 1000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000).floor) + " мільён") + (if ((n == 1000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 1000000)))
              end))
            end
            if (n >= 500000) then
              return ((format_spellout_cardinal_masculine((n / 1000000).floor) + " тысячнае") + (if ((n == 500000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 1000000)))
              end))
            end
            if (n >= 400001) then
              return ((format_spellout_cardinal_masculine((n / 1000000).floor) + " тысячны") + (if ((n == 400001) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 1000000)))
              end))
            end
            return "чатырохсот тысячны" if (n >= 400000)
            if (n >= 300001) then
              return ((format_spellout_cardinal_masculine((n / 1000000).floor) + " тысячны") + (if ((n == 300001) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 1000000)))
              end))
            end
            return "трохсот тысячны" if (n >= 300000)
            if (n >= 200001) then
              return ((format_spellout_cardinal_masculine((n / 1000000).floor) + " тысячны") + (if ((n == 200001) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 1000000)))
              end))
            end
            return "дзвухсот тысячны" if (n >= 200000)
            if (n >= 110000) then
              return ((format_spellout_cardinal_masculine((n / 1000000).floor) + " тысячны") + (if ((n == 110000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 1000000)))
              end))
            end
            if (n >= 100001) then
              return ((format_spellout_cardinal_masculine((n / 1000000).floor) + " тысяч") + (if ((n == 100001) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 1000000)))
              end))
            end
            return "сто тысячны" if (n >= 100000)
            if (n >= 21000) then
              return ((format_spellout_cardinal_feminine((n / 1000000).floor) + " тысяча") + (if ((n == 21000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 1000000)))
              end))
            end
            if (n >= 20001) then
              return ((format_spellout_cardinal_masculine((n / 1000000).floor) + " тысяч") + (if ((n == 20001) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 1000000)))
              end))
            end
            return "дваццаці тысячны" if (n >= 20000)
            if (n >= 11000) then
              return ((format_spellout_cardinal_masculine((n / 1000000).floor) + " тысяч") + (if ((n == 11000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 1000000)))
              end))
            end
            if (n >= 10001) then
              return ("дзесяць тысяч" + (if ((n == 10001) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 1000000)))
              end))
            end
            return "дзесяці тысячны" if (n >= 10000)
            if (n >= 5001) then
              return ((format_spellout_cardinal_feminine((n / 10000).floor) + " тысяч") + (if ((n == 5001) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 10000)))
              end))
            end
            if (n >= 5000) then
              return (format_spellout_cardinal_feminine((n / 10000).floor) + " тысячны")
            end
            if (n >= 2001) then
              return ((format_spellout_cardinal_feminine((n / 10000).floor) + " тысячы") + (if ((n == 2001) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 10000)))
              end))
            end
            return "дзвух тысячны" if (n >= 2000)
            if (n >= 1001) then
              return ((format_spellout_cardinal_feminine((n / 10000).floor) + " тысяча") + (if ((n == 1001) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 10000)))
              end))
            end
            if (n >= 1000) then
              return (format_spellout_cardinal_feminine((n / 1000).floor) + " тысячны")
            end
            if (n >= 901) then
              return ("дзевяцьсот" + (if ((n == 901) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 1000)))
              end))
            end
            return "дзевяцісоты" if (n >= 900)
            if (n >= 801) then
              return ("васямсот" + (if ((n == 801) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 1000)))
              end))
            end
            return "васьмісоты" if (n >= 800)
            if (n >= 701) then
              return ("семсот" + (if ((n == 701) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 1000)))
              end))
            end
            return "сямісоты" if (n >= 700)
            if (n >= 601) then
              return ("шэсцьсот" + (if ((n == 601) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 1000)))
              end))
            end
            return "шасьцісоты" if (n >= 600)
            if (n >= 501) then
              return ("пяцьсот" + (if ((n == 501) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 1000)))
              end))
            end
            return "пяцісоты" if (n >= 500)
            if (n >= 401) then
              return ("чатырыста" + (if ((n == 401) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 1000)))
              end))
            end
            return "чатырохсоты" if (n >= 400)
            if (n >= 301) then
              return ("трыста" + (if ((n == 301) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 1000)))
              end))
            end
            return "трохсоты" if (n >= 300)
            if (n >= 201) then
              return ("дзвесце" + (if ((n == 201) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 1000)))
              end))
            end
            return "дзвухсоты" if (n >= 200)
            if (n >= 101) then
              return ("сто" + (if ((n == 101) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 1000)))
              end))
            end
            return "соты" if (n >= 100)
            if (n >= 91) then
              return ("дзевяноста" + (if ((n == 91) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 100)))
              end))
            end
            return "дзевяносты" if (n >= 90)
            if (n >= 81) then
              return ("восемдзесят" + (if ((n == 81) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 100)))
              end))
            end
            return "васьмідзясяты" if (n >= 80)
            if (n >= 71) then
              return ("семдзесят" + (if ((n == 71) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 100)))
              end))
            end
            return "семдзесяты" if (n >= 70)
            if (n >= 61) then
              return ("шэсцьдзесят" + (if ((n == 61) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 100)))
              end))
            end
            return "шэсцьдзесяты" if (n >= 60)
            if (n >= 51) then
              return ("пяцідзясят" + (if ((n == 51) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 100)))
              end))
            end
            return "пяцідзясяты" if (n >= 50)
            if (n >= 41) then
              return ("сорак" + (if ((n == 41) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 100)))
              end))
            end
            return "саракавы" if (n >= 40)
            if (n >= 31) then
              return ("трыццаць" + (if ((n == 31) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 100)))
              end))
            end
            return "трыццаты" if (n >= 30)
            if (n >= 21) then
              return ("дваццаць" + (if ((n == 21) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 100)))
              end))
            end
            return "дваццаты" if (n >= 20)
            return "дзевятнаццаты" if (n >= 19)
            return "васямнаццаты" if (n >= 18)
            return "сямнаццаты" if (n >= 17)
            return "шаснаццаты" if (n >= 16)
            return "пятнаццаты" if (n >= 15)
            return "чатырнаццаты" if (n >= 14)
            return "трынаццаты" if (n >= 13)
            return "дванаццаты" if (n >= 12)
            return "адзінаццаты" if (n >= 11)
            return "дзясяты" if (n >= 10)
            return "дзявяты" if (n >= 9)
            return "восьмы" if (n >= 8)
            return "сёмы" if (n >= 7)
            return "шосты" if (n >= 6)
            return "пяты" if (n >= 5)
            return "чацьверты" if (n >= 4)
            return "трэйці" if (n >= 3)
            return "другі" if (n >= 2)
            return "першы" if (n >= 1)
            return "нулявы" if (n >= 0)
          end
          def format_spellout_ordinal_feminine(n)
            is_fractional = (n != n.floor)
            return ("мінус " + format_spellout_ordinal_feminine(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 5000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000000000).floor) + " квадрыльёнаў") + (if ((n == 5000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 10000000000000000)))
              end))
            end
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000000000).floor) + " квадрыльёны") + (if ((n == 2000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 10000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000000000).floor) + " квадрыльён") + (if ((n == 1000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 1000000000000000)))
              end))
            end
            if (n >= 5000000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000000).floor) + " трылёнаў") + (if ((n == 5000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 10000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000000).floor) + " трыльёны") + (if ((n == 2000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 10000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000000).floor) + " трыльён") + (if ((n == 1000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 1000000000000)))
              end))
            end
            if (n >= 5000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000).floor) + " мільярдаў") + (if ((n == 5000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 10000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000).floor) + " мільярды") + (if ((n == 2000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 10000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000).floor) + " мільярд") + (if ((n == 1000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 1000000000)))
              end))
            end
            if (n >= 5000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000).floor) + " мільёнаў") + (if ((n == 5000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 10000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000).floor) + " мільёны") + (if ((n == 2000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 10000000)))
              end))
            end
            if (n >= 1000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000).floor) + " мільён") + (if ((n == 1000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 1000000)))
              end))
            end
            if (n >= 500000) then
              return ((format_spellout_cardinal_feminine((n / 1000000).floor) + " тысячнае") + (if ((n == 500000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 1000000)))
              end))
            end
            if (n >= 400001) then
              return ((format_spellout_cardinal_feminine((n / 1000000).floor) + " тысячная") + (if ((n == 400001) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 1000000)))
              end))
            end
            return "чатырохсот тысячная" if (n >= 400000)
            if (n >= 300001) then
              return ((format_spellout_cardinal_feminine((n / 1000000).floor) + " тысячная") + (if ((n == 300001) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 1000000)))
              end))
            end
            return "трохсот тысячная" if (n >= 300000)
            if (n >= 200001) then
              return ((format_spellout_cardinal_feminine((n / 1000000).floor) + " тысячная") + (if ((n == 200001) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 1000000)))
              end))
            end
            return "дзвухсот тысячная" if (n >= 200000)
            if (n >= 110000) then
              return ((format_spellout_cardinal_feminine((n / 1000000).floor) + " тысячная") + (if ((n == 110000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 1000000)))
              end))
            end
            if (n >= 100001) then
              return ((format_spellout_cardinal_masculine((n / 1000000).floor) + " тысяч") + (if ((n == 100001) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 1000000)))
              end))
            end
            return "сто тысячная" if (n >= 100000)
            if (n >= 21000) then
              return ((format_spellout_cardinal_feminine((n / 1000000).floor) + " тысяча") + (if ((n == 21000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 1000000)))
              end))
            end
            if (n >= 20001) then
              return ((format_spellout_cardinal_masculine((n / 1000000).floor) + " тысяч") + (if ((n == 20001) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 1000000)))
              end))
            end
            return "дваццаці тысячная" if (n >= 20000)
            if (n >= 11000) then
              return ((format_spellout_cardinal_masculine((n / 1000000).floor) + " тысяч") + (if ((n == 11000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 1000000)))
              end))
            end
            if (n >= 10001) then
              return ("дзесяць тысяч" + (if ((n == 10001) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 1000000)))
              end))
            end
            return "дзесяці тысячная" if (n >= 10000)
            if (n >= 5001) then
              return ((format_spellout_cardinal_feminine((n / 10000).floor) + " тысяч") + (if ((n == 5001) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 10000)))
              end))
            end
            if (n >= 5000) then
              return (format_spellout_cardinal_feminine((n / 10000).floor) + " тысячная")
            end
            if (n >= 2001) then
              return ((format_spellout_cardinal_feminine((n / 10000).floor) + " тысячы") + (if ((n == 2001) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 10000)))
              end))
            end
            return "дзвух тысячная" if (n >= 2000)
            if (n >= 1001) then
              return ((format_spellout_cardinal_feminine((n / 10000).floor) + " тысяча") + (if ((n == 1001) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 10000)))
              end))
            end
            if (n >= 1000) then
              return (format_spellout_cardinal_feminine((n / 1000).floor) + " тысячны")
            end
            if (n >= 901) then
              return ("дзевяцьсот" + (if ((n == 901) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 1000)))
              end))
            end
            return "дзевяцісотая" if (n >= 900)
            if (n >= 801) then
              return ("васямсот" + (if ((n == 801) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 1000)))
              end))
            end
            return "васьмісотая" if (n >= 800)
            if (n >= 701) then
              return ("семсот" + (if ((n == 701) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 1000)))
              end))
            end
            return "сямісотая" if (n >= 700)
            if (n >= 601) then
              return ("шэсцьсот" + (if ((n == 601) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 1000)))
              end))
            end
            return "шасьцісотая" if (n >= 600)
            if (n >= 501) then
              return ("пяцьсот" + (if ((n == 501) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 1000)))
              end))
            end
            return "пяцісотая" if (n >= 500)
            if (n >= 401) then
              return ("чатырыста" + (if ((n == 401) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 1000)))
              end))
            end
            return "чатырохсотая" if (n >= 400)
            if (n >= 301) then
              return ("трыста" + (if ((n == 301) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 1000)))
              end))
            end
            return "трохсотая" if (n >= 300)
            if (n >= 201) then
              return ("дзвесце" + (if ((n == 201) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 1000)))
              end))
            end
            return "дзвухсотая" if (n >= 200)
            if (n >= 101) then
              return ("сто" + (if ((n == 101) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 1000)))
              end))
            end
            return "сотая" if (n >= 100)
            if (n >= 91) then
              return ("дзевяноста" + (if ((n == 91) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 100)))
              end))
            end
            return "дзевяностая" if (n >= 90)
            if (n >= 81) then
              return ("восемдзесят" + (if ((n == 81) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 100)))
              end))
            end
            return "васьмідзясятая" if (n >= 80)
            if (n >= 71) then
              return ("семдзесят" + (if ((n == 71) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 100)))
              end))
            end
            return "семдзесятая" if (n >= 70)
            if (n >= 61) then
              return ("шэсцьдзесят" + (if ((n == 61) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 100)))
              end))
            end
            return "шэсцідзесятая" if (n >= 60)
            if (n >= 51) then
              return ("пяцідзясят" + (if ((n == 51) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 100)))
              end))
            end
            return "пяцідзесятая" if (n >= 50)
            if (n >= 41) then
              return ("сорак" + (if ((n == 41) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 100)))
              end))
            end
            return "саракавая" if (n >= 40)
            if (n >= 31) then
              return ("трыццаць" + (if ((n == 31) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 100)))
              end))
            end
            return "трыццатая" if (n >= 30)
            if (n >= 21) then
              return ("дваццаць" + (if ((n == 21) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 100)))
              end))
            end
            return "дваццатая" if (n >= 20)
            return "дзевятнаццатая" if (n >= 19)
            return "васямнаццатая" if (n >= 18)
            return "сямнаццатая" if (n >= 17)
            return "шаснаццатая" if (n >= 16)
            return "пятнаццатая" if (n >= 15)
            return "чатырнаццатая" if (n >= 14)
            return "трынаццатая" if (n >= 13)
            return "дванаццатая" if (n >= 12)
            return "адзінаццатая" if (n >= 11)
            return "дзясятая" if (n >= 10)
            return "дзявятая" if (n >= 9)
            return "восьмая" if (n >= 8)
            return "сёмая" if (n >= 7)
            return "шостая" if (n >= 6)
            return "пятая" if (n >= 5)
            return "чацьвертая" if (n >= 4)
            return "трэццяя" if (n >= 3)
            return "другая" if (n >= 2)
            return "першая" if (n >= 1)
            return "нулявая" if (n >= 0)
          end
          def format_spellout_ordinal_neuter(n)
            is_fractional = (n != n.floor)
            return ("мінус " + format_spellout_ordinal_neuter(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 5000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000000000).floor) + " квадрыльёнаў") + (if ((n == 5000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 10000000000000000)))
              end))
            end
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000000000).floor) + " квадрыльёны") + (if ((n == 2000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 10000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000000000).floor) + " квадрыльён") + (if ((n == 1000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 1000000000000000)))
              end))
            end
            if (n >= 5000000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000000).floor) + " трылёнаў") + (if ((n == 5000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 10000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000000).floor) + " трыльёны") + (if ((n == 2000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 10000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000000).floor) + " трыльён") + (if ((n == 1000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 1000000000000)))
              end))
            end
            if (n >= 5000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000).floor) + " мільярдаў") + (if ((n == 5000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 10000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000).floor) + " мільярды") + (if ((n == 2000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 10000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000).floor) + " мільярд") + (if ((n == 1000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 1000000000)))
              end))
            end
            if (n >= 5000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000).floor) + " мільёнаў") + (if ((n == 5000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 10000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000).floor) + " мільёны") + (if ((n == 2000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 10000000)))
              end))
            end
            if (n >= 1000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000).floor) + " мільён") + (if ((n == 1000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 1000000)))
              end))
            end
            if (n >= 500000) then
              return ((format_spellout_cardinal_feminine((n / 1000000).floor) + " тысячнае") + (if ((n == 500000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 1000000)))
              end))
            end
            if (n >= 400001) then
              return ((format_spellout_cardinal_feminine((n / 1000000).floor) + " тысячнае") + (if ((n == 400001) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 1000000)))
              end))
            end
            return "чатырохсот тысячнае" if (n >= 400000)
            if (n >= 300001) then
              return ((format_spellout_cardinal_feminine((n / 1000000).floor) + " тысячнае") + (if ((n == 300001) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 1000000)))
              end))
            end
            return "трохсот тысячнае" if (n >= 300000)
            if (n >= 200001) then
              return ((format_spellout_cardinal_feminine((n / 1000000).floor) + " тысячнае") + (if ((n == 200001) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 1000000)))
              end))
            end
            return "дзвухсот тысячнае" if (n >= 200000)
            if (n >= 110000) then
              return ((format_spellout_cardinal_feminine((n / 1000000).floor) + " тысячнае") + (if ((n == 110000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 1000000)))
              end))
            end
            if (n >= 100001) then
              return ((format_spellout_cardinal_masculine((n / 1000000).floor) + " тысяч") + (if ((n == 100001) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 1000000)))
              end))
            end
            return "сто тысячнае" if (n >= 100000)
            if (n >= 21000) then
              return ((format_spellout_cardinal_feminine((n / 1000000).floor) + " тысяча") + (if ((n == 21000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 1000000)))
              end))
            end
            if (n >= 20001) then
              return ((format_spellout_cardinal_masculine((n / 1000000).floor) + " тысяч") + (if ((n == 20001) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 1000000)))
              end))
            end
            return "дваццаці тысячнае" if (n >= 20000)
            if (n >= 11000) then
              return ((format_spellout_cardinal_masculine((n / 1000000).floor) + " тысяч") + (if ((n == 11000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 1000000)))
              end))
            end
            if (n >= 10001) then
              return ("дзесяць тысяч" + (if ((n == 10001) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 1000000)))
              end))
            end
            return "дзесяці тысячнае" if (n >= 10000)
            if (n >= 5001) then
              return ((format_spellout_cardinal_feminine((n / 10000).floor) + " тысяч") + (if ((n == 5001) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 10000)))
              end))
            end
            if (n >= 5000) then
              return (format_spellout_cardinal_feminine((n / 10000).floor) + " тысячнае")
            end
            if (n >= 2001) then
              return ((format_spellout_cardinal_feminine((n / 10000).floor) + " тысячы") + (if ((n == 2001) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 10000)))
              end))
            end
            return "дзвух тысячнае" if (n >= 2000)
            if (n >= 1001) then
              return ((format_spellout_cardinal_feminine((n / 10000).floor) + " тысяча") + (if ((n == 1001) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 10000)))
              end))
            end
            if (n >= 1000) then
              return (format_spellout_cardinal_feminine((n / 1000).floor) + " тысячны")
            end
            if (n >= 901) then
              return ("дзевяцьсот" + (if ((n == 901) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 1000)))
              end))
            end
            return "дзевяцісотае" if (n >= 900)
            if (n >= 801) then
              return ("васямсот" + (if ((n == 801) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 1000)))
              end))
            end
            return "васьмісотае" if (n >= 800)
            if (n >= 701) then
              return ("семсот" + (if ((n == 701) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 1000)))
              end))
            end
            return "сямісотае" if (n >= 700)
            if (n >= 601) then
              return ("шэсцьсот" + (if ((n == 601) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 1000)))
              end))
            end
            return "шасьцісотае" if (n >= 600)
            if (n >= 501) then
              return ("пяцьсот" + (if ((n == 501) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 1000)))
              end))
            end
            return "пяцісотае" if (n >= 500)
            if (n >= 401) then
              return ("чатырыста" + (if ((n == 401) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 1000)))
              end))
            end
            return "чатырохсотае" if (n >= 400)
            if (n >= 301) then
              return ("трыста" + (if ((n == 301) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 1000)))
              end))
            end
            return "трохсотае" if (n >= 300)
            if (n >= 201) then
              return ("дзвесце" + (if ((n == 201) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 1000)))
              end))
            end
            return "дзвухсотае" if (n >= 200)
            if (n >= 101) then
              return ("сто" + (if ((n == 101) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 1000)))
              end))
            end
            return "сотае" if (n >= 100)
            if (n >= 91) then
              return ("дзевяноста" + (if ((n == 91) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 100)))
              end))
            end
            return "дзевяностае" if (n >= 90)
            if (n >= 81) then
              return ("восемдзесят" + (if ((n == 81) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 100)))
              end))
            end
            return "васьмідзясятае" if (n >= 80)
            if (n >= 71) then
              return ("семдзесят" + (if ((n == 71) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 100)))
              end))
            end
            return "сямдзясятае" if (n >= 70)
            if (n >= 61) then
              return ("шэсцьдзесят" + (if ((n == 61) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 100)))
              end))
            end
            return "шэсцідзясятае" if (n >= 60)
            if (n >= 51) then
              return ("пяцідзясят" + (if ((n == 51) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 100)))
              end))
            end
            return "пяцьдзесятае" if (n >= 50)
            if (n >= 41) then
              return ("сорак" + (if ((n == 41) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 100)))
              end))
            end
            return "саракавое" if (n >= 40)
            if (n >= 31) then
              return ("трыццаць" + (if ((n == 31) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 100)))
              end))
            end
            return "трыццатае" if (n >= 30)
            if (n >= 21) then
              return ("дваццаць" + (if ((n == 21) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 100)))
              end))
            end
            return "дваццатае" if (n >= 20)
            return "дзевятнаццатае" if (n >= 19)
            return "васямнаццатае" if (n >= 18)
            return "сямнаццатае" if (n >= 17)
            return "шаснаццатае" if (n >= 16)
            return "пятнаццатае" if (n >= 15)
            return "чатырнаццатае" if (n >= 14)
            return "трынаццатае" if (n >= 13)
            return "дванаццатае" if (n >= 12)
            return "адзінаццатае" if (n >= 11)
            return "дзясятае" if (n >= 10)
            return "дзявятае" if (n >= 9)
            return "восьмае" if (n >= 8)
            return "сёмае" if (n >= 7)
            return "шостае" if (n >= 6)
            return "пятае" if (n >= 5)
            return "чацьвертае" if (n >= 4)
            return "трэццяе" if (n >= 3)
            return "другое" if (n >= 2)
            return "першае" if (n >= 1)
            return "нулявое" if (n >= 0)
          end
        end
      end
    end
  end
end