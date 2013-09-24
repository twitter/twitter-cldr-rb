# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:pl] = Polish = Class.new do
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
              return ((renderSpelloutCardinalMasculine(n.floor) + " przecinek ") + renderSpelloutCardinalMasculine(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 5000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 5.0e+15).floor) + " biliardów") + (if (n == 5000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 1000000000000000)))
              end))
            end
            if (n >= 2000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2.0e+15).floor) + " biliardy") + (if (n == 2000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 1.0e+15).floor) + " biliard") + (if (n == 1000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 100000000000000)))
              end))
            end
            if (n >= 5000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 5000000000000.0).floor) + " bilionów") + (if (n == 5000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 1000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000000.0).floor) + " biliony") + (if (n == 2000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000000000.0).floor) + " bilion") + (if (n == 1000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 100000000000)))
              end))
            end
            if (n >= 5000000000) then
              return ((renderSpelloutCardinalMasculine((n / 5000000000.0).floor) + " miliardów") + (if (n == 5000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 1000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000.0).floor) + " miliardy") + (if (n == 2000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000000.0).floor) + " miliard") + (if (n == 1000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 100000000)))
              end))
            end
            if (n >= 5000000) then
              return ((renderSpelloutCardinalMasculine((n / 5000000.0).floor) + " milionów") + (if (n == 5000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 1000000)))
              end))
            end
            if (n >= 2000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000.0).floor) + " miliony") + (if (n == 2000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000.0).floor) + " milion") + (if (n == 1000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 100000)))
              end))
            end
            if (n >= 5000) then
              return ((renderSpelloutCardinalMasculine((n / 5000.0).floor) + " tysięcy") + ((n == 5000) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 1000))))))
            end
            if (n >= 2000) then
              return ((renderSpelloutCardinalMasculine((n / 2000.0).floor) + " tysiące") + ((n == 2000) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 1000))))))
            end
            if (n >= 1000) then
              return ((renderSpelloutCardinalMasculine((n / 1000.0).floor) + " tysiąc") + ((n == 1000) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 500) then
              return ((renderSpelloutCardinalFeminine((n / 500.0).floor) + "set") + ((n == 500) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 300) then
              return ((renderSpelloutCardinalFeminine((n / 300.0).floor) + "sta") + ((n == 300) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 200) then
              return ((renderSpelloutCardinalFeminine((n / 200.0).floor) + "ście") + ((n == 200) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 100) then
              return ("sto" + ((n == 100) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 50) then
              return ((renderSpelloutCardinalMasculine((n / 50.0).floor) + "dziesiąt") + ((n == 50) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 40) then
              return ("czterdzieści" + ((n == 40) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 30) then
              return ("trzydzieści" + ((n == 30) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 20) then
              return ("dwadzieścia" + ((n == 20) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            return "dziewiętnaście" if (n >= 19)
            return "osiemnaście" if (n >= 18)
            return "siedemnaście" if (n >= 17)
            return "szesnaście" if (n >= 16)
            return "piętnaście" if (n >= 15)
            return "czternaście" if (n >= 14)
            return "trzynaście" if (n >= 13)
            return "dwanaście" if (n >= 12)
            return "jedenaście" if (n >= 11)
            return "dziesięć" if (n >= 10)
            return "dziewięć" if (n >= 9)
            return "osiem" if (n >= 8)
            return "siedem" if (n >= 7)
            return "sześć" if (n >= 6)
            return "pięć" if (n >= 5)
            return "cztery" if (n >= 4)
            return "trzy" if (n >= 3)
            return "dwa" if (n >= 2)
            return "jeden" if (n >= 1)
            return "zero" if (n >= 0)
          end
          def renderSpelloutCardinalNeuter(n)
            is_fractional = (n != n.floor)
            return ("minus " + renderSpelloutCardinalNeuter(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((renderSpelloutCardinalNeuter(n.floor) + " przecinek ") + renderSpelloutFraction(n.to_s.gsub(/d*./, "").to_f))
            end
            return renderSpelloutCardinalNeuterPriv(n) if (n >= 2)
            return "jedno" if (n >= 1)
            return "zero" if (n >= 0)
          end
          def renderSpelloutCardinalNeuterPriv(n)
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 5000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 5.0e+15).floor) + " biliardów") + (if (n == 5000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuterPriv((n % 1000000000000000)))
              end))
            end
            if (n >= 2000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2.0e+15).floor) + " biliardy") + (if (n == 2000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuterPriv((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 1.0e+15).floor) + " biliard") + (if (n == 1000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuterPriv((n % 100000000000000)))
              end))
            end
            if (n >= 5000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 5000000000000.0).floor) + " bilionów") + (if (n == 5000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuterPriv((n % 1000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000000.0).floor) + " biliony") + (if (n == 2000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuterPriv((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000000000.0).floor) + " bilion") + (if (n == 1000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuterPriv((n % 100000000000)))
              end))
            end
            if (n >= 5000000000) then
              return ((renderSpelloutCardinalMasculine((n / 5000000000.0).floor) + " miliardów") + (if (n == 5000000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuterPriv((n % 1000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000.0).floor) + " miliardy") + (if (n == 2000000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuterPriv((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000000.0).floor) + " miliard") + (if (n == 1000000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuterPriv((n % 100000000)))
              end))
            end
            if (n >= 5000000) then
              return ((renderSpelloutCardinalMasculine((n / 5000000.0).floor) + " milionów") + (if (n == 5000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuterPriv((n % 1000000)))
              end))
            end
            if (n >= 2000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000.0).floor) + " miliony") + (if (n == 2000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuterPriv((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000.0).floor) + " milion") + (if (n == 1000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuterPriv((n % 100000)))
              end))
            end
            if (n >= 5000) then
              return ((renderSpelloutCardinalMasculine((n / 5000.0).floor) + " tysięcy") + ((n == 5000) ? ("") : ((" " + renderSpelloutCardinalNeuterPriv((n % 1000))))))
            end
            if (n >= 2000) then
              return ((renderSpelloutCardinalMasculine((n / 2000.0).floor) + " tysiące") + ((n == 2000) ? ("") : ((" " + renderSpelloutCardinalNeuterPriv((n % 1000))))))
            end
            if (n >= 1000) then
              return ((renderSpelloutCardinalMasculine((n / 1000.0).floor) + " tysiąc") + ((n == 1000) ? ("") : ((" " + renderSpelloutCardinalNeuterPriv((n % 100))))))
            end
            if (n >= 500) then
              return ((renderSpelloutCardinalFeminine((n / 500.0).floor) + "set") + ((n == 500) ? ("") : ((" " + renderSpelloutCardinalNeuterPriv((n % 100))))))
            end
            if (n >= 300) then
              return ((renderSpelloutCardinalFeminine((n / 300.0).floor) + "sta") + ((n == 300) ? ("") : ((" " + renderSpelloutCardinalNeuterPriv((n % 100))))))
            end
            if (n >= 200) then
              return ((renderSpelloutCardinalFeminine((n / 200.0).floor) + "ście") + ((n == 200) ? ("") : ((" " + renderSpelloutCardinalNeuterPriv((n % 100))))))
            end
            if (n >= 100) then
              return ("sto" + ((n == 100) ? ("") : ((" " + renderSpelloutCardinalNeuterPriv((n % 100))))))
            end
            if (n >= 50) then
              return ((renderSpelloutCardinalNeuterPriv((n / 50.0).floor) + "dziesiąt") + ((n == 50) ? ("") : ((" " + renderSpelloutCardinalNeuterPriv((n % 10))))))
            end
            if (n >= 40) then
              return ("czterdzieści" + ((n == 40) ? ("") : ((" " + renderSpelloutCardinalNeuterPriv((n % 10))))))
            end
            if (n >= 30) then
              return ("trzydzieści" + ((n == 30) ? ("") : ((" " + renderSpelloutCardinalNeuterPriv((n % 10))))))
            end
            if (n >= 20) then
              return ("dwadzieścia" + ((n == 20) ? ("") : ((" " + renderSpelloutCardinalNeuterPriv((n % 10))))))
            end
            return renderSpelloutCardinalMasculine(n) if (n >= 2)
            return "jeden" if (n >= 1)
          end
          private(:renderSpelloutCardinalNeuterPriv)
          def renderSpelloutCardinalFeminine(n)
            is_fractional = (n != n.floor)
            return ("minus " + renderSpelloutCardinalFeminine(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((renderSpelloutCardinalFeminine(n.floor) + " przecinek ") + renderSpelloutFraction(n.to_s.gsub(/d*./, "").to_f))
            end
            return renderSpelloutCardinalFemininePriv(n) if (n >= 2)
            return "jedna" if (n >= 1)
            return "zero" if (n >= 0)
          end
          def renderSpelloutCardinalFemininePriv(n)
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 5000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 5.0e+15).floor) + " biliardów") + (if (n == 5000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFemininePriv((n % 1000000000000000)))
              end))
            end
            if (n >= 2000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2.0e+15).floor) + " biliardy") + (if (n == 2000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFemininePriv((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 1.0e+15).floor) + " biliard") + (if (n == 1000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFemininePriv((n % 100000000000000)))
              end))
            end
            if (n >= 5000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 5000000000000.0).floor) + " bilionów") + (if (n == 5000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFemininePriv((n % 1000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000000.0).floor) + " biliony") + (if (n == 2000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFemininePriv((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000000000.0).floor) + " bilion") + (if (n == 1000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFemininePriv((n % 100000000000)))
              end))
            end
            if (n >= 5000000000) then
              return ((renderSpelloutCardinalMasculine((n / 5000000000.0).floor) + " miliardów") + (if (n == 5000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFemininePriv((n % 1000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000.0).floor) + " miliardy") + (if (n == 2000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFemininePriv((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000000.0).floor) + " miliard") + (if (n == 1000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFemininePriv((n % 100000000)))
              end))
            end
            if (n >= 5000000) then
              return ((renderSpelloutCardinalMasculine((n / 5000000.0).floor) + " milionów") + (if (n == 5000000) then
                ""
              else
                (" " + renderSpelloutCardinalFemininePriv((n % 1000000)))
              end))
            end
            if (n >= 2000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000.0).floor) + " miliony") + (if (n == 2000000) then
                ""
              else
                (" " + renderSpelloutCardinalFemininePriv((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000.0).floor) + " milion") + (if (n == 1000000) then
                ""
              else
                (" " + renderSpelloutCardinalFemininePriv((n % 100000)))
              end))
            end
            if (n >= 5000) then
              return ((renderSpelloutCardinalMasculine((n / 5000.0).floor) + " tysięcy") + (if (n == 5000) then
                ""
              else
                (" " + renderSpelloutCardinalFemininePriv((n % 1000)))
              end))
            end
            if (n >= 2000) then
              return ((renderSpelloutCardinalMasculine((n / 2000.0).floor) + " tysiące") + (if (n == 2000) then
                ""
              else
                (" " + renderSpelloutCardinalFemininePriv((n % 1000)))
              end))
            end
            if (n >= 1000) then
              return ((renderSpelloutCardinalMasculine((n / 1000.0).floor) + " tysiąc") + (if (n == 1000) then
                ""
              else
                (" " + renderSpelloutCardinalFemininePriv((n % 100)))
              end))
            end
            if (n >= 500) then
              return ((renderSpelloutCardinalFeminine((n / 500.0).floor) + "set") + ((n == 500) ? ("") : ((" " + renderSpelloutCardinalFemininePriv((n % 100))))))
            end
            if (n >= 300) then
              return ((renderSpelloutCardinalFeminine((n / 300.0).floor) + "sta") + ((n == 300) ? ("") : ((" " + renderSpelloutCardinalFemininePriv((n % 100))))))
            end
            if (n >= 200) then
              return ((renderSpelloutCardinalFeminine((n / 200.0).floor) + "ście") + ((n == 200) ? ("") : ((" " + renderSpelloutCardinalFemininePriv((n % 100))))))
            end
            if (n >= 100) then
              return ("sto" + ((n == 100) ? ("") : ((" " + renderSpelloutCardinalFemininePriv((n % 100))))))
            end
            if (n >= 50) then
              return ((renderSpelloutCardinalFemininePriv((n / 50.0).floor) + "dziesiąt") + ((n == 50) ? ("") : ((" " + renderSpelloutCardinalFemininePriv((n % 10))))))
            end
            if (n >= 40) then
              return ("czterdzieści" + ((n == 40) ? ("") : ((" " + renderSpelloutCardinalFemininePriv((n % 10))))))
            end
            if (n >= 30) then
              return ("trzydzieści" + ((n == 30) ? ("") : ((" " + renderSpelloutCardinalFemininePriv((n % 10))))))
            end
            if (n >= 20) then
              return ("dwadzieścia" + ((n == 20) ? ("") : ((" " + renderSpelloutCardinalFemininePriv((n % 10))))))
            end
            return renderSpelloutCardinalMasculine(n) if (n >= 3)
            return "dwie" if (n >= 2)
            return "jeden" if (n >= 1)
          end
          private(:renderSpelloutCardinalFemininePriv)
          def renderSpelloutFraction(n)
            return (n / 10000000000.0).floor.to_s if (n >= 10000000000)
            if (n >= 1000000000) then
              return renderSpelloutFractionDigits((n / 1000000000.0).floor)
            end
            if (n >= 100000000) then
              return renderSpelloutFractionDigits((n / 100000000.0).floor)
            end
            if (n >= 10000000) then
              return renderSpelloutFractionDigits((n / 10000000.0).floor)
            end
            if (n >= 1000000) then
              return renderSpelloutFractionDigits((n / 1000000.0).floor)
            end
            return renderSpelloutFractionDigits((n / 100000.0).floor) if (n >= 100000)
            return renderSpelloutFractionDigits((n / 10000.0).floor) if (n >= 10000)
            return renderSpelloutFractionDigits((n / 1000.0).floor) if (n >= 1000)
            return renderSpelloutFractionDigits((n / 100.0).floor) if (n >= 100)
            return renderSpelloutFractionDigits((n / 10.0).floor) if (n >= 10)
          end
          private(:renderSpelloutFraction)
          def renderSpelloutFractionDigits(n)
            if (n >= 10) then
              return ((renderSpelloutFractionDigits((n / 10.0).floor) + " ") + renderSpelloutFractionDigits((n % 10)))
            end
            return renderSpelloutCardinalMasculine(n) if (n >= 0)
          end
          private(:renderSpelloutFractionDigits))
        end
      end
    end
  end
end