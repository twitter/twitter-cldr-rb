# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:uk] = Ukrainian = Module.new { }
      
      class Ukrainian::Spellout
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
              return ((format_spellout_cardinal_masculine(n.floor) + " кома ") + format_spellout_cardinal_masculine((n % 10)))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 5000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000000000).floor) + " більярдів") + (if ((n == 5000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 10000000000000000)))
              end))
            end
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000000000).floor) + " більярди") + (if ((n == 2000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 10000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000000000).floor) + " більярд") + (if ((n == 1000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000000000000)))
              end))
            end
            if (n >= 5000000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000000).floor) + " більйонів") + (if ((n == 5000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 10000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000000).floor) + " більйони") + (if ((n == 2000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 10000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000000).floor) + " більйон") + (if ((n == 1000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000000000)))
              end))
            end
            if (n >= 5000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000).floor) + " мільярдів") + (if ((n == 5000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 10000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000).floor) + " мільярди") + (if ((n == 2000000000) or ((n % 10) == 0)) then
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
              return ((format_spellout_cardinal_masculine((n / 10000000).floor) + " мільйонів") + (if ((n == 5000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 10000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000).floor) + " мільйони") + (if ((n == 2000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 10000000)))
              end))
            end
            if (n >= 1000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000).floor) + " мільйон") + (if ((n == 1000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000)))
              end))
            end
            if (n >= 5000) then
              return ((format_spellout_cardinal_feminine((n / 10000).floor) + " тисяч") + (if ((n == 5000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 10000)))
              end))
            end
            if (n >= 2000) then
              return ((format_spellout_cardinal_feminine((n / 10000).floor) + " тисячі") + (if ((n == 2000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 10000)))
              end))
            end
            if (n >= 1000) then
              return ((format_spellout_cardinal_feminine((n / 1000).floor) + " тисяча") + (if ((n == 1000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000)))
              end))
            end
            if (n >= 900) then
              return ("девʼятсот" + (if ((n == 900) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000)))
              end))
            end
            if (n >= 800) then
              return ("вісімсот" + (if ((n == 800) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000)))
              end))
            end
            if (n >= 700) then
              return ("сімсот" + (if ((n == 700) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000)))
              end))
            end
            if (n >= 600) then
              return ("шістсот" + (if ((n == 600) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000)))
              end))
            end
            if (n >= 500) then
              return ("пʼятсот" + (if ((n == 500) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000)))
              end))
            end
            if (n >= 400) then
              return ("чотириста" + (if ((n == 400) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000)))
              end))
            end
            if (n >= 300) then
              return ("триста" + (if ((n == 300) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000)))
              end))
            end
            if (n >= 200) then
              return ("двісті" + (if ((n == 200) or ((n % 10) == 0)) then
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
              return ("девʼяносто" + (if ((n == 90) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100)))
              end))
            end
            if (n >= 80) then
              return ("вісімдесят" + (if ((n == 80) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100)))
              end))
            end
            if (n >= 70) then
              return ("сімдесят" + (if ((n == 70) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100)))
              end))
            end
            if (n >= 60) then
              return ("шістдесят" + (if ((n == 60) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100)))
              end))
            end
            if (n >= 50) then
              return ("пʼятдесят" + (if ((n == 50) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100)))
              end))
            end
            if (n >= 40) then
              return ("сорок" + (if ((n == 40) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100)))
              end))
            end
            if (n >= 30) then
              return ("тридцять" + (if ((n == 30) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100)))
              end))
            end
            if (n >= 20) then
              return ("двадцять" + (if ((n == 20) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100)))
              end))
            end
            return "девʼятнадцять" if (n >= 19)
            return "вісімнадцять" if (n >= 18)
            return "сімнадцять" if (n >= 17)
            return "шістнадцять" if (n >= 16)
            return "пʼятнадцять" if (n >= 15)
            return "чотирнадцять" if (n >= 14)
            return "тринадцять" if (n >= 13)
            return "дванадцять" if (n >= 12)
            return "одинадцять" if (n >= 11)
            return "десять" if (n >= 10)
            return "девʼять" if (n >= 9)
            return "вісім" if (n >= 8)
            return "сім" if (n >= 7)
            return "шість" if (n >= 6)
            return "пʼять" if (n >= 5)
            return "чотири" if (n >= 4)
            return "три" if (n >= 3)
            return "два" if (n >= 2)
            return "один" if (n >= 1)
            return "нуль" if (n >= 0)
          end
          def format_spellout_cardinal_neuter(n)
            is_fractional = (n != n.floor)
            return ("мінус " + format_spellout_cardinal_neuter(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_cardinal_neuter(n.floor) + " кома ") + format_spellout_cardinal_neuter((n % 10)))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 5000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000000000).floor) + " більярдів") + (if ((n == 5000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 10000000000000000)))
              end))
            end
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000000000).floor) + " більярди") + (if ((n == 2000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 10000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000000000).floor) + " більярд") + (if ((n == 1000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000000000000000)))
              end))
            end
            if (n >= 5000000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000000).floor) + " більйонів") + (if ((n == 5000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 10000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000000).floor) + " більйони") + (if ((n == 2000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 10000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000000).floor) + " більйон") + (if ((n == 1000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000000000000)))
              end))
            end
            if (n >= 5000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000).floor) + " мільярдів") + (if ((n == 5000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 10000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000).floor) + " мільярди") + (if ((n == 2000000000) or ((n % 10) == 0)) then
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
              return ((format_spellout_cardinal_masculine((n / 10000000).floor) + " мільйонів") + (if ((n == 5000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 10000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000).floor) + " мільйони") + (if ((n == 2000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 10000000)))
              end))
            end
            if (n >= 1000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000).floor) + " мільйон") + (if ((n == 1000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000000)))
              end))
            end
            if (n >= 5000) then
              return ((format_spellout_cardinal_feminine((n / 10000).floor) + " тисяч") + (if ((n == 5000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 10000)))
              end))
            end
            if (n >= 2000) then
              return ((format_spellout_cardinal_feminine((n / 10000).floor) + " тисячі") + (if ((n == 2000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 10000)))
              end))
            end
            if (n >= 1000) then
              return ((format_spellout_cardinal_feminine((n / 1000).floor) + " тисяча") + (if ((n == 1000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000)))
              end))
            end
            if (n >= 900) then
              return ("девʼятсот" + (if ((n == 900) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000)))
              end))
            end
            if (n >= 800) then
              return ("вісімсот" + (if ((n == 800) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000)))
              end))
            end
            if (n >= 700) then
              return ("сімсот" + (if ((n == 700) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000)))
              end))
            end
            if (n >= 600) then
              return ("шістсот" + (if ((n == 600) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000)))
              end))
            end
            if (n >= 500) then
              return ("пʼятсот" + (if ((n == 500) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000)))
              end))
            end
            if (n >= 400) then
              return ("чотириста" + (if ((n == 400) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000)))
              end))
            end
            if (n >= 300) then
              return ("триста" + (if ((n == 300) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000)))
              end))
            end
            if (n >= 200) then
              return ("двісті" + (if ((n == 200) or ((n % 10) == 0)) then
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
              return ("девʼяносто" + (if ((n == 90) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 100)))
              end))
            end
            if (n >= 80) then
              return ("вісімдесят" + (if ((n == 80) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 100)))
              end))
            end
            if (n >= 70) then
              return ("сімдесят" + (if ((n == 70) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 100)))
              end))
            end
            if (n >= 60) then
              return ("шістдесят" + (if ((n == 60) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 100)))
              end))
            end
            if (n >= 50) then
              return ("пʼятдесят" + (if ((n == 50) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 100)))
              end))
            end
            if (n >= 40) then
              return ("сорок" + (if ((n == 40) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 100)))
              end))
            end
            if (n >= 30) then
              return ("тридцять" + (if ((n == 30) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 100)))
              end))
            end
            if (n >= 20) then
              return ("двадцять" + (if ((n == 20) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 100)))
              end))
            end
            return format_spellout_cardinal_masculine(n) if (n >= 3)
            return "два" if (n >= 2)
            return "одне" if (n >= 1)
            return "нуль" if (n >= 0)
          end
          def format_spellout_cardinal_feminine(n)
            is_fractional = (n != n.floor)
            return ("мінус " + format_spellout_cardinal_feminine(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_cardinal_feminine(n.floor) + " кома ") + format_spellout_cardinal_feminine((n % 10)))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 5000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000000000).floor) + " більярдів") + (if ((n == 5000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 10000000000000000)))
              end))
            end
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000000000).floor) + " більярди") + (if ((n == 2000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 10000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000000000).floor) + " більярд") + (if ((n == 1000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000000000000)))
              end))
            end
            if (n >= 5000000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000000).floor) + " більйонів") + (if ((n == 5000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 10000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000000).floor) + " більйони") + (if ((n == 2000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 10000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000000).floor) + " більйон") + (if ((n == 1000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000000000)))
              end))
            end
            if (n >= 5000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000).floor) + " мільярдів") + (if ((n == 5000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 10000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000).floor) + " мільярди") + (if ((n == 2000000000) or ((n % 10) == 0)) then
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
              return ((format_spellout_cardinal_masculine((n / 10000000).floor) + " мільйонів") + (if ((n == 5000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 10000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000).floor) + " мільйони") + (if ((n == 2000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 10000000)))
              end))
            end
            if (n >= 1000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000).floor) + " мільйон") + (if ((n == 1000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000)))
              end))
            end
            if (n >= 5000) then
              return ((format_spellout_cardinal_feminine((n / 10000).floor) + " тисяч") + (if ((n == 5000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 10000)))
              end))
            end
            if (n >= 2000) then
              return ((format_spellout_cardinal_feminine((n / 10000).floor) + " тисячі") + (if ((n == 2000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 10000)))
              end))
            end
            if (n >= 1000) then
              return ((format_spellout_cardinal_feminine((n / 1000).floor) + " тисяча") + (if ((n == 1000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000)))
              end))
            end
            if (n >= 900) then
              return ("девʼятсот" + (if ((n == 900) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000)))
              end))
            end
            if (n >= 800) then
              return ("вісімсот" + (if ((n == 800) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000)))
              end))
            end
            if (n >= 700) then
              return ("сімсот" + (if ((n == 700) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000)))
              end))
            end
            if (n >= 600) then
              return ("шістсот" + (if ((n == 600) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000)))
              end))
            end
            if (n >= 500) then
              return ("пʼятсот" + (if ((n == 500) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000)))
              end))
            end
            if (n >= 400) then
              return ("чотириста" + (if ((n == 400) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000)))
              end))
            end
            if (n >= 300) then
              return ("триста" + (if ((n == 300) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000)))
              end))
            end
            if (n >= 200) then
              return ("двісті" + (if ((n == 200) or ((n % 10) == 0)) then
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
              return ("девʼяносто" + (if ((n == 90) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100)))
              end))
            end
            if (n >= 80) then
              return ("вісімдесят" + (if ((n == 80) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100)))
              end))
            end
            if (n >= 70) then
              return ("сімдесят" + (if ((n == 70) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100)))
              end))
            end
            if (n >= 60) then
              return ("шістдесят" + (if ((n == 60) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100)))
              end))
            end
            if (n >= 50) then
              return ("пʼятдесят" + (if ((n == 50) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100)))
              end))
            end
            if (n >= 40) then
              return ("сорок" + (if ((n == 40) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100)))
              end))
            end
            if (n >= 30) then
              return ("тридцять" + (if ((n == 30) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100)))
              end))
            end
            if (n >= 20) then
              return ("двадцять" + (if ((n == 20) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100)))
              end))
            end
            return format_spellout_cardinal_masculine(n) if (n >= 3)
            return "дві" if (n >= 2)
            return "одна" if (n >= 1)
            return "нуль" if (n >= 0)
          end
        end
      end
    end
  end
end