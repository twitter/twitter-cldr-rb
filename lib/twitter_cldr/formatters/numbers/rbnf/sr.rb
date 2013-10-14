# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:sr] = Serbian = Module.new { }
      
      class Serbian::Spellout
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
              return ((format_spellout_cardinal_masculine(n.floor) + " кома ") + format_spellout_cardinal_masculine(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 1000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 1.0e+15).floor) + " билијарда") + (if (n == 1000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000000.0).floor) + " билион") + (if (n == 1000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000.0).floor) + " милијарда") + (if (n == 1000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100000000)))
              end))
            end
            if (n >= 1000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000.0).floor) + " милион") + (if (n == 1000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100000)))
              end))
            end
            if (n >= 2000) then
              return ((format_spellout_cardinal_feminine((n / 2000.0).floor) + " хиљада") + (if (n == 2000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000)))
              end))
            end
            if (n >= 1000) then
              return ((format_spellout_cardinal_feminine((n / 1000.0).floor) + " хиљаду") + (if (n == 1000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100)))
              end))
            end
            if (n >= 400) then
              return ((format_spellout_cardinal_feminine((n / 400.0).floor) + "сто") + ((n == 400) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 100))))))
            end
            if (n >= 300) then
              return ("триста" + ((n == 300) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 100))))))
            end
            if (n >= 200) then
              return ("двеста" + ((n == 200) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 100))))))
            end
            if (n >= 100) then
              return ("сто" + ((n == 100) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 100))))))
            end
            if (n >= 90) then
              return ("деведесет" + ((n == 90) ? ("") : ((" и " + format_spellout_cardinal_masculine((n % 10))))))
            end
            if (n >= 80) then
              return ("осамдесет" + ((n == 80) ? ("") : ((" и " + format_spellout_cardinal_masculine((n % 10))))))
            end
            if (n >= 70) then
              return ("седамдесет" + ((n == 70) ? ("") : ((" и " + format_spellout_cardinal_masculine((n % 10))))))
            end
            if (n >= 60) then
              return ("шездесет" + ((n == 60) ? ("") : ((" и " + format_spellout_cardinal_masculine((n % 10))))))
            end
            if (n >= 50) then
              return ("педесет" + ((n == 50) ? ("") : ((" и " + format_spellout_cardinal_masculine((n % 10))))))
            end
            if (n >= 40) then
              return ("четрдесет" + ((n == 40) ? ("") : ((" и " + format_spellout_cardinal_masculine((n % 10))))))
            end
            if (n >= 30) then
              return ("тридесет" + ((n == 30) ? ("") : ((" и " + format_spellout_cardinal_masculine((n % 10))))))
            end
            if (n >= 20) then
              return ("двадесет" + ((n == 20) ? ("") : ((" и " + format_spellout_cardinal_masculine((n % 10))))))
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
          def format_spellout_cardinal_neuter(n)
            is_fractional = (n != n.floor)
            return ("минус " + format_spellout_cardinal_neuter(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_cardinal_neuter(n.floor) + " кома ") + format_spellout_cardinal_neuter(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 1000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 1.0e+15).floor) + " билијарда") + (if (n == 1000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 100000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000000.0).floor) + " билион") + (if (n == 1000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 100000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000.0).floor) + " милијарда") + (if (n == 1000000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 100000000)))
              end))
            end
            if (n >= 1000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000.0).floor) + " милион") + (if (n == 1000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 100000)))
              end))
            end
            if (n >= 2000) then
              return ((format_spellout_cardinal_feminine((n / 2000.0).floor) + " хиљада") + ((n == 2000) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 1000))))))
            end
            if (n >= 1000) then
              return ((format_spellout_cardinal_feminine((n / 1000.0).floor) + " хиљаду") + ((n == 1000) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 100))))))
            end
            if (n >= 400) then
              return ((format_spellout_cardinal_feminine((n / 400.0).floor) + "сто") + ((n == 400) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 100))))))
            end
            if (n >= 300) then
              return ("триста" + ((n == 300) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 100))))))
            end
            if (n >= 200) then
              return ("двеста" + ((n == 200) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 100))))))
            end
            if (n >= 100) then
              return ("сто" + ((n == 100) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 100))))))
            end
            if (n >= 90) then
              return ("деведесет" + ((n == 90) ? ("") : ((" и " + format_spellout_cardinal_neuter((n % 10))))))
            end
            if (n >= 80) then
              return ("осамдесет" + ((n == 80) ? ("") : ((" и " + format_spellout_cardinal_neuter((n % 10))))))
            end
            if (n >= 70) then
              return ("седамдесет" + ((n == 70) ? ("") : ((" и " + format_spellout_cardinal_neuter((n % 10))))))
            end
            if (n >= 60) then
              return ("шездесет" + ((n == 60) ? ("") : ((" и " + format_spellout_cardinal_neuter((n % 10))))))
            end
            if (n >= 50) then
              return ("педесет" + ((n == 50) ? ("") : ((" и " + format_spellout_cardinal_neuter((n % 10))))))
            end
            if (n >= 40) then
              return ("четрдесет" + ((n == 40) ? ("") : ((" и " + format_spellout_cardinal_neuter((n % 10))))))
            end
            if (n >= 30) then
              return ("тридесет" + ((n == 30) ? ("") : ((" и " + format_spellout_cardinal_neuter((n % 10))))))
            end
            if (n >= 20) then
              return ("двадесет" + ((n == 20) ? ("") : ((" и " + format_spellout_cardinal_neuter((n % 10))))))
            end
            return format_spellout_cardinal_masculine(n) if (n >= 3)
            return "два" if (n >= 2)
            return "једно" if (n >= 1)
            return "нула" if (n >= 0)
          end
          def format_spellout_cardinal_feminine(n)
            is_fractional = (n != n.floor)
            return ("минус " + format_spellout_cardinal_feminine(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_cardinal_feminine(n.floor) + " кома ") + format_spellout_cardinal_feminine(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 1000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 1.0e+15).floor) + " билијарда") + (if (n == 1000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000000.0).floor) + " билион") + (if (n == 1000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000.0).floor) + " милијарда") + (if (n == 1000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100000000)))
              end))
            end
            if (n >= 1000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000.0).floor) + " милион") + (if (n == 1000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100000)))
              end))
            end
            if (n >= 2000) then
              return ((format_spellout_cardinal_feminine((n / 2000.0).floor) + " хиљада") + (if (n == 2000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000)))
              end))
            end
            if (n >= 1000) then
              return ((format_spellout_cardinal_feminine((n / 1000.0).floor) + " хиљаду") + ((n == 1000) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 100))))))
            end
            if (n >= 400) then
              return ((format_spellout_cardinal_feminine((n / 400.0).floor) + "сто") + ((n == 400) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 100))))))
            end
            if (n >= 300) then
              return ("триста" + ((n == 300) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 100))))))
            end
            if (n >= 200) then
              return ("двеста" + ((n == 200) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 100))))))
            end
            if (n >= 100) then
              return ("сто" + ((n == 100) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 100))))))
            end
            if (n >= 90) then
              return ("деведесет" + ((n == 90) ? ("") : ((" и " + format_spellout_cardinal_feminine((n % 10))))))
            end
            if (n >= 80) then
              return ("осамдесет" + ((n == 80) ? ("") : ((" и " + format_spellout_cardinal_feminine((n % 10))))))
            end
            if (n >= 70) then
              return ("седамдесет" + ((n == 70) ? ("") : ((" и " + format_spellout_cardinal_feminine((n % 10))))))
            end
            if (n >= 60) then
              return ("шездесет" + ((n == 60) ? ("") : ((" и " + format_spellout_cardinal_feminine((n % 10))))))
            end
            if (n >= 50) then
              return ("педесет" + ((n == 50) ? ("") : ((" и " + format_spellout_cardinal_feminine((n % 10))))))
            end
            if (n >= 40) then
              return ("четрдесет" + ((n == 40) ? ("") : ((" и " + format_spellout_cardinal_feminine((n % 10))))))
            end
            if (n >= 30) then
              return ("тридесет" + ((n == 30) ? ("") : ((" и " + format_spellout_cardinal_feminine((n % 10))))))
            end
            if (n >= 20) then
              return ("двадесет" + ((n == 20) ? ("") : ((" и " + format_spellout_cardinal_feminine((n % 10))))))
            end
            return format_spellout_cardinal_masculine(n) if (n >= 3)
            return "две" if (n >= 2)
            return "једна" if (n >= 1)
            return "нула" if (n >= 0)
          end
          def format_ordi(n)
            return (" и " + format_spellout_ordinal(n)) if (n >= 1)
            return "и" if (n >= 0)
          end
          private(:format_ordi)
          def format_ordti(n)
            return (" " + format_spellout_ordinal(n)) if (n >= 1)
            return "ти" if (n >= 0)
          end
          private(:format_ordti)
          def format_spellout_ordinal(n)
            is_fractional = (n != n.floor)
            return ("минус " + format_spellout_ordinal(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            if (n >= 400) then
              return ((format_spellout_cardinal_feminine((n / 400.0).floor) + "сто") + format_ordti((n % 100)))
            end
            return ("триста" + format_ordti((n % 100))) if (n >= 300)
            return ("двеста" + format_ordti((n % 100))) if (n >= 200)
            return ("сто" + format_ordti((n % 100))) if (n >= 100)
            return ("деведесет" + format_ordi((n % 10))) if (n >= 90)
            return ("осамдесет" + format_ordi((n % 10))) if (n >= 80)
            return ("седамдесет" + format_ordi((n % 10))) if (n >= 70)
            return ("шездесет" + format_ordi((n % 10))) if (n >= 60)
            return ("педесет" + format_ordi((n % 10))) if (n >= 50)
            return ("четрдесет" + format_ordi((n % 10))) if (n >= 40)
            return ("тридесет" + format_ordi((n % 10))) if (n >= 30)
            return ("двадесет" + format_ordi((n % 10))) if (n >= 20)
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
          end
        end
      end
    end
  end
end