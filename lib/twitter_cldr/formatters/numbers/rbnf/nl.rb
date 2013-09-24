# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:nl] = Dutch = Class.new do
        class << self
          (def render2dYear(n)
            return renderSpelloutNumbering(n) if (n >= 1)
            return "honderd" if (n >= 0)
          end
          private(:render2dYear)
          def renderSpelloutNumberingYear(n)
            is_fractional = (n != n.floor)
            return ("min " + renderSpelloutNumberingYear(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return renderSpelloutNumbering(n) if (n >= 10000)
            if (n >= 9100) then
              return ((renderSpelloutNumberingYear((n / 9100.0).floor) + "­") + render2dYear((n % 100)))
            end
            return renderSpelloutNumbering(n) if (n >= 9000)
            if (n >= 8100) then
              return ((renderSpelloutNumberingYear((n / 8100.0).floor) + "­") + render2dYear((n % 100)))
            end
            return renderSpelloutNumbering(n) if (n >= 8000)
            if (n >= 7100) then
              return ((renderSpelloutNumberingYear((n / 7100.0).floor) + "­") + render2dYear((n % 100)))
            end
            return renderSpelloutNumbering(n) if (n >= 7000)
            if (n >= 6100) then
              return ((renderSpelloutNumberingYear((n / 6100.0).floor) + "­") + render2dYear((n % 100)))
            end
            return renderSpelloutNumbering(n) if (n >= 6000)
            if (n >= 5100) then
              return ((renderSpelloutNumberingYear((n / 5100.0).floor) + "­") + render2dYear((n % 100)))
            end
            return renderSpelloutNumbering(n) if (n >= 5000)
            if (n >= 4100) then
              return ((renderSpelloutNumberingYear((n / 4100.0).floor) + "­") + render2dYear((n % 100)))
            end
            return renderSpelloutNumbering(n) if (n >= 4000)
            if (n >= 3100) then
              return ((renderSpelloutNumberingYear((n / 3100.0).floor) + "­") + render2dYear((n % 100)))
            end
            return renderSpelloutNumbering(n) if (n >= 3000)
            if (n >= 2100) then
              return ((renderSpelloutNumberingYear((n / 2100.0).floor) + "­") + render2dYear((n % 100)))
            end
            return renderSpelloutNumbering(n) if (n >= 2000)
            if (n >= 1100) then
              return ((renderSpelloutNumberingYear((n / 1100.0).floor) + "­") + render2dYear((n % 100)))
            end
            return renderSpelloutNumbering(n) if (n >= 0)
          end
          def renderSpelloutNumbering(n)
            return renderSpelloutCardinal(n) if (n >= 0)
          end
          def renderNumberEn(n)
            return (renderSpelloutCardinal(n) + "­en­") if (n >= 4)
            return "drie­ën­" if (n >= 3)
            return "twee­ën­" if (n >= 2)
            return "een­en­" if (n >= 1)
          end
          private(:renderNumberEn)
          def renderSpelloutCardinal(n)
            is_fractional = (n != n.floor)
            return ("min " + renderSpelloutCardinal(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((renderSpelloutCardinal(n.floor) + " komma ") + renderSpelloutCardinal(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 1000000000000000) then
              return ((renderSpelloutCardinal((n / 1.0e+15).floor) + " biljard") + (if (n == 1000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinal((n % 100000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((renderSpelloutCardinal((n / 1000000000000.0).floor) + " biljoen") + (if (n == 1000000000000) then
                ""
              else
                (" " + renderSpelloutCardinal((n % 100000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((renderSpelloutCardinal((n / 1000000000.0).floor) + " miljard") + (if (n == 1000000000) then
                ""
              else
                (" " + renderSpelloutCardinal((n % 100000000)))
              end))
            end
            if (n >= 1000000) then
              return ((renderSpelloutCardinal((n / 1000000.0).floor) + " miljoen") + ((n == 1000000) ? ("") : ((" " + renderSpelloutCardinal((n % 100000))))))
            end
            if (n >= 100000) then
              return ((renderSpelloutCardinal((n / 100000.0).floor) + "­duizend") + ((n == 100000) ? ("") : (("­" + renderSpelloutCardinal((n % 1000))))))
            end
            if (n >= 2000) then
              return ((renderSpelloutCardinal((n / 2000.0).floor) + "­duizend") + ((n == 2000) ? ("") : (("­" + renderSpelloutCardinal((n % 1000))))))
            end
            if (n >= 1000) then
              return ("duizend" + ((n == 1000) ? ("") : (("­" + renderSpelloutCardinal((n % 100))))))
            end
            if (n >= 200) then
              return ((renderSpelloutCardinal((n / 200.0).floor) + "­honderd") + ((n == 200) ? ("") : (("­" + renderSpelloutCardinal((n % 100))))))
            end
            if (n >= 100) then
              return ("honderd" + ((n == 100) ? ("") : (renderSpelloutCardinal((n % 100)))))
            end
            if (n >= 90) then
              return (((n == 90) ? ("") : (renderNumberEn((n % 10)))) + "negentig")
            end
            if (n >= 80) then
              return (((n == 80) ? ("") : (renderNumberEn((n % 10)))) + "tachtig")
            end
            if (n >= 70) then
              return (((n == 70) ? ("") : (renderNumberEn((n % 10)))) + "zeventig")
            end
            if (n >= 60) then
              return (((n == 60) ? ("") : (renderNumberEn((n % 10)))) + "zestig")
            end
            if (n >= 50) then
              return (((n == 50) ? ("") : (renderNumberEn((n % 10)))) + "vijftig")
            end
            if (n >= 40) then
              return (((n == 40) ? ("") : (renderNumberEn((n % 10)))) + "veertig")
            end
            if (n >= 30) then
              return (((n == 30) ? ("") : (renderNumberEn((n % 10)))) + "dertig")
            end
            if (n >= 20) then
              return (((n == 20) ? ("") : (renderNumberEn((n % 10)))) + "twintig")
            end
            return "negentien" if (n >= 19)
            return "achttien" if (n >= 18)
            return "zeventien" if (n >= 17)
            return "zestien" if (n >= 16)
            return "vijftien" if (n >= 15)
            return "veertien" if (n >= 14)
            return "dertien" if (n >= 13)
            return "twaalf" if (n >= 12)
            return "elf" if (n >= 11)
            return "tien" if (n >= 10)
            return "negen" if (n >= 9)
            return "acht" if (n >= 8)
            return "zeven" if (n >= 7)
            return "zes" if (n >= 6)
            return "vijf" if (n >= 5)
            return "vier" if (n >= 4)
            return "drie" if (n >= 3)
            return "twee" if (n >= 2)
            return "een" if (n >= 1)
            return "nul" if (n >= 0)
          end
          def renderOrdSte(n)
            return ("­" + renderSpelloutOrdinal(n)) if (n >= 1)
            return "ste" if (n >= 0)
          end
          private(:renderOrdSte)
          def renderSpelloutOrdinal(n)
            is_fractional = (n != n.floor)
            return ("min " + renderSpelloutOrdinal(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return (n.to_s + ".") if (n >= 1000000000000000000)
            if (n >= 1000000000000000) then
              return ((renderSpelloutCardinal((n / 1.0e+15).floor) + "­biljard") + renderOrdSte((n % 100000000000000)))
            end
            if (n >= 1000000000000) then
              return ((renderSpelloutCardinal((n / 1000000000000.0).floor) + "­biljoen") + renderOrdSte((n % 100000000000)))
            end
            if (n >= 1000000000) then
              return ((renderSpelloutCardinal((n / 1000000000.0).floor) + "­miljard") + renderOrdSte((n % 100000000)))
            end
            if (n >= 1000000) then
              return ((renderSpelloutCardinal((n / 1000000.0).floor) + "­miljoen") + renderOrdSte((n % 100000)))
            end
            if (n >= 2000) then
              return ((renderSpelloutCardinal((n / 2000.0).floor) + "­duizend") + renderOrdSte((n % 1000)))
            end
            return ("duizend" + renderOrdSte((n % 100))) if (n >= 1000)
            if (n >= 200) then
              return ((renderSpelloutCardinal((n / 200.0).floor) + "­honderd") + renderOrdSte((n % 100)))
            end
            return ("honderd" + renderOrdSte((n % 100))) if (n >= 100)
            return (renderSpelloutCardinal(n) + "ste") if (n >= 20)
            return (renderSpelloutCardinal(n) + "de") if (n >= 9)
            return (renderSpelloutCardinal(n) + "ste") if (n >= 8)
            return (renderSpelloutCardinal(n) + "de") if (n >= 4)
            return "derde" if (n >= 3)
            return "tweede" if (n >= 2)
            return "eerste" if (n >= 1)
            return "nulste" if (n >= 0)
          end
          def renderDigitsOrdinal(n)
            return ("−" + renderDigitsOrdinal(-n)) if (n < 0)
            return (n.to_s + "e") if (n >= 0)
          end)
        end
      end
    end
  end
end