# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:sq] = Albanian = Class.new do
        class << self
          (def renderSpelloutNumberingYear(n)
            is_fractional = (n != n.floor)
            return n.to_s if is_fractional and (n > 1)
            return renderSpelloutNumbering(n) if (n >= 0)
          end
          def renderSpelloutNumbering(n)
            return renderSpelloutCardinalMasculine(n) if (n >= 0)
          end
          def renderSpelloutCardinalMasculine(n)
            is_fractional = (n != n.floor)
            return ("minus " + renderSpelloutCardinalMasculine(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((renderSpelloutCardinalMasculine(n.floor) + " presje ") + renderSpelloutCardinalMasculine(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((renderSpelloutCardinalFeminine((n / 2.0e+15).floor) + " biliarë") + (if (n == 2000000000000000) then
                ""
              else
                (" e " + renderSpelloutCardinalMasculine((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("një biliar" + (if (n == 1000000000000000) then
                ""
              else
                (" e " + renderSpelloutCardinalMasculine((n % 100000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((renderSpelloutCardinalFeminine((n / 2000000000000.0).floor) + " bilionë") + (if (n == 2000000000000) then
                ""
              else
                (" e " + renderSpelloutCardinalMasculine((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("një bilion" + (if (n == 1000000000000) then
                ""
              else
                (" e " + renderSpelloutCardinalMasculine((n % 100000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((renderSpelloutCardinalFeminine((n / 2000000000.0).floor) + " miliarë") + (if (n == 2000000000) then
                ""
              else
                (" e " + renderSpelloutCardinalMasculine((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("një miliar" + (if (n == 1000000000) then
                ""
              else
                (" e " + renderSpelloutCardinalMasculine((n % 100000000)))
              end))
            end
            if (n >= 2000000) then
              return ((renderSpelloutCardinalFeminine((n / 2000000.0).floor) + " milionë") + (if (n == 2000000) then
                ""
              else
                (" e " + renderSpelloutCardinalMasculine((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ("një milion" + (if (n == 1000000) then
                ""
              else
                (" e " + renderSpelloutCardinalMasculine((n % 100000)))
              end))
            end
            if (n >= 1000) then
              return ((renderSpelloutCardinalMasculine((n / 1000.0).floor) + " mijë") + ((n == 1000) ? ("") : ((" e " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 100) then
              return ((renderSpelloutCardinalMasculine((n / 100.0).floor) + "qind") + ((n == 100) ? ("") : ((" e " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 50) then
              return ((renderSpelloutCardinalFeminine((n / 50.0).floor) + "dhjetë") + ((n == 50) ? ("") : ((" e " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 40) then
              return ("dyzet" + ((n == 40) ? ("") : ((" e " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 30) then
              return ("tridhjetë" + ((n == 30) ? ("") : ((" e " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 20) then
              return ("njëzet" + ((n == 20) ? ("") : ((" e " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 11) then
              return (renderSpelloutCardinalMasculine((n % 10)) + "mbëdhjetë")
            end
            return "dhjetë" if (n >= 10)
            return "nëntë" if (n >= 9)
            return "tetë" if (n >= 8)
            return "shtatë" if (n >= 7)
            return "gjashtë" if (n >= 6)
            return "pesë" if (n >= 5)
            return "katër" if (n >= 4)
            return "tre" if (n >= 3)
            return "dy" if (n >= 2)
            return "një" if (n >= 1)
            return "zero" if (n >= 0)
          end
          def renderSpelloutCardinalFeminine(n)
            is_fractional = (n != n.floor)
            return ("minus " + renderSpelloutCardinalFeminine(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((renderSpelloutCardinalFeminine(n.floor) + " presje ") + renderSpelloutCardinalFeminine(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((renderSpelloutCardinalFeminine((n / 2.0e+15).floor) + " biliarë") + (if (n == 2000000000000000) then
                ""
              else
                (" e " + renderSpelloutCardinalFeminine((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("një biliar" + (if (n == 1000000000000000) then
                ""
              else
                (" e " + renderSpelloutCardinalFeminine((n % 100000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((renderSpelloutCardinalFeminine((n / 2000000000000.0).floor) + " bilionë") + (if (n == 2000000000000) then
                ""
              else
                (" e " + renderSpelloutCardinalFeminine((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("një bilion" + (if (n == 1000000000000) then
                ""
              else
                (" e " + renderSpelloutCardinalFeminine((n % 100000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((renderSpelloutCardinalFeminine((n / 2000000000.0).floor) + " miliarë") + (if (n == 2000000000) then
                ""
              else
                (" e " + renderSpelloutCardinalFeminine((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("një miliar" + (if (n == 1000000000) then
                ""
              else
                (" e " + renderSpelloutCardinalFeminine((n % 100000000)))
              end))
            end
            if (n >= 2000000) then
              return ((renderSpelloutCardinalFeminine((n / 2000000.0).floor) + " milionë") + (if (n == 2000000) then
                ""
              else
                (" e " + renderSpelloutCardinalFeminine((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ("një milion" + (if (n == 1000000) then
                ""
              else
                (" e " + renderSpelloutCardinalFeminine((n % 100000)))
              end))
            end
            if (n >= 1000) then
              return ((renderSpelloutCardinalMasculine((n / 1000.0).floor) + " mijë") + ((n == 1000) ? ("") : ((" e " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 100) then
              return ((renderSpelloutCardinalMasculine((n / 100.0).floor) + "qind") + ((n == 100) ? ("") : ((" e " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 50) then
              return ((renderSpelloutCardinalFeminine((n / 50.0).floor) + "dhjetë") + ((n == 50) ? ("") : ((" e " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 40) then
              return ("dyzet" + ((n == 40) ? ("") : ((" e " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 30) then
              return ("tridhjetë" + ((n == 30) ? ("") : ((" e " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 20) then
              return ("njëzet" + ((n == 20) ? ("") : ((" e " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            return renderSpelloutCardinalMasculine(n) if (n >= 4)
            return "tri" if (n >= 3)
            return "dy" if (n >= 2)
            return "një" if (n >= 1)
            return "zero" if (n >= 0)
          end)
        end
      end
    end
  end
end