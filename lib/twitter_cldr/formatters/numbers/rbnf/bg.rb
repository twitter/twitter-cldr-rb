# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:bg] = Bulgarian = Class.new do
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
              return ((renderSpelloutCardinalMasculine(n.floor) + " кома ") + renderSpelloutCardinalMasculine(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 1000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 1.0e+15).floor) + " билијарда") + (if (n == 1000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 100000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000000000.0).floor) + " билион") + (if (n == 1000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 100000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000000.0).floor) + " милијарда") + (if (n == 1000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 100000000)))
              end))
            end
            if (n >= 1000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000.0).floor) + " милион") + (if (n == 1000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 100000)))
              end))
            end
            if (n >= 1000) then
              return ((renderSpelloutCardinalFeminine((n / 1000.0).floor) + " илјада") + ((n == 1000) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 100) then
              return ((renderSpelloutCardinalFeminine((n / 100.0).floor) + "сто") + ((n == 100) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 90) then
              return ("деведесет" + ((n == 90) ? ("") : ((" и " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 80) then
              return ("осумдесет" + ((n == 80) ? ("") : ((" и " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 70) then
              return ("седумдесет" + ((n == 70) ? ("") : ((" и " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 60) then
              return ("шеесет" + ((n == 60) ? ("") : ((" и " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 50) then
              return ("педесет" + ((n == 50) ? ("") : ((" и " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 40) then
              return ("четириесет" + ((n == 40) ? ("") : ((" и " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 30) then
              return ("триесет" + ((n == 30) ? ("") : ((" и " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 20) then
              return ("дваесет" + ((n == 20) ? ("") : ((" и " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            return "деветнаесет" if (n >= 19)
            return "осумнаесет" if (n >= 18)
            return "седумнаесет" if (n >= 17)
            return "шеснаесет" if (n >= 16)
            return "петнаесет" if (n >= 15)
            return "четиринаесет" if (n >= 14)
            return "тринаесет" if (n >= 13)
            return "дванаесет" if (n >= 12)
            return "единаесет" if (n >= 11)
            return "десет" if (n >= 10)
            return "девет" if (n >= 9)
            return "осум" if (n >= 8)
            return "седум" if (n >= 7)
            return "шест" if (n >= 6)
            return "пет" if (n >= 5)
            return "четири" if (n >= 4)
            return "три" if (n >= 3)
            return "два" if (n >= 2)
            return "еден" if (n >= 1)
            return "нула" if (n >= 0)
          end
          def renderSpelloutCardinalNeuter(n)
            is_fractional = (n != n.floor)
            return ("минус " + renderSpelloutCardinalNeuter(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((renderSpelloutCardinalNeuter(n.floor) + " кома ") + renderSpelloutCardinalNeuter(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 1000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 1.0e+15).floor) + " билијарда") + (if (n == 1000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 100000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000000000.0).floor) + " билион") + (if (n == 1000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 100000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000000.0).floor) + " милијарда") + (if (n == 1000000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 100000000)))
              end))
            end
            if (n >= 1000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000.0).floor) + " милион") + (if (n == 1000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 100000)))
              end))
            end
            if (n >= 1000) then
              return ((renderSpelloutCardinalFeminine((n / 1000.0).floor) + " илјада") + ((n == 1000) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 100))))))
            end
            if (n >= 100) then
              return ((renderSpelloutCardinalFeminine((n / 100.0).floor) + "сто") + ((n == 100) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 100))))))
            end
            if (n >= 90) then
              return ("деведесет" + ((n == 90) ? ("") : ((" и " + renderSpelloutCardinalNeuter((n % 10))))))
            end
            if (n >= 80) then
              return ("осумдесет" + ((n == 80) ? ("") : ((" и " + renderSpelloutCardinalNeuter((n % 10))))))
            end
            if (n >= 70) then
              return ("седумдесет" + ((n == 70) ? ("") : ((" и " + renderSpelloutCardinalNeuter((n % 10))))))
            end
            if (n >= 60) then
              return ("шеесет" + ((n == 60) ? ("") : ((" и " + renderSpelloutCardinalNeuter((n % 10))))))
            end
            if (n >= 50) then
              return ("педесет" + ((n == 50) ? ("") : ((" и " + renderSpelloutCardinalNeuter((n % 10))))))
            end
            if (n >= 40) then
              return ("четириесет" + ((n == 40) ? ("") : ((" и " + renderSpelloutCardinalNeuter((n % 10))))))
            end
            if (n >= 30) then
              return ("триесет" + ((n == 30) ? ("") : ((" и " + renderSpelloutCardinalNeuter((n % 10))))))
            end
            if (n >= 20) then
              return ("дваесет" + ((n == 20) ? ("") : ((" и " + renderSpelloutCardinalNeuter((n % 10))))))
            end
            return renderSpelloutCardinalMasculine(n) if (n >= 3)
            return "два" if (n >= 2)
            return "едно" if (n >= 1)
            return "нула" if (n >= 0)
          end
          def renderSpelloutCardinalFeminine(n)
            is_fractional = (n != n.floor)
            return ("минус " + renderSpelloutCardinalFeminine(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((renderSpelloutCardinalFeminine(n.floor) + " кома ") + renderSpelloutCardinalFeminine(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 1000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 1.0e+15).floor) + " билијарда") + (if (n == 1000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 100000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000000000.0).floor) + " билион") + (if (n == 1000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 100000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000000.0).floor) + " милијарда") + (if (n == 1000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 100000000)))
              end))
            end
            if (n >= 1000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000.0).floor) + " милион") + (if (n == 1000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 100000)))
              end))
            end
            if (n >= 1000) then
              return ((renderSpelloutCardinalFeminine((n / 1000.0).floor) + " илјада") + ((n == 1000) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 100) then
              return ((renderSpelloutCardinalFeminine((n / 100.0).floor) + "сто") + ((n == 100) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 90) then
              return ("деведесет" + ((n == 90) ? ("") : ((" и " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 80) then
              return ("осумдесет" + ((n == 80) ? ("") : ((" и " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 70) then
              return ("седумдесет" + ((n == 70) ? ("") : ((" и " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 60) then
              return ("шеесет" + ((n == 60) ? ("") : ((" и " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 50) then
              return ("педесет" + ((n == 50) ? ("") : ((" и " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 40) then
              return ("четириесет" + ((n == 40) ? ("") : ((" и " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 30) then
              return ("триесет" + ((n == 30) ? ("") : ((" и " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 20) then
              return ("дваесет" + ((n == 20) ? ("") : ((" и " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            return renderSpelloutCardinalMasculine(n) if (n >= 3)
            return "две" if (n >= 2)
            return "една" if (n >= 1)
            return "нула" if (n >= 0)
          end)
        end
      end
    end
  end
end