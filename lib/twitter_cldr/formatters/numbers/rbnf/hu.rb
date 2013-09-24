# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:hu] = Hungarian = Class.new do
        class << self
          (def renderSpelloutNumberingYear(n)
            is_fractional = (n != n.floor)
            return ("minusz " + renderSpelloutNumberingYear(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return renderSpelloutNumbering(n) if (n >= 10000)
            if (n >= 1100) then
              return ((renderSpelloutNumberingYear((n / 1100.0).floor) + "­száz") + ((n == 1100) ? ("") : (("­" + renderSpelloutNumberingYear((n % 100))))))
            end
            return renderSpelloutNumbering(n) if (n >= 0)
          end
          def renderSpelloutNumbering(n)
            return renderSpelloutCardinal(n) if (n >= 0)
          end
          def renderSpelloutCardinal(n)
            is_fractional = (n != n.floor)
            return ("minusz " + renderSpelloutCardinal(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((renderSpelloutCardinal(n.floor) + " vessző ") + renderSpelloutCardinal(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 1000000000000000) then
              return ((renderSpelloutCardinal((n / 1.0e+15).floor) + " billiárd") + (if (n == 1000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinal((n % 100000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((renderSpelloutCardinal((n / 1000000000000.0).floor) + " billió") + (if (n == 1000000000000) then
                ""
              else
                (" " + renderSpelloutCardinal((n % 100000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((renderSpelloutCardinal((n / 1000000000.0).floor) + " milliárd") + (if (n == 1000000000) then
                ""
              else
                (" " + renderSpelloutCardinal((n % 100000000)))
              end))
            end
            if (n >= 1000000) then
              return ((renderSpelloutCardinal((n / 1000000.0).floor) + " millió") + ((n == 1000000) ? ("") : ((" " + renderSpelloutCardinal((n % 100000))))))
            end
            if (n >= 1000) then
              return ((renderSpelloutCardinal((n / 1000.0).floor) + "­ezer") + ((n == 1000) ? ("") : ((" " + renderSpelloutCardinal((n % 100))))))
            end
            if (n >= 100) then
              return ((renderSpelloutCardinal((n / 100.0).floor) + "­száz") + ((n == 100) ? ("") : (("­" + renderSpelloutCardinal((n % 100))))))
            end
            if (n >= 90) then
              return ("kilencven" + ((n == 90) ? ("") : (("­" + renderSpelloutCardinal((n % 10))))))
            end
            if (n >= 80) then
              return ("nyolcvan" + ((n == 80) ? ("") : (("­" + renderSpelloutCardinal((n % 10))))))
            end
            if (n >= 70) then
              return ("hetven" + ((n == 70) ? ("") : (("­" + renderSpelloutCardinal((n % 10))))))
            end
            if (n >= 60) then
              return ("hatvan" + ((n == 60) ? ("") : (("­" + renderSpelloutCardinal((n % 10))))))
            end
            if (n >= 50) then
              return ("ötven" + ((n == 50) ? ("") : (("­" + renderSpelloutCardinal((n % 10))))))
            end
            if (n >= 40) then
              return ("negyven" + ((n == 40) ? ("") : (("­" + renderSpelloutCardinal((n % 10))))))
            end
            if (n >= 30) then
              return ("harminc" + ((n == 30) ? ("") : (("­" + renderSpelloutCardinal((n % 10))))))
            end
            return ("huszon­" + renderSpelloutCardinal((n % 10))) if (n >= 21)
            return "húsz" if (n >= 20)
            return ("tizen­" + renderSpelloutCardinal((n % 10))) if (n >= 11)
            return "tíz" if (n >= 10)
            return "kilenc" if (n >= 9)
            return "nyolc" if (n >= 8)
            return "hét" if (n >= 7)
            return "hat" if (n >= 6)
            return "öt" if (n >= 5)
            return "négy" if (n >= 4)
            return "három" if (n >= 3)
            return "kettő" if (n >= 2)
            return "egy" if (n >= 1)
            return "nulla" if (n >= 0)
          end)
        end
      end
    end
  end
end