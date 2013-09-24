# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:is] = Icelandic = Class.new do
        class << self
          (def renderSpelloutNumberingYear(n)
            is_fractional = (n != n.floor)
            return ("mínus " + renderSpelloutNumberingYear(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return renderSpelloutNumbering(n) if (n >= 10000)
            if (n >= 1100) then
              return ((renderSpelloutNumberingYear((n / 1100.0).floor) + " hundrað") + ((n == 1100) ? ("") : ((" og " + renderSpelloutNumberingYear((n % 100))))))
            end
            return renderSpelloutNumbering(n) if (n >= 0)
          end
          def renderSpelloutNumbering(n)
            return renderSpelloutCardinalMasculine(n) if (n >= 0)
          end
          def renderSpelloutCardinalMasculine(n)
            is_fractional = (n != n.floor)
            return ("mínus " + renderSpelloutCardinalMasculine(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((renderSpelloutCardinalMasculine(n.floor) + " komma ") + renderSpelloutCardinalMasculine(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((renderSpelloutCardinalFeminine((n / 2.0e+15).floor) + " billiarður") + (if (n == 2000000000000000) then
                ""
              else
                (" og " + renderSpelloutCardinalMasculine((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("ein billiarð" + (if (n == 1000000000000000) then
                ""
              else
                (" og " + renderSpelloutCardinalMasculine((n % 100000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((renderSpelloutCardinalFeminine((n / 2000000000000.0).floor) + " billiónur") + (if (n == 2000000000000) then
                ""
              else
                (" og " + renderSpelloutCardinalMasculine((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("ein billión" + (if (n == 1000000000000) then
                ""
              else
                (" og " + renderSpelloutCardinalMasculine((n % 100000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((renderSpelloutCardinalFeminine((n / 2000000000.0).floor) + " milliarður") + (if (n == 2000000000) then
                ""
              else
                (" og " + renderSpelloutCardinalMasculine((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("ein milliarð" + (if (n == 1000000000) then
                ""
              else
                (" og " + renderSpelloutCardinalMasculine((n % 100000000)))
              end))
            end
            if (n >= 2000000) then
              return ((renderSpelloutCardinalFeminine((n / 2000000.0).floor) + " milliónur") + (if (n == 2000000) then
                ""
              else
                (" og " + renderSpelloutCardinalMasculine((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ("ein millión" + (if (n == 1000000) then
                ""
              else
                (" og " + renderSpelloutCardinalMasculine((n % 100000)))
              end))
            end
            if (n >= 1000) then
              return ((renderSpelloutCardinalNeuter((n / 1000.0).floor) + " þúsund") + (if (n == 1000) then
                ""
              else
                (" og " + renderSpelloutCardinalMasculine((n % 100)))
              end))
            end
            if (n >= 100) then
              return ((renderSpelloutCardinalNeuter((n / 100.0).floor) + "­hundrað") + ((n == 100) ? ("") : ((" og " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 90) then
              return ("níutíu" + ((n == 90) ? ("") : ((" og " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 80) then
              return ("áttatíu" + ((n == 80) ? ("") : ((" og " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 70) then
              return ("sjötíu" + ((n == 70) ? ("") : ((" og " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 60) then
              return ("sextíu" + ((n == 60) ? ("") : ((" og " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 50) then
              return ("fimmtíu" + ((n == 50) ? ("") : ((" og " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 40) then
              return ("fjörutíu" + ((n == 40) ? ("") : ((" og " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 30) then
              return ("þrjátíu" + ((n == 30) ? ("") : ((" og " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 20) then
              return ("tuttugu" + ((n == 20) ? ("") : ((" og " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            return "nítján" if (n >= 19)
            return "átján" if (n >= 18)
            return "sautján" if (n >= 17)
            return "sextán" if (n >= 16)
            return "fimmtán" if (n >= 15)
            return "fjórtán" if (n >= 14)
            return "þrettán" if (n >= 13)
            return "tólf" if (n >= 12)
            return "ellefu" if (n >= 11)
            return "tíu" if (n >= 10)
            return "níu" if (n >= 9)
            return "átta" if (n >= 8)
            return "sjó" if (n >= 7)
            return "sex" if (n >= 6)
            return "fimm" if (n >= 5)
            return "fjórir" if (n >= 4)
            return "þrír" if (n >= 3)
            return "tveir" if (n >= 2)
            return "einn" if (n >= 1)
            return "núll" if (n >= 0)
          end
          def renderSpelloutCardinalNeuter(n)
            is_fractional = (n != n.floor)
            return ("mínus " + renderSpelloutCardinalNeuter(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((renderSpelloutCardinalNeuter(n.floor) + " komma ") + renderSpelloutCardinalNeuter(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((renderSpelloutCardinalFeminine((n / 2.0e+15).floor) + " billiarður") + (if (n == 2000000000000000) then
                ""
              else
                (" og " + renderSpelloutCardinalNeuter((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("ein billiarð" + (if (n == 1000000000000000) then
                ""
              else
                (" og " + renderSpelloutCardinalNeuter((n % 100000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((renderSpelloutCardinalFeminine((n / 2000000000000.0).floor) + " billiónur") + (if (n == 2000000000000) then
                ""
              else
                (" og " + renderSpelloutCardinalNeuter((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("ein billión" + (if (n == 1000000000000) then
                ""
              else
                (" og " + renderSpelloutCardinalNeuter((n % 100000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((renderSpelloutCardinalFeminine((n / 2000000000.0).floor) + " milliarður") + (if (n == 2000000000) then
                ""
              else
                (" og " + renderSpelloutCardinalNeuter((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("ein milliarð" + (if (n == 1000000000) then
                ""
              else
                (" og " + renderSpelloutCardinalNeuter((n % 100000000)))
              end))
            end
            if (n >= 2000000) then
              return ((renderSpelloutCardinalFeminine((n / 2000000.0).floor) + " milliónur") + (if (n == 2000000) then
                ""
              else
                (" og " + renderSpelloutCardinalNeuter((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ("ein millión" + (if (n == 1000000) then
                ""
              else
                (" og " + renderSpelloutCardinalNeuter((n % 100000)))
              end))
            end
            if (n >= 1000) then
              return ((renderSpelloutCardinalNeuter((n / 1000.0).floor) + " þúsund") + ((n == 1000) ? ("") : ((" og " + renderSpelloutCardinalNeuter((n % 100))))))
            end
            if (n >= 100) then
              return ((renderSpelloutCardinalNeuter((n / 100.0).floor) + "­hundrað") + ((n == 100) ? ("") : ((" og " + renderSpelloutCardinalNeuter((n % 100))))))
            end
            if (n >= 90) then
              return ("níutíu" + ((n == 90) ? ("") : ((" og " + renderSpelloutCardinalNeuter((n % 10))))))
            end
            if (n >= 80) then
              return ("áttatíu" + ((n == 80) ? ("") : ((" og " + renderSpelloutCardinalNeuter((n % 10))))))
            end
            if (n >= 70) then
              return ("sjötíu" + ((n == 70) ? ("") : ((" og " + renderSpelloutCardinalNeuter((n % 10))))))
            end
            if (n >= 60) then
              return ("sextíu" + ((n == 60) ? ("") : ((" og " + renderSpelloutCardinalNeuter((n % 10))))))
            end
            if (n >= 50) then
              return ("fimmtíu" + ((n == 50) ? ("") : ((" og " + renderSpelloutCardinalNeuter((n % 10))))))
            end
            if (n >= 40) then
              return ("fjörutíu" + ((n == 40) ? ("") : ((" og " + renderSpelloutCardinalNeuter((n % 10))))))
            end
            if (n >= 30) then
              return ("þrjátíu" + ((n == 30) ? ("") : ((" og " + renderSpelloutCardinalNeuter((n % 10))))))
            end
            if (n >= 20) then
              return ("tuttugu" + ((n == 20) ? ("") : ((" og " + renderSpelloutCardinalNeuter((n % 10))))))
            end
            return renderSpelloutCardinalMasculine(n) if (n >= 5)
            return "fjögur" if (n >= 4)
            return "þrjú" if (n >= 3)
            return "tvö" if (n >= 2)
            return "eitt" if (n >= 1)
            return "núll" if (n >= 0)
          end
          def renderSpelloutCardinalFeminine(n)
            is_fractional = (n != n.floor)
            return ("mínus " + renderSpelloutCardinalFeminine(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((renderSpelloutCardinalFeminine(n.floor) + " komma ") + renderSpelloutCardinalFeminine(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((renderSpelloutCardinalFeminine((n / 2.0e+15).floor) + " billiarður") + (if (n == 2000000000000000) then
                ""
              else
                (" og " + renderSpelloutCardinalFeminine((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("ein billiarð" + (if (n == 1000000000000000) then
                ""
              else
                (" og " + renderSpelloutCardinalFeminine((n % 100000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((renderSpelloutCardinalFeminine((n / 2000000000000.0).floor) + " billiónur") + (if (n == 2000000000000) then
                ""
              else
                (" og " + renderSpelloutCardinalFeminine((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("ein billión" + (if (n == 1000000000000) then
                ""
              else
                (" og " + renderSpelloutCardinalFeminine((n % 100000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((renderSpelloutCardinalFeminine((n / 2000000000.0).floor) + " milliarður") + (if (n == 2000000000) then
                ""
              else
                (" og " + renderSpelloutCardinalFeminine((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("ein milliarð" + (if (n == 1000000000) then
                ""
              else
                (" og " + renderSpelloutCardinalFeminine((n % 100000000)))
              end))
            end
            if (n >= 2000000) then
              return ((renderSpelloutCardinalFeminine((n / 2000000.0).floor) + " milliónur") + (if (n == 2000000) then
                ""
              else
                (" og " + renderSpelloutCardinalFeminine((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ("ein millión" + (if (n == 1000000) then
                ""
              else
                (" og " + renderSpelloutCardinalFeminine((n % 100000)))
              end))
            end
            if (n >= 1000) then
              return ((renderSpelloutCardinalNeuter((n / 1000.0).floor) + " þúsund") + ((n == 1000) ? ("") : ((" og " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 100) then
              return ((renderSpelloutCardinalNeuter((n / 100.0).floor) + "­hundrað") + ((n == 100) ? ("") : ((" og " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 90) then
              return ("níutíu" + ((n == 90) ? ("") : ((" og " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 80) then
              return ("áttatíu" + ((n == 80) ? ("") : ((" og " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 70) then
              return ("sjötíu" + ((n == 70) ? ("") : ((" og " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 60) then
              return ("sextíu" + ((n == 60) ? ("") : ((" og " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 50) then
              return ("fimmtíu" + ((n == 50) ? ("") : ((" og " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 40) then
              return ("fjörutíu" + ((n == 40) ? ("") : ((" og " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 30) then
              return ("þrjátíu" + ((n == 30) ? ("") : ((" og " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 20) then
              return ("tuttugu" + ((n == 20) ? ("") : ((" og " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            return renderSpelloutCardinalMasculine(n) if (n >= 5)
            return "fjórar" if (n >= 4)
            return "þrjár" if (n >= 3)
            return "tvær" if (n >= 2)
            return "ein" if (n >= 1)
            return "núll" if (n >= 0)
          end)
        end
      end
    end
  end
end