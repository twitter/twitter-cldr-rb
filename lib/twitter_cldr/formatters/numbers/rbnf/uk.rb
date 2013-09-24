# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:uk] = Ukrainian = Class.new do
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
            return ("мінус " + renderSpelloutCardinalMasculine(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((renderSpelloutCardinalMasculine(n.floor) + " кома ") + renderSpelloutCardinalMasculine(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 5000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 5.0e+15).floor) + " більярдів") + (if (n == 5000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 1000000000000000)))
              end))
            end
            if (n >= 2000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2.0e+15).floor) + " більярди") + (if (n == 2000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 1.0e+15).floor) + " більярд") + (if (n == 1000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 100000000000000)))
              end))
            end
            if (n >= 5000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 5000000000000.0).floor) + " більйонів") + (if (n == 5000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 1000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000000.0).floor) + " більйони") + (if (n == 2000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000000000.0).floor) + " більйон") + (if (n == 1000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 100000000000)))
              end))
            end
            if (n >= 5000000000) then
              return ((renderSpelloutCardinalMasculine((n / 5000000000.0).floor) + " мільярдів") + (if (n == 5000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 1000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000.0).floor) + " мільярди") + (if (n == 2000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000000.0).floor) + " мільярд") + (if (n == 1000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 100000000)))
              end))
            end
            if (n >= 5000000) then
              return ((renderSpelloutCardinalMasculine((n / 5000000.0).floor) + " мільйонів") + (if (n == 5000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 1000000)))
              end))
            end
            if (n >= 2000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000.0).floor) + " мільйони") + (if (n == 2000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000.0).floor) + " мільйон") + (if (n == 1000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 100000)))
              end))
            end
            if (n >= 5000) then
              return ((renderSpelloutCardinalFeminine((n / 5000.0).floor) + " тисяч") + ((n == 5000) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 1000))))))
            end
            if (n >= 2000) then
              return ((renderSpelloutCardinalFeminine((n / 2000.0).floor) + " тисячі") + ((n == 2000) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 1000))))))
            end
            if (n >= 1000) then
              return ((renderSpelloutCardinalFeminine((n / 1000.0).floor) + " тисяча") + ((n == 1000) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 900) then
              return ("девʼятсот" + ((n == 900) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 800) then
              return ("вісімсот" + ((n == 800) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 700) then
              return ("сімсот" + ((n == 700) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 600) then
              return ("шістсот" + ((n == 600) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 500) then
              return ("пʼятсот" + ((n == 500) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 400) then
              return ("чотириста" + ((n == 400) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 300) then
              return ("триста" + ((n == 300) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 200) then
              return ("двісті" + ((n == 200) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 100) then
              return ("сто" + ((n == 100) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 90) then
              return ("девʼяносто" + ((n == 90) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 80) then
              return ("вісімдесят" + ((n == 80) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 70) then
              return ("сімдесят" + ((n == 70) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 60) then
              return ("шістдесят" + ((n == 60) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 50) then
              return ("пʼятдесят" + ((n == 50) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 40) then
              return ("сорок" + ((n == 40) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 30) then
              return ("тридцять" + ((n == 30) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 20) then
              return ("двадцять" + ((n == 20) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 10))))))
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
          def renderSpelloutCardinalNeuter(n)
            is_fractional = (n != n.floor)
            return ("мінус " + renderSpelloutCardinalNeuter(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((renderSpelloutCardinalNeuter(n.floor) + " кома ") + renderSpelloutCardinalNeuter(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 5000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 5.0e+15).floor) + " більярдів") + (if (n == 5000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 1000000000000000)))
              end))
            end
            if (n >= 2000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2.0e+15).floor) + " більярди") + (if (n == 2000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 1.0e+15).floor) + " більярд") + (if (n == 1000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 100000000000000)))
              end))
            end
            if (n >= 5000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 5000000000000.0).floor) + " більйонів") + (if (n == 5000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 1000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000000.0).floor) + " більйони") + (if (n == 2000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000000000.0).floor) + " більйон") + (if (n == 1000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 100000000000)))
              end))
            end
            if (n >= 5000000000) then
              return ((renderSpelloutCardinalMasculine((n / 5000000000.0).floor) + " мільярдів") + (if (n == 5000000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 1000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000.0).floor) + " мільярди") + (if (n == 2000000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000000.0).floor) + " мільярд") + (if (n == 1000000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 100000000)))
              end))
            end
            if (n >= 5000000) then
              return ((renderSpelloutCardinalMasculine((n / 5000000.0).floor) + " мільйонів") + (if (n == 5000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 1000000)))
              end))
            end
            if (n >= 2000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000.0).floor) + " мільйони") + (if (n == 2000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000.0).floor) + " мільйон") + (if (n == 1000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 100000)))
              end))
            end
            if (n >= 5000) then
              return ((renderSpelloutCardinalFeminine((n / 5000.0).floor) + " тисяч") + ((n == 5000) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 1000))))))
            end
            if (n >= 2000) then
              return ((renderSpelloutCardinalFeminine((n / 2000.0).floor) + " тисячі") + ((n == 2000) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 1000))))))
            end
            if (n >= 1000) then
              return ((renderSpelloutCardinalFeminine((n / 1000.0).floor) + " тисяча") + ((n == 1000) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 100))))))
            end
            if (n >= 900) then
              return ("девʼятсот" + ((n == 900) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 100))))))
            end
            if (n >= 800) then
              return ("вісімсот" + ((n == 800) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 100))))))
            end
            if (n >= 700) then
              return ("сімсот" + ((n == 700) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 100))))))
            end
            if (n >= 600) then
              return ("шістсот" + ((n == 600) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 100))))))
            end
            if (n >= 500) then
              return ("пʼятсот" + ((n == 500) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 100))))))
            end
            if (n >= 400) then
              return ("чотириста" + ((n == 400) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 100))))))
            end
            if (n >= 300) then
              return ("триста" + ((n == 300) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 100))))))
            end
            if (n >= 200) then
              return ("двісті" + ((n == 200) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 100))))))
            end
            if (n >= 100) then
              return ("сто" + ((n == 100) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 100))))))
            end
            if (n >= 90) then
              return ("девʼяносто" + ((n == 90) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 10))))))
            end
            if (n >= 80) then
              return ("вісімдесят" + ((n == 80) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 10))))))
            end
            if (n >= 70) then
              return ("сімдесят" + ((n == 70) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 10))))))
            end
            if (n >= 60) then
              return ("шістдесят" + ((n == 60) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 10))))))
            end
            if (n >= 50) then
              return ("пʼятдесят" + ((n == 50) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 10))))))
            end
            if (n >= 40) then
              return ("сорок" + ((n == 40) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 10))))))
            end
            if (n >= 30) then
              return ("тридцять" + ((n == 30) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 10))))))
            end
            if (n >= 20) then
              return ("двадцять" + ((n == 20) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 10))))))
            end
            return renderSpelloutCardinalMasculine(n) if (n >= 3)
            return "два" if (n >= 2)
            return "одне" if (n >= 1)
            return "нуль" if (n >= 0)
          end
          def renderSpelloutCardinalFeminine(n)
            is_fractional = (n != n.floor)
            return ("мінус " + renderSpelloutCardinalFeminine(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((renderSpelloutCardinalFeminine(n.floor) + " кома ") + renderSpelloutCardinalFeminine(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 5000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 5.0e+15).floor) + " більярдів") + (if (n == 5000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 1000000000000000)))
              end))
            end
            if (n >= 2000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2.0e+15).floor) + " більярди") + (if (n == 2000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 1.0e+15).floor) + " більярд") + (if (n == 1000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 100000000000000)))
              end))
            end
            if (n >= 5000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 5000000000000.0).floor) + " більйонів") + (if (n == 5000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 1000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000000.0).floor) + " більйони") + (if (n == 2000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000000000.0).floor) + " більйон") + (if (n == 1000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 100000000000)))
              end))
            end
            if (n >= 5000000000) then
              return ((renderSpelloutCardinalMasculine((n / 5000000000.0).floor) + " мільярдів") + (if (n == 5000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 1000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000.0).floor) + " мільярди") + (if (n == 2000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000000.0).floor) + " мільярд") + (if (n == 1000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 100000000)))
              end))
            end
            if (n >= 5000000) then
              return ((renderSpelloutCardinalMasculine((n / 5000000.0).floor) + " мільйонів") + (if (n == 5000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 1000000)))
              end))
            end
            if (n >= 2000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000.0).floor) + " мільйони") + (if (n == 2000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000.0).floor) + " мільйон") + (if (n == 1000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 100000)))
              end))
            end
            if (n >= 5000) then
              return ((renderSpelloutCardinalFeminine((n / 5000.0).floor) + " тисяч") + ((n == 5000) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 1000))))))
            end
            if (n >= 2000) then
              return ((renderSpelloutCardinalFeminine((n / 2000.0).floor) + " тисячі") + ((n == 2000) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 1000))))))
            end
            if (n >= 1000) then
              return ((renderSpelloutCardinalFeminine((n / 1000.0).floor) + " тисяча") + ((n == 1000) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 900) then
              return ("девʼятсот" + ((n == 900) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 800) then
              return ("вісімсот" + ((n == 800) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 700) then
              return ("сімсот" + ((n == 700) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 600) then
              return ("шістсот" + ((n == 600) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 500) then
              return ("пʼятсот" + ((n == 500) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 400) then
              return ("чотириста" + ((n == 400) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 300) then
              return ("триста" + ((n == 300) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 200) then
              return ("двісті" + ((n == 200) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 100) then
              return ("сто" + ((n == 100) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 90) then
              return ("девʼяносто" + ((n == 90) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 80) then
              return ("вісімдесят" + ((n == 80) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 70) then
              return ("сімдесят" + ((n == 70) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 60) then
              return ("шістдесят" + ((n == 60) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 50) then
              return ("пʼятдесят" + ((n == 50) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 40) then
              return ("сорок" + ((n == 40) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 30) then
              return ("тридцять" + ((n == 30) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 20) then
              return ("двадцять" + ((n == 20) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            return renderSpelloutCardinalMasculine(n) if (n >= 3)
            return "дві" if (n >= 2)
            return "одна" if (n >= 1)
            return "нуль" if (n >= 0)
          end)
        end
      end
    end
  end
end