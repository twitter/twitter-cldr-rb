# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:bg] = Bulgarian = Module.new { }
      
      class Bulgarian::Spellout
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
            if (n >= 1000) then
              return ((format_spellout_cardinal_feminine((n / 1000.0).floor) + " илјада") + (if (n == 1000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100)))
              end))
            end
            if (n >= 100) then
              return ((format_spellout_cardinal_feminine((n / 100.0).floor) + "сто") + ((n == 100) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 100))))))
            end
            if (n >= 90) then
              return ("деведесет" + ((n == 90) ? ("") : ((" и " + format_spellout_cardinal_masculine((n % 10))))))
            end
            if (n >= 80) then
              return ("осумдесет" + ((n == 80) ? ("") : ((" и " + format_spellout_cardinal_masculine((n % 10))))))
            end
            if (n >= 70) then
              return ("седумдесет" + ((n == 70) ? ("") : ((" и " + format_spellout_cardinal_masculine((n % 10))))))
            end
            if (n >= 60) then
              return ("шеесет" + ((n == 60) ? ("") : ((" и " + format_spellout_cardinal_masculine((n % 10))))))
            end
            if (n >= 50) then
              return ("педесет" + ((n == 50) ? ("") : ((" и " + format_spellout_cardinal_masculine((n % 10))))))
            end
            if (n >= 40) then
              return ("четириесет" + ((n == 40) ? ("") : ((" и " + format_spellout_cardinal_masculine((n % 10))))))
            end
            if (n >= 30) then
              return ("триесет" + ((n == 30) ? ("") : ((" и " + format_spellout_cardinal_masculine((n % 10))))))
            end
            if (n >= 20) then
              return ("дваесет" + ((n == 20) ? ("") : ((" и " + format_spellout_cardinal_masculine((n % 10))))))
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
            if (n >= 1000) then
              return ((format_spellout_cardinal_feminine((n / 1000.0).floor) + " илјада") + ((n == 1000) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 100))))))
            end
            if (n >= 100) then
              return ((format_spellout_cardinal_feminine((n / 100.0).floor) + "сто") + ((n == 100) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 100))))))
            end
            if (n >= 90) then
              return ("деведесет" + ((n == 90) ? ("") : ((" и " + format_spellout_cardinal_neuter((n % 10))))))
            end
            if (n >= 80) then
              return ("осумдесет" + ((n == 80) ? ("") : ((" и " + format_spellout_cardinal_neuter((n % 10))))))
            end
            if (n >= 70) then
              return ("седумдесет" + ((n == 70) ? ("") : ((" и " + format_spellout_cardinal_neuter((n % 10))))))
            end
            if (n >= 60) then
              return ("шеесет" + ((n == 60) ? ("") : ((" и " + format_spellout_cardinal_neuter((n % 10))))))
            end
            if (n >= 50) then
              return ("педесет" + ((n == 50) ? ("") : ((" и " + format_spellout_cardinal_neuter((n % 10))))))
            end
            if (n >= 40) then
              return ("четириесет" + ((n == 40) ? ("") : ((" и " + format_spellout_cardinal_neuter((n % 10))))))
            end
            if (n >= 30) then
              return ("триесет" + ((n == 30) ? ("") : ((" и " + format_spellout_cardinal_neuter((n % 10))))))
            end
            if (n >= 20) then
              return ("дваесет" + ((n == 20) ? ("") : ((" и " + format_spellout_cardinal_neuter((n % 10))))))
            end
            return format_spellout_cardinal_masculine(n) if (n >= 3)
            return "два" if (n >= 2)
            return "едно" if (n >= 1)
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
            if (n >= 1000) then
              return ((format_spellout_cardinal_feminine((n / 1000.0).floor) + " илјада") + ((n == 1000) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 100))))))
            end
            if (n >= 100) then
              return ((format_spellout_cardinal_feminine((n / 100.0).floor) + "сто") + ((n == 100) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 100))))))
            end
            if (n >= 90) then
              return ("деведесет" + ((n == 90) ? ("") : ((" и " + format_spellout_cardinal_feminine((n % 10))))))
            end
            if (n >= 80) then
              return ("осумдесет" + ((n == 80) ? ("") : ((" и " + format_spellout_cardinal_feminine((n % 10))))))
            end
            if (n >= 70) then
              return ("седумдесет" + ((n == 70) ? ("") : ((" и " + format_spellout_cardinal_feminine((n % 10))))))
            end
            if (n >= 60) then
              return ("шеесет" + ((n == 60) ? ("") : ((" и " + format_spellout_cardinal_feminine((n % 10))))))
            end
            if (n >= 50) then
              return ("педесет" + ((n == 50) ? ("") : ((" и " + format_spellout_cardinal_feminine((n % 10))))))
            end
            if (n >= 40) then
              return ("четириесет" + ((n == 40) ? ("") : ((" и " + format_spellout_cardinal_feminine((n % 10))))))
            end
            if (n >= 30) then
              return ("триесет" + ((n == 30) ? ("") : ((" и " + format_spellout_cardinal_feminine((n % 10))))))
            end
            if (n >= 20) then
              return ("дваесет" + ((n == 20) ? ("") : ((" и " + format_spellout_cardinal_feminine((n % 10))))))
            end
            return format_spellout_cardinal_masculine(n) if (n >= 3)
            return "две" if (n >= 2)
            return "една" if (n >= 1)
            return "нула" if (n >= 0)
          end
        end
      end
    end
  end
end