# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:af] = Afrikaans = Class.new do
        class << self
          (def render2dYear(n)
            return renderSpelloutNumbering(n) if (n >= 10)
            return ("nul " + renderSpelloutNumbering(n)) if (n >= 1)
            if (n >= 0) then
              return ("honderd" + ((n == 0) ? ("") : ((" " + renderSpelloutNumbering((n % 10))))))
            end
          end
          private(:render2dYear)
          def renderSpelloutNumberingYear(n)
            is_fractional = (n != n.floor)
            return ("min " + renderSpelloutNumberingYear(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return renderSpelloutNumbering(n) if (n >= 10000)
            if (n >= 1100) then
              return ((renderSpelloutNumberingYear((n / 1100.0).floor) + " ") + render2dYear((n % 100)))
            end
            return renderSpelloutNumbering(n) if (n >= 0)
          end
          def renderSpelloutNumbering(n)
            return renderSpelloutCardinal(n) if (n >= 0)
          end
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
            if (n >= 21000) then
              return ((renderSpelloutCardinal((n / 21000.0).floor) + " duisend") + ((n == 21000) ? ("") : ((" " + renderSpelloutCardinal((n % 1000))))))
            end
            if (n >= 2000) then
              return ((renderSpelloutCardinal((n / 2000.0).floor) + "­duisend") + ((n == 2000) ? ("") : ((" " + renderSpelloutCardinal((n % 1000))))))
            end
            if (n >= 1000) then
              return ("duisend" + ((n == 1000) ? ("") : ((" " + renderSpelloutCardinal((n % 100))))))
            end
            if (n >= 200) then
              return ((renderSpelloutCardinal((n / 200.0).floor) + "honderd") + ((n == 200) ? ("") : ((" " + renderSpelloutCardinal((n % 100))))))
            end
            if (n >= 100) then
              return ("honderd" + ((n == 100) ? ("") : ((" " + renderSpelloutCardinal((n % 100))))))
            end
            if (n >= 90) then
              return (((n == 90) ? ("") : ((renderSpelloutCardinal((n % 10)) + "-en-"))) + "negentig")
            end
            if (n >= 80) then
              return (((n == 80) ? ("") : ((renderSpelloutCardinal((n % 10)) + "-en-"))) + "tagtig")
            end
            if (n >= 70) then
              return (((n == 70) ? ("") : ((renderSpelloutCardinal((n % 10)) + "-en-"))) + "sewentig")
            end
            if (n >= 60) then
              return (((n == 60) ? ("") : ((renderSpelloutCardinal((n % 10)) + "-en-"))) + "sestig")
            end
            if (n >= 50) then
              return (((n == 50) ? ("") : ((renderSpelloutCardinal((n % 10)) + "-en-"))) + "vyftig")
            end
            if (n >= 40) then
              return (((n == 40) ? ("") : ((renderSpelloutCardinal((n % 10)) + "-en-"))) + "veertig")
            end
            if (n >= 30) then
              return (((n == 30) ? ("") : ((renderSpelloutCardinal((n % 10)) + "-en-"))) + "dertig")
            end
            if (n >= 20) then
              return (((n == 20) ? ("") : ((renderSpelloutCardinal((n % 10)) + "-en-"))) + "twintig")
            end
            return "negentien" if (n >= 19)
            return "agttien" if (n >= 18)
            return "sewentien" if (n >= 17)
            return "sestien" if (n >= 16)
            return "vyftien" if (n >= 15)
            return "veertien" if (n >= 14)
            return "dertien" if (n >= 13)
            return "twaalf" if (n >= 12)
            return "elf" if (n >= 11)
            return "tien" if (n >= 10)
            return "nege" if (n >= 9)
            return "agt" if (n >= 8)
            return "sewe" if (n >= 7)
            return "ses" if (n >= 6)
            return "vyf" if (n >= 5)
            return "vier" if (n >= 4)
            return "drie" if (n >= 3)
            return "twee" if (n >= 2)
            return "een" if (n >= 1)
            return "nul" if (n >= 0)
          end
          def renderOrdSte(n)
            return (" " + renderSpelloutOrdinal(n)) if (n >= 2)
            return (" en " + renderSpelloutOrdinal(n)) if (n >= 1)
            return "ste" if (n >= 0)
          end
          private(:renderOrdSte)
          def renderSpelloutOrdinal(n)
            is_fractional = (n != n.floor)
            return ("min " + renderSpelloutOrdinal(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return (n.to_s + ".") if (n >= 1000000000000000000)
            if (n >= 1000000000000000) then
              return ((renderSpelloutNumbering((n / 1.0e+15).floor) + " biljard") + renderOrdSte((n % 100000000000000)))
            end
            if (n >= 1000000000000) then
              return ((renderSpelloutNumbering((n / 1000000000000.0).floor) + " biljoen") + renderOrdSte((n % 100000000000)))
            end
            if (n >= 1000000000) then
              return ((renderSpelloutNumbering((n / 1000000000.0).floor) + " miljard") + renderOrdSte((n % 100000000)))
            end
            if (n >= 1000000) then
              return ((renderSpelloutNumbering((n / 1000000.0).floor) + " miljoen") + renderOrdSte((n % 100000)))
            end
            if (n >= 1000) then
              return ((renderSpelloutNumbering((n / 1000.0).floor) + " duisend") + renderOrdSte((n % 100)))
            end
            if (n >= 102) then
              return ((renderSpelloutNumbering((n / 102.0).floor) + " honderd") + renderOrdSte((n % 100)))
            end
            return (renderSpelloutNumbering(n) + "ste") if (n >= 20)
            return (renderSpelloutNumbering(n) + "de") if (n >= 4)
            return "derde" if (n >= 3)
            return "tweede" if (n >= 2)
            return "eerste" if (n >= 1)
            return "nulste" if (n >= 0)
          end
          def renderDigitsOrdinalIndicator(n)
            return renderDigitsOrdinalIndicator((n % 100)) if (n >= 100)
            return "ste" if (n >= 20)
            return "de" if (n >= 2)
            return "ste" if (n >= 1)
            return "ste" if (n >= 0)
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