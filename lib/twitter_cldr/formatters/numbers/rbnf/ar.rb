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
              return ((format_spellout_numbering(n.floor) + " فاصل ") + format_spellout_numbering(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((format_spellout_numbering_m((n / 2.0e+15).floor) + " بليار") + (if (n == 2000000000000000) then
                ""
              else
                (" و " + format_spellout_numbering((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("بليار" + (if (n == 1000000000000000) then
                ""
              else
                (" و " + format_spellout_numbering((n % 100000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_numbering_m((n / 2000000000000.0).floor) + " بليون") + (if (n == 2000000000000) then
                ""
              else
                (" و " + format_spellout_numbering((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("بليون" + (if (n == 1000000000000) then
                ""
              else
                (" و " + format_spellout_numbering((n % 100000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_numbering_m((n / 2000000000.0).floor) + " مليار") + (if (n == 2000000000) then
                ""
              else
                (" و " + format_spellout_numbering((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("مليار" + (if (n == 1000000000) then
                ""
              else
                (" و " + format_spellout_numbering((n % 100000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_numbering_m((n / 2000000.0).floor) + " مليون") + (if (n == 2000000) then
                ""
              else
                (" و " + format_spellout_numbering((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ("مليون" + ((n == 1000000) ? ("") : ((" و " + format_spellout_numbering((n % 100000))))))
            end
            if (n >= 11000) then
              return ((format_spellout_numbering_m((n / 11000.0).floor) + " ألف") + ((n == 11000) ? ("") : ((" و " + format_spellout_numbering((n % 1000))))))
            end
            if (n >= 3000) then
              return ((format_spellout_numbering((n / 3000.0).floor) + " آلاف") + ((n == 3000) ? ("") : ((" و " + format_spellout_numbering((n % 1000))))))
            end
            if (n >= 2000) then
              return ("ألفين" + ((n == 2000) ? ("") : ((" و " + format_spellout_numbering((n % 1000))))))
            end
            if (n >= 1000) then
              return ("ألف" + ((n == 1000) ? ("") : ((" و " + format_spellout_numbering((n % 100))))))
            end
            if (n >= 300) then
              return ((format_spellout_numbering((n / 300.0).floor) + " مائة") + ((n == 300) ? ("") : ((" و " + format_spellout_numbering((n % 100))))))
            end
            if (n >= 200) then
              return ("مائتان" + ((n == 200) ? ("") : ((" و " + format_spellout_numbering((n % 100))))))
            end
            if (n >= 100) then
              return ("مائة" + ((n == 100) ? ("") : ((" و " + format_spellout_numbering((n % 100))))))
            end
            if (n >= 90) then
              return (((n == 90) ? ("") : ((format_spellout_numbering((n % 10)) + " و "))) + "تسعون")
            end
            if (n >= 80) then
              return (((n == 80) ? ("") : ((format_spellout_numbering((n % 10)) + " و "))) + "ثمانون")
            end
            if (n >= 70) then
              return (((n == 70) ? ("") : ((format_spellout_numbering((n % 10)) + " و "))) + "سبعون")
            end
            if (n >= 60) then
              return (((n == 60) ? ("") : ((format_spellout_numbering((n % 10)) + " و "))) + "ستون")
            end
            if (n >= 50) then
              return (((n == 50) ? ("") : ((format_spellout_numbering((n % 10)) + " و "))) + "خمسون")
            end
            if (n >= 40) then
              return (((n == 40) ? ("") : ((format_spellout_numbering((n % 10)) + " و "))) + "أربعون")
            end
            if (n >= 30) then
              return (((n == 30) ? ("") : ((format_spellout_numbering((n % 10)) + " و "))) + "ثلاثون")
            end
            if (n >= 20) then
              return (((n == 20) ? ("") : ((format_spellout_numbering((n % 10)) + " و "))) + "عشرون")
            end
            return (format_spellout_numbering((n % 10)) + " عشر") if (n >= 13)
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
              return ((format_spellout_cardinal_feminine(n.floor) + " فاصل ") + format_spellout_cardinal_feminine(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((format_spellout_numbering_m((n / 2.0e+15).floor) + " بليار") + (if (n == 2000000000000000) then
                ""
              else
                (" و " + format_spellout_numbering((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("بليار" + (if (n == 1000000000000000) then
                ""
              else
                (" و " + format_spellout_numbering((n % 100000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_numbering_m((n / 2000000000000.0).floor) + " بليون") + (if (n == 2000000000000) then
                ""
              else
                (" و " + format_spellout_numbering((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("بليون" + (if (n == 1000000000000) then
                ""
              else
                (" و " + format_spellout_numbering((n % 100000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_numbering_m((n / 2000000000.0).floor) + " مليار") + (if (n == 2000000000) then
                ""
              else
                (" و " + format_spellout_numbering((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("مليار" + (if (n == 1000000000) then
                ""
              else
                (" و " + format_spellout_numbering((n % 100000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_numbering_m((n / 2000000.0).floor) + " مليون") + (if (n == 2000000) then
                ""
              else
                (" و " + format_spellout_numbering((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ("مليون" + ((n == 1000000) ? ("") : ((" و " + format_spellout_numbering((n % 100000))))))
            end
            if (n >= 11000) then
              return ((format_spellout_numbering_m((n / 11000.0).floor) + " ألف") + ((n == 11000) ? ("") : ((" و " + format_spellout_numbering((n % 1000))))))
            end
            if (n >= 3000) then
              return ((format_spellout_numbering((n / 3000.0).floor) + " آلاف") + ((n == 3000) ? ("") : ((" و " + format_spellout_numbering((n % 1000))))))
            end
            if (n >= 2000) then
              return ("ألفي" + ((n == 2000) ? ("") : ((" و " + format_spellout_numbering((n % 1000))))))
            end
            if (n >= 1000) then
              return ("ألف" + ((n == 1000) ? ("") : ((" و " + format_spellout_numbering((n % 100))))))
            end
            if (n >= 300) then
              return ((format_spellout_numbering((n / 300.0).floor) + " مائة") + ((n == 300) ? ("") : ((" و " + format_spellout_numbering((n % 100))))))
            end
            if (n >= 200) then
              return ("مائتان" + ((n == 200) ? ("") : ((" و " + format_spellout_numbering((n % 100))))))
            end
            if (n >= 100) then
              return ("مائة" + ((n == 100) ? ("") : ((" و " + format_spellout_numbering((n % 100))))))
            end
            if (n >= 90) then
              return (((n == 90) ? ("") : ((format_spellout_numbering((n % 10)) + " و "))) + "تسعون")
            end
            if (n >= 80) then
              return (((n == 80) ? ("") : ((format_spellout_numbering((n % 10)) + " و "))) + "ثمانون")
            end
            if (n >= 70) then
              return (((n == 70) ? ("") : ((format_spellout_numbering((n % 10)) + " و "))) + "سبعون")
            end
            if (n >= 60) then
              return (((n == 60) ? ("") : ((format_spellout_numbering((n % 10)) + " و "))) + "ستون")
            end
            if (n >= 50) then
              return (((n == 50) ? ("") : ((format_spellout_numbering((n % 10)) + " و "))) + "خمسون")
            end
            if (n >= 40) then
              return (((n == 40) ? ("") : ((format_spellout_numbering((n % 10)) + " و "))) + "أربعون")
            end
            if (n >= 30) then
              return (((n == 30) ? ("") : ((format_spellout_numbering((n % 10)) + " و "))) + "ثلاثون")
            end
            if (n >= 20) then
              return (((n == 20) ? ("") : ((format_spellout_numbering((n % 10)) + " و "))) + "عشرون")
            end
            return (format_spellout_numbering((n % 10)) + " عشر") if (n >= 13)
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
              return ((format_spellout_numbering_m((n / 2.0e+15).floor) + " بليار") + (if (n == 2000000000000000) then
                ""
              else
                (" و " + format_spellout_numbering_m((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("بليار" + (if (n == 1000000000000000) then
                ""
              else
                (" و " + format_spellout_numbering_m((n % 100000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_numbering_m((n / 2000000000000.0).floor) + " بليون") + (if (n == 2000000000000) then
                ""
              else
                (" و " + format_spellout_numbering_m((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("بليون" + (if (n == 1000000000000) then
                ""
              else
                (" و " + format_spellout_numbering_m((n % 100000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_numbering_m((n / 2000000000.0).floor) + " مليار") + (if (n == 2000000000) then
                ""
              else
                (" و " + format_spellout_numbering_m((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("مليار" + (if (n == 1000000000) then
                ""
              else
                (" و " + format_spellout_numbering_m((n % 100000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_numbering_m((n / 2000000.0).floor) + " مليون") + (if (n == 2000000) then
                ""
              else
                (" و " + format_spellout_numbering_m((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ("مليون" + (if (n == 1000000) then
                ""
              else
                (" و " + format_spellout_numbering_m((n % 100000)))
              end))
            end
            if (n >= 11000) then
              return ((format_spellout_numbering_m((n / 11000.0).floor) + " ألف") + ((n == 11000) ? ("") : ((" و " + format_spellout_numbering_m((n % 1000))))))
            end
            if (n >= 3000) then
              return ((format_spellout_numbering((n / 3000.0).floor) + " آلاف") + ((n == 3000) ? ("") : ((" و " + format_spellout_numbering_m((n % 1000))))))
            end
            if (n >= 2000) then
              return ("ألفي" + ((n == 2000) ? ("") : ((" و " + format_spellout_numbering_m((n % 1000))))))
            end
            if (n >= 1000) then
              return ("ألف" + ((n == 1000) ? ("") : ((" و " + format_spellout_numbering_m((n % 100))))))
            end
            if (n >= 300) then
              return ((format_spellout_numbering((n / 300.0).floor) + " مائة") + ((n == 300) ? ("") : ((" و " + format_spellout_numbering_m((n % 100))))))
            end
            if (n >= 200) then
              return ("مائتان" + ((n == 200) ? ("") : ((" و " + format_spellout_numbering_m((n % 100))))))
            end
            if (n >= 100) then
              return ("مائة" + ((n == 100) ? ("") : ((" و " + format_spellout_numbering_m((n % 100))))))
            end
            if (n >= 90) then
              return (((n == 90) ? ("") : ((format_spellout_numbering_m((n % 10)) + " و "))) + "تسعون")
            end
            if (n >= 80) then
              return (((n == 80) ? ("") : ((format_spellout_numbering_m((n % 10)) + " و "))) + "ثمانون")
            end
            if (n >= 70) then
              return (((n == 70) ? ("") : ((format_spellout_numbering_m((n % 10)) + " و "))) + "سبعون")
            end
            if (n >= 60) then
              return (((n == 60) ? ("") : ((format_spellout_numbering_m((n % 10)) + " و "))) + "ستون")
            end
            if (n >= 50) then
              return (((n == 50) ? ("") : ((format_spellout_numbering_m((n % 10)) + " و "))) + "خمسون")
            end
            if (n >= 40) then
              return (((n == 40) ? ("") : ((format_spellout_numbering_m((n % 10)) + " و "))) + "أربعون")
            end
            if (n >= 30) then
              return (((n == 30) ? ("") : ((format_spellout_numbering_m((n % 10)) + " و "))) + "ثلاثون")
            end
            if (n >= 20) then
              return (((n == 20) ? ("") : ((format_spellout_numbering_m((n % 10)) + " و "))) + "عشرون")
            end
            return (format_spellout_numbering_m((n % 10)) + " عشر") if (n >= 13)
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
              return (((format_spellout_numbering_m(n.floor) + " فاصل ") + format_spellout_cardinal_masculine(n.to_s.gsub(/d*./, "").to_f)) + " ")
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((format_spellout_numbering_m((n / 2.0e+15).floor) + " بليار") + (if (n == 2000000000000000) then
                ""
              else
                (" و " + format_spellout_numbering_m((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("بليار" + (if (n == 1000000000000000) then
                ""
              else
                (" و " + format_spellout_numbering_m((n % 100000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_numbering_m((n / 2000000000000.0).floor) + " بليون") + (if (n == 2000000000000) then
                ""
              else
                (" و " + format_spellout_numbering_m((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("بليون" + (if (n == 1000000000000) then
                ""
              else
                (" و " + format_spellout_numbering_m((n % 100000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_numbering_m((n / 2000000000.0).floor) + " مليار") + (if (n == 2000000000) then
                ""
              else
                (" و " + format_spellout_numbering_m((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("مليار" + (if (n == 1000000000) then
                ""
              else
                (" و " + format_spellout_numbering_m((n % 100000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_numbering_m((n / 2000000.0).floor) + " مليون") + (if (n == 2000000) then
                ""
              else
                (" و " + format_spellout_numbering_m((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ("مليون" + (if (n == 1000000) then
                ""
              else
                (" و " + format_spellout_numbering_m((n % 100000)))
              end))
            end
            if (n >= 11000) then
              return ((format_spellout_numbering_m((n / 11000.0).floor) + " ألف") + ((n == 11000) ? ("") : ((" و " + format_spellout_numbering_m((n % 1000))))))
            end
            if (n >= 3000) then
              return ((format_spellout_numbering((n / 3000.0).floor) + " آلاف") + ((n == 3000) ? ("") : ((" و " + format_spellout_numbering_m((n % 1000))))))
            end
            if (n >= 2000) then
              return ("ألفي" + ((n == 2000) ? ("") : ((" و " + format_spellout_numbering_m((n % 1000))))))
            end
            if (n >= 1000) then
              return ("ألف" + ((n == 1000) ? ("") : ((" و " + format_spellout_numbering_m((n % 100))))))
            end
            if (n >= 300) then
              return ((format_spellout_numbering((n / 300.0).floor) + " مائة") + ((n == 300) ? ("") : ((" و " + format_spellout_numbering_m((n % 100))))))
            end
            if (n >= 200) then
              return ("مائتان" + ((n == 200) ? ("") : ((" و " + format_spellout_numbering_m((n % 100))))))
            end
            if (n >= 100) then
              return ("مائة" + ((n == 100) ? ("") : ((" و " + format_spellout_numbering_m((n % 100))))))
            end
            if (n >= 90) then
              return (((n == 90) ? ("") : ((format_spellout_numbering_m((n % 10)) + " و "))) + "تسعون")
            end
            if (n >= 80) then
              return (((n == 80) ? ("") : ((format_spellout_numbering_m((n % 10)) + " و "))) + "ثمانون")
            end
            if (n >= 70) then
              return (((n == 70) ? ("") : ((format_spellout_numbering_m((n % 10)) + " و "))) + "سبعون")
            end
            if (n >= 60) then
              return (((n == 60) ? ("") : ((format_spellout_numbering_m((n % 10)) + " و "))) + "ستون")
            end
            if (n >= 50) then
              return (((n == 50) ? ("") : ((format_spellout_numbering_m((n % 10)) + " و "))) + "خمسون")
            end
            if (n >= 40) then
              return (((n == 40) ? ("") : ((format_spellout_numbering_m((n % 10)) + " و "))) + "أربعون")
            end
            if (n >= 30) then
              return (((n == 30) ? ("") : ((format_spellout_numbering_m((n % 10)) + " و "))) + "ثلاثون")
            end
            if (n >= 20) then
              return (((n == 20) ? ("") : ((format_spellout_numbering_m((n % 10)) + " و "))) + "عشرون")
            end
            return (format_spellout_cardinal_masculine((n % 10)) + " عشر") if (n >= 13)
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