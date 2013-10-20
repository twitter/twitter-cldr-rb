# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:cs] = Czech = Module.new { }
      
      class Czech::Spellout
        class << self
          def format_spellout_numbering_year(n)
            is_fractional = (n != n.floor)
            return n.to_s if is_fractional and (n > 1)
            return format_spellout_numbering(n) if (n >= 0)
          end
          def format_spellout_numbering(n)
            return format_spellout_cardinal_masculine(n) if (n >= 0)
          end
          def format_spellout_cardinal_masculine(n)
            is_fractional = (n != n.floor)
            return ("minus " + format_spellout_cardinal_masculine(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_cardinal_masculine(n.floor) + " čárka ") + format_spellout_cardinal_masculine((n % 10)))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 5000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000000000).floor) + " biliardů") + (if ((n == 5000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 10000000000000000)))
              end))
            end
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000000000).floor) + " biliardy") + (if ((n == 2000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 10000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000000000).floor) + " biliarda") + (if ((n == 1000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000000000000)))
              end))
            end
            if (n >= 5000000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000000).floor) + " biliónů") + (if ((n == 5000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 10000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000000).floor) + " bilióny") + (if ((n == 2000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 10000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000000).floor) + " bilión") + (if ((n == 1000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000000000)))
              end))
            end
            if (n >= 5000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000).floor) + " miliardů") + (if ((n == 5000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 10000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000).floor) + " miliardy") + (if ((n == 2000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 10000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000).floor) + " miliarda") + (if ((n == 1000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000000)))
              end))
            end
            if (n >= 5000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000).floor) + " miliónů") + (if ((n == 5000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 10000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000).floor) + " milióny") + (if ((n == 2000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 10000000)))
              end))
            end
            if (n >= 1000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000).floor) + " milión") + (if ((n == 1000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000)))
              end))
            end
            if (n >= 5000) then
              return ((format_spellout_cardinal_feminine((n / 10000).floor) + " tisíc") + (if ((n == 5000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 10000)))
              end))
            end
            if (n >= 2000) then
              return ((format_spellout_cardinal_feminine((n / 10000).floor) + " tisíce") + (if ((n == 2000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 10000)))
              end))
            end
            if (n >= 1000) then
              return ((format_spellout_cardinal_feminine((n / 1000).floor) + " tisíc") + (if ((n == 1000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000)))
              end))
            end
            if (n >= 500) then
              return ((format_spellout_cardinal_feminine((n / 1000).floor) + " set") + (if ((n == 500) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000)))
              end))
            end
            if (n >= 300) then
              return ((format_spellout_cardinal_feminine((n / 1000).floor) + " sta") + (if ((n == 300) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000)))
              end))
            end
            if (n >= 200) then
              return ((format_spellout_cardinal_feminine((n / 1000).floor) + " stě") + (if ((n == 200) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000)))
              end))
            end
            if (n >= 100) then
              return ("sto" + (if ((n == 100) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100)))
              end))
            end
            if (n >= 90) then
              return ("devadesát" + (if ((n == 90) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100)))
              end))
            end
            if (n >= 80) then
              return ("osmdesát" + (if ((n == 80) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100)))
              end))
            end
            if (n >= 70) then
              return ("sedmdesát" + (if ((n == 70) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100)))
              end))
            end
            if (n >= 60) then
              return ("šedesát" + (if ((n == 60) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100)))
              end))
            end
            if (n >= 50) then
              return ("padesát" + (if ((n == 50) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100)))
              end))
            end
            if (n >= 20) then
              return ((format_spellout_cardinal_masculine((n / 100).floor) + "cet") + (if ((n == 20) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100)))
              end))
            end
            return "devatenáct" if (n >= 19)
            return "osmnáct" if (n >= 18)
            return "sedmnáct" if (n >= 17)
            return "šestnáct" if (n >= 16)
            return "patnáct" if (n >= 15)
            return "čtrnáct" if (n >= 14)
            return "třináct" if (n >= 13)
            return "dvanáct" if (n >= 12)
            return "jedenáct" if (n >= 11)
            return "deset" if (n >= 10)
            return "devět" if (n >= 9)
            return "osm" if (n >= 8)
            return "sedm" if (n >= 7)
            return "šest" if (n >= 6)
            return "pět" if (n >= 5)
            return "čtyři" if (n >= 4)
            return "tři" if (n >= 3)
            return "dva" if (n >= 2)
            return "jeden" if (n >= 1)
            return "nula" if (n >= 0)
          end
          def format_spellout_cardinal_neuter(n)
            is_fractional = (n != n.floor)
            return ("minus " + format_spellout_cardinal_neuter(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_cardinal_neuter(n.floor) + " čárka ") + format_spellout_cardinal_neuter((n % 10)))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 5000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000000000).floor) + " biliardů") + (if ((n == 5000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 10000000000000000)))
              end))
            end
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000000000).floor) + " biliardy") + (if ((n == 2000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 10000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000000000).floor) + " biliarda") + (if ((n == 1000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000000000000000)))
              end))
            end
            if (n >= 5000000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000000).floor) + " biliónů") + (if ((n == 5000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 10000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000000).floor) + " bilióny") + (if ((n == 2000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 10000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000000).floor) + " bilión") + (if ((n == 1000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000000000000)))
              end))
            end
            if (n >= 5000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000).floor) + " miliardů") + (if ((n == 5000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 10000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000).floor) + " miliardy") + (if ((n == 2000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 10000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000).floor) + " miliarda") + (if ((n == 1000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000000000)))
              end))
            end
            if (n >= 5000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000).floor) + " miliónů") + (if ((n == 5000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 10000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000).floor) + " milióny") + (if ((n == 2000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 10000000)))
              end))
            end
            if (n >= 1000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000).floor) + " milión") + (if ((n == 1000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000000)))
              end))
            end
            if (n >= 5000) then
              return ((format_spellout_cardinal_feminine((n / 10000).floor) + " tisíc") + (if ((n == 5000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 10000)))
              end))
            end
            if (n >= 2000) then
              return ((format_spellout_cardinal_feminine((n / 10000).floor) + " tisíce") + (if ((n == 2000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 10000)))
              end))
            end
            if (n >= 1000) then
              return ((format_spellout_cardinal_feminine((n / 1000).floor) + " tisíc") + (if ((n == 1000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000)))
              end))
            end
            if (n >= 500) then
              return ((format_spellout_cardinal_feminine((n / 1000).floor) + " set") + (if ((n == 500) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000)))
              end))
            end
            if (n >= 300) then
              return ((format_spellout_cardinal_feminine((n / 1000).floor) + " sta") + (if ((n == 300) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000)))
              end))
            end
            if (n >= 200) then
              return ((format_spellout_cardinal_feminine((n / 1000).floor) + " stě") + (if ((n == 200) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000)))
              end))
            end
            if (n >= 100) then
              return ("sto" + (if ((n == 100) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 100)))
              end))
            end
            if (n >= 90) then
              return ("devadesát" + (if ((n == 90) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 100)))
              end))
            end
            if (n >= 80) then
              return ("osmdesát" + (if ((n == 80) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 100)))
              end))
            end
            if (n >= 70) then
              return ("sedmdesát" + (if ((n == 70) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 100)))
              end))
            end
            if (n >= 60) then
              return ("šedesát" + (if ((n == 60) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 100)))
              end))
            end
            if (n >= 50) then
              return ("padesát" + (if ((n == 50) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 100)))
              end))
            end
            if (n >= 20) then
              return ((format_spellout_cardinal_masculine((n / 100).floor) + "cet") + (if ((n == 20) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 100)))
              end))
            end
            return format_spellout_cardinal_masculine(n) if (n >= 3)
            return "dvě" if (n >= 2)
            return "jedno" if (n >= 1)
            return "nula" if (n >= 0)
          end
          def format_spellout_cardinal_feminine(n)
            is_fractional = (n != n.floor)
            return ("minus " + format_spellout_cardinal_feminine(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_cardinal_feminine(n.floor) + " čárka ") + format_spellout_cardinal_feminine((n % 10)))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 5000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000000000).floor) + " biliardů") + (if ((n == 5000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 10000000000000000)))
              end))
            end
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000000000).floor) + " biliardy") + (if ((n == 2000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 10000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000000000).floor) + " biliarda") + (if ((n == 1000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000000000000)))
              end))
            end
            if (n >= 5000000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000000).floor) + " biliónů") + (if ((n == 5000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 10000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000000).floor) + " bilióny") + (if ((n == 2000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 10000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000000).floor) + " bilión") + (if ((n == 1000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000000000)))
              end))
            end
            if (n >= 5000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000).floor) + " miliardů") + (if ((n == 5000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 10000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000).floor) + " miliardy") + (if ((n == 2000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 10000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000).floor) + " miliarda") + (if ((n == 1000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000000)))
              end))
            end
            if (n >= 5000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000).floor) + " miliónů") + (if ((n == 5000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 10000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000).floor) + " milióny") + (if ((n == 2000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 10000000)))
              end))
            end
            if (n >= 1000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000).floor) + " milión") + (if ((n == 1000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000)))
              end))
            end
            if (n >= 5000) then
              return ((format_spellout_cardinal_feminine((n / 10000).floor) + " tisíc") + (if ((n == 5000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 10000)))
              end))
            end
            if (n >= 2000) then
              return ((format_spellout_cardinal_feminine((n / 10000).floor) + " tisíce") + (if ((n == 2000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 10000)))
              end))
            end
            if (n >= 1000) then
              return ((format_spellout_cardinal_feminine((n / 1000).floor) + " tisíc") + (if ((n == 1000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000)))
              end))
            end
            if (n >= 500) then
              return ((format_spellout_cardinal_feminine((n / 1000).floor) + " set") + (if ((n == 500) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000)))
              end))
            end
            if (n >= 300) then
              return ((format_spellout_cardinal_feminine((n / 1000).floor) + " sta") + (if ((n == 300) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000)))
              end))
            end
            if (n >= 200) then
              return ((format_spellout_cardinal_feminine((n / 1000).floor) + " stě") + (if ((n == 200) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000)))
              end))
            end
            if (n >= 100) then
              return ("sto" + (if ((n == 100) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100)))
              end))
            end
            if (n >= 90) then
              return ("devadesát" + (if ((n == 90) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100)))
              end))
            end
            if (n >= 80) then
              return ("osmdesát" + (if ((n == 80) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100)))
              end))
            end
            if (n >= 70) then
              return ("sedmdesát" + (if ((n == 70) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100)))
              end))
            end
            if (n >= 60) then
              return ("šedesát" + (if ((n == 60) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100)))
              end))
            end
            if (n >= 50) then
              return ("padesát" + (if ((n == 50) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100)))
              end))
            end
            if (n >= 20) then
              return ((format_spellout_cardinal_masculine((n / 100).floor) + "cet") + (if ((n == 20) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100)))
              end))
            end
            return format_spellout_cardinal_masculine(n) if (n >= 3)
            return "dvě" if (n >= 2)
            return "jedna" if (n >= 1)
            return "nula" if (n >= 0)
          end
        end
      end
    end
  end
end