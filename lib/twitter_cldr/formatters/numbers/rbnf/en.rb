# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:en] = English = Class.new do
        class << self
          (def render2dYear(n)
            return renderSpelloutNumbering(n) if (n >= 10)
            return ("oh-" + renderSpelloutNumbering(n)) if (n >= 1)
            return "hundred" if (n >= 0)
          end
          private(:render2dYear)
          def renderSpelloutNumberingYear(n)
            is_fractional = (n != n.floor)
            return ("minus " + renderSpelloutNumberingYear(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return renderSpelloutNumbering(n) if (n >= 10000)
            if (n >= 9100) then
              return ((renderSpelloutNumberingYear((n / 9100.0).floor) + " ") + render2dYear((n % 100)))
            end
            if (n >= 9010) then
              return ((renderSpelloutNumberingYear((n / 9010.0).floor) + " ") + render2dYear((n % 100)))
            end
            return renderSpelloutNumbering(n) if (n >= 9000)
            if (n >= 8100) then
              return ((renderSpelloutNumberingYear((n / 8100.0).floor) + " ") + render2dYear((n % 100)))
            end
            if (n >= 8010) then
              return ((renderSpelloutNumberingYear((n / 8010.0).floor) + " ") + render2dYear((n % 100)))
            end
            return renderSpelloutNumbering(n) if (n >= 8000)
            if (n >= 7100) then
              return ((renderSpelloutNumberingYear((n / 7100.0).floor) + " ") + render2dYear((n % 100)))
            end
            if (n >= 7010) then
              return ((renderSpelloutNumberingYear((n / 7010.0).floor) + " ") + render2dYear((n % 100)))
            end
            return renderSpelloutNumbering(n) if (n >= 7000)
            if (n >= 6100) then
              return ((renderSpelloutNumberingYear((n / 6100.0).floor) + " ") + render2dYear((n % 100)))
            end
            if (n >= 6010) then
              return ((renderSpelloutNumberingYear((n / 6010.0).floor) + " ") + render2dYear((n % 100)))
            end
            return renderSpelloutNumbering(n) if (n >= 6000)
            if (n >= 5100) then
              return ((renderSpelloutNumberingYear((n / 5100.0).floor) + " ") + render2dYear((n % 100)))
            end
            if (n >= 5010) then
              return ((renderSpelloutNumberingYear((n / 5010.0).floor) + " ") + render2dYear((n % 100)))
            end
            return renderSpelloutNumbering(n) if (n >= 5000)
            if (n >= 4100) then
              return ((renderSpelloutNumberingYear((n / 4100.0).floor) + " ") + render2dYear((n % 100)))
            end
            if (n >= 4010) then
              return ((renderSpelloutNumberingYear((n / 4010.0).floor) + " ") + render2dYear((n % 100)))
            end
            return renderSpelloutNumbering(n) if (n >= 4000)
            if (n >= 3100) then
              return ((renderSpelloutNumberingYear((n / 3100.0).floor) + " ") + render2dYear((n % 100)))
            end
            if (n >= 3010) then
              return ((renderSpelloutNumberingYear((n / 3010.0).floor) + " ") + render2dYear((n % 100)))
            end
            return renderSpelloutNumbering(n) if (n >= 3000)
            if (n >= 2100) then
              return ((renderSpelloutNumberingYear((n / 2100.0).floor) + " ") + render2dYear((n % 100)))
            end
            if (n >= 2010) then
              return ((renderSpelloutNumberingYear((n / 2010.0).floor) + " ") + render2dYear((n % 100)))
            end
            return renderSpelloutNumbering(n) if (n >= 2000)
            if (n >= 1100) then
              return ((renderSpelloutNumberingYear((n / 1100.0).floor) + " ") + render2dYear((n % 100)))
            end
            if (n >= 1010) then
              return ((renderSpelloutNumberingYear((n / 1010.0).floor) + " ") + render2dYear((n % 100)))
            end
            return renderSpelloutNumbering(n) if (n >= 0)
          end
          def renderSpelloutNumbering(n)
            return renderSpelloutCardinal(n) if (n >= 0)
          end
          def renderSpelloutNumberingVerbose(n)
            return renderSpelloutCardinalVerbose(n) if (n >= 0)
          end
          def renderSpelloutCardinal(n)
            is_fractional = (n != n.floor)
            return ("minus " + renderSpelloutCardinal(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((renderSpelloutCardinal(n.floor) + " point ") + renderSpelloutCardinal(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 1000000000000000) then
              return ((renderSpelloutCardinal((n / 1.0e+15).floor) + " quadrillion") + (if (n == 1000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinal((n % 100000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((renderSpelloutCardinal((n / 1000000000000.0).floor) + " trillion") + (if (n == 1000000000000) then
                ""
              else
                (" " + renderSpelloutCardinal((n % 100000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((renderSpelloutCardinal((n / 1000000000.0).floor) + " billion") + (if (n == 1000000000) then
                ""
              else
                (" " + renderSpelloutCardinal((n % 100000000)))
              end))
            end
            if (n >= 1000000) then
              return ((renderSpelloutCardinal((n / 1000000.0).floor) + " million") + ((n == 1000000) ? ("") : ((" " + renderSpelloutCardinal((n % 100000))))))
            end
            if (n >= 1000) then
              return ((renderSpelloutCardinal((n / 1000.0).floor) + " thousand") + ((n == 1000) ? ("") : ((" " + renderSpelloutCardinal((n % 100))))))
            end
            if (n >= 100) then
              return ((renderSpelloutCardinal((n / 100.0).floor) + " hundred") + ((n == 100) ? ("") : ((" " + renderSpelloutCardinal((n % 100))))))
            end
            if (n >= 90) then
              return ("ninety" + ((n == 90) ? ("") : (("-" + renderSpelloutCardinal((n % 10))))))
            end
            if (n >= 80) then
              return ("eighty" + ((n == 80) ? ("") : (("-" + renderSpelloutCardinal((n % 10))))))
            end
            if (n >= 70) then
              return ("seventy" + ((n == 70) ? ("") : (("-" + renderSpelloutCardinal((n % 10))))))
            end
            if (n >= 60) then
              return ("sixty" + ((n == 60) ? ("") : (("-" + renderSpelloutCardinal((n % 10))))))
            end
            if (n >= 50) then
              return ("fifty" + ((n == 50) ? ("") : (("-" + renderSpelloutCardinal((n % 10))))))
            end
            if (n >= 40) then
              return ("forty" + ((n == 40) ? ("") : (("-" + renderSpelloutCardinal((n % 10))))))
            end
            if (n >= 30) then
              return ("thirty" + ((n == 30) ? ("") : (("-" + renderSpelloutCardinal((n % 10))))))
            end
            if (n >= 20) then
              return ("twenty" + ((n == 20) ? ("") : (("-" + renderSpelloutCardinal((n % 10))))))
            end
            return "nineteen" if (n >= 19)
            return "eighteen" if (n >= 18)
            return "seventeen" if (n >= 17)
            return "sixteen" if (n >= 16)
            return "fifteen" if (n >= 15)
            return "fourteen" if (n >= 14)
            return "thirteen" if (n >= 13)
            return "twelve" if (n >= 12)
            return "eleven" if (n >= 11)
            return "ten" if (n >= 10)
            return "nine" if (n >= 9)
            return "eight" if (n >= 8)
            return "seven" if (n >= 7)
            return "six" if (n >= 6)
            return "five" if (n >= 5)
            return "four" if (n >= 4)
            return "three" if (n >= 3)
            return "two" if (n >= 2)
            return "one" if (n >= 1)
            return "zero" if (n >= 0)
          end
          def renderAnd(n)
            return (" " + renderSpelloutCardinalVerbose(n)) if (n >= 100)
            return (" and " + renderSpelloutCardinalVerbose(n)) if (n >= 1)
          end
          private(:renderAnd)
          def renderCommas(n)
            return (" " + renderSpelloutCardinalVerbose(n)) if (n >= 1000000)
            if (n >= 1000) then
              return (((" " + renderSpelloutCardinalVerbose((n / 1000.0).floor)) + " thousand") + ((n == 1000) ? ("") : (renderCommas((n % 100)))))
            end
            return (" " + renderSpelloutCardinalVerbose(n)) if (n >= 100)
            return (" and " + renderSpelloutCardinalVerbose(n)) if (n >= 1)
          end
          private(:renderCommas)
          def renderSpelloutCardinalVerbose(n)
            is_fractional = (n != n.floor)
            return ("minus " + renderSpelloutCardinalVerbose(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((renderSpelloutCardinalVerbose(n.floor) + " point ") + renderSpelloutCardinalVerbose(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 1000000000000000) then
              return ((renderSpelloutCardinalVerbose((n / 1.0e+15).floor) + " quadrillion") + ((n == 1000000000000000) ? ("") : (renderCommas((n % 100000000000000)))))
            end
            if (n >= 1000000000000) then
              return ((renderSpelloutCardinalVerbose((n / 1000000000000.0).floor) + " trillion") + ((n == 1000000000000) ? ("") : (renderCommas((n % 100000000000)))))
            end
            if (n >= 1000000000) then
              return ((renderSpelloutCardinalVerbose((n / 1000000000.0).floor) + " billion") + ((n == 1000000000) ? ("") : (renderCommas((n % 100000000)))))
            end
            if (n >= 1000000) then
              return ((renderSpelloutCardinalVerbose((n / 1000000.0).floor) + " million") + ((n == 1000000) ? ("") : (renderCommas((n % 100000)))))
            end
            if (n >= 100000) then
              return ((renderSpelloutCardinalVerbose((n / 100000.0).floor) + " thousand") + ((n == 100000) ? ("") : (renderCommas((n % 1000)))))
            end
            if (n >= 1000) then
              return ((renderSpelloutCardinalVerbose((n / 1000.0).floor) + " thousand") + ((n == 1000) ? ("") : (renderAnd((n % 100)))))
            end
            if (n >= 100) then
              return ((renderSpelloutCardinalVerbose((n / 100.0).floor) + " hundred") + ((n == 100) ? ("") : (renderAnd((n % 100)))))
            end
            return renderSpelloutNumbering(n) if (n >= 0)
          end
          def renderTieth(n)
            return ("ty-" + renderSpelloutOrdinal(n)) if (n >= 1)
            return "tieth" if (n >= 0)
          end
          private(:renderTieth)
          def renderTh(n)
            return (" " + renderSpelloutOrdinal(n)) if (n >= 1)
            return "th" if (n >= 0)
          end
          private(:renderTh)
          def renderSpelloutOrdinal(n)
            is_fractional = (n != n.floor)
            return ("minus " + renderSpelloutOrdinal(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return (n.to_s + ".") if (n >= 1000000000000000000)
            if (n >= 1000000000000000) then
              return ((renderSpelloutNumbering((n / 1.0e+15).floor) + " quadrillion") + renderTh((n % 100000000000000)))
            end
            if (n >= 1000000000000) then
              return ((renderSpelloutNumbering((n / 1000000000000.0).floor) + " trillion") + renderTh((n % 100000000000)))
            end
            if (n >= 1000000000) then
              return ((renderSpelloutNumbering((n / 1000000000.0).floor) + " billion") + renderTh((n % 100000000)))
            end
            if (n >= 1000000) then
              return ((renderSpelloutNumbering((n / 1000000.0).floor) + " million") + renderTh((n % 100000)))
            end
            if (n >= 1000) then
              return ((renderSpelloutNumbering((n / 1000.0).floor) + " thousand") + renderTh((n % 100)))
            end
            if (n >= 100) then
              return ((renderSpelloutNumbering((n / 100.0).floor) + " hundred") + renderTh((n % 100)))
            end
            return ("nine" + renderTieth((n % 10))) if (n >= 90)
            return ("eigh" + renderTieth((n % 10))) if (n >= 80)
            return ("seven" + renderTieth((n % 10))) if (n >= 70)
            return ("six" + renderTieth((n % 10))) if (n >= 60)
            return ("fif" + renderTieth((n % 10))) if (n >= 50)
            return ("for" + renderTieth((n % 10))) if (n >= 40)
            return ("thir" + renderTieth((n % 10))) if (n >= 30)
            return ("twen" + renderTieth((n % 10))) if (n >= 20)
            return (renderSpelloutNumbering(n) + "th") if (n >= 13)
            return "twelfth" if (n >= 12)
            return "eleventh" if (n >= 11)
            return "tenth" if (n >= 10)
            return "ninth" if (n >= 9)
            return "eighth" if (n >= 8)
            return "seventh" if (n >= 7)
            return "sixth" if (n >= 6)
            return "fifth" if (n >= 5)
            return "fourth" if (n >= 4)
            return "third" if (n >= 3)
            return "second" if (n >= 2)
            return "first" if (n >= 1)
            return "zeroth" if (n >= 0)
          end
          def renderAndO(n)
            return (" " + renderSpelloutOrdinalVerbose(n)) if (n >= 100)
            return (" and " + renderSpelloutOrdinalVerbose(n)) if (n >= 1)
            return "th" if (n >= 0)
          end
          private(:renderAndO)
          def renderCommasO(n)
            return (" " + renderSpelloutOrdinalVerbose(n)) if (n >= 1000000)
            if (n >= 1000) then
              return (((" " + renderSpelloutCardinalVerbose((n / 1000.0).floor)) + " thousand") + renderCommasO((n % 100)))
            end
            return (" " + renderSpelloutOrdinalVerbose(n)) if (n >= 100)
            return (" and " + renderSpelloutOrdinalVerbose(n)) if (n >= 1)
            return "th" if (n >= 0)
          end
          private(:renderCommasO)
          def renderSpelloutOrdinalVerbose(n)
            is_fractional = (n != n.floor)
            return ("minus " + renderSpelloutOrdinalVerbose(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return (n.to_s + ".") if (n >= 1000000000000000000)
            if (n >= 1000000000000000) then
              return ((renderSpelloutNumberingVerbose((n / 1.0e+15).floor) + " quadrillion") + renderCommasO((n % 100000000000000)))
            end
            if (n >= 1000000000000) then
              return ((renderSpelloutNumberingVerbose((n / 1000000000000.0).floor) + " trillion") + renderCommasO((n % 100000000000)))
            end
            if (n >= 1000000000) then
              return ((renderSpelloutNumberingVerbose((n / 1000000000.0).floor) + " billion") + renderCommasO((n % 100000000)))
            end
            if (n >= 1000000) then
              return ((renderSpelloutNumberingVerbose((n / 1000000.0).floor) + " million") + renderCommasO((n % 100000)))
            end
            if (n >= 100000) then
              return ((renderSpelloutNumberingVerbose((n / 100000.0).floor) + " thousand") + renderCommasO((n % 1000)))
            end
            if (n >= 1000) then
              return ((renderSpelloutNumberingVerbose((n / 1000.0).floor) + " thousand") + renderAndO((n % 100)))
            end
            if (n >= 100) then
              return ((renderSpelloutNumberingVerbose((n / 100.0).floor) + " hundred") + renderAndO((n % 100)))
            end
            return renderSpelloutOrdinal(n) if (n >= 0)
          end
          def renderDigitsOrdinalIndicator(n)
            return renderDigitsOrdinalIndicator((n % 100)) if (n >= 100)
            return renderDigitsOrdinalIndicator((n % 10)) if (n >= 20)
            return "th" if (n >= 4)
            return "rd" if (n >= 3)
            return "nd" if (n >= 2)
            return "st" if (n >= 1)
            return "th" if (n >= 0)
          end
          private(:renderDigitsOrdinalIndicator)
          def renderDigitsOrdinal(n)
            return ("−" + renderDigitsOrdinal(-n)) if (n < 0)
            return (n.to_s + renderDigitsOrdinalIndicator(n)) if (n >= 0)
          end)
        end
      end
    end
  end
end