# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:be] = Belarusian = Class.new do
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
              return ((renderSpelloutCardinalMasculine(n.floor) + " коска ") + renderSpelloutCardinalMasculine(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 5000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 5.0e+15).floor) + " квадрыльёнаў") + (if (n == 5000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 1000000000000000)))
              end))
            end
            if (n >= 2000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2.0e+15).floor) + " квадрыльёны") + (if (n == 2000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 1.0e+15).floor) + " квадрыльён") + (if (n == 1000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 100000000000000)))
              end))
            end
            if (n >= 5000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 5000000000000.0).floor) + " трылёнаў") + (if (n == 5000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 1000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000000.0).floor) + " трыльёны") + (if (n == 2000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000000000.0).floor) + " трыльён") + (if (n == 1000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 100000000000)))
              end))
            end
            if (n >= 5000000000) then
              return ((renderSpelloutCardinalMasculine((n / 5000000000.0).floor) + " мільярдаў") + (if (n == 5000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 1000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000.0).floor) + " мільярды") + (if (n == 2000000000) then
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
              return ((renderSpelloutCardinalMasculine((n / 5000000.0).floor) + " мільёнаў") + (if (n == 5000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 1000000)))
              end))
            end
            if (n >= 2000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000.0).floor) + " мільёны") + (if (n == 2000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000.0).floor) + " мільён") + (if (n == 1000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 100000)))
              end))
            end
            if (n >= 5000) then
              return ((renderSpelloutCardinalFeminine((n / 5000.0).floor) + " тысяч") + ((n == 5000) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 1000))))))
            end
            if (n >= 2000) then
              return ((renderSpelloutCardinalFeminine((n / 2000.0).floor) + " тысячы") + ((n == 2000) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 1000))))))
            end
            if (n >= 1000) then
              return ((renderSpelloutCardinalFeminine((n / 1000.0).floor) + " тысяча") + ((n == 1000) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 900) then
              return ("дзевяцьсот" + ((n == 900) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 800) then
              return ("восемсот" + ((n == 800) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 700) then
              return ("семсот" + ((n == 700) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 600) then
              return ("шэсцьсот" + ((n == 600) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 500) then
              return ("пяцьсот" + ((n == 500) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 400) then
              return ("чатырыста" + ((n == 400) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 300) then
              return ("трыста" + ((n == 300) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 200) then
              return ("дзвесце" + ((n == 200) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 100) then
              return ("сто" + ((n == 100) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 90) then
              return ("дзевяноста" + ((n == 90) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 80) then
              return ("восемдзесят" + ((n == 80) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 70) then
              return ("семдзесят" + ((n == 70) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 60) then
              return ("шэсцьдзесят" + ((n == 60) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 50) then
              return ("пяцьдзесят" + ((n == 50) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 40) then
              return ("сорак" + ((n == 40) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 30) then
              return ("трыццаць" + ((n == 30) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 20) then
              return ("дваццаць" + ((n == 20) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 10))))))
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
          def renderSpelloutCardinalNeuter(n)
            is_fractional = (n != n.floor)
            return ("мінус " + renderSpelloutCardinalNeuter(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((renderSpelloutCardinalNeuter(n.floor) + " коска ") + renderSpelloutCardinalNeuter(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 5000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 5.0e+15).floor) + " квадрыльёнаў") + (if (n == 5000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 1000000000000000)))
              end))
            end
            if (n >= 2000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2.0e+15).floor) + " квадрыльёны") + (if (n == 2000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 1.0e+15).floor) + " квадрыльён") + (if (n == 1000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 100000000000000)))
              end))
            end
            if (n >= 5000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 5000000000000.0).floor) + " трылёнаў") + (if (n == 5000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 1000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000000.0).floor) + " трыльёны") + (if (n == 2000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000000000.0).floor) + " трыльён") + (if (n == 1000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 100000000000)))
              end))
            end
            if (n >= 5000000000) then
              return ((renderSpelloutCardinalMasculine((n / 5000000000.0).floor) + " мільярдаў") + (if (n == 5000000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 1000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000.0).floor) + " мільярды") + (if (n == 2000000000) then
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
              return ((renderSpelloutCardinalMasculine((n / 5000000.0).floor) + " мільёнаў") + (if (n == 5000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 1000000)))
              end))
            end
            if (n >= 2000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000.0).floor) + " мільёны") + (if (n == 2000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000.0).floor) + " мільён") + (if (n == 1000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 100000)))
              end))
            end
            if (n >= 5000) then
              return ((renderSpelloutCardinalFeminine((n / 5000.0).floor) + " тысяч") + ((n == 5000) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 1000))))))
            end
            if (n >= 2000) then
              return ((renderSpelloutCardinalFeminine((n / 2000.0).floor) + " тысячы") + ((n == 2000) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 1000))))))
            end
            if (n >= 1000) then
              return ((renderSpelloutCardinalFeminine((n / 1000.0).floor) + " тысяча") + ((n == 1000) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 100))))))
            end
            if (n >= 900) then
              return ("дзевяцьсот" + ((n == 900) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 100))))))
            end
            if (n >= 800) then
              return ("васямсот" + ((n == 800) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 100))))))
            end
            if (n >= 700) then
              return ("сямсот" + ((n == 700) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 100))))))
            end
            if (n >= 600) then
              return ("шэсцьсот" + ((n == 600) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 100))))))
            end
            if (n >= 500) then
              return ("пяцьсот" + ((n == 500) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 100))))))
            end
            if (n >= 400) then
              return ("чатырыста" + ((n == 400) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 100))))))
            end
            if (n >= 300) then
              return ("трыста" + ((n == 300) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 100))))))
            end
            if (n >= 200) then
              return ("дзвесце" + ((n == 200) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 100))))))
            end
            if (n >= 100) then
              return ("сто" + ((n == 100) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 100))))))
            end
            if (n >= 90) then
              return ("дзевяноста" + ((n == 90) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 10))))))
            end
            if (n >= 80) then
              return ("восемдзесят" + ((n == 80) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 10))))))
            end
            if (n >= 70) then
              return ("семдзесят" + ((n == 70) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 10))))))
            end
            if (n >= 60) then
              return ("шэсцьдзесят" + ((n == 60) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 10))))))
            end
            if (n >= 50) then
              return ("пяцьдзесят" + ((n == 50) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 10))))))
            end
            if (n >= 40) then
              return ("сорак" + ((n == 40) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 10))))))
            end
            if (n >= 30) then
              return ("трыццаць" + ((n == 30) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 10))))))
            end
            if (n >= 20) then
              return ("дваццаць" + ((n == 20) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 10))))))
            end
            return renderSpelloutCardinalMasculine(n) if (n >= 3)
            return "два" if (n >= 2)
            return "адно" if (n >= 1)
            return "нуль" if (n >= 0)
          end
          def renderSpelloutCardinalFeminine(n)
            is_fractional = (n != n.floor)
            return ("мінус " + renderSpelloutCardinalFeminine(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((renderSpelloutCardinalFeminine(n.floor) + " коска ") + renderSpelloutCardinalFeminine(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 5000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 5.0e+15).floor) + " квадрыльёнаў") + (if (n == 5000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 1000000000000000)))
              end))
            end
            if (n >= 2000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2.0e+15).floor) + " квадрыльёны") + (if (n == 2000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 1.0e+15).floor) + " квадрыльён") + (if (n == 1000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 100000000000000)))
              end))
            end
            if (n >= 5000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 5000000000000.0).floor) + " трылёнаў") + (if (n == 5000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 1000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000000.0).floor) + " трыльёны") + (if (n == 2000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000000000.0).floor) + " трыльён") + (if (n == 1000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 100000000000)))
              end))
            end
            if (n >= 5000000000) then
              return ((renderSpelloutCardinalMasculine((n / 5000000000.0).floor) + " мільярдаў") + (if (n == 5000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 1000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000.0).floor) + " мільярды") + (if (n == 2000000000) then
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
              return ((renderSpelloutCardinalMasculine((n / 5000000.0).floor) + " мільёнаў") + (if (n == 5000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 1000000)))
              end))
            end
            if (n >= 2000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000.0).floor) + " мільёны") + (if (n == 2000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000.0).floor) + " мільён") + (if (n == 1000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 100000)))
              end))
            end
            if (n >= 5000) then
              return ((renderSpelloutCardinalFeminine((n / 5000.0).floor) + " тысяч") + ((n == 5000) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 1000))))))
            end
            if (n >= 2000) then
              return ((renderSpelloutCardinalFeminine((n / 2000.0).floor) + " тысячы") + ((n == 2000) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 1000))))))
            end
            if (n >= 1000) then
              return ((renderSpelloutCardinalFeminine((n / 1000.0).floor) + " тысяча") + ((n == 1000) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 900) then
              return ("дзевяцьсот" + ((n == 900) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 800) then
              return ("васямсот" + ((n == 800) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 700) then
              return ("семсот" + ((n == 700) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 600) then
              return ("шэсцьсот" + ((n == 600) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 500) then
              return ("пяцьсот" + ((n == 500) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 400) then
              return ("чатырыста" + ((n == 400) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 300) then
              return ("трыста" + ((n == 300) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 200) then
              return ("дзвесце" + ((n == 200) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 100) then
              return ("сто" + ((n == 100) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 90) then
              return ("дзевяноста" + ((n == 90) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 80) then
              return ("восемдзесят" + ((n == 80) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 70) then
              return ("семдзесят" + ((n == 70) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 60) then
              return ("шэсцьдзесят" + ((n == 60) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 50) then
              return ("пяцьдзясят" + ((n == 50) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 40) then
              return ("сорак" + ((n == 40) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 30) then
              return ("трыццаць" + ((n == 30) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 20) then
              return ("дваццаць" + ((n == 20) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            return renderSpelloutCardinalMasculine(n) if (n >= 3)
            return "дзве" if (n >= 2)
            return "адна" if (n >= 1)
            return "нуль" if (n >= 0)
          end
          def renderSpelloutOrdinalMasculine(n)
            is_fractional = (n != n.floor)
            return ("мінус " + renderSpelloutOrdinalMasculine(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 5000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 5.0e+15).floor) + " квадрыльёнаў") + (if (n == 5000000000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalMasculine((n % 1000000000000000)))
              end))
            end
            if (n >= 2000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2.0e+15).floor) + " квадрыльёны") + (if (n == 2000000000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalMasculine((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 1.0e+15).floor) + " квадрыльён") + (if (n == 1000000000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalMasculine((n % 100000000000000)))
              end))
            end
            if (n >= 5000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 5000000000000.0).floor) + " трылёнаў") + (if (n == 5000000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalMasculine((n % 1000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000000.0).floor) + " трыльёны") + (if (n == 2000000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalMasculine((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000000000.0).floor) + " трыльён") + (if (n == 1000000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalMasculine((n % 100000000000)))
              end))
            end
            if (n >= 5000000000) then
              return ((renderSpelloutCardinalMasculine((n / 5000000000.0).floor) + " мільярдаў") + (if (n == 5000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalMasculine((n % 1000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000.0).floor) + " мільярды") + (if (n == 2000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalMasculine((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000000.0).floor) + " мільярд") + (if (n == 1000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalMasculine((n % 100000000)))
              end))
            end
            if (n >= 5000000) then
              return ((renderSpelloutCardinalMasculine((n / 5000000.0).floor) + " мільёнаў") + (if (n == 5000000) then
                ""
              else
                (" " + renderSpelloutOrdinalMasculine((n % 1000000)))
              end))
            end
            if (n >= 2000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000.0).floor) + " мільёны") + (if (n == 2000000) then
                ""
              else
                (" " + renderSpelloutOrdinalMasculine((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000.0).floor) + " мільён") + (if (n == 1000000) then
                ""
              else
                (" " + renderSpelloutOrdinalMasculine((n % 100000)))
              end))
            end
            if (n >= 500000) then
              return ((renderSpelloutCardinalMasculine((n / 500000.0).floor) + " тысячнае") + ((n == 500000) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 1000))))))
            end
            if (n >= 400001) then
              return ((renderSpelloutCardinalMasculine((n / 400001.0).floor) + " тысячны") + ((n == 400001) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 1000))))))
            end
            return "чатырохсот тысячны" if (n >= 400000)
            if (n >= 300001) then
              return ((renderSpelloutCardinalMasculine((n / 300001.0).floor) + " тысячны") + ((n == 300001) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 1000))))))
            end
            return "трохсот тысячны" if (n >= 300000)
            if (n >= 200001) then
              return ((renderSpelloutCardinalMasculine((n / 200001.0).floor) + " тысячны") + ((n == 200001) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 1000))))))
            end
            return "дзвухсот тысячны" if (n >= 200000)
            if (n >= 110000) then
              return ((renderSpelloutCardinalMasculine((n / 110000.0).floor) + " тысячны") + ((n == 110000) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 1000))))))
            end
            if (n >= 100001) then
              return ((renderSpelloutCardinalMasculine((n / 100001.0).floor) + " тысяч") + ((n == 100001) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 1000))))))
            end
            return "сто тысячны" if (n >= 100000)
            if (n >= 21000) then
              return ((renderSpelloutCardinalFeminine((n / 21000.0).floor) + " тысяча") + ((n == 21000) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 1000))))))
            end
            if (n >= 20001) then
              return ((renderSpelloutCardinalMasculine((n / 20001.0).floor) + " тысяч") + ((n == 20001) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 1000))))))
            end
            return "дваццаці тысячны" if (n >= 20000)
            if (n >= 11000) then
              return ((renderSpelloutCardinalMasculine((n / 11000.0).floor) + " тысяч") + ((n == 11000) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 1000))))))
            end
            if (n >= 10001) then
              return ("дзесяць тысяч" + ((n == 10001) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 1000))))))
            end
            return "дзесяці тысячны" if (n >= 10000)
            if (n >= 5001) then
              return ((renderSpelloutCardinalFeminine((n / 5001.0).floor) + " тысяч") + ((n == 5001) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 1000))))))
            end
            if (n >= 5000) then
              return (renderSpelloutCardinalFeminine((n / 5000.0).floor) + " тысячны")
            end
            if (n >= 2001) then
              return ((renderSpelloutCardinalFeminine((n / 2001.0).floor) + " тысячы") + ((n == 2001) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 1000))))))
            end
            return "дзвух тысячны" if (n >= 2000)
            if (n >= 1001) then
              return ((renderSpelloutCardinalFeminine((n / 1001.0).floor) + " тысяча") + ((n == 1001) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 1000))))))
            end
            if (n >= 1000) then
              return (renderSpelloutCardinalFeminine((n / 1000.0).floor) + " тысячны")
            end
            if (n >= 901) then
              return ("дзевяцьсот" + ((n == 901) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 100))))))
            end
            return "дзевяцісоты" if (n >= 900)
            if (n >= 801) then
              return ("васямсот" + ((n == 801) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 100))))))
            end
            return "васьмісоты" if (n >= 800)
            if (n >= 701) then
              return ("семсот" + ((n == 701) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 100))))))
            end
            return "сямісоты" if (n >= 700)
            if (n >= 601) then
              return ("шэсцьсот" + ((n == 601) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 100))))))
            end
            return "шасьцісоты" if (n >= 600)
            if (n >= 501) then
              return ("пяцьсот" + ((n == 501) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 100))))))
            end
            return "пяцісоты" if (n >= 500)
            if (n >= 401) then
              return ("чатырыста" + ((n == 401) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 100))))))
            end
            return "чатырохсоты" if (n >= 400)
            if (n >= 301) then
              return ("трыста" + ((n == 301) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 100))))))
            end
            return "трохсоты" if (n >= 300)
            if (n >= 201) then
              return ("дзвесце" + ((n == 201) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 100))))))
            end
            return "дзвухсоты" if (n >= 200)
            if (n >= 101) then
              return ("сто" + ((n == 101) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 100))))))
            end
            return "соты" if (n >= 100)
            if (n >= 91) then
              return ("дзевяноста" + ((n == 91) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 10))))))
            end
            return "дзевяносты" if (n >= 90)
            if (n >= 81) then
              return ("восемдзесят" + ((n == 81) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 10))))))
            end
            return "васьмідзясяты" if (n >= 80)
            if (n >= 71) then
              return ("семдзесят" + ((n == 71) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 10))))))
            end
            return "семдзесяты" if (n >= 70)
            if (n >= 61) then
              return ("шэсцьдзесят" + ((n == 61) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 10))))))
            end
            return "шэсцьдзесяты" if (n >= 60)
            if (n >= 51) then
              return ("пяцідзясят" + ((n == 51) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 10))))))
            end
            return "пяцідзясяты" if (n >= 50)
            if (n >= 41) then
              return ("сорак" + ((n == 41) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 10))))))
            end
            return "саракавы" if (n >= 40)
            if (n >= 31) then
              return ("трыццаць" + ((n == 31) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 10))))))
            end
            return "трыццаты" if (n >= 30)
            if (n >= 21) then
              return ("дваццаць" + ((n == 21) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 10))))))
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
          def renderSpelloutOrdinalFeminine(n)
            is_fractional = (n != n.floor)
            return ("мінус " + renderSpelloutOrdinalFeminine(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 5000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 5.0e+15).floor) + " квадрыльёнаў") + (if (n == 5000000000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalFeminine((n % 1000000000000000)))
              end))
            end
            if (n >= 2000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2.0e+15).floor) + " квадрыльёны") + (if (n == 2000000000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalFeminine((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 1.0e+15).floor) + " квадрыльён") + (if (n == 1000000000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalFeminine((n % 100000000000000)))
              end))
            end
            if (n >= 5000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 5000000000000.0).floor) + " трылёнаў") + (if (n == 5000000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalFeminine((n % 1000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000000.0).floor) + " трыльёны") + (if (n == 2000000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalFeminine((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000000000.0).floor) + " трыльён") + (if (n == 1000000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalFeminine((n % 100000000000)))
              end))
            end
            if (n >= 5000000000) then
              return ((renderSpelloutCardinalMasculine((n / 5000000000.0).floor) + " мільярдаў") + (if (n == 5000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalFeminine((n % 1000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000.0).floor) + " мільярды") + (if (n == 2000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalFeminine((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000000.0).floor) + " мільярд") + (if (n == 1000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalFeminine((n % 100000000)))
              end))
            end
            if (n >= 5000000) then
              return ((renderSpelloutCardinalMasculine((n / 5000000.0).floor) + " мільёнаў") + (if (n == 5000000) then
                ""
              else
                (" " + renderSpelloutOrdinalFeminine((n % 1000000)))
              end))
            end
            if (n >= 2000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000.0).floor) + " мільёны") + (if (n == 2000000) then
                ""
              else
                (" " + renderSpelloutOrdinalFeminine((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000.0).floor) + " мільён") + (if (n == 1000000) then
                ""
              else
                (" " + renderSpelloutOrdinalFeminine((n % 100000)))
              end))
            end
            if (n >= 500000) then
              return ((renderSpelloutCardinalFeminine((n / 500000.0).floor) + " тысячнае") + ((n == 500000) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 1000))))))
            end
            if (n >= 400001) then
              return ((renderSpelloutCardinalFeminine((n / 400001.0).floor) + " тысячная") + ((n == 400001) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 1000))))))
            end
            return "чатырохсот тысячная" if (n >= 400000)
            if (n >= 300001) then
              return ((renderSpelloutCardinalFeminine((n / 300001.0).floor) + " тысячная") + ((n == 300001) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 1000))))))
            end
            return "трохсот тысячная" if (n >= 300000)
            if (n >= 200001) then
              return ((renderSpelloutCardinalFeminine((n / 200001.0).floor) + " тысячная") + ((n == 200001) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 1000))))))
            end
            return "дзвухсот тысячная" if (n >= 200000)
            if (n >= 110000) then
              return ((renderSpelloutCardinalFeminine((n / 110000.0).floor) + " тысячная") + ((n == 110000) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 1000))))))
            end
            if (n >= 100001) then
              return ((renderSpelloutCardinalMasculine((n / 100001.0).floor) + " тысяч") + ((n == 100001) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 1000))))))
            end
            return "сто тысячная" if (n >= 100000)
            if (n >= 21000) then
              return ((renderSpelloutCardinalFeminine((n / 21000.0).floor) + " тысяча") + ((n == 21000) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 1000))))))
            end
            if (n >= 20001) then
              return ((renderSpelloutCardinalMasculine((n / 20001.0).floor) + " тысяч") + ((n == 20001) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 1000))))))
            end
            return "дваццаці тысячная" if (n >= 20000)
            if (n >= 11000) then
              return ((renderSpelloutCardinalMasculine((n / 11000.0).floor) + " тысяч") + ((n == 11000) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 1000))))))
            end
            if (n >= 10001) then
              return ("дзесяць тысяч" + ((n == 10001) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 1000))))))
            end
            return "дзесяці тысячная" if (n >= 10000)
            if (n >= 5001) then
              return ((renderSpelloutCardinalFeminine((n / 5001.0).floor) + " тысяч") + ((n == 5001) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 1000))))))
            end
            if (n >= 5000) then
              return (renderSpelloutCardinalFeminine((n / 5000.0).floor) + " тысячная")
            end
            if (n >= 2001) then
              return ((renderSpelloutCardinalFeminine((n / 2001.0).floor) + " тысячы") + ((n == 2001) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 1000))))))
            end
            return "дзвух тысячная" if (n >= 2000)
            if (n >= 1001) then
              return ((renderSpelloutCardinalFeminine((n / 1001.0).floor) + " тысяча") + ((n == 1001) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 1000))))))
            end
            if (n >= 1000) then
              return (renderSpelloutCardinalFeminine((n / 1000.0).floor) + " тысячны")
            end
            if (n >= 901) then
              return ("дзевяцьсот" + ((n == 901) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 100))))))
            end
            return "дзевяцісотая" if (n >= 900)
            if (n >= 801) then
              return ("васямсот" + ((n == 801) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 100))))))
            end
            return "васьмісотая" if (n >= 800)
            if (n >= 701) then
              return ("семсот" + ((n == 701) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 100))))))
            end
            return "сямісотая" if (n >= 700)
            if (n >= 601) then
              return ("шэсцьсот" + ((n == 601) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 100))))))
            end
            return "шасьцісотая" if (n >= 600)
            if (n >= 501) then
              return ("пяцьсот" + ((n == 501) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 100))))))
            end
            return "пяцісотая" if (n >= 500)
            if (n >= 401) then
              return ("чатырыста" + ((n == 401) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 100))))))
            end
            return "чатырохсотая" if (n >= 400)
            if (n >= 301) then
              return ("трыста" + ((n == 301) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 100))))))
            end
            return "трохсотая" if (n >= 300)
            if (n >= 201) then
              return ("дзвесце" + ((n == 201) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 100))))))
            end
            return "дзвухсотая" if (n >= 200)
            if (n >= 101) then
              return ("сто" + ((n == 101) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 100))))))
            end
            return "сотая" if (n >= 100)
            if (n >= 91) then
              return ("дзевяноста" + ((n == 91) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 10))))))
            end
            return "дзевяностая" if (n >= 90)
            if (n >= 81) then
              return ("восемдзесят" + ((n == 81) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 10))))))
            end
            return "васьмідзясятая" if (n >= 80)
            if (n >= 71) then
              return ("семдзесят" + ((n == 71) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 10))))))
            end
            return "семдзесятая" if (n >= 70)
            if (n >= 61) then
              return ("шэсцьдзесят" + ((n == 61) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 10))))))
            end
            return "шэсцідзесятая" if (n >= 60)
            if (n >= 51) then
              return ("пяцідзясят" + ((n == 51) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 10))))))
            end
            return "пяцідзесятая" if (n >= 50)
            if (n >= 41) then
              return ("сорак" + ((n == 41) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 10))))))
            end
            return "саракавая" if (n >= 40)
            if (n >= 31) then
              return ("трыццаць" + ((n == 31) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 10))))))
            end
            return "трыццатая" if (n >= 30)
            if (n >= 21) then
              return ("дваццаць" + ((n == 21) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 10))))))
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
          def renderSpelloutOrdinalNeuter(n)
            is_fractional = (n != n.floor)
            return ("мінус " + renderSpelloutOrdinalNeuter(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 5000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 5.0e+15).floor) + " квадрыльёнаў") + (if (n == 5000000000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalNeuter((n % 1000000000000000)))
              end))
            end
            if (n >= 2000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2.0e+15).floor) + " квадрыльёны") + (if (n == 2000000000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalNeuter((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 1.0e+15).floor) + " квадрыльён") + (if (n == 1000000000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalNeuter((n % 100000000000000)))
              end))
            end
            if (n >= 5000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 5000000000000.0).floor) + " трылёнаў") + (if (n == 5000000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalNeuter((n % 1000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000000.0).floor) + " трыльёны") + (if (n == 2000000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalNeuter((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000000000.0).floor) + " трыльён") + (if (n == 1000000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalNeuter((n % 100000000000)))
              end))
            end
            if (n >= 5000000000) then
              return ((renderSpelloutCardinalMasculine((n / 5000000000.0).floor) + " мільярдаў") + (if (n == 5000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalNeuter((n % 1000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000.0).floor) + " мільярды") + (if (n == 2000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalNeuter((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000000.0).floor) + " мільярд") + (if (n == 1000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalNeuter((n % 100000000)))
              end))
            end
            if (n >= 5000000) then
              return ((renderSpelloutCardinalMasculine((n / 5000000.0).floor) + " мільёнаў") + (if (n == 5000000) then
                ""
              else
                (" " + renderSpelloutOrdinalNeuter((n % 1000000)))
              end))
            end
            if (n >= 2000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000.0).floor) + " мільёны") + (if (n == 2000000) then
                ""
              else
                (" " + renderSpelloutOrdinalNeuter((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000.0).floor) + " мільён") + ((n == 1000000) ? ("") : ((" " + renderSpelloutOrdinalNeuter((n % 100000))))))
            end
            if (n >= 500000) then
              return ((renderSpelloutCardinalFeminine((n / 500000.0).floor) + " тысячнае") + ((n == 500000) ? ("") : ((" " + renderSpelloutOrdinalNeuter((n % 1000))))))
            end
            if (n >= 400001) then
              return ((renderSpelloutCardinalFeminine((n / 400001.0).floor) + " тысячнае") + ((n == 400001) ? ("") : ((" " + renderSpelloutOrdinalNeuter((n % 1000))))))
            end
            return "чатырохсот тысячнае" if (n >= 400000)
            if (n >= 300001) then
              return ((renderSpelloutCardinalFeminine((n / 300001.0).floor) + " тысячнае") + ((n == 300001) ? ("") : ((" " + renderSpelloutOrdinalNeuter((n % 1000))))))
            end
            return "трохсот тысячнае" if (n >= 300000)
            if (n >= 200001) then
              return ((renderSpelloutCardinalFeminine((n / 200001.0).floor) + " тысячнае") + ((n == 200001) ? ("") : ((" " + renderSpelloutOrdinalNeuter((n % 1000))))))
            end
            return "дзвухсот тысячнае" if (n >= 200000)
            if (n >= 110000) then
              return ((renderSpelloutCardinalFeminine((n / 110000.0).floor) + " тысячнае") + ((n == 110000) ? ("") : ((" " + renderSpelloutOrdinalNeuter((n % 1000))))))
            end
            if (n >= 100001) then
              return ((renderSpelloutCardinalMasculine((n / 100001.0).floor) + " тысяч") + ((n == 100001) ? ("") : ((" " + renderSpelloutOrdinalNeuter((n % 1000))))))
            end
            return "сто тысячнае" if (n >= 100000)
            if (n >= 21000) then
              return ((renderSpelloutCardinalFeminine((n / 21000.0).floor) + " тысяча") + ((n == 21000) ? ("") : ((" " + renderSpelloutOrdinalNeuter((n % 1000))))))
            end
            if (n >= 20001) then
              return ((renderSpelloutCardinalMasculine((n / 20001.0).floor) + " тысяч") + ((n == 20001) ? ("") : ((" " + renderSpelloutOrdinalNeuter((n % 1000))))))
            end
            return "дваццаці тысячнае" if (n >= 20000)
            if (n >= 11000) then
              return ((renderSpelloutCardinalMasculine((n / 11000.0).floor) + " тысяч") + ((n == 11000) ? ("") : ((" " + renderSpelloutOrdinalNeuter((n % 1000))))))
            end
            if (n >= 10001) then
              return ("дзесяць тысяч" + ((n == 10001) ? ("") : ((" " + renderSpelloutOrdinalNeuter((n % 1000))))))
            end
            return "дзесяці тысячнае" if (n >= 10000)
            if (n >= 5001) then
              return ((renderSpelloutCardinalFeminine((n / 5001.0).floor) + " тысяч") + ((n == 5001) ? ("") : ((" " + renderSpelloutOrdinalNeuter((n % 1000))))))
            end
            if (n >= 5000) then
              return (renderSpelloutCardinalFeminine((n / 5000.0).floor) + " тысячнае")
            end
            if (n >= 2001) then
              return ((renderSpelloutCardinalFeminine((n / 2001.0).floor) + " тысячы") + ((n == 2001) ? ("") : ((" " + renderSpelloutOrdinalNeuter((n % 1000))))))
            end
            return "дзвух тысячнае" if (n >= 2000)
            if (n >= 1001) then
              return ((renderSpelloutCardinalFeminine((n / 1001.0).floor) + " тысяча") + ((n == 1001) ? ("") : ((" " + renderSpelloutOrdinalNeuter((n % 1000))))))
            end
            if (n >= 1000) then
              return (renderSpelloutCardinalFeminine((n / 1000.0).floor) + " тысячны")
            end
            if (n >= 901) then
              return ("дзевяцьсот" + ((n == 901) ? ("") : ((" " + renderSpelloutOrdinalNeuter((n % 100))))))
            end
            return "дзевяцісотае" if (n >= 900)
            if (n >= 801) then
              return ("васямсот" + ((n == 801) ? ("") : ((" " + renderSpelloutOrdinalNeuter((n % 100))))))
            end
            return "васьмісотае" if (n >= 800)
            if (n >= 701) then
              return ("семсот" + ((n == 701) ? ("") : ((" " + renderSpelloutOrdinalNeuter((n % 100))))))
            end
            return "сямісотае" if (n >= 700)
            if (n >= 601) then
              return ("шэсцьсот" + ((n == 601) ? ("") : ((" " + renderSpelloutOrdinalNeuter((n % 100))))))
            end
            return "шасьцісотае" if (n >= 600)
            if (n >= 501) then
              return ("пяцьсот" + ((n == 501) ? ("") : ((" " + renderSpelloutOrdinalNeuter((n % 100))))))
            end
            return "пяцісотае" if (n >= 500)
            if (n >= 401) then
              return ("чатырыста" + ((n == 401) ? ("") : ((" " + renderSpelloutOrdinalNeuter((n % 100))))))
            end
            return "чатырохсотае" if (n >= 400)
            if (n >= 301) then
              return ("трыста" + ((n == 301) ? ("") : ((" " + renderSpelloutOrdinalNeuter((n % 100))))))
            end
            return "трохсотае" if (n >= 300)
            if (n >= 201) then
              return ("дзвесце" + ((n == 201) ? ("") : ((" " + renderSpelloutOrdinalNeuter((n % 100))))))
            end
            return "дзвухсотае" if (n >= 200)
            if (n >= 101) then
              return ("сто" + ((n == 101) ? ("") : ((" " + renderSpelloutOrdinalNeuter((n % 100))))))
            end
            return "сотае" if (n >= 100)
            if (n >= 91) then
              return ("дзевяноста" + ((n == 91) ? ("") : ((" " + renderSpelloutOrdinalNeuter((n % 10))))))
            end
            return "дзевяностае" if (n >= 90)
            if (n >= 81) then
              return ("восемдзесят" + ((n == 81) ? ("") : ((" " + renderSpelloutOrdinalNeuter((n % 10))))))
            end
            return "васьмідзясятае" if (n >= 80)
            if (n >= 71) then
              return ("семдзесят" + ((n == 71) ? ("") : ((" " + renderSpelloutOrdinalNeuter((n % 10))))))
            end
            return "сямдзясятае" if (n >= 70)
            if (n >= 61) then
              return ("шэсцьдзесят" + ((n == 61) ? ("") : ((" " + renderSpelloutOrdinalNeuter((n % 10))))))
            end
            return "шэсцідзясятае" if (n >= 60)
            if (n >= 51) then
              return ("пяцідзясят" + ((n == 51) ? ("") : ((" " + renderSpelloutOrdinalNeuter((n % 10))))))
            end
            return "пяцьдзесятае" if (n >= 50)
            if (n >= 41) then
              return ("сорак" + ((n == 41) ? ("") : ((" " + renderSpelloutOrdinalNeuter((n % 10))))))
            end
            return "саракавое" if (n >= 40)
            if (n >= 31) then
              return ("трыццаць" + ((n == 31) ? ("") : ((" " + renderSpelloutOrdinalNeuter((n % 10))))))
            end
            return "трыццатае" if (n >= 30)
            if (n >= 21) then
              return ("дваццаць" + ((n == 21) ? ("") : ((" " + renderSpelloutOrdinalNeuter((n % 10))))))
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
          end)
        end
      end
    end
  end
end