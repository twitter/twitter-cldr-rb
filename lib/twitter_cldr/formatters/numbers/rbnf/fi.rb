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
              return ((format_spellout_cardinal(n.floor) + " pilkku ") + format_spellout_cardinal((n % 10)))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal((n / 10000000000000).floor) + " biljoonaa") + (if ((n == 2000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal((n % 10000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal((n / 1000000000000).floor) + " biljoona") + (if ((n == 1000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal((n % 1000000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal((n / 10000000000).floor) + " miljardia") + (if ((n == 2000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal((n % 10000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((format_spellout_cardinal((n / 1000000000).floor) + " miljardi") + (if ((n == 1000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal((n % 1000000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal((n / 10000000).floor) + " miljoonaa") + (if ((n == 2000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal((n % 10000000)))
              end))
            end
            if (n >= 1000000) then
              return ((format_spellout_cardinal((n / 1000000).floor) + " miljoona") + (if ((n == 1000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal((n % 1000000)))
              end))
            end
            if (n >= 2000) then
              return ((format_spellout_cardinal((n / 10000).floor) + "­tuhatta") + (if ((n == 2000) or ((n % 10) == 0)) then
                ""
              else
                ("­" + format_spellout_cardinal((n % 10000)))
              end))
            end
            if (n >= 1000) then
              return ("tuhat" + (if ((n == 1000) or ((n % 10) == 0)) then
                ""
              else
                ("­" + format_spellout_cardinal((n % 1000)))
              end))
            end
            if (n >= 200) then
              return ((format_spellout_cardinal((n / 1000).floor) + "­sataa") + (if ((n == 200) or ((n % 10) == 0)) then
                ""
              else
                ("­" + format_spellout_cardinal((n % 1000)))
              end))
            end
            if (n >= 100) then
              return ("sata" + (if ((n == 100) or ((n % 10) == 0)) then
                ""
              else
                ("­" + format_spellout_cardinal((n % 100)))
              end))
            end
            if (n >= 20) then
              return ((format_spellout_cardinal((n / 100).floor) + "kymmentä") + (if ((n == 20) or ((n % 10) == 0)) then
                ""
              else
                ("­" + format_spellout_cardinal((n % 100)))
              end))
            end
            return (format_spellout_cardinal((n % 100)) + "toista") if (n >= 11)
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