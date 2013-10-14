# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:hu] = Hungarian = Module.new { }
      
      class Hungarian::Spellout
        class << self
          def format_spellout_numbering_year(n)
            is_fractional = (n != n.floor)
            return ("minusz " + format_spellout_numbering_year(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return format_spellout_numbering(n) if (n >= 10000)
            if (n >= 1100) then
              return ((format_spellout_numbering_year((n / 1100.0).floor) + "­száz") + ((n == 1100) ? ("") : (("­" + format_spellout_numbering_year((n % 100))))))
            end
            return format_spellout_numbering(n) if (n >= 0)
          end
          def format_spellout_numbering(n)
            return format_spellout_cardinal(n) if (n >= 0)
          end
          def format_spellout_cardinal(n)
            is_fractional = (n != n.floor)
            return ("minusz " + format_spellout_cardinal(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_cardinal(n.floor) + " vessző ") + format_spellout_cardinal(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 1000000000000000) then
              return ((format_spellout_cardinal((n / 1.0e+15).floor) + " billiárd") + (if (n == 1000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal((n % 100000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal((n / 1000000000000.0).floor) + " billió") + (if (n == 1000000000000) then
                ""
              else
                (" " + format_spellout_cardinal((n % 100000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((format_spellout_cardinal((n / 1000000000.0).floor) + " milliárd") + (if (n == 1000000000) then
                ""
              else
                (" " + format_spellout_cardinal((n % 100000000)))
              end))
            end
            if (n >= 1000000) then
              return ((format_spellout_cardinal((n / 1000000.0).floor) + " millió") + ((n == 1000000) ? ("") : ((" " + format_spellout_cardinal((n % 100000))))))
            end
            if (n >= 1000) then
              return ((format_spellout_cardinal((n / 1000.0).floor) + "­ezer") + ((n == 1000) ? ("") : ((" " + format_spellout_cardinal((n % 100))))))
            end
            if (n >= 100) then
              return ((format_spellout_cardinal((n / 100.0).floor) + "­száz") + ((n == 100) ? ("") : (("­" + format_spellout_cardinal((n % 100))))))
            end
            if (n >= 90) then
              return ("kilencven" + ((n == 90) ? ("") : (("­" + format_spellout_cardinal((n % 10))))))
            end
            if (n >= 80) then
              return ("nyolcvan" + ((n == 80) ? ("") : (("­" + format_spellout_cardinal((n % 10))))))
            end
            if (n >= 70) then
              return ("hetven" + ((n == 70) ? ("") : (("­" + format_spellout_cardinal((n % 10))))))
            end
            if (n >= 60) then
              return ("hatvan" + ((n == 60) ? ("") : (("­" + format_spellout_cardinal((n % 10))))))
            end
            if (n >= 50) then
              return ("ötven" + ((n == 50) ? ("") : (("­" + format_spellout_cardinal((n % 10))))))
            end
            if (n >= 40) then
              return ("negyven" + ((n == 40) ? ("") : (("­" + format_spellout_cardinal((n % 10))))))
            end
            if (n >= 30) then
              return ("harminc" + ((n == 30) ? ("") : (("­" + format_spellout_cardinal((n % 10))))))
            end
            return ("huszon­" + format_spellout_cardinal((n % 10))) if (n >= 21)
            return "húsz" if (n >= 20)
            return ("tizen­" + format_spellout_cardinal((n % 10))) if (n >= 11)
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
          end
        end
      end
    end
  end
end