# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:ru] = Russian = Class.new do
        class << self
          (def renderSpelloutNumberingYear(n)
            is_fractional = (n != n.floor)
            return n.to_s if is_fractional and (n > 1)
            return renderSpelloutNumbering(n) if (n >= 0)
          end
          def renderSpelloutNumbering(n)
            return renderSpelloutCardinalMasculine(n) if (n >= 0)
          end
          def renderSpelloutCardinalMasculine(n)
            is_fractional = (n != n.floor)
            return ("минус " + renderSpelloutCardinalMasculine(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((renderSpelloutCardinalMasculine(n.floor) + " запятая ") + renderSpelloutCardinalMasculine(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 5000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 5.0e+15).floor) + " биллиардов") + (if (n == 5000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 1000000000000000)))
              end))
            end
            if (n >= 2000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2.0e+15).floor) + " биллиарды") + (if (n == 2000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 1.0e+15).floor) + " биллиард") + (if (n == 1000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 100000000000000)))
              end))
            end
            if (n >= 5000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 5000000000000.0).floor) + " биллионов") + (if (n == 5000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 1000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000000.0).floor) + " биллионы") + (if (n == 2000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000000000.0).floor) + " биллион") + (if (n == 1000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 100000000000)))
              end))
            end
            if (n >= 5000000000) then
              return ((renderSpelloutCardinalMasculine((n / 5000000000.0).floor) + " миллиардов") + (if (n == 5000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 1000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000.0).floor) + " миллиарды") + (if (n == 2000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000000.0).floor) + " миллиард") + (if (n == 1000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 100000000)))
              end))
            end
            if (n >= 5000000) then
              return ((renderSpelloutCardinalMasculine((n / 5000000.0).floor) + " миллионов") + (if (n == 5000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 1000000)))
              end))
            end
            if (n >= 2000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000.0).floor) + " миллионы") + (if (n == 2000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000.0).floor) + " миллион") + (if (n == 1000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 100000)))
              end))
            end
            if (n >= 5000) then
              return ((renderSpelloutCardinalFeminine((n / 5000.0).floor) + " тысяч") + ((n == 5000) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 1000))))))
            end
            if (n >= 2000) then
              return ((renderSpelloutCardinalFeminine((n / 2000.0).floor) + " тысячи") + ((n == 2000) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 1000))))))
            end
            if (n >= 1000) then
              return ((renderSpelloutCardinalFeminine((n / 1000.0).floor) + " тысяча") + ((n == 1000) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 500) then
              return ((renderSpelloutCardinalFeminine((n / 500.0).floor) + "сот") + ((n == 500) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 300) then
              return ((renderSpelloutCardinalFeminine((n / 300.0).floor) + "ста") + ((n == 300) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 200) then
              return ((renderSpelloutCardinalFeminine((n / 200.0).floor) + "сти") + ((n == 200) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 100) then
              return ("сто" + ((n == 100) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 90) then
              return ("девяносто" + ((n == 90) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 80) then
              return ("восемьдесят" + ((n == 80) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 70) then
              return ("семьдесят" + ((n == 70) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 60) then
              return ("шестьдесят" + ((n == 60) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 50) then
              return ("пятьдесят" + ((n == 50) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 40) then
              return ("сорок" + ((n == 40) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 30) then
              return ("тридцать" + ((n == 30) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 20) then
              return ("двадцать" + ((n == 20) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 10))))))
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
          def renderSpelloutCardinalNeuter(n)
            is_fractional = (n != n.floor)
            return ("минус " + renderSpelloutCardinalNeuter(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((renderSpelloutCardinalNeuter(n.floor) + " запятая ") + renderSpelloutCardinalNeuter(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 5000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 5.0e+15).floor) + " биллиардов") + (if (n == 5000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 1000000000000000)))
              end))
            end
            if (n >= 2000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2.0e+15).floor) + " биллиарды") + (if (n == 2000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 1.0e+15).floor) + " биллиард") + (if (n == 1000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 100000000000000)))
              end))
            end
            if (n >= 5000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 5000000000000.0).floor) + " биллионов") + (if (n == 5000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 1000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000000.0).floor) + " биллионы") + (if (n == 2000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000000000.0).floor) + " биллион") + (if (n == 1000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 100000000000)))
              end))
            end
            if (n >= 5000000000) then
              return ((renderSpelloutCardinalMasculine((n / 5000000000.0).floor) + " миллиардов") + (if (n == 5000000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 1000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000.0).floor) + " миллиарды") + (if (n == 2000000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000000.0).floor) + " миллиард") + (if (n == 1000000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 100000000)))
              end))
            end
            if (n >= 5000000) then
              return ((renderSpelloutCardinalMasculine((n / 5000000.0).floor) + " миллионов") + (if (n == 5000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 1000000)))
              end))
            end
            if (n >= 2000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000.0).floor) + " миллионы") + (if (n == 2000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000.0).floor) + " миллион") + (if (n == 1000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 100000)))
              end))
            end
            if (n >= 5000) then
              return ((renderSpelloutCardinalFeminine((n / 5000.0).floor) + " тысяч") + ((n == 5000) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 1000))))))
            end
            if (n >= 2000) then
              return ((renderSpelloutCardinalFeminine((n / 2000.0).floor) + " тысячи") + ((n == 2000) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 1000))))))
            end
            if (n >= 1000) then
              return ((renderSpelloutCardinalFeminine((n / 1000.0).floor) + " тысяча") + ((n == 1000) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 100))))))
            end
            if (n >= 500) then
              return ((renderSpelloutCardinalFeminine((n / 500.0).floor) + "сот") + ((n == 500) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 100))))))
            end
            if (n >= 300) then
              return ((renderSpelloutCardinalFeminine((n / 300.0).floor) + "ста") + ((n == 300) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 100))))))
            end
            if (n >= 200) then
              return ((renderSpelloutCardinalFeminine((n / 200.0).floor) + "сти") + ((n == 200) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 100))))))
            end
            if (n >= 100) then
              return ("сто" + ((n == 100) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 100))))))
            end
            if (n >= 90) then
              return ("девяносто" + ((n == 90) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 10))))))
            end
            if (n >= 80) then
              return ("восемьдесят" + ((n == 80) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 10))))))
            end
            if (n >= 70) then
              return ("семьдесят" + ((n == 70) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 10))))))
            end
            if (n >= 60) then
              return ("шестьдесят" + ((n == 60) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 10))))))
            end
            if (n >= 50) then
              return ("пятьдесят" + ((n == 50) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 10))))))
            end
            if (n >= 40) then
              return ("сорок" + ((n == 40) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 10))))))
            end
            if (n >= 30) then
              return ("тридцать" + ((n == 30) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 10))))))
            end
            if (n >= 20) then
              return ("двадцать" + ((n == 20) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 10))))))
            end
            return renderSpelloutCardinalMasculine(n) if (n >= 3)
            return "два" if (n >= 2)
            return "одно" if (n >= 1)
            return "ноль" if (n >= 0)
          end
          def renderSpelloutCardinalFeminine(n)
            is_fractional = (n != n.floor)
            return ("минус " + renderSpelloutCardinalFeminine(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((renderSpelloutCardinalFeminine(n.floor) + " запятая ") + renderSpelloutCardinalFeminine(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 5000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 5.0e+15).floor) + " биллиардов") + (if (n == 5000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 1000000000000000)))
              end))
            end
            if (n >= 2000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2.0e+15).floor) + " биллиарды") + (if (n == 2000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 1.0e+15).floor) + " биллиард") + (if (n == 1000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 100000000000000)))
              end))
            end
            if (n >= 5000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 5000000000000.0).floor) + " биллионов") + (if (n == 5000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 1000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000000.0).floor) + " биллионы") + (if (n == 2000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000000000.0).floor) + " биллион") + (if (n == 1000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 100000000000)))
              end))
            end
            if (n >= 5000000000) then
              return ((renderSpelloutCardinalMasculine((n / 5000000000.0).floor) + " миллиардов") + (if (n == 5000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 1000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000.0).floor) + " миллиарды") + (if (n == 2000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000000.0).floor) + " миллиард") + (if (n == 1000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 100000000)))
              end))
            end
            if (n >= 5000000) then
              return ((renderSpelloutCardinalMasculine((n / 5000000.0).floor) + " миллионов") + (if (n == 5000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 1000000)))
              end))
            end
            if (n >= 2000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000.0).floor) + " миллионы") + (if (n == 2000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000.0).floor) + " миллион") + (if (n == 1000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 100000)))
              end))
            end
            if (n >= 5000) then
              return ((renderSpelloutCardinalFeminine((n / 5000.0).floor) + " тысяч") + ((n == 5000) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 1000))))))
            end
            if (n >= 2000) then
              return ((renderSpelloutCardinalFeminine((n / 2000.0).floor) + " тысячи") + ((n == 2000) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 1000))))))
            end
            if (n >= 1000) then
              return ((renderSpelloutCardinalFeminine((n / 1000.0).floor) + " тысяча") + ((n == 1000) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 500) then
              return ((renderSpelloutCardinalFeminine((n / 500.0).floor) + "сот") + ((n == 500) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 300) then
              return ((renderSpelloutCardinalFeminine((n / 300.0).floor) + "ста") + ((n == 300) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 200) then
              return ((renderSpelloutCardinalFeminine((n / 200.0).floor) + "сти") + ((n == 200) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 100) then
              return ("сто" + ((n == 100) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 90) then
              return ("девяносто" + ((n == 90) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 80) then
              return ("восемьдесят" + ((n == 80) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 70) then
              return ("семьдесят" + ((n == 70) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 60) then
              return ("шестьдесят" + ((n == 60) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 50) then
              return ("пятьдесят" + ((n == 50) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 40) then
              return ("сорок" + ((n == 40) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 30) then
              return ("тридцать" + ((n == 30) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 20) then
              return ("двадцать" + ((n == 20) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            return renderSpelloutCardinalMasculine(n) if (n >= 3)
            return "две" if (n >= 2)
            return "одна" if (n >= 1)
            return "ноль" if (n >= 0)
          end)
        end
      end
    end
  end
end