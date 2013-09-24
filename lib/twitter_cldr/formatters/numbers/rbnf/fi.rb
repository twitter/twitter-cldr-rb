# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:fi] = Finnish = Class.new do
        class << self
          (def renderSpelloutNumberingYear(n)
            is_fractional = (n != n.floor)
            return ("miinus " + renderSpelloutNumberingYear(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return renderSpelloutNumbering(n) if (n >= 0)
          end
          def renderSpelloutNumbering(n)
            return renderSpelloutCardinal(n) if (n >= 0)
          end
          def renderSpelloutCardinal(n)
            is_fractional = (n != n.floor)
            return ("miinus " + renderSpelloutCardinal(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((renderSpelloutCardinal(n.floor) + " pilkku ") + renderSpelloutCardinal(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000) then
              return ((renderSpelloutCardinal((n / 2000000000000.0).floor) + " biljoonaa") + (if (n == 2000000000000) then
                ""
              else
                (" " + renderSpelloutCardinal((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((renderSpelloutCardinal((n / 1000000000000.0).floor) + " biljoona") + (if (n == 1000000000000) then
                ""
              else
                (" " + renderSpelloutCardinal((n % 100000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((renderSpelloutCardinal((n / 2000000000.0).floor) + " miljardia") + (if (n == 2000000000) then
                ""
              else
                (" " + renderSpelloutCardinal((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((renderSpelloutCardinal((n / 1000000000.0).floor) + " miljardi") + (if (n == 1000000000) then
                ""
              else
                (" " + renderSpelloutCardinal((n % 100000000)))
              end))
            end
            if (n >= 2000000) then
              return ((renderSpelloutCardinal((n / 2000000.0).floor) + " miljoonaa") + ((n == 2000000) ? ("") : ((" " + renderSpelloutCardinal((n % 1000000))))))
            end
            if (n >= 1000000) then
              return ((renderSpelloutCardinal((n / 1000000.0).floor) + " miljoona") + ((n == 1000000) ? ("") : ((" " + renderSpelloutCardinal((n % 100000))))))
            end
            if (n >= 2000) then
              return ((renderSpelloutCardinal((n / 2000.0).floor) + "­tuhatta") + ((n == 2000) ? ("") : (("­" + renderSpelloutCardinal((n % 1000))))))
            end
            if (n >= 1000) then
              return ("tuhat" + ((n == 1000) ? ("") : (("­" + renderSpelloutCardinal((n % 100))))))
            end
            if (n >= 200) then
              return ((renderSpelloutCardinal((n / 200.0).floor) + "­sataa") + ((n == 200) ? ("") : (("­" + renderSpelloutCardinal((n % 100))))))
            end
            if (n >= 100) then
              return ("sata" + ((n == 100) ? ("") : (("­" + renderSpelloutCardinal((n % 100))))))
            end
            if (n >= 20) then
              return ((renderSpelloutCardinal((n / 20.0).floor) + "kymmentä") + ((n == 20) ? ("") : (("­" + renderSpelloutCardinal((n % 10))))))
            end
            return (renderSpelloutCardinal((n % 10)) + "toista") if (n >= 11)
            return "kymmenen" if (n >= 10)
            return "yhdeksän" if (n >= 9)
            return "kahdeksan" if (n >= 8)
            return "seitsemän" if (n >= 7)
            return "kuusi" if (n >= 6)
            return "viisi" if (n >= 5)
            return "neljä" if (n >= 4)
            return "kolme" if (n >= 3)
            return "kaksi" if (n >= 2)
            return "yksi" if (n >= 1)
            return "nolla" if (n >= 0)
          end)
        end
      end
    end
  end
end