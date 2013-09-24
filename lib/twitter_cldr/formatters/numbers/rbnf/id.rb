# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:id] = Indonesian = Class.new do
        class << self
          (def renderSpelloutNumberingYear(n)
            is_fractional = (n != n.floor)
            return n.to_s if is_fractional and (n > 1)
            return renderSpelloutNumbering(n) if (n >= 0)
          end
          def renderSpelloutNumbering(n)
            return renderSpelloutCardinal(n) if (n >= 0)
          end
          def renderSpelloutCardinal(n)
            is_fractional = (n != n.floor)
            return ("minus " + renderSpelloutCardinal(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((renderSpelloutCardinal(n.floor) + " titik ") + renderSpelloutCardinal(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 1000000000000000) then
              return ((renderSpelloutCardinal((n / 1.0e+15).floor) + " bilyar") + (if (n == 1000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinal((n % 100000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((renderSpelloutCardinal((n / 1000000000000.0).floor) + " bilyun") + (if (n == 1000000000000) then
                ""
              else
                (" " + renderSpelloutCardinal((n % 100000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((renderSpelloutCardinal((n / 1000000000.0).floor) + " milyar") + (if (n == 1000000000) then
                ""
              else
                (" " + renderSpelloutCardinal((n % 100000000)))
              end))
            end
            if (n >= 1000000) then
              return ((renderSpelloutCardinal((n / 1000000.0).floor) + " juts") + ((n == 1000000) ? ("") : ((" " + renderSpelloutCardinal((n % 100000))))))
            end
            if (n >= 2000) then
              return ((renderSpelloutCardinal((n / 2000.0).floor) + " ribu") + ((n == 2000) ? ("") : ((" " + renderSpelloutCardinal((n % 1000))))))
            end
            if (n >= 1000) then
              return ("seribu" + ((n == 1000) ? ("") : ((" " + renderSpelloutCardinal((n % 100))))))
            end
            if (n >= 200) then
              return ((renderSpelloutCardinal((n / 200.0).floor) + " ratus") + ((n == 200) ? ("") : ((" " + renderSpelloutCardinal((n % 100))))))
            end
            if (n >= 100) then
              return ("seratus" + ((n == 100) ? ("") : ((" " + renderSpelloutCardinal((n % 100))))))
            end
            if (n >= 20) then
              return ((renderSpelloutCardinal((n / 20.0).floor) + " puluh") + ((n == 20) ? ("") : ((" " + renderSpelloutCardinal((n % 10))))))
            end
            return (renderSpelloutCardinal((n % 10)) + " belas") if (n >= 12)
            return "sebelas" if (n >= 11)
            return "sepuluh" if (n >= 10)
            return "sembilan" if (n >= 9)
            return "delapan" if (n >= 8)
            return "tujuh" if (n >= 7)
            return "enam" if (n >= 6)
            return "lima" if (n >= 5)
            return "empat" if (n >= 4)
            return "tiga" if (n >= 3)
            return "dua" if (n >= 2)
            return "satu" if (n >= 1)
            return "kosong" if (n >= 0)
          end
          def renderSpelloutOrdinal(n)
            is_fractional = (n != n.floor)
            return n.to_s if is_fractional and (n > 1)
            return ("ke" + renderSpelloutCardinal(n)) if (n >= 0)
          end
          def renderDigitsOrdinal(n)
            return ("ke−" + -n.to_s) if (n < 0)
            return ("ke" + n.to_s) if (n >= 0)
          end)
        end
      end
    end
  end
end