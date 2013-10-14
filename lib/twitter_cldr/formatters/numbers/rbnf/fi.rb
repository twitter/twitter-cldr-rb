# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:fi] = Finnish = Module.new { }
      
      class Finnish::Spellout
        class << self
          def format_spellout_numbering_year(n)
            is_fractional = (n != n.floor)
            return ("miinus " + format_spellout_numbering_year(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return format_spellout_numbering(n) if (n >= 0)
          end
          def format_spellout_numbering(n)
            return format_spellout_cardinal(n) if (n >= 0)
          end
          def format_spellout_cardinal(n)
            is_fractional = (n != n.floor)
            return ("miinus " + format_spellout_cardinal(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_cardinal(n.floor) + " pilkku ") + format_spellout_cardinal(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal((n / 2000000000000.0).floor) + " biljoonaa") + (if (n == 2000000000000) then
                ""
              else
                (" " + format_spellout_cardinal((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal((n / 1000000000000.0).floor) + " biljoona") + (if (n == 1000000000000) then
                ""
              else
                (" " + format_spellout_cardinal((n % 100000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal((n / 2000000000.0).floor) + " miljardia") + (if (n == 2000000000) then
                ""
              else
                (" " + format_spellout_cardinal((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((format_spellout_cardinal((n / 1000000000.0).floor) + " miljardi") + (if (n == 1000000000) then
                ""
              else
                (" " + format_spellout_cardinal((n % 100000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal((n / 2000000.0).floor) + " miljoonaa") + ((n == 2000000) ? ("") : ((" " + format_spellout_cardinal((n % 1000000))))))
            end
            if (n >= 1000000) then
              return ((format_spellout_cardinal((n / 1000000.0).floor) + " miljoona") + ((n == 1000000) ? ("") : ((" " + format_spellout_cardinal((n % 100000))))))
            end
            if (n >= 2000) then
              return ((format_spellout_cardinal((n / 2000.0).floor) + "­tuhatta") + ((n == 2000) ? ("") : (("­" + format_spellout_cardinal((n % 1000))))))
            end
            if (n >= 1000) then
              return ("tuhat" + ((n == 1000) ? ("") : (("­" + format_spellout_cardinal((n % 100))))))
            end
            if (n >= 200) then
              return ((format_spellout_cardinal((n / 200.0).floor) + "­sataa") + ((n == 200) ? ("") : (("­" + format_spellout_cardinal((n % 100))))))
            end
            if (n >= 100) then
              return ("sata" + ((n == 100) ? ("") : (("­" + format_spellout_cardinal((n % 100))))))
            end
            if (n >= 20) then
              return ((format_spellout_cardinal((n / 20.0).floor) + "kymmentä") + ((n == 20) ? ("") : (("­" + format_spellout_cardinal((n % 10))))))
            end
            return (format_spellout_cardinal((n % 10)) + "toista") if (n >= 11)
            return "kymmenen" if (n >= 10)
            return "yhdeksän" if (n >= 9)
            return "kahdeksan" if (n >= 8)
            return "seitsemän" if (n >= 7)
            return "kuusi" if (n >= 6)
            return "viisi" if (n >= 5)
            return "neljä" if (n >= 4)
            return "kolme" if (n >= 3)
            return "kaksi" if (n >= 2)
            return "yksi" if (n >= 1)
            return "nolla" if (n >= 0)
          end
        end
      end
    end
  end
end