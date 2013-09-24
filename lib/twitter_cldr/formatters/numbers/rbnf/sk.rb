# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:sk] = Slovak = Class.new do
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
              return ((renderSpelloutCardinalMasculine(n.floor) + " čiarka ") + renderSpelloutCardinalMasculine(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 5000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 5.0e+15).floor) + " biliardov") + (if (n == 5000000000000000) then
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
              return ((renderSpelloutCardinalMasculine((n / 1.0e+15).floor) + " biliarda") + (if (n == 1000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 100000000000000)))
              end))
            end
            if (n >= 5000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 5000000000000.0).floor) + " biliónov") + (if (n == 5000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 1000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000000.0).floor) + " bilióny") + (if (n == 2000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000000000.0).floor) + " bilión") + (if (n == 1000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 100000000000)))
              end))
            end
            if (n >= 5000000000) then
              return ((renderSpelloutCardinalMasculine((n / 5000000000.0).floor) + " miliardov") + (if (n == 5000000000) then
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
              return ((renderSpelloutCardinalMasculine((n / 1000000000.0).floor) + " miliarda") + (if (n == 1000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 100000000)))
              end))
            end
            if (n >= 5000000) then
              return ((renderSpelloutCardinalMasculine((n / 5000000.0).floor) + " miliónov") + (if (n == 5000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 1000000)))
              end))
            end
            if (n >= 2000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000.0).floor) + " milióny") + (if (n == 2000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000.0).floor) + " milión") + (if (n == 1000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 100000)))
              end))
            end
            if (n >= 1000) then
              return ((renderSpelloutCardinalFeminine((n / 1000.0).floor) + " tisíc") + ((n == 1000) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 100) then
              return ((renderSpelloutCardinalFeminine((n / 100.0).floor) + "­sto") + ((n == 100) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 50) then
              return ((renderSpelloutCardinalMasculine((n / 50.0).floor) + "desiat") + ((n == 50) ? ("") : (("­" + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 40) then
              return ("štyridsať" + ((n == 40) ? ("") : (("­" + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 30) then
              return ("trisať" + ((n == 30) ? ("") : (("­" + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 20) then
              return ("dvasať" + ((n == 20) ? ("") : (("­" + renderSpelloutCardinalMasculine((n % 10))))))
            end
            return "devätnásť" if (n >= 19)
            return "osemnásť" if (n >= 18)
            return "sedemnásť" if (n >= 17)
            return "šestnásť" if (n >= 16)
            return "pätnásť" if (n >= 15)
            return "štrnásť" if (n >= 14)
            return "trinásť" if (n >= 13)
            return "dvaásť" if (n >= 12)
            return "jedenásť" if (n >= 11)
            return "desať" if (n >= 10)
            return "deväť" if (n >= 9)
            return "osem" if (n >= 8)
            return "sedem" if (n >= 7)
            return "šesť" if (n >= 6)
            return "päť" if (n >= 5)
            return "štyri" if (n >= 4)
            return "tri" if (n >= 3)
            return "dva" if (n >= 2)
            return "jeden" if (n >= 1)
            return "nula" if (n >= 0)
          end
          def renderSpelloutCardinalNeuter(n)
            is_fractional = (n != n.floor)
            return ("minus " + renderSpelloutCardinalNeuter(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((renderSpelloutCardinalNeuter(n.floor) + " čiarka ") + renderSpelloutCardinalNeuter(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 5000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 5.0e+15).floor) + " biliardov") + (if (n == 5000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 1000000000000000)))
              end))
            end
            if (n >= 2000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2.0e+15).floor) + " biliardy") + (if (n == 2000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 1.0e+15).floor) + " biliarda") + (if (n == 1000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 100000000000000)))
              end))
            end
            if (n >= 5000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 5000000000000.0).floor) + " biliónov") + (if (n == 5000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 1000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000000.0).floor) + " bilióny") + (if (n == 2000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000000000.0).floor) + " bilión") + (if (n == 1000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 100000000000)))
              end))
            end
            if (n >= 5000000000) then
              return ((renderSpelloutCardinalMasculine((n / 5000000000.0).floor) + " miliardov") + (if (n == 5000000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 1000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000.0).floor) + " miliardy") + (if (n == 2000000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000000.0).floor) + " miliarda") + (if (n == 1000000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 100000000)))
              end))
            end
            if (n >= 5000000) then
              return ((renderSpelloutCardinalMasculine((n / 5000000.0).floor) + " miliónov") + (if (n == 5000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 1000000)))
              end))
            end
            if (n >= 2000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000.0).floor) + " milióny") + (if (n == 2000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000.0).floor) + " milión") + (if (n == 1000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 100000)))
              end))
            end
            if (n >= 1000) then
              return ((renderSpelloutCardinalFeminine((n / 1000.0).floor) + " tisíc") + ((n == 1000) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 100))))))
            end
            if (n >= 100) then
              return ((renderSpelloutCardinalFeminine((n / 100.0).floor) + "­sto") + ((n == 100) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 100))))))
            end
            if (n >= 50) then
              return ((renderSpelloutCardinalNeuter((n / 50.0).floor) + "desiat") + ((n == 50) ? ("") : (("­" + renderSpelloutCardinalNeuter((n % 10))))))
            end
            if (n >= 40) then
              return ("štyridsať" + ((n == 40) ? ("") : (("­" + renderSpelloutCardinalNeuter((n % 10))))))
            end
            if (n >= 30) then
              return ("trisať" + ((n == 30) ? ("") : (("­" + renderSpelloutCardinalNeuter((n % 10))))))
            end
            if (n >= 20) then
              return ("dvasať" + ((n == 20) ? ("") : (("­" + renderSpelloutCardinalNeuter((n % 10))))))
            end
            return renderSpelloutCardinalMasculine(n) if (n >= 3)
            return "dve" if (n >= 2)
            return "jedno" if (n >= 1)
            return "nula" if (n >= 0)
          end
          def renderSpelloutCardinalFeminine(n)
            is_fractional = (n != n.floor)
            return ("minus " + renderSpelloutCardinalFeminine(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((renderSpelloutCardinalFeminine(n.floor) + " čiarka ") + renderSpelloutCardinalFeminine(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 5000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 5.0e+15).floor) + " biliardov") + (if (n == 5000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 1000000000000000)))
              end))
            end
            if (n >= 2000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2.0e+15).floor) + " biliardy") + (if (n == 2000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 1.0e+15).floor) + " biliarda") + (if (n == 1000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 100000000000000)))
              end))
            end
            if (n >= 5000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 5000000000000.0).floor) + " biliónov") + (if (n == 5000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 1000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000000.0).floor) + " bilióny") + (if (n == 2000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000000000.0).floor) + " bilión") + (if (n == 1000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 100000000000)))
              end))
            end
            if (n >= 5000000000) then
              return ((renderSpelloutCardinalMasculine((n / 5000000000.0).floor) + " miliardov") + (if (n == 5000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 1000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000.0).floor) + " miliardy") + (if (n == 2000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000000.0).floor) + " miliarda") + (if (n == 1000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 100000000)))
              end))
            end
            if (n >= 5000000) then
              return ((renderSpelloutCardinalMasculine((n / 5000000.0).floor) + " miliónov") + (if (n == 5000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 1000000)))
              end))
            end
            if (n >= 2000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000.0).floor) + " milióny") + (if (n == 2000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000.0).floor) + " milión") + (if (n == 1000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 100000)))
              end))
            end
            if (n >= 1000) then
              return ((renderSpelloutCardinalFeminine((n / 1000.0).floor) + " tisíc") + ((n == 1000) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 100) then
              return ((renderSpelloutCardinalFeminine((n / 100.0).floor) + "­sto") + ((n == 100) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 50) then
              return ((renderSpelloutCardinalFeminine((n / 50.0).floor) + "desiat") + ((n == 50) ? ("") : (("­" + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 40) then
              return ("štyridsať" + ((n == 40) ? ("") : (("­" + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 30) then
              return ("trisať" + ((n == 30) ? ("") : (("­" + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 20) then
              return ("dvasať" + ((n == 20) ? ("") : (("­" + renderSpelloutCardinalFeminine((n % 10))))))
            end
            return renderSpelloutCardinalMasculine(n) if (n >= 3)
            return "dve" if (n >= 2)
            return "jedna" if (n >= 1)
            return "nula" if (n >= 0)
          end)
        end
      end
    end
  end
end