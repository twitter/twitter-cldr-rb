# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:da] = Danish = Module.new { }
      
      class Danish::Spellout
        class << self
          def format_spellout_numbering_year(n)
            is_fractional = (n != n.floor)
            return ("minus " + format_spellout_numbering_year(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return format_spellout_numbering(n) if (n >= 10000)
            if (n >= 1100) then
              return ((format_spellout_numbering_year((n / 1100.0).floor) + "­hundred") + ((n == 1100) ? ("") : ((" og " + format_spellout_numbering_year((n % 100))))))
            end
            return format_spellout_numbering(n) if (n >= 0)
          end
          def format_spellout_numbering(n)
            return format_spellout_cardinal_reale(n) if (n >= 0)
          end
          def format_spellout_cardinal_neuter(n)
            is_fractional = (n != n.floor)
            return ("minus " + format_spellout_cardinal_neuter(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_cardinal_neuter(n.floor) + " komma ") + format_spellout_cardinal_neuter(n.to_s.gsub(/d*./, "").to_f))
            end
            return format_spellout_cardinal_reale(n) if (n >= 2)
            return "et" if (n >= 1)
            return "nul" if (n >= 0)
          end
          def format_spellout_cardinal_masculine(n)
            return format_spellout_cardinal_reale(n) if (n >= 0)
          end
          def format_spellout_cardinal_feminine(n)
            return format_spellout_cardinal_reale(n) if (n >= 0)
          end
          def format_spellout_cardinal_reale(n)
            is_fractional = (n != n.floor)
            return ("minus " + format_spellout_cardinal_reale(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_cardinal_reale(n.floor) + " komma ") + format_spellout_cardinal_reale(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_reale((n / 2.0e+15).floor) + " billiarder") + (if (n == 2000000000000000) then
                ""
              else
                (" og " + format_spellout_cardinal_reale((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("en billiard" + (if (n == 1000000000000000) then
                ""
              else
                (" og " + format_spellout_cardinal_reale((n % 100000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_reale((n / 2000000000000.0).floor) + " billioner") + (if (n == 2000000000000) then
                ""
              else
                (" og " + format_spellout_cardinal_reale((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("en billion" + (if (n == 1000000000000) then
                ""
              else
                (" og " + format_spellout_cardinal_reale((n % 100000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_reale((n / 2000000000.0).floor) + " milliarder") + (if (n == 2000000000) then
                ""
              else
                (" og " + format_spellout_cardinal_reale((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("en milliard" + (if (n == 1000000000) then
                ""
              else
                (" og " + format_spellout_cardinal_reale((n % 100000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_reale((n / 2000000.0).floor) + " millioner") + (if (n == 2000000) then
                ""
              else
                (" og " + format_spellout_cardinal_reale((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ("en million" + (if (n == 1000000) then
                ""
              else
                (" og " + format_spellout_cardinal_reale((n % 100000)))
              end))
            end
            if (n >= 2000) then
              return ((format_spellout_cardinal_neuter((n / 2000.0).floor) + " tusind") + (if (n == 2000) then
                ""
              else
                (" og " + format_spellout_cardinal_reale((n % 1000)))
              end))
            end
            if (n >= 1000) then
              return ("et tusinde" + ((n == 1000) ? ("") : ((" og " + format_spellout_cardinal_reale((n % 100))))))
            end
            if (n >= 200) then
              return ((format_spellout_cardinal_neuter((n / 200.0).floor) + "­hundred") + ((n == 200) ? ("") : ((" og " + format_spellout_cardinal_reale((n % 100))))))
            end
            if (n >= 100) then
              return ("et­hundrede" + ((n == 100) ? ("") : ((" og " + format_spellout_cardinal_reale((n % 100))))))
            end
            if (n >= 90) then
              return (((n == 90) ? ("") : ((format_spellout_cardinal_reale((n % 10)) + "­og­"))) + "halvfems")
            end
            if (n >= 80) then
              return (((n == 80) ? ("") : ((format_spellout_cardinal_reale((n % 10)) + "­og­"))) + "firs")
            end
            if (n >= 70) then
              return (((n == 70) ? ("") : ((format_spellout_cardinal_reale((n % 10)) + "­og­"))) + "halvfjerds")
            end
            if (n >= 60) then
              return (((n == 60) ? ("") : ((format_spellout_cardinal_reale((n % 10)) + "­og­"))) + "tres")
            end
            if (n >= 50) then
              return (((n == 50) ? ("") : ((format_spellout_cardinal_reale((n % 10)) + "­og­"))) + "halvtreds")
            end
            if (n >= 40) then
              return (((n == 40) ? ("") : ((format_spellout_cardinal_reale((n % 10)) + "­og­"))) + "fyrre")
            end
            if (n >= 30) then
              return (((n == 30) ? ("") : ((format_spellout_cardinal_reale((n % 10)) + "­og­"))) + "tredive")
            end
            if (n >= 20) then
              return (((n == 20) ? ("") : ((format_spellout_cardinal_reale((n % 10)) + "­og­"))) + "tyve")
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
          end
        end
      end
    end
  end
end