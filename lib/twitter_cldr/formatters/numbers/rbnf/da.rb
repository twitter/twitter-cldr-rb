# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:da] = Danish = Class.new do
        class << self
          (def renderSpelloutNumberingYear(n)
            is_fractional = (n != n.floor)
            return ("minus " + renderSpelloutNumberingYear(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return renderSpelloutNumbering(n) if (n >= 10000)
            if (n >= 1100) then
              return ((renderSpelloutNumberingYear((n / 1100.0).floor) + "­hundred") + ((n == 1100) ? ("") : ((" og " + renderSpelloutNumberingYear((n % 100))))))
            end
            return renderSpelloutNumbering(n) if (n >= 0)
          end
          def renderSpelloutNumbering(n)
            return renderSpelloutCardinalReale(n) if (n >= 0)
          end
          def renderSpelloutCardinalNeuter(n)
            is_fractional = (n != n.floor)
            return ("minus " + renderSpelloutCardinalNeuter(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((renderSpelloutCardinalNeuter(n.floor) + " komma ") + renderSpelloutCardinalNeuter(n.to_s.gsub(/d*./, "").to_f))
            end
            return renderSpelloutCardinalReale(n) if (n >= 2)
            return "et" if (n >= 1)
            return "nul" if (n >= 0)
          end
          def renderSpelloutCardinalMasculine(n)
            return renderSpelloutCardinalReale(n) if (n >= 0)
          end
          def renderSpelloutCardinalFeminine(n)
            return renderSpelloutCardinalReale(n) if (n >= 0)
          end
          def renderSpelloutCardinalReale(n)
            is_fractional = (n != n.floor)
            return ("minus " + renderSpelloutCardinalReale(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((renderSpelloutCardinalReale(n.floor) + " komma ") + renderSpelloutCardinalReale(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((renderSpelloutCardinalReale((n / 2.0e+15).floor) + " billiarder") + (if (n == 2000000000000000) then
                ""
              else
                (" og " + renderSpelloutCardinalReale((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("en billiard" + (if (n == 1000000000000000) then
                ""
              else
                (" og " + renderSpelloutCardinalReale((n % 100000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((renderSpelloutCardinalReale((n / 2000000000000.0).floor) + " billioner") + (if (n == 2000000000000) then
                ""
              else
                (" og " + renderSpelloutCardinalReale((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("en billion" + (if (n == 1000000000000) then
                ""
              else
                (" og " + renderSpelloutCardinalReale((n % 100000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((renderSpelloutCardinalReale((n / 2000000000.0).floor) + " milliarder") + (if (n == 2000000000) then
                ""
              else
                (" og " + renderSpelloutCardinalReale((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("en milliard" + (if (n == 1000000000) then
                ""
              else
                (" og " + renderSpelloutCardinalReale((n % 100000000)))
              end))
            end
            if (n >= 2000000) then
              return ((renderSpelloutCardinalReale((n / 2000000.0).floor) + " millioner") + (if (n == 2000000) then
                ""
              else
                (" og " + renderSpelloutCardinalReale((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ("en million" + (if (n == 1000000) then
                ""
              else
                (" og " + renderSpelloutCardinalReale((n % 100000)))
              end))
            end
            if (n >= 2000) then
              return ((renderSpelloutCardinalNeuter((n / 2000.0).floor) + " tusind") + ((n == 2000) ? ("") : ((" og " + renderSpelloutCardinalReale((n % 1000))))))
            end
            if (n >= 1000) then
              return ("et tusinde" + ((n == 1000) ? ("") : ((" og " + renderSpelloutCardinalReale((n % 100))))))
            end
            if (n >= 200) then
              return ((renderSpelloutCardinalNeuter((n / 200.0).floor) + "­hundred") + ((n == 200) ? ("") : ((" og " + renderSpelloutCardinalReale((n % 100))))))
            end
            if (n >= 100) then
              return ("et­hundrede" + ((n == 100) ? ("") : ((" og " + renderSpelloutCardinalReale((n % 100))))))
            end
            if (n >= 90) then
              return (((n == 90) ? ("") : ((renderSpelloutCardinalReale((n % 10)) + "­og­"))) + "halvfems")
            end
            if (n >= 80) then
              return (((n == 80) ? ("") : ((renderSpelloutCardinalReale((n % 10)) + "­og­"))) + "firs")
            end
            if (n >= 70) then
              return (((n == 70) ? ("") : ((renderSpelloutCardinalReale((n % 10)) + "­og­"))) + "halvfjerds")
            end
            if (n >= 60) then
              return (((n == 60) ? ("") : ((renderSpelloutCardinalReale((n % 10)) + "­og­"))) + "tres")
            end
            if (n >= 50) then
              return (((n == 50) ? ("") : ((renderSpelloutCardinalReale((n % 10)) + "­og­"))) + "halvtreds")
            end
            if (n >= 40) then
              return (((n == 40) ? ("") : ((renderSpelloutCardinalReale((n % 10)) + "­og­"))) + "fyrre")
            end
            if (n >= 30) then
              return (((n == 30) ? ("") : ((renderSpelloutCardinalReale((n % 10)) + "­og­"))) + "tredive")
            end
            if (n >= 20) then
              return (((n == 20) ? ("") : ((renderSpelloutCardinalReale((n % 10)) + "­og­"))) + "tyve")
            end
            return "nitten" if (n >= 19)
            return "atten" if (n >= 18)
            return "sytten" if (n >= 17)
            return "seksten" if (n >= 16)
            return "femten" if (n >= 15)
            return "fjorten" if (n >= 14)
            return "tretten" if (n >= 13)
            return "tolv" if (n >= 12)
            return "elve" if (n >= 11)
            return "ti" if (n >= 10)
            return "ni" if (n >= 9)
            return "otte" if (n >= 8)
            return "syv" if (n >= 7)
            return "seks" if (n >= 6)
            return "fem" if (n >= 5)
            return "fire" if (n >= 4)
            return "tre" if (n >= 3)
            return "to" if (n >= 2)
            return "en" if (n >= 1)
            return "nul" if (n >= 0)
          end)
        end
      end
    end
  end
end