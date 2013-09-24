# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:ar] = Arabic = Class.new do
        class << self
          (def renderSpelloutNumberingYear(n)
            is_fractional = (n != n.floor)
            return n.to_s if is_fractional and (n > 1)
            return renderSpelloutNumbering(n) if (n >= 0)
          end
          def renderSpelloutNumbering(n)
            is_fractional = (n != n.floor)
            return ("ناقص " + renderSpelloutNumbering(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((renderSpelloutNumbering(n.floor) + " فاصل ") + renderSpelloutNumbering(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((renderSpelloutNumberingM((n / 2.0e+15).floor) + " بليار") + (if (n == 2000000000000000) then
                ""
              else
                (" و " + renderSpelloutNumbering((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("بليار" + (if (n == 1000000000000000) then
                ""
              else
                (" و " + renderSpelloutNumbering((n % 100000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((renderSpelloutNumberingM((n / 2000000000000.0).floor) + " بليون") + (if (n == 2000000000000) then
                ""
              else
                (" و " + renderSpelloutNumbering((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("بليون" + (if (n == 1000000000000) then
                ""
              else
                (" و " + renderSpelloutNumbering((n % 100000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((renderSpelloutNumberingM((n / 2000000000.0).floor) + " مليار") + (if (n == 2000000000) then
                ""
              else
                (" و " + renderSpelloutNumbering((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("مليار" + (if (n == 1000000000) then
                ""
              else
                (" و " + renderSpelloutNumbering((n % 100000000)))
              end))
            end
            if (n >= 2000000) then
              return ((renderSpelloutNumberingM((n / 2000000.0).floor) + " مليون") + ((n == 2000000) ? ("") : ((" و " + renderSpelloutNumbering((n % 1000000))))))
            end
            if (n >= 1000000) then
              return ("مليون" + ((n == 1000000) ? ("") : ((" و " + renderSpelloutNumbering((n % 100000))))))
            end
            if (n >= 11000) then
              return ((renderSpelloutNumberingM((n / 11000.0).floor) + " ألف") + ((n == 11000) ? ("") : ((" و " + renderSpelloutNumbering((n % 1000))))))
            end
            if (n >= 3000) then
              return ((renderSpelloutNumbering((n / 3000.0).floor) + " آلاف") + ((n == 3000) ? ("") : ((" و " + renderSpelloutNumbering((n % 1000))))))
            end
            if (n >= 2000) then
              return ("ألفين" + ((n == 2000) ? ("") : ((" و " + renderSpelloutNumbering((n % 1000))))))
            end
            if (n >= 1000) then
              return ("ألف" + ((n == 1000) ? ("") : ((" و " + renderSpelloutNumbering((n % 100))))))
            end
            if (n >= 300) then
              return ((renderSpelloutNumbering((n / 300.0).floor) + " مائة") + ((n == 300) ? ("") : ((" و " + renderSpelloutNumbering((n % 100))))))
            end
            if (n >= 200) then
              return ("مائتان" + ((n == 200) ? ("") : ((" و " + renderSpelloutNumbering((n % 100))))))
            end
            if (n >= 100) then
              return ("مائة" + ((n == 100) ? ("") : ((" و " + renderSpelloutNumbering((n % 100))))))
            end
            if (n >= 90) then
              return (((n == 90) ? ("") : ((renderSpelloutNumbering((n % 10)) + " و "))) + "تسعون")
            end
            if (n >= 80) then
              return (((n == 80) ? ("") : ((renderSpelloutNumbering((n % 10)) + " و "))) + "ثمانون")
            end
            if (n >= 70) then
              return (((n == 70) ? ("") : ((renderSpelloutNumbering((n % 10)) + " و "))) + "سبعون")
            end
            if (n >= 60) then
              return (((n == 60) ? ("") : ((renderSpelloutNumbering((n % 10)) + " و "))) + "ستون")
            end
            if (n >= 50) then
              return (((n == 50) ? ("") : ((renderSpelloutNumbering((n % 10)) + " و "))) + "خمسون")
            end
            if (n >= 40) then
              return (((n == 40) ? ("") : ((renderSpelloutNumbering((n % 10)) + " و "))) + "أربعون")
            end
            if (n >= 30) then
              return (((n == 30) ? ("") : ((renderSpelloutNumbering((n % 10)) + " و "))) + "ثلاثون")
            end
            if (n >= 20) then
              return (((n == 20) ? ("") : ((renderSpelloutNumbering((n % 10)) + " و "))) + "عشرون")
            end
            return (renderSpelloutNumbering((n % 10)) + " عشر") if (n >= 13)
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
          def renderSpelloutCardinalFeminine(n)
            is_fractional = (n != n.floor)
            return ("ناقص " + renderSpelloutCardinalFeminine(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((renderSpelloutCardinalFeminine(n.floor) + " فاصل ") + renderSpelloutCardinalFeminine(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((renderSpelloutNumberingM((n / 2.0e+15).floor) + " بليار") + (if (n == 2000000000000000) then
                ""
              else
                (" و " + renderSpelloutNumbering((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("بليار" + (if (n == 1000000000000000) then
                ""
              else
                (" و " + renderSpelloutNumbering((n % 100000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((renderSpelloutNumberingM((n / 2000000000000.0).floor) + " بليون") + (if (n == 2000000000000) then
                ""
              else
                (" و " + renderSpelloutNumbering((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("بليون" + (if (n == 1000000000000) then
                ""
              else
                (" و " + renderSpelloutNumbering((n % 100000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((renderSpelloutNumberingM((n / 2000000000.0).floor) + " مليار") + (if (n == 2000000000) then
                ""
              else
                (" و " + renderSpelloutNumbering((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("مليار" + (if (n == 1000000000) then
                ""
              else
                (" و " + renderSpelloutNumbering((n % 100000000)))
              end))
            end
            if (n >= 2000000) then
              return ((renderSpelloutNumberingM((n / 2000000.0).floor) + " مليون") + ((n == 2000000) ? ("") : ((" و " + renderSpelloutNumbering((n % 1000000))))))
            end
            if (n >= 1000000) then
              return ("مليون" + ((n == 1000000) ? ("") : ((" و " + renderSpelloutNumbering((n % 100000))))))
            end
            if (n >= 11000) then
              return ((renderSpelloutNumberingM((n / 11000.0).floor) + " ألف") + ((n == 11000) ? ("") : ((" و " + renderSpelloutNumbering((n % 1000))))))
            end
            if (n >= 3000) then
              return ((renderSpelloutNumbering((n / 3000.0).floor) + " آلاف") + ((n == 3000) ? ("") : ((" و " + renderSpelloutNumbering((n % 1000))))))
            end
            if (n >= 2000) then
              return ("ألفي" + ((n == 2000) ? ("") : ((" و " + renderSpelloutNumbering((n % 1000))))))
            end
            if (n >= 1000) then
              return ("ألف" + ((n == 1000) ? ("") : ((" و " + renderSpelloutNumbering((n % 100))))))
            end
            if (n >= 300) then
              return ((renderSpelloutNumbering((n / 300.0).floor) + " مائة") + ((n == 300) ? ("") : ((" و " + renderSpelloutNumbering((n % 100))))))
            end
            if (n >= 200) then
              return ("مائتان" + ((n == 200) ? ("") : ((" و " + renderSpelloutNumbering((n % 100))))))
            end
            if (n >= 100) then
              return ("مائة" + ((n == 100) ? ("") : ((" و " + renderSpelloutNumbering((n % 100))))))
            end
            if (n >= 90) then
              return (((n == 90) ? ("") : ((renderSpelloutNumbering((n % 10)) + " و "))) + "تسعون")
            end
            if (n >= 80) then
              return (((n == 80) ? ("") : ((renderSpelloutNumbering((n % 10)) + " و "))) + "ثمانون")
            end
            if (n >= 70) then
              return (((n == 70) ? ("") : ((renderSpelloutNumbering((n % 10)) + " و "))) + "سبعون")
            end
            if (n >= 60) then
              return (((n == 60) ? ("") : ((renderSpelloutNumbering((n % 10)) + " و "))) + "ستون")
            end
            if (n >= 50) then
              return (((n == 50) ? ("") : ((renderSpelloutNumbering((n % 10)) + " و "))) + "خمسون")
            end
            if (n >= 40) then
              return (((n == 40) ? ("") : ((renderSpelloutNumbering((n % 10)) + " و "))) + "أربعون")
            end
            if (n >= 30) then
              return (((n == 30) ? ("") : ((renderSpelloutNumbering((n % 10)) + " و "))) + "ثلاثون")
            end
            if (n >= 20) then
              return (((n == 20) ? ("") : ((renderSpelloutNumbering((n % 10)) + " و "))) + "عشرون")
            end
            return (renderSpelloutNumbering((n % 10)) + " عشر") if (n >= 13)
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
          def renderSpelloutNumberingM(n)
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((renderSpelloutNumberingM((n / 2.0e+15).floor) + " بليار") + (if (n == 2000000000000000) then
                ""
              else
                (" و " + renderSpelloutNumberingM((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("بليار" + (if (n == 1000000000000000) then
                ""
              else
                (" و " + renderSpelloutNumberingM((n % 100000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((renderSpelloutNumberingM((n / 2000000000000.0).floor) + " بليون") + (if (n == 2000000000000) then
                ""
              else
                (" و " + renderSpelloutNumberingM((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("بليون" + (if (n == 1000000000000) then
                ""
              else
                (" و " + renderSpelloutNumberingM((n % 100000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((renderSpelloutNumberingM((n / 2000000000.0).floor) + " مليار") + (if (n == 2000000000) then
                ""
              else
                (" و " + renderSpelloutNumberingM((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("مليار" + (if (n == 1000000000) then
                ""
              else
                (" و " + renderSpelloutNumberingM((n % 100000000)))
              end))
            end
            if (n >= 2000000) then
              return ((renderSpelloutNumberingM((n / 2000000.0).floor) + " مليون") + ((n == 2000000) ? ("") : ((" و " + renderSpelloutNumberingM((n % 1000000))))))
            end
            if (n >= 1000000) then
              return ("مليون" + ((n == 1000000) ? ("") : ((" و " + renderSpelloutNumberingM((n % 100000))))))
            end
            if (n >= 11000) then
              return ((renderSpelloutNumberingM((n / 11000.0).floor) + " ألف") + ((n == 11000) ? ("") : ((" و " + renderSpelloutNumberingM((n % 1000))))))
            end
            if (n >= 3000) then
              return ((renderSpelloutNumbering((n / 3000.0).floor) + " آلاف") + ((n == 3000) ? ("") : ((" و " + renderSpelloutNumberingM((n % 1000))))))
            end
            if (n >= 2000) then
              return ("ألفي" + ((n == 2000) ? ("") : ((" و " + renderSpelloutNumberingM((n % 1000))))))
            end
            if (n >= 1000) then
              return ("ألف" + ((n == 1000) ? ("") : ((" و " + renderSpelloutNumberingM((n % 100))))))
            end
            if (n >= 300) then
              return ((renderSpelloutNumbering((n / 300.0).floor) + " مائة") + ((n == 300) ? ("") : ((" و " + renderSpelloutNumberingM((n % 100))))))
            end
            if (n >= 200) then
              return ("مائتان" + ((n == 200) ? ("") : ((" و " + renderSpelloutNumberingM((n % 100))))))
            end
            if (n >= 100) then
              return ("مائة" + ((n == 100) ? ("") : ((" و " + renderSpelloutNumberingM((n % 100))))))
            end
            if (n >= 90) then
              return (((n == 90) ? ("") : ((renderSpelloutNumberingM((n % 10)) + " و "))) + "تسعون")
            end
            if (n >= 80) then
              return (((n == 80) ? ("") : ((renderSpelloutNumberingM((n % 10)) + " و "))) + "ثمانون")
            end
            if (n >= 70) then
              return (((n == 70) ? ("") : ((renderSpelloutNumberingM((n % 10)) + " و "))) + "سبعون")
            end
            if (n >= 60) then
              return (((n == 60) ? ("") : ((renderSpelloutNumberingM((n % 10)) + " و "))) + "ستون")
            end
            if (n >= 50) then
              return (((n == 50) ? ("") : ((renderSpelloutNumberingM((n % 10)) + " و "))) + "خمسون")
            end
            if (n >= 40) then
              return (((n == 40) ? ("") : ((renderSpelloutNumberingM((n % 10)) + " و "))) + "أربعون")
            end
            if (n >= 30) then
              return (((n == 30) ? ("") : ((renderSpelloutNumberingM((n % 10)) + " و "))) + "ثلاثون")
            end
            if (n >= 20) then
              return (((n == 20) ? ("") : ((renderSpelloutNumberingM((n % 10)) + " و "))) + "عشرون")
            end
            return (renderSpelloutNumberingM((n % 10)) + " عشر") if (n >= 13)
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
          private(:renderSpelloutNumberingM)
          def renderSpelloutCardinalMasculine(n)
            is_fractional = (n != n.floor)
            return ("ناقص " + renderSpelloutCardinalMasculine(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return (((renderSpelloutNumberingM(n.floor) + " فاصل ") + renderSpelloutCardinalMasculine(n.to_s.gsub(/d*./, "").to_f)) + " ")
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((renderSpelloutNumberingM((n / 2.0e+15).floor) + " بليار") + (if (n == 2000000000000000) then
                ""
              else
                (" و " + renderSpelloutNumberingM((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("بليار" + (if (n == 1000000000000000) then
                ""
              else
                (" و " + renderSpelloutNumberingM((n % 100000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((renderSpelloutNumberingM((n / 2000000000000.0).floor) + " بليون") + (if (n == 2000000000000) then
                ""
              else
                (" و " + renderSpelloutNumberingM((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("بليون" + (if (n == 1000000000000) then
                ""
              else
                (" و " + renderSpelloutNumberingM((n % 100000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((renderSpelloutNumberingM((n / 2000000000.0).floor) + " مليار") + (if (n == 2000000000) then
                ""
              else
                (" و " + renderSpelloutNumberingM((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("مليار" + (if (n == 1000000000) then
                ""
              else
                (" و " + renderSpelloutNumberingM((n % 100000000)))
              end))
            end
            if (n >= 2000000) then
              return ((renderSpelloutNumberingM((n / 2000000.0).floor) + " مليون") + ((n == 2000000) ? ("") : ((" و " + renderSpelloutNumberingM((n % 1000000))))))
            end
            if (n >= 1000000) then
              return ("مليون" + ((n == 1000000) ? ("") : ((" و " + renderSpelloutNumberingM((n % 100000))))))
            end
            if (n >= 11000) then
              return ((renderSpelloutNumberingM((n / 11000.0).floor) + " ألف") + ((n == 11000) ? ("") : ((" و " + renderSpelloutNumberingM((n % 1000))))))
            end
            if (n >= 3000) then
              return ((renderSpelloutNumbering((n / 3000.0).floor) + " آلاف") + ((n == 3000) ? ("") : ((" و " + renderSpelloutNumberingM((n % 1000))))))
            end
            if (n >= 2000) then
              return ("ألفي" + ((n == 2000) ? ("") : ((" و " + renderSpelloutNumberingM((n % 1000))))))
            end
            if (n >= 1000) then
              return ("ألف" + ((n == 1000) ? ("") : ((" و " + renderSpelloutNumberingM((n % 100))))))
            end
            if (n >= 300) then
              return ((renderSpelloutNumbering((n / 300.0).floor) + " مائة") + ((n == 300) ? ("") : ((" و " + renderSpelloutNumberingM((n % 100))))))
            end
            if (n >= 200) then
              return ("مائتان" + ((n == 200) ? ("") : ((" و " + renderSpelloutNumberingM((n % 100))))))
            end
            if (n >= 100) then
              return ("مائة" + ((n == 100) ? ("") : ((" و " + renderSpelloutNumberingM((n % 100))))))
            end
            if (n >= 90) then
              return (((n == 90) ? ("") : ((renderSpelloutNumberingM((n % 10)) + " و "))) + "تسعون")
            end
            if (n >= 80) then
              return (((n == 80) ? ("") : ((renderSpelloutNumberingM((n % 10)) + " و "))) + "ثمانون")
            end
            if (n >= 70) then
              return (((n == 70) ? ("") : ((renderSpelloutNumberingM((n % 10)) + " و "))) + "سبعون")
            end
            if (n >= 60) then
              return (((n == 60) ? ("") : ((renderSpelloutNumberingM((n % 10)) + " و "))) + "ستون")
            end
            if (n >= 50) then
              return (((n == 50) ? ("") : ((renderSpelloutNumberingM((n % 10)) + " و "))) + "خمسون")
            end
            if (n >= 40) then
              return (((n == 40) ? ("") : ((renderSpelloutNumberingM((n % 10)) + " و "))) + "أربعون")
            end
            if (n >= 30) then
              return (((n == 30) ? ("") : ((renderSpelloutNumberingM((n % 10)) + " و "))) + "ثلاثون")
            end
            if (n >= 20) then
              return (((n == 20) ? ("") : ((renderSpelloutNumberingM((n % 10)) + " و "))) + "عشرون")
            end
            return (renderSpelloutCardinalMasculine((n % 10)) + " عشر") if (n >= 13)
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
          def renderDigitsOrdinal(n)
            return ("−" + renderDigitsOrdinal(-n)) if (n < 0)
            return (n.to_s + ".") if (n >= 0)
          end)
        end
      end
    end
  end
end