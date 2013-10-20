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
              return ((format_spellout_cardinal(n.floor) + " ممیز ") + format_spellout_cardinal((n % 10)))
            end
            return n.to_s if (n >= 1000000000000000)
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal((n / 1000000000000).floor) + " هزار میلیارد") + (if ((n == 1000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_cardinal((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((format_spellout_cardinal((n / 1000000000).floor) + " میلیارد") + (if ((n == 1000000000) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_cardinal((n % 1000000000)))
              end))
            end
            if (n >= 1000000) then
              return ((format_spellout_cardinal((n / 1000000).floor) + " میلیون") + (if ((n == 1000000) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_cardinal((n % 1000000)))
              end))
            end
            if (n >= 1000) then
              return ((format_spellout_cardinal((n / 1000).floor) + " هزار") + (if ((n == 1000) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_cardinal((n % 1000)))
              end))
            end
            if (n >= 900) then
              return ("نهصد" + (if ((n == 900) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_cardinal((n % 1000)))
              end))
            end
            if (n >= 800) then
              return ("هشتصد" + (if ((n == 800) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_cardinal((n % 1000)))
              end))
            end
            if (n >= 700) then
              return ("هفتصد" + (if ((n == 700) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_cardinal((n % 1000)))
              end))
            end
            if (n >= 600) then
              return ("ششصد" + (if ((n == 600) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_cardinal((n % 1000)))
              end))
            end
            if (n >= 500) then
              return ("پانصد" + (if ((n == 500) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_cardinal((n % 1000)))
              end))
            end
            if (n >= 400) then
              return ("چهارصد" + (if ((n == 400) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_cardinal((n % 1000)))
              end))
            end
            if (n >= 300) then
              return ("سیصد" + (if ((n == 300) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_cardinal((n % 1000)))
              end))
            end
            if (n >= 200) then
              return ("دویست" + (if ((n == 200) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_cardinal((n % 1000)))
              end))
            end
            if (n >= 100) then
              return ("صد" + (if ((n == 100) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_cardinal((n % 100)))
              end))
            end
            if (n >= 90) then
              return ("نود" + (if ((n == 90) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_cardinal((n % 100)))
              end))
            end
            if (n >= 80) then
              return ("هشتاد" + (if ((n == 80) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_cardinal((n % 100)))
              end))
            end
            if (n >= 70) then
              return ("هفتاد" + (if ((n == 70) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_cardinal((n % 100)))
              end))
            end
            if (n >= 60) then
              return ("شصت" + (if ((n == 60) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_cardinal((n % 100)))
              end))
            end
            if (n >= 50) then
              return ("پنجاه" + (if ((n == 50) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_cardinal((n % 100)))
              end))
            end
            if (n >= 40) then
              return ("چهل" + (if ((n == 40) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_cardinal((n % 100)))
              end))
            end
            if (n >= 30) then
              return ("سی" + (if ((n == 30) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_cardinal((n % 100)))
              end))
            end
            if (n >= 20) then
              return ("بیست" + (if ((n == 20) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_cardinal((n % 100)))
              end))
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