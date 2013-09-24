# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:sr] = Serbian = Class.new do
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
            if (n >= 2000) then
              return ((renderSpelloutCardinalFeminine((n / 2000.0).floor) + " хиљада") + ((n == 2000) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 1000))))))
            end
            if (n >= 1000) then
              return ((renderSpelloutCardinalFeminine((n / 1000.0).floor) + " хиљаду") + ((n == 1000) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 400) then
              return ((renderSpelloutCardinalFeminine((n / 400.0).floor) + "сто") + ((n == 400) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 300) then
              return ("триста" + ((n == 300) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 200) then
              return ("двеста" + ((n == 200) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 100) then
              return ("сто" + ((n == 100) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 90) then
              return ("деведесет" + ((n == 90) ? ("") : ((" и " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 80) then
              return ("осамдесет" + ((n == 80) ? ("") : ((" и " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 70) then
              return ("седамдесет" + ((n == 70) ? ("") : ((" и " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 60) then
              return ("шездесет" + ((n == 60) ? ("") : ((" и " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 50) then
              return ("педесет" + ((n == 50) ? ("") : ((" и " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 40) then
              return ("четрдесет" + ((n == 40) ? ("") : ((" и " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 30) then
              return ("тридесет" + ((n == 30) ? ("") : ((" и " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 20) then
              return ("двадесет" + ((n == 20) ? ("") : ((" и " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            return "деветнаест" if (n >= 19)
            return "осамнаест" if (n >= 18)
            return "седамнаест" if (n >= 17)
            return "шеснаест" if (n >= 16)
            return "петнаест" if (n >= 15)
            return "четрнаест" if (n >= 14)
            return "тринаест" if (n >= 13)
            return "дванаест" if (n >= 12)
            return "једанаест" if (n >= 11)
            return "десет" if (n >= 10)
            return "девет" if (n >= 9)
            return "осам" if (n >= 8)
            return "седам" if (n >= 7)
            return "шест" if (n >= 6)
            return "пет" if (n >= 5)
            return "четири" if (n >= 4)
            return "три" if (n >= 3)
            return "два" if (n >= 2)
            return "један" if (n >= 1)
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
            if (n >= 2000) then
              return ((renderSpelloutCardinalFeminine((n / 2000.0).floor) + " хиљада") + ((n == 2000) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 1000))))))
            end
            if (n >= 1000) then
              return ((renderSpelloutCardinalFeminine((n / 1000.0).floor) + " хиљаду") + ((n == 1000) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 100))))))
            end
            if (n >= 400) then
              return ((renderSpelloutCardinalFeminine((n / 400.0).floor) + "сто") + ((n == 400) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 100))))))
            end
            if (n >= 300) then
              return ("триста" + ((n == 300) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 100))))))
            end
            if (n >= 200) then
              return ("двеста" + ((n == 200) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 100))))))
            end
            if (n >= 100) then
              return ("сто" + ((n == 100) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 100))))))
            end
            if (n >= 90) then
              return ("деведесет" + ((n == 90) ? ("") : ((" и " + renderSpelloutCardinalNeuter((n % 10))))))
            end
            if (n >= 80) then
              return ("осамдесет" + ((n == 80) ? ("") : ((" и " + renderSpelloutCardinalNeuter((n % 10))))))
            end
            if (n >= 70) then
              return ("седамдесет" + ((n == 70) ? ("") : ((" и " + renderSpelloutCardinalNeuter((n % 10))))))
            end
            if (n >= 60) then
              return ("шездесет" + ((n == 60) ? ("") : ((" и " + renderSpelloutCardinalNeuter((n % 10))))))
            end
            if (n >= 50) then
              return ("педесет" + ((n == 50) ? ("") : ((" и " + renderSpelloutCardinalNeuter((n % 10))))))
            end
            if (n >= 40) then
              return ("четрдесет" + ((n == 40) ? ("") : ((" и " + renderSpelloutCardinalNeuter((n % 10))))))
            end
            if (n >= 30) then
              return ("тридесет" + ((n == 30) ? ("") : ((" и " + renderSpelloutCardinalNeuter((n % 10))))))
            end
            if (n >= 20) then
              return ("двадесет" + ((n == 20) ? ("") : ((" и " + renderSpelloutCardinalNeuter((n % 10))))))
            end
            return renderSpelloutCardinalMasculine(n) if (n >= 3)
            return "два" if (n >= 2)
            return "једно" if (n >= 1)
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
            if (n >= 2000) then
              return ((renderSpelloutCardinalFeminine((n / 2000.0).floor) + " хиљада") + ((n == 2000) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 1000))))))
            end
            if (n >= 1000) then
              return ((renderSpelloutCardinalFeminine((n / 1000.0).floor) + " хиљаду") + ((n == 1000) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 400) then
              return ((renderSpelloutCardinalFeminine((n / 400.0).floor) + "сто") + ((n == 400) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 300) then
              return ("триста" + ((n == 300) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 200) then
              return ("двеста" + ((n == 200) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 100) then
              return ("сто" + ((n == 100) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 90) then
              return ("деведесет" + ((n == 90) ? ("") : ((" и " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 80) then
              return ("осамдесет" + ((n == 80) ? ("") : ((" и " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 70) then
              return ("седамдесет" + ((n == 70) ? ("") : ((" и " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 60) then
              return ("шездесет" + ((n == 60) ? ("") : ((" и " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 50) then
              return ("педесет" + ((n == 50) ? ("") : ((" и " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 40) then
              return ("четрдесет" + ((n == 40) ? ("") : ((" и " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 30) then
              return ("тридесет" + ((n == 30) ? ("") : ((" и " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 20) then
              return ("двадесет" + ((n == 20) ? ("") : ((" и " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            return renderSpelloutCardinalMasculine(n) if (n >= 3)
            return "две" if (n >= 2)
            return "једна" if (n >= 1)
            return "нула" if (n >= 0)
          end
          def renderOrdi(n)
            return (" и " + renderSpelloutOrdinal(n)) if (n >= 1)
            return "и" if (n >= 0)
          end
          private(:renderOrdi)
          def renderOrdti(n)
            return (" " + renderSpelloutOrdinal(n)) if (n >= 1)
            return "ти" if (n >= 0)
          end
          private(:renderOrdti)
          def renderSpelloutOrdinal(n)
            is_fractional = (n != n.floor)
            return ("минус " + renderSpelloutOrdinal(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            if (n >= 400) then
              return ((renderSpelloutCardinalFeminine((n / 400.0).floor) + "сто") + renderOrdti((n % 100)))
            end
            return ("триста" + renderOrdti((n % 100))) if (n >= 300)
            return ("двеста" + renderOrdti((n % 100))) if (n >= 200)
            return ("сто" + renderOrdti((n % 100))) if (n >= 100)
            return ("деведесет" + renderOrdi((n % 10))) if (n >= 90)
            return ("осамдесет" + renderOrdi((n % 10))) if (n >= 80)
            return ("седамдесет" + renderOrdi((n % 10))) if (n >= 70)
            return ("шездесет" + renderOrdi((n % 10))) if (n >= 60)
            return ("педесет" + renderOrdi((n % 10))) if (n >= 50)
            return ("четрдесет" + renderOrdi((n % 10))) if (n >= 40)
            return ("тридесет" + renderOrdi((n % 10))) if (n >= 30)
            return ("двадесет" + renderOrdi((n % 10))) if (n >= 20)
            return "деветнаести" if (n >= 19)
            return "осамнаести" if (n >= 18)
            return "седамнаести" if (n >= 17)
            return "шеснаести" if (n >= 16)
            return "петнаести" if (n >= 15)
            return "четрнаести" if (n >= 14)
            return "тринаести" if (n >= 13)
            return "дванаести" if (n >= 12)
            return "једанаести" if (n >= 11)
            return "десети" if (n >= 10)
            return "девети" if (n >= 9)
            return "осми" if (n >= 8)
            return "седми" if (n >= 7)
            return "шести" if (n >= 6)
            return "пети" if (n >= 5)
            return "четврти" if (n >= 4)
            return "трећи" if (n >= 3)
            return "други" if (n >= 2)
            return "први" if (n >= 1)
            return "нулти" if (n >= 0)
          end)
        end
      end
    end
  end
end