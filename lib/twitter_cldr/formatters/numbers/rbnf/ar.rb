# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:ar] = Arabic = Module.new { }
      
      class Arabic::Spellout
        class << self
          def format_spellout_numbering_year(n)
            is_fractional = (n != n.floor)
            return n.to_s if is_fractional and (n > 1)
            return format_spellout_numbering(n) if (n >= 0)
          end
          def format_spellout_numbering(n)
            is_fractional = (n != n.floor)
            return ("ناقص " + format_spellout_numbering(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_numbering(n.floor) + " فاصل ") + format_spellout_numbering((n % 10)))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((format_spellout_numbering_m((n / 10000000000000000).floor) + " بليار") + (if ((n == 2000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_numbering((n % 10000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("بليار" + (if ((n == 1000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_numbering((n % 1000000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_numbering_m((n / 10000000000000).floor) + " بليون") + (if ((n == 2000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_numbering((n % 10000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("بليون" + (if ((n == 1000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_numbering((n % 1000000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_numbering_m((n / 10000000000).floor) + " مليار") + (if ((n == 2000000000) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_numbering((n % 10000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("مليار" + (if ((n == 1000000000) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_numbering((n % 1000000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_numbering_m((n / 10000000).floor) + " مليون") + (if ((n == 2000000) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_numbering((n % 10000000)))
              end))
            end
            if (n >= 1000000) then
              return ("مليون" + (if ((n == 1000000) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_numbering((n % 1000000)))
              end))
            end
            if (n >= 11000) then
              return ((format_spellout_numbering_m((n / 1000000).floor) + " ألف") + (if ((n == 11000) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_numbering((n % 1000000)))
              end))
            end
            if (n >= 3000) then
              return ((format_spellout_numbering((n / 10000).floor) + " آلاف") + (if ((n == 3000) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_numbering((n % 10000)))
              end))
            end
            if (n >= 2000) then
              return ("ألفين" + (if ((n == 2000) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_numbering((n % 10000)))
              end))
            end
            if (n >= 1000) then
              return ("ألف" + (if ((n == 1000) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_numbering((n % 1000)))
              end))
            end
            if (n >= 300) then
              return ((format_spellout_numbering((n / 1000).floor) + " مائة") + (if ((n == 300) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_numbering((n % 1000)))
              end))
            end
            if (n >= 200) then
              return ("مائتان" + (if ((n == 200) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_numbering((n % 1000)))
              end))
            end
            if (n >= 100) then
              return ("مائة" + (if ((n == 100) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_numbering((n % 100)))
              end))
            end
            if (n >= 90) then
              return ((if ((n == 90) or ((n % 10) == 0)) then
                ""
              else
                (format_spellout_numbering((n % 100)) + " و ")
              end) + "تسعون")
            end
            if (n >= 80) then
              return ((if ((n == 80) or ((n % 10) == 0)) then
                ""
              else
                (format_spellout_numbering((n % 100)) + " و ")
              end) + "ثمانون")
            end
            if (n >= 70) then
              return ((if ((n == 70) or ((n % 10) == 0)) then
                ""
              else
                (format_spellout_numbering((n % 100)) + " و ")
              end) + "سبعون")
            end
            if (n >= 60) then
              return ((if ((n == 60) or ((n % 10) == 0)) then
                ""
              else
                (format_spellout_numbering((n % 100)) + " و ")
              end) + "ستون")
            end
            if (n >= 50) then
              return ((if ((n == 50) or ((n % 10) == 0)) then
                ""
              else
                (format_spellout_numbering((n % 100)) + " و ")
              end) + "خمسون")
            end
            if (n >= 40) then
              return ((if ((n == 40) or ((n % 10) == 0)) then
                ""
              else
                (format_spellout_numbering((n % 100)) + " و ")
              end) + "أربعون")
            end
            if (n >= 30) then
              return ((if ((n == 30) or ((n % 10) == 0)) then
                ""
              else
                (format_spellout_numbering((n % 100)) + " و ")
              end) + "ثلاثون")
            end
            if (n >= 20) then
              return ((if ((n == 20) or ((n % 10) == 0)) then
                ""
              else
                (format_spellout_numbering((n % 100)) + " و ")
              end) + "عشرون")
            end
            return (format_spellout_numbering((n % 100)) + " عشر") if (n >= 13)
            return "إثنا عشر" if (n >= 12)
            return "إحدى عشر" if (n >= 11)
            return "عشرة" if (n >= 10)
            return "تسعة" if (n >= 9)
            return "ثمانية" if (n >= 8)
            return "سبعة" if (n >= 7)
            return "ستة" if (n >= 6)
            return "خمسة" if (n >= 5)
            return "أربعة" if (n >= 4)
            return "ثلاثة" if (n >= 3)
            return "إثنان" if (n >= 2)
            return "واحد" if (n >= 1)
            return "صفر" if (n >= 0)
          end
          def format_spellout_cardinal_feminine(n)
            is_fractional = (n != n.floor)
            return ("ناقص " + format_spellout_cardinal_feminine(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_cardinal_feminine(n.floor) + " فاصل ") + format_spellout_cardinal_feminine((n % 10)))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((format_spellout_numbering_m((n / 10000000000000000).floor) + " بليار") + (if ((n == 2000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_numbering((n % 10000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("بليار" + (if ((n == 1000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_numbering((n % 1000000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_numbering_m((n / 10000000000000).floor) + " بليون") + (if ((n == 2000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_numbering((n % 10000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("بليون" + (if ((n == 1000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_numbering((n % 1000000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_numbering_m((n / 10000000000).floor) + " مليار") + (if ((n == 2000000000) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_numbering((n % 10000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("مليار" + (if ((n == 1000000000) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_numbering((n % 1000000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_numbering_m((n / 10000000).floor) + " مليون") + (if ((n == 2000000) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_numbering((n % 10000000)))
              end))
            end
            if (n >= 1000000) then
              return ("مليون" + (if ((n == 1000000) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_numbering((n % 1000000)))
              end))
            end
            if (n >= 11000) then
              return ((format_spellout_numbering_m((n / 1000000).floor) + " ألف") + (if ((n == 11000) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_numbering((n % 1000000)))
              end))
            end
            if (n >= 3000) then
              return ((format_spellout_numbering((n / 10000).floor) + " آلاف") + (if ((n == 3000) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_numbering((n % 10000)))
              end))
            end
            if (n >= 2000) then
              return ("ألفي" + (if ((n == 2000) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_numbering((n % 10000)))
              end))
            end
            if (n >= 1000) then
              return ("ألف" + (if ((n == 1000) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_numbering((n % 1000)))
              end))
            end
            if (n >= 300) then
              return ((format_spellout_numbering((n / 1000).floor) + " مائة") + (if ((n == 300) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_numbering((n % 1000)))
              end))
            end
            if (n >= 200) then
              return ("مائتان" + (if ((n == 200) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_numbering((n % 1000)))
              end))
            end
            if (n >= 100) then
              return ("مائة" + (if ((n == 100) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_numbering((n % 100)))
              end))
            end
            if (n >= 90) then
              return ((if ((n == 90) or ((n % 10) == 0)) then
                ""
              else
                (format_spellout_numbering((n % 100)) + " و ")
              end) + "تسعون")
            end
            if (n >= 80) then
              return ((if ((n == 80) or ((n % 10) == 0)) then
                ""
              else
                (format_spellout_numbering((n % 100)) + " و ")
              end) + "ثمانون")
            end
            if (n >= 70) then
              return ((if ((n == 70) or ((n % 10) == 0)) then
                ""
              else
                (format_spellout_numbering((n % 100)) + " و ")
              end) + "سبعون")
            end
            if (n >= 60) then
              return ((if ((n == 60) or ((n % 10) == 0)) then
                ""
              else
                (format_spellout_numbering((n % 100)) + " و ")
              end) + "ستون")
            end
            if (n >= 50) then
              return ((if ((n == 50) or ((n % 10) == 0)) then
                ""
              else
                (format_spellout_numbering((n % 100)) + " و ")
              end) + "خمسون")
            end
            if (n >= 40) then
              return ((if ((n == 40) or ((n % 10) == 0)) then
                ""
              else
                (format_spellout_numbering((n % 100)) + " و ")
              end) + "أربعون")
            end
            if (n >= 30) then
              return ((if ((n == 30) or ((n % 10) == 0)) then
                ""
              else
                (format_spellout_numbering((n % 100)) + " و ")
              end) + "ثلاثون")
            end
            if (n >= 20) then
              return ((if ((n == 20) or ((n % 10) == 0)) then
                ""
              else
                (format_spellout_numbering((n % 100)) + " و ")
              end) + "عشرون")
            end
            return (format_spellout_numbering((n % 100)) + " عشر") if (n >= 13)
            return "إثنتا عشرة" if (n >= 12)
            return "إحدى عشر" if (n >= 11)
            return "عشرة" if (n >= 10)
            return "تسعة" if (n >= 9)
            return "ثمانية" if (n >= 8)
            return "سبعة" if (n >= 7)
            return "ستة" if (n >= 6)
            return "خمسة" if (n >= 5)
            return "أربعة" if (n >= 4)
            return "ثلاثة" if (n >= 3)
            return "إثنتان" if (n >= 2)
            return "واحدة" if (n >= 1)
            return "صفر" if (n >= 0)
          end
          def format_spellout_numbering_m(n)
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((format_spellout_numbering_m((n / 10000000000000000).floor) + " بليار") + (if ((n == 2000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_numbering_m((n % 10000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("بليار" + (if ((n == 1000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_numbering_m((n % 1000000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_numbering_m((n / 10000000000000).floor) + " بليون") + (if ((n == 2000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_numbering_m((n % 10000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("بليون" + (if ((n == 1000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_numbering_m((n % 1000000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_numbering_m((n / 10000000000).floor) + " مليار") + (if ((n == 2000000000) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_numbering_m((n % 10000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("مليار" + (if ((n == 1000000000) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_numbering_m((n % 1000000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_numbering_m((n / 10000000).floor) + " مليون") + (if ((n == 2000000) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_numbering_m((n % 10000000)))
              end))
            end
            if (n >= 1000000) then
              return ("مليون" + (if ((n == 1000000) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_numbering_m((n % 1000000)))
              end))
            end
            if (n >= 11000) then
              return ((format_spellout_numbering_m((n / 1000000).floor) + " ألف") + (if ((n == 11000) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_numbering_m((n % 1000000)))
              end))
            end
            if (n >= 3000) then
              return ((format_spellout_numbering((n / 10000).floor) + " آلاف") + (if ((n == 3000) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_numbering_m((n % 10000)))
              end))
            end
            if (n >= 2000) then
              return ("ألفي" + (if ((n == 2000) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_numbering_m((n % 10000)))
              end))
            end
            if (n >= 1000) then
              return ("ألف" + (if ((n == 1000) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_numbering_m((n % 1000)))
              end))
            end
            if (n >= 300) then
              return ((format_spellout_numbering((n / 1000).floor) + " مائة") + (if ((n == 300) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_numbering_m((n % 1000)))
              end))
            end
            if (n >= 200) then
              return ("مائتان" + (if ((n == 200) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_numbering_m((n % 1000)))
              end))
            end
            if (n >= 100) then
              return ("مائة" + (if ((n == 100) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_numbering_m((n % 100)))
              end))
            end
            if (n >= 90) then
              return ((if ((n == 90) or ((n % 10) == 0)) then
                ""
              else
                (format_spellout_numbering_m((n % 100)) + " و ")
              end) + "تسعون")
            end
            if (n >= 80) then
              return ((if ((n == 80) or ((n % 10) == 0)) then
                ""
              else
                (format_spellout_numbering_m((n % 100)) + " و ")
              end) + "ثمانون")
            end
            if (n >= 70) then
              return ((if ((n == 70) or ((n % 10) == 0)) then
                ""
              else
                (format_spellout_numbering_m((n % 100)) + " و ")
              end) + "سبعون")
            end
            if (n >= 60) then
              return ((if ((n == 60) or ((n % 10) == 0)) then
                ""
              else
                (format_spellout_numbering_m((n % 100)) + " و ")
              end) + "ستون")
            end
            if (n >= 50) then
              return ((if ((n == 50) or ((n % 10) == 0)) then
                ""
              else
                (format_spellout_numbering_m((n % 100)) + " و ")
              end) + "خمسون")
            end
            if (n >= 40) then
              return ((if ((n == 40) or ((n % 10) == 0)) then
                ""
              else
                (format_spellout_numbering_m((n % 100)) + " و ")
              end) + "أربعون")
            end
            if (n >= 30) then
              return ((if ((n == 30) or ((n % 10) == 0)) then
                ""
              else
                (format_spellout_numbering_m((n % 100)) + " و ")
              end) + "ثلاثون")
            end
            if (n >= 20) then
              return ((if ((n == 20) or ((n % 10) == 0)) then
                ""
              else
                (format_spellout_numbering_m((n % 100)) + " و ")
              end) + "عشرون")
            end
            return (format_spellout_numbering_m((n % 100)) + " عشر") if (n >= 13)
            return "إثنا عشر" if (n >= 12)
            return "إحدى عشر" if (n >= 11)
            return "عشرة" if (n >= 10)
            return "تسعة" if (n >= 9)
            return "ثمانية" if (n >= 8)
            return "سبعة" if (n >= 7)
            return "ستة" if (n >= 6)
            return "خمسة" if (n >= 5)
            return "أربعة" if (n >= 4)
            return "ثلاثةة" if (n >= 3)
            return "إثنانة" if (n >= 2)
            return "واحدة" if (n >= 1)
            return "صفر" if (n >= 0)
          end
          private(:format_spellout_numbering_m)
          def format_spellout_cardinal_masculine(n)
            is_fractional = (n != n.floor)
            return ("ناقص " + format_spellout_cardinal_masculine(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return (((format_spellout_numbering_m(n.floor) + " فاصل ") + format_spellout_cardinal_masculine((n % 10))) + " ")
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((format_spellout_numbering_m((n / 10000000000000000).floor) + " بليار") + (if ((n == 2000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_numbering_m((n % 10000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("بليار" + (if ((n == 1000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_numbering_m((n % 1000000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_numbering_m((n / 10000000000000).floor) + " بليون") + (if ((n == 2000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_numbering_m((n % 10000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("بليون" + (if ((n == 1000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_numbering_m((n % 1000000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_numbering_m((n / 10000000000).floor) + " مليار") + (if ((n == 2000000000) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_numbering_m((n % 10000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("مليار" + (if ((n == 1000000000) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_numbering_m((n % 1000000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_numbering_m((n / 10000000).floor) + " مليون") + (if ((n == 2000000) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_numbering_m((n % 10000000)))
              end))
            end
            if (n >= 1000000) then
              return ("مليون" + (if ((n == 1000000) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_numbering_m((n % 1000000)))
              end))
            end
            if (n >= 11000) then
              return ((format_spellout_numbering_m((n / 1000000).floor) + " ألف") + (if ((n == 11000) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_numbering_m((n % 1000000)))
              end))
            end
            if (n >= 3000) then
              return ((format_spellout_numbering((n / 10000).floor) + " آلاف") + (if ((n == 3000) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_numbering_m((n % 10000)))
              end))
            end
            if (n >= 2000) then
              return ("ألفي" + (if ((n == 2000) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_numbering_m((n % 10000)))
              end))
            end
            if (n >= 1000) then
              return ("ألف" + (if ((n == 1000) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_numbering_m((n % 1000)))
              end))
            end
            if (n >= 300) then
              return ((format_spellout_numbering((n / 1000).floor) + " مائة") + (if ((n == 300) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_numbering_m((n % 1000)))
              end))
            end
            if (n >= 200) then
              return ("مائتان" + (if ((n == 200) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_numbering_m((n % 1000)))
              end))
            end
            if (n >= 100) then
              return ("مائة" + (if ((n == 100) or ((n % 10) == 0)) then
                ""
              else
                (" و " + format_spellout_numbering_m((n % 100)))
              end))
            end
            if (n >= 90) then
              return ((if ((n == 90) or ((n % 10) == 0)) then
                ""
              else
                (format_spellout_numbering_m((n % 100)) + " و ")
              end) + "تسعون")
            end
            if (n >= 80) then
              return ((if ((n == 80) or ((n % 10) == 0)) then
                ""
              else
                (format_spellout_numbering_m((n % 100)) + " و ")
              end) + "ثمانون")
            end
            if (n >= 70) then
              return ((if ((n == 70) or ((n % 10) == 0)) then
                ""
              else
                (format_spellout_numbering_m((n % 100)) + " و ")
              end) + "سبعون")
            end
            if (n >= 60) then
              return ((if ((n == 60) or ((n % 10) == 0)) then
                ""
              else
                (format_spellout_numbering_m((n % 100)) + " و ")
              end) + "ستون")
            end
            if (n >= 50) then
              return ((if ((n == 50) or ((n % 10) == 0)) then
                ""
              else
                (format_spellout_numbering_m((n % 100)) + " و ")
              end) + "خمسون")
            end
            if (n >= 40) then
              return ((if ((n == 40) or ((n % 10) == 0)) then
                ""
              else
                (format_spellout_numbering_m((n % 100)) + " و ")
              end) + "أربعون")
            end
            if (n >= 30) then
              return ((if ((n == 30) or ((n % 10) == 0)) then
                ""
              else
                (format_spellout_numbering_m((n % 100)) + " و ")
              end) + "ثلاثون")
            end
            if (n >= 20) then
              return ((if ((n == 20) or ((n % 10) == 0)) then
                ""
              else
                (format_spellout_numbering_m((n % 100)) + " و ")
              end) + "عشرون")
            end
            if (n >= 13) then
              return (format_spellout_cardinal_masculine((n % 100)) + " عشر")
            end
            return "إثنا عشر" if (n >= 12)
            return "إحدى عشر" if (n >= 11)
            return "عشرة" if (n >= 10)
            return "تسعة" if (n >= 9)
            return "ثمانية" if (n >= 8)
            return "سبعة" if (n >= 7)
            return "ستة" if (n >= 6)
            return "خمسة" if (n >= 5)
            return "أربعة" if (n >= 4)
            return "ثلاثة" if (n >= 3)
            return "إثنان" if (n >= 2)
            return "واحد" if (n >= 1)
            return "صفر" if (n >= 0)
          end
        end
      end
      
      class Arabic::Ordinal
        class << self
          def format_digits_ordinal(n)
            return ("−" + format_digits_ordinal(-n)) if (n < 0)
            return (n.to_s + ".") if (n >= 0)
          end
        end
      end
    end
  end
end