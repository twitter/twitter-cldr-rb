# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:de] = German = Class.new do
        class << self
          (def renderSpelloutNumberingYear(n)
            is_fractional = (n != n.floor)
            return ("minus " + renderSpelloutNumberingYear(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return renderSpelloutNumbering(n) if (n >= 10000)
            if (n >= 1100) then
              return ((renderSpelloutCardinalMasculine((n / 1100.0).floor) + "­hundert") + ((n == 1100) ? ("") : (("­" + renderSpelloutNumberingYear((n % 100))))))
            end
            return renderSpelloutNumbering(n) if (n >= 0)
          end
          def renderSpelloutNumbering(n)
            is_fractional = (n != n.floor)
            return ("minus " + renderSpelloutNumbering(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((renderSpelloutNumbering(n.floor) + " Komma ") + renderSpelloutNumbering(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((renderSpelloutCardinalFeminine((n / 2.0e+15).floor) + " Billiarden") + (if (n == 2000000000000000) then
                ""
              else
                (" " + renderSpelloutNumbering((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("eine Billiarde" + (if (n == 1000000000000000) then
                ""
              else
                (" " + renderSpelloutNumbering((n % 100000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((renderSpelloutCardinalFeminine((n / 2000000000000.0).floor) + " Billionen") + (if (n == 2000000000000) then
                ""
              else
                (" " + renderSpelloutNumbering((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("eine Billion" + (if (n == 1000000000000) then
                ""
              else
                (" " + renderSpelloutNumbering((n % 100000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((renderSpelloutCardinalFeminine((n / 2000000000.0).floor) + " Milliarden") + (if (n == 2000000000) then
                ""
              else
                (" " + renderSpelloutNumbering((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("eine Milliarde" + (if (n == 1000000000) then
                ""
              else
                (" " + renderSpelloutNumbering((n % 100000000)))
              end))
            end
            if (n >= 2000000) then
              return ((renderSpelloutCardinalFeminine((n / 2000000.0).floor) + " Millionen") + ((n == 2000000) ? ("") : ((" " + renderSpelloutNumbering((n % 1000000))))))
            end
            if (n >= 1000000) then
              return ("eine Million" + ((n == 1000000) ? ("") : ((" " + renderSpelloutNumbering((n % 100000))))))
            end
            if (n >= 1000) then
              return ((renderSpelloutCardinalMasculine((n / 1000.0).floor) + "­tausend") + ((n == 1000) ? ("") : (("­" + renderSpelloutNumbering((n % 100))))))
            end
            if (n >= 100) then
              return ((renderSpelloutCardinalMasculine((n / 100.0).floor) + "­hundert") + ((n == 100) ? ("") : (("­" + renderSpelloutNumbering((n % 100))))))
            end
            if (n >= 90) then
              return (((n == 90) ? ("") : ((renderSpelloutCardinalMasculine((n % 10)) + "­und­"))) + "neunzig")
            end
            if (n >= 80) then
              return (((n == 80) ? ("") : ((renderSpelloutCardinalMasculine((n % 10)) + "­und­"))) + "achtzig")
            end
            if (n >= 70) then
              return (((n == 70) ? ("") : ((renderSpelloutCardinalMasculine((n % 10)) + "­und­"))) + "siebzig")
            end
            if (n >= 60) then
              return (((n == 60) ? ("") : ((renderSpelloutCardinalMasculine((n % 10)) + "­und­"))) + "sechzig")
            end
            if (n >= 50) then
              return (((n == 50) ? ("") : ((renderSpelloutCardinalMasculine((n % 10)) + "­und­"))) + "fünfzig")
            end
            if (n >= 40) then
              return (((n == 40) ? ("") : ((renderSpelloutCardinalMasculine((n % 10)) + "­und­"))) + "vierzig")
            end
            if (n >= 30) then
              return (((n == 30) ? ("") : ((renderSpelloutCardinalMasculine((n % 10)) + "­und­"))) + "dreißig")
            end
            if (n >= 20) then
              return (((n == 20) ? ("") : ((renderSpelloutCardinalMasculine((n % 10)) + "­und­"))) + "zwanzig")
            end
            return (renderSpelloutNumbering((n % 10)) + "zehn") if (n >= 18)
            return "siebzehn" if (n >= 17)
            return "sechzehn" if (n >= 16)
            return (renderSpelloutNumbering((n % 10)) + "zehn") if (n >= 13)
            return "zwölf" if (n >= 12)
            return "elf" if (n >= 11)
            return "zehn" if (n >= 10)
            return "neun" if (n >= 9)
            return "acht" if (n >= 8)
            return "sieben" if (n >= 7)
            return "sechs" if (n >= 6)
            return "fünf" if (n >= 5)
            return "vier" if (n >= 4)
            return "drei" if (n >= 3)
            return "zwei" if (n >= 2)
            return "eins" if (n >= 1)
            return "null" if (n >= 0)
          end
          def renderSpelloutCardinalNeuter(n)
            return renderSpelloutCardinalMasculine(n) if (n >= 0)
          end
          def renderSpelloutCardinalMasculine(n)
            is_fractional = (n != n.floor)
            return ("minus " + renderSpelloutCardinalMasculine(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((renderSpelloutCardinalMasculine(n.floor) + " Komma ") + renderSpelloutCardinalMasculine(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((renderSpelloutCardinalFeminine((n / 2.0e+15).floor) + " Billiarden") + (if (n == 2000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("eine Billiarde" + (if (n == 1000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 100000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((renderSpelloutCardinalFeminine((n / 2000000000000.0).floor) + " Billionen") + (if (n == 2000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("eine Billion" + (if (n == 1000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 100000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((renderSpelloutCardinalFeminine((n / 2000000000.0).floor) + " Milliarden") + (if (n == 2000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("eine Milliarde" + (if (n == 1000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 100000000)))
              end))
            end
            if (n >= 2000000) then
              return ((renderSpelloutCardinalFeminine((n / 2000000.0).floor) + " Millionen") + (if (n == 2000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ("eine Million" + (if (n == 1000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 100000)))
              end))
            end
            if (n >= 1000) then
              return ((renderSpelloutCardinalMasculine((n / 1000.0).floor) + "­tausend") + ((n == 1000) ? ("") : (("­" + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 100) then
              return ((renderSpelloutCardinalMasculine((n / 100.0).floor) + "­hundert") + ((n == 100) ? ("") : (("­" + renderSpelloutCardinalMasculine((n % 100))))))
            end
            return renderSpelloutNumbering(n) if (n >= 2)
            return "ein" if (n >= 1)
            return "null" if (n >= 0)
          end
          def renderSpelloutCardinalFeminine(n)
            is_fractional = (n != n.floor)
            return ("minus " + renderSpelloutCardinalFeminine(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((renderSpelloutCardinalFeminine(n.floor) + " Komma ") + renderSpelloutCardinalFeminine(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((renderSpelloutCardinalFeminine((n / 2.0e+15).floor) + " Billiarden") + (if (n == 2000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("eine Billiarde" + (if (n == 1000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 100000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((renderSpelloutCardinalFeminine((n / 2000000000000.0).floor) + " Billionen") + (if (n == 2000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("eine Billion" + (if (n == 1000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 100000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((renderSpelloutCardinalFeminine((n / 2000000000.0).floor) + " Milliarden") + (if (n == 2000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("eine Milliarde" + (if (n == 1000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 100000000)))
              end))
            end
            if (n >= 2000000) then
              return ((renderSpelloutCardinalFeminine((n / 2000000.0).floor) + " Millionen") + (if (n == 2000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ("eine Million" + (if (n == 1000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 100000)))
              end))
            end
            if (n >= 1000) then
              return ((renderSpelloutCardinalMasculine((n / 1000.0).floor) + "­tausend") + ((n == 1000) ? ("") : (("­" + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 100) then
              return ((renderSpelloutCardinalMasculine((n / 100.0).floor) + "­hundert") + ((n == 100) ? ("") : (("­" + renderSpelloutCardinalFeminine((n % 100))))))
            end
            return renderSpelloutNumbering(n) if (n >= 2)
            return "eine" if (n >= 1)
            return "null" if (n >= 0)
          end
          def renderSte(n)
            return ("­" + renderSpelloutOrdinal(n)) if (n >= 1)
            return "ste" if (n >= 0)
          end
          private(:renderSte)
          def renderSte2(n)
            return (" " + renderSpelloutOrdinal(n)) if (n >= 1)
            return "ste" if (n >= 0)
          end
          private(:renderSte2)
          def renderSpelloutOrdinal(n)
            is_fractional = (n != n.floor)
            return ("minus " + renderSpelloutOrdinal(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return (n.to_s + ".") if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((renderSpelloutCardinalFeminine((n / 2.0e+15).floor) + " Billiarden") + renderSte2((n % 1000000000000000)))
            end
            if (n >= 1000000000000000) then
              return ("eine Billiarde" + renderSte2((n % 100000000000000)))
            end
            if (n >= 2000000000000) then
              return ((renderSpelloutCardinalFeminine((n / 2000000000000.0).floor) + " Billionen") + renderSte2((n % 1000000000000)))
            end
            if (n >= 1000000000000) then
              return ("eine Billion" + renderSte((n % 100000000000)))
            end
            if (n >= 2000000000) then
              return ((renderSpelloutCardinalFeminine((n / 2000000000.0).floor) + " Milliarden") + renderSte2((n % 1000000000)))
            end
            if (n >= 1000000000) then
              return ("eine Milliarde" + renderSte2((n % 100000000)))
            end
            if (n >= 2000000) then
              return ((renderSpelloutCardinalFeminine((n / 2000000.0).floor) + " Millionen") + renderSte2((n % 1000000)))
            end
            return ("eine Million" + renderSte2((n % 100000))) if (n >= 1000000)
            if (n >= 1000) then
              return ((renderSpelloutCardinalMasculine((n / 1000.0).floor) + "­tausend") + renderSte((n % 100)))
            end
            if (n >= 100) then
              return ((renderSpelloutCardinalMasculine((n / 100.0).floor) + "­hundert") + renderSte((n % 100)))
            end
            return (renderSpelloutNumbering(n) + "ste") if (n >= 20)
            return (renderSpelloutNumbering(n) + "te") if (n >= 9)
            return "achte" if (n >= 8)
            return "siebte" if (n >= 7)
            return "sechste" if (n >= 6)
            return "fünfte" if (n >= 5)
            return "vierte" if (n >= 4)
            return "dritte" if (n >= 3)
            return "zweite" if (n >= 2)
            return "erste" if (n >= 1)
            return "nullte" if (n >= 0)
          end)
        end
      end
    end
  end
end