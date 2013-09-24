# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:tr] = Turkish = Class.new do
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
            return ("eksi " + renderSpelloutCardinal(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((renderSpelloutCardinal(n.floor) + " virgül ") + renderSpelloutCardinal(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 1000000000000000) then
              return ((renderSpelloutCardinal((n / 1.0e+15).floor) + " katrilyon") + (if (n == 1000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinal((n % 100000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((renderSpelloutCardinal((n / 1000000000000.0).floor) + " trilyon") + (if (n == 1000000000000) then
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
              return ((renderSpelloutCardinal((n / 1000000.0).floor) + " milyon") + ((n == 1000000) ? ("") : ((" " + renderSpelloutCardinal((n % 100000))))))
            end
            if (n >= 2000) then
              return ((renderSpelloutCardinal((n / 2000.0).floor) + " bin") + ((n == 2000) ? ("") : ((" " + renderSpelloutCardinal((n % 1000))))))
            end
            if (n >= 1000) then
              return ("bin" + ((n == 1000) ? ("") : ((" " + renderSpelloutCardinal((n % 100))))))
            end
            if (n >= 200) then
              return ((renderSpelloutCardinal((n / 200.0).floor) + " yüz") + ((n == 200) ? ("") : ((" " + renderSpelloutCardinal((n % 100))))))
            end
            if (n >= 100) then
              return ("yüz" + ((n == 100) ? ("") : ((" " + renderSpelloutCardinal((n % 100))))))
            end
            if (n >= 90) then
              return ("doksan" + ((n == 90) ? ("") : ((" " + renderSpelloutCardinal((n % 10))))))
            end
            if (n >= 80) then
              return ("seksen" + ((n == 80) ? ("") : ((" " + renderSpelloutCardinal((n % 10))))))
            end
            if (n >= 70) then
              return ("yetmiş" + ((n == 70) ? ("") : ((" " + renderSpelloutCardinal((n % 10))))))
            end
            if (n >= 60) then
              return ("altmış" + ((n == 60) ? ("") : ((" " + renderSpelloutCardinal((n % 10))))))
            end
            if (n >= 50) then
              return ("elli" + ((n == 50) ? ("") : ((" " + renderSpelloutCardinal((n % 10))))))
            end
            if (n >= 40) then
              return ("kırk" + ((n == 40) ? ("") : ((" " + renderSpelloutCardinal((n % 10))))))
            end
            if (n >= 30) then
              return ("otuz" + ((n == 30) ? ("") : ((" " + renderSpelloutCardinal((n % 10))))))
            end
            if (n >= 20) then
              return ("yirmi" + ((n == 20) ? ("") : ((" " + renderSpelloutCardinal((n % 10))))))
            end
            if (n >= 10) then
              return ("on" + ((n == 10) ? ("") : ((" " + renderSpelloutCardinal((n % 10))))))
            end
            return "dokuz" if (n >= 9)
            return "sekiz" if (n >= 8)
            return "yedi" if (n >= 7)
            return "altı" if (n >= 6)
            return "beş" if (n >= 5)
            return "dört" if (n >= 4)
            return "üç" if (n >= 3)
            return "iki" if (n >= 2)
            return "bir" if (n >= 1)
            return "sıfır" if (n >= 0)
          end
          def renderInci(n)
            return (" " + renderSpelloutOrdinal(n)) if (n >= 1)
            return "inci" if (n >= 0)
          end
          private(:renderInci)
          def renderNci(n)
            return (" " + renderSpelloutOrdinal(n)) if (n >= 1)
            return "nci" if (n >= 0)
          end
          private(:renderNci)
          def renderNc-(n)
            return (" " + renderSpelloutOrdinal(n)) if (n >= 1)
            return "üncü" if (n >= 0)
          end
          private(:"renderNc-")
          def renderUncu(n)
            return (" " + renderSpelloutOrdinal(n)) if (n >= 1)
            return "uncu" if (n >= 0)
          end
          private(:renderUncu)
          def renderSpelloutOrdinal(n)
            is_fractional = (n != n.floor)
            return ("eksi " + renderSpelloutOrdinal(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return (n.to_s + "'inci") if (n >= 1000000000000000000)
            if (n >= 1000000000000000) then
              return ((renderSpelloutNumbering((n / 1.0e+15).floor) + " katrilyon") + renderUncu((n % 100000000000000)))
            end
            if (n >= 1000000000000) then
              return ((renderSpelloutNumbering((n / 1000000000000.0).floor) + " trilyon") + renderUncu((n % 100000000000)))
            end
            if (n >= 1000000000) then
              return ((renderSpelloutNumbering((n / 1000000000.0).floor) + " milyar") + "ıncı")
            end
            if (n >= 1000000) then
              return ((renderSpelloutNumbering((n / 1000000.0).floor) + " milyon") + renderUncu((n % 100000)))
            end
            if (n >= 2000) then
              return ((renderSpelloutNumbering((n / 2000.0).floor) + " bin") + renderInci((n % 1000)))
            end
            return ("bin" + renderInci((n % 100))) if (n >= 1000)
            if (n >= 200) then
              return ((renderSpelloutNumbering((n / 200.0).floor) + " yüz") + "üncü")
            end
            return ("yüz" + "üncü") if (n >= 100)
            return ("doksan" + "ıncı") if (n >= 90)
            return ("seksen" + renderInci((n % 10))) if (n >= 80)
            return ("yetmiş" + renderInci((n % 10))) if (n >= 70)
            return ("altmış" + "ıncı") if (n >= 60)
            return ("elli" + renderNci((n % 10))) if (n >= 50)
            return ("kırk" + "ıncı") if (n >= 40)
            return ("otuz" + renderUncu((n % 10))) if (n >= 30)
            return ("yirmi" + renderNci((n % 10))) if (n >= 20)
            return ("on" + renderUncu((n % 10))) if (n >= 10)
            return "dokuzuncu" if (n >= 9)
            return "sekizinci" if (n >= 8)
            return "yedinci" if (n >= 7)
            return "altıncı" if (n >= 6)
            return "beşinci" if (n >= 5)
            return "dörtüncü" if (n >= 4)
            return "üçüncü" if (n >= 3)
            return "ikinci" if (n >= 2)
            return "birinci" if (n >= 1)
            return "sıfırıncı" if (n >= 0)
          end
          def renderDigitsOrdinalIndicator(n)
            return "inci" if (n >= 0)
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