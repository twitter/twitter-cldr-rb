# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:fil] = Filipino = Class.new do
        class << self
          (def renderSpelloutNumberingYear(n)
            is_fractional = (n != n.floor)
            return n.to_s if is_fractional and (n > 1)
            return renderSpelloutNumbering(n) if (n >= 0)
          end
          def renderSpelloutNumbering(n)
            return renderSpelloutCardinal(n) if (n >= 0)
          end
          def renderNumberTimes(n)
            if (n >= 1000) then
              return ((renderNumberTimes((n / 1000.0).floor) + " libó") + ((n == 1000) ? ("") : (("’t " + renderNumberTimes((n % 100))))))
            end
            if (n >= 100) then
              return ((renderNumberTimes((n / 100.0).floor) + " daán") + ((n == 100) ? ("") : ((" at " + renderNumberTimes((n % 100))))))
            end
            if (n >= 20) then
              return ((renderNumberTimes((n / 20.0).floor) + " pû") + ((n == 20) ? ("") : (("’t " + renderNumberTimes((n % 10))))))
            end
            return ("labíng-" + renderNumberTimes((n % 10))) if (n >= 11)
            return "sampûng" if (n >= 10)
            return "siyám na" if (n >= 9)
            return "walóng" if (n >= 8)
            return "pitóng" if (n >= 7)
            return "anim na" if (n >= 6)
            return "limáng" if (n >= 5)
            return "ápat na" if (n >= 4)
            return "tatlóng" if (n >= 3)
            return "dalawáng" if (n >= 2)
            return "isáng" if (n >= 1)
          end
          private(:renderNumberTimes)
          def renderSpelloutCardinal(n)
            is_fractional = (n != n.floor)
            return ("minus " + renderSpelloutCardinal(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((renderSpelloutCardinal(n.floor) + " tuldok ") + renderSpelloutCardinal(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 1000000000000000) then
              return ((renderNumberTimes((n / 1.0e+15).floor) + " katrilyón") + (if (n == 1000000000000000) then
                ""
              else
                (" at " + renderSpelloutCardinal((n % 100000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((renderNumberTimes((n / 1000000000000.0).floor) + " trilyón") + (if (n == 1000000000000) then
                ""
              else
                (" at " + renderSpelloutCardinal((n % 100000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((renderNumberTimes((n / 1000000000.0).floor) + " bilyón") + (if (n == 1000000000) then
                ""
              else
                (" at " + renderSpelloutCardinal((n % 100000000)))
              end))
            end
            if (n >= 1000000) then
              return ((renderNumberTimes((n / 1000000.0).floor) + " milyón") + ((n == 1000000) ? ("") : ((" at " + renderSpelloutCardinal((n % 100000))))))
            end
            if (n >= 1000) then
              return ((renderNumberTimes((n / 1000.0).floor) + " libó") + ((n == 1000) ? ("") : (("’t " + renderSpelloutCardinal((n % 100))))))
            end
            if (n >= 100) then
              return ((renderNumberTimes((n / 100.0).floor) + " daán") + ((n == 100) ? ("") : ((" at " + renderSpelloutCardinal((n % 100))))))
            end
            if (n >= 20) then
              return ((renderNumberTimes((n / 20.0).floor) + " pû") + ((n == 20) ? ("") : (("’t " + renderSpelloutCardinal((n % 10))))))
            end
            return ("labíng-" + renderSpelloutCardinal((n % 10))) if (n >= 11)
            return "sampû" if (n >= 10)
            return "siyám" if (n >= 9)
            return "waló" if (n >= 8)
            return "pitó" if (n >= 7)
            return "anim" if (n >= 6)
            return "limá" if (n >= 5)
            return "ápat" if (n >= 4)
            return "tatló" if (n >= 3)
            return "dalawá" if (n >= 2)
            return "isá" if (n >= 1)
            return "walâ" if (n >= 0)
          end
          def renderSpelloutOrdinal(n)
            is_fractional = (n != n.floor)
            return n.to_s if is_fractional and (n > 1)
            return ("ika " + renderSpelloutCardinal(n)) if (n >= 0)
          end
          def renderDigitsOrdinal(n)
            return ("−" + renderDigitsOrdinal(-n)) if (n < 0)
            return ("ika" + n.to_s) if (n >= 0)
          end)
        end
      end
    end
  end
end