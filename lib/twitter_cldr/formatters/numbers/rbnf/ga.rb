# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:ga] = Irish = Class.new do
        class << self
          (def renderLenientParse(n)
            return ((" ' ' " + " '") + "' ") if (n >= 0)
          end
          private(:renderLenientParse)
          def render2dYear(n)
            return renderSpelloutNumberingNoA(n) if (n >= 10)
            return ("agus " + renderSpelloutNumbering(n)) if (n >= 0)
          end
          private(:render2dYear)
          def renderSpelloutNumberingYear(n)
            is_fractional = (n != n.floor)
            return ("míneas " + renderSpelloutNumberingYear(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return renderSpelloutNumbering(n) if (n >= 10000)
            if (n >= 1000) then
              return ((renderSpelloutNumberingNoA((n / 1000.0).floor) + " ") + render2dYear((n % 100)))
            end
            return renderSpelloutNumbering(n) if (n >= 0)
          end
          def renderSpelloutNumberingNoA(n)
            return renderSpelloutNumbering(n) if (n >= 20)
            return (renderSpelloutNumberingNoA((n % 10)) + " déag") if (n >= 13)
            return (renderSpelloutNumberingNoA((n % 10)) + " dhéag") if (n >= 12)
            return (renderSpelloutNumberingNoA((n % 10)) + " déag") if (n >= 11)
            return "deich" if (n >= 10)
            return "naoi" if (n >= 9)
            return "ocht" if (n >= 8)
            return "seacht" if (n >= 7)
            return "sé" if (n >= 6)
            return "cúig" if (n >= 5)
            return "ceathair" if (n >= 4)
            return "trí" if (n >= 3)
            return "dó" if (n >= 2)
            return "aon" if (n >= 1)
            return "náid" if (n >= 0)
          end
          private(:renderSpelloutNumberingNoA)
          def renderSpelloutNumbering(n)
            is_fractional = (n != n.floor)
            return ("míneas " + renderSpelloutNumbering(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((renderSpelloutNumbering(n.floor) + " pointe ") + renderSpelloutNumbering(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 1000000000000000) then
              return (renderQuadrillions((n / 1.0e+15).floor) + (if (n == 1000000000000000) then
                ""
              else
                (" " + renderSpelloutNumbering((n % 100000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return (renderTrillions((n / 1000000000000.0).floor) + (if (n == 1000000000000) then
                ""
              else
                (" " + renderSpelloutNumbering((n % 100000000000)))
              end))
            end
            if (n >= 1000000000) then
              return (renderBillions((n / 1000000000.0).floor) + (if (n == 1000000000) then
                ""
              else
                (" " + renderSpelloutNumbering((n % 100000000)))
              end))
            end
            if (n >= 1000000) then
              return (renderMillions((n / 1000000.0).floor) + ((n == 1000000) ? ("") : ((" " + renderSpelloutNumbering((n % 100000))))))
            end
            if (n >= 1000) then
              return (renderThousands((n / 1000.0).floor) + ((n == 1000) ? ("") : ((" " + renderSpelloutNumbering((n % 100))))))
            end
            if (n >= 100) then
              return (renderHundreds((n / 100.0).floor) + ((n == 100) ? ("") : (renderIsNumber((n % 100)))))
            end
            if (n >= 90) then
              return ("nócha" + ((n == 90) ? ("") : ((" " + renderSpelloutNumbering((n % 10))))))
            end
            if (n >= 80) then
              return ("ochtó" + ((n == 80) ? ("") : ((" " + renderSpelloutNumbering((n % 10))))))
            end
            if (n >= 70) then
              return ("seachtó" + ((n == 70) ? ("") : ((" " + renderSpelloutNumbering((n % 10))))))
            end
            if (n >= 60) then
              return ("seasca" + ((n == 60) ? ("") : ((" " + renderSpelloutNumbering((n % 10))))))
            end
            if (n >= 50) then
              return ("caoga" + ((n == 50) ? ("") : ((" " + renderSpelloutNumbering((n % 10))))))
            end
            if (n >= 40) then
              return ("daichead" + ((n == 40) ? ("") : ((" " + renderSpelloutNumbering((n % 10))))))
            end
            if (n >= 30) then
              return ("tríocha" + ((n == 30) ? ("") : ((" " + renderSpelloutNumbering((n % 10))))))
            end
            if (n >= 20) then
              return ("fiche" + ((n == 20) ? ("") : ((" " + renderSpelloutNumbering((n % 10))))))
            end
            return (renderSpelloutNumbering((n % 10)) + " déag") if (n >= 13)
            return (renderSpelloutNumbering((n % 10)) + " dhéag") if (n >= 12)
            return (renderSpelloutNumbering((n % 10)) + " déag") if (n >= 11)
            return "a deich" if (n >= 10)
            return "a naoi" if (n >= 9)
            return "a hocht" if (n >= 8)
            return "a seacht" if (n >= 7)
            return "a sé" if (n >= 6)
            return "a cúig" if (n >= 5)
            return "a ceathair" if (n >= 4)
            return "a trí" if (n >= 3)
            return "a dó" if (n >= 2)
            return "a haon" if (n >= 1)
            return "a náid" if (n >= 0)
          end
          def renderIsNumber(n)
            return (" " + renderSpelloutNumbering(n)) if (n >= 1)
            return (" is " + renderSpelloutNumbering(n)) if (n >= 0)
          end
          private(:renderIsNumber)
          def renderIsNumberp(n)
            return (" " + renderNumberp(n)) if (n >= 1)
            return (" is " + renderNumberp(n)) if (n >= 0)
          end
          private(:renderIsNumberp)
          def renderNumberp(n)
            return renderSpelloutCardinalPrefixpart(n) if (n >= 20)
            return (renderSpelloutCardinalPrefixpart(n) + " déag") if (n >= 13)
            return "dó dhéag" if (n >= 12)
            return renderSpelloutCardinalPrefixpart(n) if (n >= 0)
          end
          private(:renderNumberp)
          def renderSpelloutCardinal(n)
            return renderSpelloutNumbering(n) if (n >= 0)
          end
          def renderSpelloutCardinalPrefixpart(n)
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 1000000000000000) then
              return (renderQuadrillions((n / 1.0e+15).floor) + (if (n == 1000000000000000) then
                ""
              else
                (" " + renderNumberp((n % 100000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return (renderTrillions((n / 1000000000000.0).floor) + ((n == 1000000000000) ? ("") : ((" " + renderNumberp((n % 100000000000))))))
            end
            if (n >= 1000000000) then
              return (renderBillions((n / 1000000000.0).floor) + ((n == 1000000000) ? ("") : ((" " + renderNumberp((n % 100000000))))))
            end
            if (n >= 1000000) then
              return (renderMillions((n / 1000000.0).floor) + ((n == 1000000) ? ("") : ((" " + renderNumberp((n % 100000))))))
            end
            if (n >= 1000) then
              return (renderThousands((n / 1000.0).floor) + ((n == 1000) ? ("") : ((" " + renderNumberp((n % 100))))))
            end
            if (n >= 100) then
              return (renderHundreds((n / 100.0).floor) + ((n == 100) ? ("") : (renderIsNumberp((n % 100)))))
            end
            if (n >= 90) then
              return ("nócha" + ((n == 90) ? ("") : ((" is " + renderSpelloutCardinalPrefixpart((n % 10))))))
            end
            if (n >= 80) then
              return ("ochtó" + ((n == 80) ? ("") : ((" is " + renderSpelloutCardinalPrefixpart((n % 10))))))
            end
            if (n >= 70) then
              return ("seachtó" + ((n == 70) ? ("") : ((" is " + renderSpelloutCardinalPrefixpart((n % 10))))))
            end
            if (n >= 60) then
              return ("seasca" + ((n == 60) ? ("") : ((" is " + renderSpelloutCardinalPrefixpart((n % 10))))))
            end
            if (n >= 50) then
              return ("caoga" + ((n == 50) ? ("") : ((" is " + renderSpelloutCardinalPrefixpart((n % 10))))))
            end
            if (n >= 40) then
              return ("daichead" + ((n == 40) ? ("") : ((" is " + renderSpelloutCardinalPrefixpart((n % 10))))))
            end
            if (n >= 30) then
              return ("tríocha" + ((n == 30) ? ("") : ((" is " + renderSpelloutCardinalPrefixpart((n % 10))))))
            end
            if (n >= 20) then
              return ("fiche" + ((n == 20) ? ("") : ((" is " + renderSpelloutCardinalPrefixpart((n % 10))))))
            end
            return renderSpelloutCardinalPrefixpart((n % 10)) if (n >= 11)
            return "deich" if (n >= 10)
            return "naoi" if (n >= 9)
            return "ocht" if (n >= 8)
            return "seacht" if (n >= 7)
            return "sé" if (n >= 6)
            return "cúig" if (n >= 5)
            return "ceithre" if (n >= 4)
            return "trí" if (n >= 3)
            return "dhá" if (n >= 2)
            return "aon" if (n >= 1)
            return "náid" if (n >= 0)
          end
          private(:renderSpelloutCardinalPrefixpart)
          def renderIs(n)
            return renderIs((n % 10)) if (n >= 10)
            return "" if (n >= 1)
            return " is" if (n >= 0)
          end
          private(:renderIs)
          def renderHundreds(n)
            return "naoi gcéad" if (n >= 9)
            return "ocht gcéad" if (n >= 8)
            return "seacht gcéad" if (n >= 7)
            return "sé chéad" if (n >= 6)
            return "cúig chéad" if (n >= 5)
            return "ceithre chéad" if (n >= 4)
            return "trí chéad" if (n >= 3)
            return "dhá chéad" if (n >= 2)
            return "céad" if (n >= 1)
          end
          private(:renderHundreds)
          def renderThousands(n)
            if (n >= 100) then
              return (renderHundreds((n / 100.0).floor) + renderIsThousands((n % 100)))
            end
            if (n >= 2) then
              return ((renderSpelloutCardinalPrefixpart(n) + " ") + renderThousandp(n))
            end
            return "míle" if (n >= 1)
          end
          private(:renderThousands)
          def renderThousandp(n)
            return renderThousand(n) if (n >= 20)
            return (renderThousand(n) + " dhéag") if (n >= 11)
            return renderThousand(n) if (n >= 2)
          end
          private(:renderThousandp)
          def renderThousand(n)
            return renderThousand((n % 10)) if (n >= 11)
            return "míle" if (n >= 7)
            return "mhíle" if (n >= 1)
            return "míle" if (n >= 0)
          end
          private(:renderThousand)
          def renderIsThousands(n)
            return ((renderIs(n) + " ") + renderThousands(n)) if (n >= 20)
            return (" is " + renderThousands(n)) if (n >= 11)
            if (n >= 1) then
              return (((" is " + renderSpelloutCardinalPrefixpart(n)) + " ") + renderThousand(n))
            end
            return (" " + renderThousand(n)) if (n >= 0)
          end
          private(:renderIsThousands)
          def renderMillions(n)
            if (n >= 100) then
              return (renderHundreds((n / 100.0).floor) + renderIsMillions((n % 100)))
            end
            if (n >= 2) then
              return ((renderSpelloutCardinalPrefixpart(n) + " ") + renderMillionsp(n))
            end
            return "milliún" if (n >= 1)
          end
          private(:renderMillions)
          def renderMillionsp(n)
            return renderMillion(n) if (n >= 20)
            return (renderMillion(n) + " déag") if (n >= 11)
            return renderMillion(n) if (n >= 2)
          end
          private(:renderMillionsp)
          def renderMillion(n)
            return renderMillion((n % 10)) if (n >= 11)
            return "milliún" if (n >= 7)
            return "mhilliún" if (n >= 1)
            return "milliún" if (n >= 0)
          end
          private(:renderMillion)
          def renderIsMillions(n)
            return ((renderIs(n) + " ") + renderMillions(n)) if (n >= 20)
            return (" is " + renderMillions(n)) if (n >= 11)
            if (n >= 1) then
              return (((" is " + renderSpelloutCardinalPrefixpart(n)) + " ") + renderMillion(n))
            end
            return (" " + renderMillion(n)) if (n >= 0)
          end
          private(:renderIsMillions)
          def renderBillions(n)
            if (n >= 100) then
              return (renderHundreds((n / 100.0).floor) + renderIsBillions((n % 100)))
            end
            return (renderSpelloutCardinalPrefixpart(n) + " billiún") if (n >= 20)
            return (renderSpelloutCardinalPrefixpart(n) + " billiún déag") if (n >= 11)
            return (renderSpelloutCardinalPrefixpart(n) + " billiún") if (n >= 2)
            return "billiún" if (n >= 1)
          end
          private(:renderBillions)
          def renderIsBillions(n)
            return ((renderIs(n) + " ") + renderBillions(n)) if (n >= 20)
            return (" is " + renderBillions(n)) if (n >= 11)
            if (n >= 1) then
              return ((" is " + renderSpelloutCardinalPrefixpart(n)) + " billiún")
            end
            return " billiún" if (n >= 0)
          end
          private(:renderIsBillions)
          def renderTrillions(n)
            if (n >= 100) then
              return (renderHundreds((n / 100.0).floor) + renderIsTrillions((n % 100)))
            end
            if (n >= 2) then
              return ((renderSpelloutCardinalPrefixpart(n) + " ") + renderTrillionsp(n))
            end
            return "thrilliún" if (n >= 1)
          end
          private(:renderTrillions)
          def renderTrillionsp(n)
            return renderTrillion(n) if (n >= 20)
            return (renderTrillion(n) + " déag") if (n >= 11)
            return renderTrillion(n) if (n >= 2)
          end
          private(:renderTrillionsp)
          def renderTrillion(n)
            return renderTrillion((n % 10)) if (n >= 11)
            return "dtrilliún" if (n >= 7)
            return "thrilliún" if (n >= 1)
            return "dtrilliún" if (n >= 0)
          end
          private(:renderTrillion)
          def renderIsTrillions(n)
            return ((renderIs(n) + " ") + renderTrillions(n)) if (n >= 20)
            return (" is " + renderTrillions(n)) if (n >= 11)
            if (n >= 1) then
              return (((" is " + renderSpelloutCardinalPrefixpart(n)) + " ") + renderTrillion(n))
            end
            return (" " + renderTrillion(n)) if (n >= 0)
          end
          private(:renderIsTrillions)
          def renderQuadrillions(n)
            if (n >= 100) then
              return (renderHundreds((n / 100.0).floor) + renderIsQuadrillions((n % 100)))
            end
            return (renderSpelloutCardinalPrefixpart(n) + " quadrilliún") if (n >= 20)
            if (n >= 11) then
              return (renderSpelloutCardinalPrefixpart(n) + " quadrilliún déag")
            end
            return (renderSpelloutCardinalPrefixpart(n) + " quadrilliún") if (n >= 2)
            return "quadrilliún" if (n >= 1)
          end
          private(:renderQuadrillions)
          def renderIsQuadrillions(n)
            return ((renderIs(n) + " ") + renderQuadrillions(n)) if (n >= 20)
            return (" is " + renderQuadrillions(n)) if (n >= 11)
            if (n >= 1) then
              return ((" is " + renderSpelloutCardinalPrefixpart(n)) + " quadrilliún")
            end
            return " quadrilliún" if (n >= 0)
          end
          private(:renderIsQuadrillions)
          def renderDigitsOrdinal(n)
            return ("−" + renderDigitsOrdinal(-n)) if (n < 0)
            return (n.to_s + "ú") if (n >= 0)
          end)
        end
      end
    end
  end
end