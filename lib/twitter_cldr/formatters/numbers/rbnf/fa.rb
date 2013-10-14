# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:fa] = Persian = Module.new { }
      
      class Persian::Spellout
        class << self
          def format_spellout_numbering_year(n)
            is_fractional = (n != n.floor)
            return n.to_s if is_fractional and (n > 1)
            return format_spellout_numbering(n) if (n >= 0)
          end
          def format_spellout_numbering(n)
            return format_spellout_cardinal(n) if (n >= 0)
          end
          def format_spellout_cardinal(n)
            is_fractional = (n != n.floor)
            return ("منفی " + format_spellout_cardinal(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_cardinal(n.floor) + " ممیز ") + format_spellout_cardinal(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000)
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal((n / 1000000000000.0).floor) + " هزار میلیارد") + (if (n == 1000000000000) then
                ""
              else
                (" و " + format_spellout_cardinal((n % 100000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((format_spellout_cardinal((n / 1000000000.0).floor) + " میلیارد") + (if (n == 1000000000) then
                ""
              else
                (" و " + format_spellout_cardinal((n % 100000000)))
              end))
            end
            if (n >= 1000000) then
              return ((format_spellout_cardinal((n / 1000000.0).floor) + " میلیون") + ((n == 1000000) ? ("") : ((" و " + format_spellout_cardinal((n % 100000))))))
            end
            if (n >= 1000) then
              return ((format_spellout_cardinal((n / 1000.0).floor) + " هزار") + ((n == 1000) ? ("") : ((" و " + format_spellout_cardinal((n % 100))))))
            end
            if (n >= 900) then
              return ("نهصد" + ((n == 900) ? ("") : ((" و " + format_spellout_cardinal((n % 100))))))
            end
            if (n >= 800) then
              return ("هشتصد" + ((n == 800) ? ("") : ((" و " + format_spellout_cardinal((n % 100))))))
            end
            if (n >= 700) then
              return ("هفتصد" + ((n == 700) ? ("") : ((" و " + format_spellout_cardinal((n % 100))))))
            end
            if (n >= 600) then
              return ("ششصد" + ((n == 600) ? ("") : ((" و " + format_spellout_cardinal((n % 100))))))
            end
            if (n >= 500) then
              return ("پانصد" + ((n == 500) ? ("") : ((" و " + format_spellout_cardinal((n % 100))))))
            end
            if (n >= 400) then
              return ("چهارصد" + ((n == 400) ? ("") : ((" و " + format_spellout_cardinal((n % 100))))))
            end
            if (n >= 300) then
              return ("سیصد" + ((n == 300) ? ("") : ((" و " + format_spellout_cardinal((n % 100))))))
            end
            if (n >= 200) then
              return ("دویست" + ((n == 200) ? ("") : ((" و " + format_spellout_cardinal((n % 100))))))
            end
            if (n >= 100) then
              return ("صد" + ((n == 100) ? ("") : ((" و " + format_spellout_cardinal((n % 100))))))
            end
            if (n >= 90) then
              return ("نود" + ((n == 90) ? ("") : ((" و " + format_spellout_cardinal((n % 10))))))
            end
            if (n >= 80) then
              return ("هشتاد" + ((n == 80) ? ("") : ((" و " + format_spellout_cardinal((n % 10))))))
            end
            if (n >= 70) then
              return ("هفتاد" + ((n == 70) ? ("") : ((" و " + format_spellout_cardinal((n % 10))))))
            end
            if (n >= 60) then
              return ("شصت" + ((n == 60) ? ("") : ((" و " + format_spellout_cardinal((n % 10))))))
            end
            if (n >= 50) then
              return ("پنجاه" + ((n == 50) ? ("") : ((" و " + format_spellout_cardinal((n % 10))))))
            end
            if (n >= 40) then
              return ("چهل" + ((n == 40) ? ("") : ((" و " + format_spellout_cardinal((n % 10))))))
            end
            if (n >= 30) then
              return ("سی" + ((n == 30) ? ("") : ((" و " + format_spellout_cardinal((n % 10))))))
            end
            if (n >= 20) then
              return ("بیست" + ((n == 20) ? ("") : ((" و " + format_spellout_cardinal((n % 10))))))
            end
            return "نوزده" if (n >= 19)
            return "هجده" if (n >= 18)
            return "هفده" if (n >= 17)
            return "شانزده" if (n >= 16)
            return "پانزده" if (n >= 15)
            return "چهارده" if (n >= 14)
            return "سیزده" if (n >= 13)
            return "دوازده" if (n >= 12)
            return "یازده" if (n >= 11)
            return "ده" if (n >= 10)
            return "نه" if (n >= 9)
            return "هشت" if (n >= 8)
            return "هفت" if (n >= 7)
            return "شش" if (n >= 6)
            return "پنج" if (n >= 5)
            return "چهار" if (n >= 4)
            return "سه" if (n >= 3)
            return "دو" if (n >= 2)
            return "یک" if (n >= 1)
            return "صفر" if (n >= 0)
          end
        end
      end
    end
  end
end