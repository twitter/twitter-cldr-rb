# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:ru] = Russian = Module.new { }
      
      class Russian::Spellout
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
            return ("минус " + format_spellout_cardinal_masculine(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_cardinal_masculine(n.floor) + " запятая ") + format_spellout_cardinal_masculine(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 5000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 5.0e+15).floor) + " биллиардов") + (if (n == 5000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000000000000)))
              end))
            end
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 2.0e+15).floor) + " биллиарды") + (if (n == 2000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 1.0e+15).floor) + " биллиард") + (if (n == 1000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100000000000000)))
              end))
            end
            if (n >= 5000000000000) then
              return ((format_spellout_cardinal_masculine((n / 5000000000000.0).floor) + " биллионов") + (if (n == 5000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000000000.0).floor) + " биллионы") + (if (n == 2000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000000.0).floor) + " биллион") + (if (n == 1000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100000000000)))
              end))
            end
            if (n >= 5000000000) then
              return ((format_spellout_cardinal_masculine((n / 5000000000.0).floor) + " миллиардов") + (if (n == 5000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000000.0).floor) + " миллиарды") + (if (n == 2000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000.0).floor) + " миллиард") + (if (n == 1000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100000000)))
              end))
            end
            if (n >= 5000000) then
              return ((format_spellout_cardinal_masculine((n / 5000000.0).floor) + " миллионов") + (if (n == 5000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000.0).floor) + " миллионы") + (if (n == 2000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000.0).floor) + " миллион") + (if (n == 1000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100000)))
              end))
            end
            if (n >= 5000) then
              return ((format_spellout_cardinal_feminine((n / 5000.0).floor) + " тысяч") + (if (n == 5000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000)))
              end))
            end
            if (n >= 2000) then
              return ((format_spellout_cardinal_feminine((n / 2000.0).floor) + " тысячи") + (if (n == 2000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000)))
              end))
            end
            if (n >= 1000) then
              return ((format_spellout_cardinal_feminine((n / 1000.0).floor) + " тысяча") + (if (n == 1000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100)))
              end))
            end
            if (n >= 500) then
              return ((format_spellout_cardinal_feminine((n / 500.0).floor) + "сот") + ((n == 500) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 100))))))
            end
            if (n >= 300) then
              return ((format_spellout_cardinal_feminine((n / 300.0).floor) + "ста") + ((n == 300) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 100))))))
            end
            if (n >= 200) then
              return ((format_spellout_cardinal_feminine((n / 200.0).floor) + "сти") + ((n == 200) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 100))))))
            end
            if (n >= 100) then
              return ("сто" + ((n == 100) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 100))))))
            end
            if (n >= 90) then
              return ("девяносто" + ((n == 90) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 10))))))
            end
            if (n >= 80) then
              return ("восемьдесят" + ((n == 80) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 10))))))
            end
            if (n >= 70) then
              return ("семьдесят" + ((n == 70) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 10))))))
            end
            if (n >= 60) then
              return ("шестьдесят" + ((n == 60) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 10))))))
            end
            if (n >= 50) then
              return ("пятьдесят" + ((n == 50) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 10))))))
            end
            if (n >= 40) then
              return ("сорок" + ((n == 40) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 10))))))
            end
            if (n >= 30) then
              return ("тридцать" + ((n == 30) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 10))))))
            end
            if (n >= 20) then
              return ("двадцать" + ((n == 20) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 10))))))
            end
            return "девятнадцать" if (n >= 19)
            return "восемнадцать" if (n >= 18)
            return "семнадцать" if (n >= 17)
            return "шестнадцать" if (n >= 16)
            return "пятнадцать" if (n >= 15)
            return "четырнадцать" if (n >= 14)
            return "тринадцать" if (n >= 13)
            return "двенадцать" if (n >= 12)
            return "одиннадцать" if (n >= 11)
            return "десять" if (n >= 10)
            return "девять" if (n >= 9)
            return "восемь" if (n >= 8)
            return "семь" if (n >= 7)
            return "шесть" if (n >= 6)
            return "пять" if (n >= 5)
            return "четыре" if (n >= 4)
            return "три" if (n >= 3)
            return "два" if (n >= 2)
            return "один" if (n >= 1)
            return "ноль" if (n >= 0)
          end
          def format_spellout_cardinal_neuter(n)
            is_fractional = (n != n.floor)
            return ("минус " + format_spellout_cardinal_neuter(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_cardinal_neuter(n.floor) + " запятая ") + format_spellout_cardinal_neuter(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 5000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 5.0e+15).floor) + " биллиардов") + (if (n == 5000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000000000000000)))
              end))
            end
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 2.0e+15).floor) + " биллиарды") + (if (n == 2000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 1.0e+15).floor) + " биллиард") + (if (n == 1000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 100000000000000)))
              end))
            end
            if (n >= 5000000000000) then
              return ((format_spellout_cardinal_masculine((n / 5000000000000.0).floor) + " биллионов") + (if (n == 5000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000000000.0).floor) + " биллионы") + (if (n == 2000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000000.0).floor) + " биллион") + (if (n == 1000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 100000000000)))
              end))
            end
            if (n >= 5000000000) then
              return ((format_spellout_cardinal_masculine((n / 5000000000.0).floor) + " миллиардов") + (if (n == 5000000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000000.0).floor) + " миллиарды") + (if (n == 2000000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000.0).floor) + " миллиард") + (if (n == 1000000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 100000000)))
              end))
            end
            if (n >= 5000000) then
              return ((format_spellout_cardinal_masculine((n / 5000000.0).floor) + " миллионов") + (if (n == 5000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000.0).floor) + " миллионы") + (if (n == 2000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000.0).floor) + " миллион") + (if (n == 1000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 100000)))
              end))
            end
            if (n >= 5000) then
              return ((format_spellout_cardinal_feminine((n / 5000.0).floor) + " тысяч") + ((n == 5000) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 1000))))))
            end
            if (n >= 2000) then
              return ((format_spellout_cardinal_feminine((n / 2000.0).floor) + " тысячи") + ((n == 2000) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 1000))))))
            end
            if (n >= 1000) then
              return ((format_spellout_cardinal_feminine((n / 1000.0).floor) + " тысяча") + ((n == 1000) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 100))))))
            end
            if (n >= 500) then
              return ((format_spellout_cardinal_feminine((n / 500.0).floor) + "сот") + ((n == 500) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 100))))))
            end
            if (n >= 300) then
              return ((format_spellout_cardinal_feminine((n / 300.0).floor) + "ста") + ((n == 300) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 100))))))
            end
            if (n >= 200) then
              return ((format_spellout_cardinal_feminine((n / 200.0).floor) + "сти") + ((n == 200) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 100))))))
            end
            if (n >= 100) then
              return ("сто" + ((n == 100) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 100))))))
            end
            if (n >= 90) then
              return ("девяносто" + ((n == 90) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 10))))))
            end
            if (n >= 80) then
              return ("восемьдесят" + ((n == 80) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 10))))))
            end
            if (n >= 70) then
              return ("семьдесят" + ((n == 70) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 10))))))
            end
            if (n >= 60) then
              return ("шестьдесят" + ((n == 60) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 10))))))
            end
            if (n >= 50) then
              return ("пятьдесят" + ((n == 50) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 10))))))
            end
            if (n >= 40) then
              return ("сорок" + ((n == 40) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 10))))))
            end
            if (n >= 30) then
              return ("тридцать" + ((n == 30) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 10))))))
            end
            if (n >= 20) then
              return ("двадцать" + ((n == 20) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 10))))))
            end
            return format_spellout_cardinal_masculine(n) if (n >= 3)
            return "два" if (n >= 2)
            return "одно" if (n >= 1)
            return "ноль" if (n >= 0)
          end
          def format_spellout_cardinal_feminine(n)
            is_fractional = (n != n.floor)
            return ("минус " + format_spellout_cardinal_feminine(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_cardinal_feminine(n.floor) + " запятая ") + format_spellout_cardinal_feminine(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 5000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 5.0e+15).floor) + " биллиардов") + (if (n == 5000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000000000000)))
              end))
            end
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 2.0e+15).floor) + " биллиарды") + (if (n == 2000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 1.0e+15).floor) + " биллиард") + (if (n == 1000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100000000000000)))
              end))
            end
            if (n >= 5000000000000) then
              return ((format_spellout_cardinal_masculine((n / 5000000000000.0).floor) + " биллионов") + (if (n == 5000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000000000.0).floor) + " биллионы") + (if (n == 2000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000000.0).floor) + " биллион") + (if (n == 1000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100000000000)))
              end))
            end
            if (n >= 5000000000) then
              return ((format_spellout_cardinal_masculine((n / 5000000000.0).floor) + " миллиардов") + (if (n == 5000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000000.0).floor) + " миллиарды") + (if (n == 2000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000.0).floor) + " миллиард") + (if (n == 1000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100000000)))
              end))
            end
            if (n >= 5000000) then
              return ((format_spellout_cardinal_masculine((n / 5000000.0).floor) + " миллионов") + (if (n == 5000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000.0).floor) + " миллионы") + (if (n == 2000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000.0).floor) + " миллион") + (if (n == 1000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100000)))
              end))
            end
            if (n >= 5000) then
              return ((format_spellout_cardinal_feminine((n / 5000.0).floor) + " тысяч") + (if (n == 5000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000)))
              end))
            end
            if (n >= 2000) then
              return ((format_spellout_cardinal_feminine((n / 2000.0).floor) + " тысячи") + (if (n == 2000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000)))
              end))
            end
            if (n >= 1000) then
              return ((format_spellout_cardinal_feminine((n / 1000.0).floor) + " тысяча") + ((n == 1000) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 100))))))
            end
            if (n >= 500) then
              return ((format_spellout_cardinal_feminine((n / 500.0).floor) + "сот") + ((n == 500) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 100))))))
            end
            if (n >= 300) then
              return ((format_spellout_cardinal_feminine((n / 300.0).floor) + "ста") + ((n == 300) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 100))))))
            end
            if (n >= 200) then
              return ((format_spellout_cardinal_feminine((n / 200.0).floor) + "сти") + ((n == 200) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 100))))))
            end
            if (n >= 100) then
              return ("сто" + ((n == 100) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 100))))))
            end
            if (n >= 90) then
              return ("девяносто" + ((n == 90) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 10))))))
            end
            if (n >= 80) then
              return ("восемьдесят" + ((n == 80) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 10))))))
            end
            if (n >= 70) then
              return ("семьдесят" + ((n == 70) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 10))))))
            end
            if (n >= 60) then
              return ("шестьдесят" + ((n == 60) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 10))))))
            end
            if (n >= 50) then
              return ("пятьдесят" + ((n == 50) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 10))))))
            end
            if (n >= 40) then
              return ("сорок" + ((n == 40) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 10))))))
            end
            if (n >= 30) then
              return ("тридцать" + ((n == 30) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 10))))))
            end
            if (n >= 20) then
              return ("двадцать" + ((n == 20) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 10))))))
            end
            return format_spellout_cardinal_masculine(n) if (n >= 3)
            return "две" if (n >= 2)
            return "одна" if (n >= 1)
            return "ноль" if (n >= 0)
          end
        end
      end
    end
  end
end