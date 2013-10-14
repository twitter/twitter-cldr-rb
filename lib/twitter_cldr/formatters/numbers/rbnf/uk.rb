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
              return ((format_spellout_cardinal_masculine(n.floor) + " кома ") + format_spellout_cardinal_masculine(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 5000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 5.0e+15).floor) + " більярдів") + (if (n == 5000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000000000000)))
              end))
            end
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 2.0e+15).floor) + " більярди") + (if (n == 2000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 1.0e+15).floor) + " більярд") + (if (n == 1000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100000000000000)))
              end))
            end
            if (n >= 5000000000000) then
              return ((format_spellout_cardinal_masculine((n / 5000000000000.0).floor) + " більйонів") + (if (n == 5000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000000000.0).floor) + " більйони") + (if (n == 2000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000000.0).floor) + " більйон") + (if (n == 1000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100000000000)))
              end))
            end
            if (n >= 5000000000) then
              return ((format_spellout_cardinal_masculine((n / 5000000000.0).floor) + " мільярдів") + (if (n == 5000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000000.0).floor) + " мільярди") + (if (n == 2000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000.0).floor) + " мільярд") + (if (n == 1000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100000000)))
              end))
            end
            if (n >= 5000000) then
              return ((format_spellout_cardinal_masculine((n / 5000000.0).floor) + " мільйонів") + (if (n == 5000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000.0).floor) + " мільйони") + (if (n == 2000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000.0).floor) + " мільйон") + (if (n == 1000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100000)))
              end))
            end
            if (n >= 5000) then
              return ((format_spellout_cardinal_feminine((n / 5000.0).floor) + " тисяч") + (if (n == 5000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000)))
              end))
            end
            if (n >= 2000) then
              return ((format_spellout_cardinal_feminine((n / 2000.0).floor) + " тисячі") + (if (n == 2000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000)))
              end))
            end
            if (n >= 1000) then
              return ((format_spellout_cardinal_feminine((n / 1000.0).floor) + " тисяча") + (if (n == 1000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100)))
              end))
            end
            if (n >= 900) then
              return ("девʼятсот" + ((n == 900) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 100))))))
            end
            if (n >= 800) then
              return ("вісімсот" + ((n == 800) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 100))))))
            end
            if (n >= 700) then
              return ("сімсот" + ((n == 700) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 100))))))
            end
            if (n >= 600) then
              return ("шістсот" + ((n == 600) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 100))))))
            end
            if (n >= 500) then
              return ("пʼятсот" + ((n == 500) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 100))))))
            end
            if (n >= 400) then
              return ("чотириста" + ((n == 400) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 100))))))
            end
            if (n >= 300) then
              return ("триста" + ((n == 300) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 100))))))
            end
            if (n >= 200) then
              return ("двісті" + ((n == 200) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 100))))))
            end
            if (n >= 100) then
              return ("сто" + ((n == 100) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 100))))))
            end
            if (n >= 90) then
              return ("девʼяносто" + ((n == 90) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 10))))))
            end
            if (n >= 80) then
              return ("вісімдесят" + ((n == 80) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 10))))))
            end
            if (n >= 70) then
              return ("сімдесят" + ((n == 70) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 10))))))
            end
            if (n >= 60) then
              return ("шістдесят" + ((n == 60) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 10))))))
            end
            if (n >= 50) then
              return ("пʼятдесят" + ((n == 50) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 10))))))
            end
            if (n >= 40) then
              return ("сорок" + ((n == 40) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 10))))))
            end
            if (n >= 30) then
              return ("тридцять" + ((n == 30) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 10))))))
            end
            if (n >= 20) then
              return ("двадцять" + ((n == 20) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 10))))))
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
              return ((format_spellout_cardinal_neuter(n.floor) + " кома ") + format_spellout_cardinal_neuter(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 5000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 5.0e+15).floor) + " більярдів") + (if (n == 5000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000000000000000)))
              end))
            end
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 2.0e+15).floor) + " більярди") + (if (n == 2000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 1.0e+15).floor) + " більярд") + (if (n == 1000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 100000000000000)))
              end))
            end
            if (n >= 5000000000000) then
              return ((format_spellout_cardinal_masculine((n / 5000000000000.0).floor) + " більйонів") + (if (n == 5000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000000000.0).floor) + " більйони") + (if (n == 2000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000000.0).floor) + " більйон") + (if (n == 1000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 100000000000)))
              end))
            end
            if (n >= 5000000000) then
              return ((format_spellout_cardinal_masculine((n / 5000000000.0).floor) + " мільярдів") + (if (n == 5000000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000000.0).floor) + " мільярди") + (if (n == 2000000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000.0).floor) + " мільярд") + (if (n == 1000000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 100000000)))
              end))
            end
            if (n >= 5000000) then
              return ((format_spellout_cardinal_masculine((n / 5000000.0).floor) + " мільйонів") + (if (n == 5000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000.0).floor) + " мільйони") + (if (n == 2000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000.0).floor) + " мільйон") + (if (n == 1000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 100000)))
              end))
            end
            if (n >= 5000) then
              return ((format_spellout_cardinal_feminine((n / 5000.0).floor) + " тисяч") + ((n == 5000) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 1000))))))
            end
            if (n >= 2000) then
              return ((format_spellout_cardinal_feminine((n / 2000.0).floor) + " тисячі") + ((n == 2000) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 1000))))))
            end
            if (n >= 1000) then
              return ((format_spellout_cardinal_feminine((n / 1000.0).floor) + " тисяча") + ((n == 1000) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 100))))))
            end
            if (n >= 900) then
              return ("девʼятсот" + ((n == 900) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 100))))))
            end
            if (n >= 800) then
              return ("вісімсот" + ((n == 800) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 100))))))
            end
            if (n >= 700) then
              return ("сімсот" + ((n == 700) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 100))))))
            end
            if (n >= 600) then
              return ("шістсот" + ((n == 600) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 100))))))
            end
            if (n >= 500) then
              return ("пʼятсот" + ((n == 500) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 100))))))
            end
            if (n >= 400) then
              return ("чотириста" + ((n == 400) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 100))))))
            end
            if (n >= 300) then
              return ("триста" + ((n == 300) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 100))))))
            end
            if (n >= 200) then
              return ("двісті" + ((n == 200) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 100))))))
            end
            if (n >= 100) then
              return ("сто" + ((n == 100) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 100))))))
            end
            if (n >= 90) then
              return ("девʼяносто" + ((n == 90) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 10))))))
            end
            if (n >= 80) then
              return ("вісімдесят" + ((n == 80) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 10))))))
            end
            if (n >= 70) then
              return ("сімдесят" + ((n == 70) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 10))))))
            end
            if (n >= 60) then
              return ("шістдесят" + ((n == 60) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 10))))))
            end
            if (n >= 50) then
              return ("пʼятдесят" + ((n == 50) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 10))))))
            end
            if (n >= 40) then
              return ("сорок" + ((n == 40) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 10))))))
            end
            if (n >= 30) then
              return ("тридцять" + ((n == 30) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 10))))))
            end
            if (n >= 20) then
              return ("двадцять" + ((n == 20) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 10))))))
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
              return ((format_spellout_cardinal_feminine(n.floor) + " кома ") + format_spellout_cardinal_feminine(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 5000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 5.0e+15).floor) + " більярдів") + (if (n == 5000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000000000000)))
              end))
            end
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 2.0e+15).floor) + " більярди") + (if (n == 2000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 1.0e+15).floor) + " більярд") + (if (n == 1000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100000000000000)))
              end))
            end
            if (n >= 5000000000000) then
              return ((format_spellout_cardinal_masculine((n / 5000000000000.0).floor) + " більйонів") + (if (n == 5000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000000000.0).floor) + " більйони") + (if (n == 2000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000000.0).floor) + " більйон") + (if (n == 1000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100000000000)))
              end))
            end
            if (n >= 5000000000) then
              return ((format_spellout_cardinal_masculine((n / 5000000000.0).floor) + " мільярдів") + (if (n == 5000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000000.0).floor) + " мільярди") + (if (n == 2000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000.0).floor) + " мільярд") + (if (n == 1000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100000000)))
              end))
            end
            if (n >= 5000000) then
              return ((format_spellout_cardinal_masculine((n / 5000000.0).floor) + " мільйонів") + (if (n == 5000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000.0).floor) + " мільйони") + (if (n == 2000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000.0).floor) + " мільйон") + (if (n == 1000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100000)))
              end))
            end
            if (n >= 5000) then
              return ((format_spellout_cardinal_feminine((n / 5000.0).floor) + " тисяч") + (if (n == 5000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000)))
              end))
            end
            if (n >= 2000) then
              return ((format_spellout_cardinal_feminine((n / 2000.0).floor) + " тисячі") + (if (n == 2000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000)))
              end))
            end
            if (n >= 1000) then
              return ((format_spellout_cardinal_feminine((n / 1000.0).floor) + " тисяча") + ((n == 1000) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 100))))))
            end
            if (n >= 900) then
              return ("девʼятсот" + ((n == 900) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 100))))))
            end
            if (n >= 800) then
              return ("вісімсот" + ((n == 800) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 100))))))
            end
            if (n >= 700) then
              return ("сімсот" + ((n == 700) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 100))))))
            end
            if (n >= 600) then
              return ("шістсот" + ((n == 600) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 100))))))
            end
            if (n >= 500) then
              return ("пʼятсот" + ((n == 500) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 100))))))
            end
            if (n >= 400) then
              return ("чотириста" + ((n == 400) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 100))))))
            end
            if (n >= 300) then
              return ("триста" + ((n == 300) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 100))))))
            end
            if (n >= 200) then
              return ("двісті" + ((n == 200) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 100))))))
            end
            if (n >= 100) then
              return ("сто" + ((n == 100) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 100))))))
            end
            if (n >= 90) then
              return ("девʼяносто" + ((n == 90) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 10))))))
            end
            if (n >= 80) then
              return ("вісімдесят" + ((n == 80) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 10))))))
            end
            if (n >= 70) then
              return ("сімдесят" + ((n == 70) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 10))))))
            end
            if (n >= 60) then
              return ("шістдесят" + ((n == 60) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 10))))))
            end
            if (n >= 50) then
              return ("пʼятдесят" + ((n == 50) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 10))))))
            end
            if (n >= 40) then
              return ("сорок" + ((n == 40) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 10))))))
            end
            if (n >= 30) then
              return ("тридцять" + ((n == 30) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 10))))))
            end
            if (n >= 20) then
              return ("двадцять" + ((n == 20) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 10))))))
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