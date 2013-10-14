# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:sq] = Albanian = Module.new { }
      
      class Albanian::Spellout
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
              return ((format_spellout_cardinal_masculine(n.floor) + " presje ") + format_spellout_cardinal_masculine(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_feminine((n / 2.0e+15).floor) + " biliarë") + (if (n == 2000000000000000) then
                ""
              else
                (" e " + format_spellout_cardinal_masculine((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("një biliar" + (if (n == 1000000000000000) then
                ""
              else
                (" e " + format_spellout_cardinal_masculine((n % 100000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_feminine((n / 2000000000000.0).floor) + " bilionë") + (if (n == 2000000000000) then
                ""
              else
                (" e " + format_spellout_cardinal_masculine((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("një bilion" + (if (n == 1000000000000) then
                ""
              else
                (" e " + format_spellout_cardinal_masculine((n % 100000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_feminine((n / 2000000000.0).floor) + " miliarë") + (if (n == 2000000000) then
                ""
              else
                (" e " + format_spellout_cardinal_masculine((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("një miliar" + (if (n == 1000000000) then
                ""
              else
                (" e " + format_spellout_cardinal_masculine((n % 100000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_feminine((n / 2000000.0).floor) + " milionë") + (if (n == 2000000) then
                ""
              else
                (" e " + format_spellout_cardinal_masculine((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ("një milion" + (if (n == 1000000) then
                ""
              else
                (" e " + format_spellout_cardinal_masculine((n % 100000)))
              end))
            end
            if (n >= 1000) then
              return ((format_spellout_cardinal_masculine((n / 1000.0).floor) + " mijë") + (if (n == 1000) then
                ""
              else
                (" e " + format_spellout_cardinal_masculine((n % 100)))
              end))
            end
            if (n >= 100) then
              return ((format_spellout_cardinal_masculine((n / 100.0).floor) + "qind") + (if (n == 100) then
                ""
              else
                (" e " + format_spellout_cardinal_masculine((n % 100)))
              end))
            end
            if (n >= 50) then
              return ((format_spellout_cardinal_feminine((n / 50.0).floor) + "dhjetë") + ((n == 50) ? ("") : ((" e " + format_spellout_cardinal_masculine((n % 10))))))
            end
            if (n >= 40) then
              return ("dyzet" + ((n == 40) ? ("") : ((" e " + format_spellout_cardinal_masculine((n % 10))))))
            end
            if (n >= 30) then
              return ("tridhjetë" + ((n == 30) ? ("") : ((" e " + format_spellout_cardinal_masculine((n % 10))))))
            end
            if (n >= 20) then
              return ("njëzet" + ((n == 20) ? ("") : ((" e " + format_spellout_cardinal_masculine((n % 10))))))
            end
            if (n >= 11) then
              return (format_spellout_cardinal_masculine((n % 10)) + "mbëdhjetë")
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
          def format_spellout_cardinal_feminine(n)
            is_fractional = (n != n.floor)
            return ("minus " + format_spellout_cardinal_feminine(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_cardinal_feminine(n.floor) + " presje ") + format_spellout_cardinal_feminine(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_feminine((n / 2.0e+15).floor) + " biliarë") + (if (n == 2000000000000000) then
                ""
              else
                (" e " + format_spellout_cardinal_feminine((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("një biliar" + (if (n == 1000000000000000) then
                ""
              else
                (" e " + format_spellout_cardinal_feminine((n % 100000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_feminine((n / 2000000000000.0).floor) + " bilionë") + (if (n == 2000000000000) then
                ""
              else
                (" e " + format_spellout_cardinal_feminine((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("një bilion" + (if (n == 1000000000000) then
                ""
              else
                (" e " + format_spellout_cardinal_feminine((n % 100000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_feminine((n / 2000000000.0).floor) + " miliarë") + (if (n == 2000000000) then
                ""
              else
                (" e " + format_spellout_cardinal_feminine((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("një miliar" + (if (n == 1000000000) then
                ""
              else
                (" e " + format_spellout_cardinal_feminine((n % 100000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_feminine((n / 2000000.0).floor) + " milionë") + (if (n == 2000000) then
                ""
              else
                (" e " + format_spellout_cardinal_feminine((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ("një milion" + (if (n == 1000000) then
                ""
              else
                (" e " + format_spellout_cardinal_feminine((n % 100000)))
              end))
            end
            if (n >= 1000) then
              return ((format_spellout_cardinal_masculine((n / 1000.0).floor) + " mijë") + (if (n == 1000) then
                ""
              else
                (" e " + format_spellout_cardinal_feminine((n % 100)))
              end))
            end
            if (n >= 100) then
              return ((format_spellout_cardinal_masculine((n / 100.0).floor) + "qind") + (if (n == 100) then
                ""
              else
                (" e " + format_spellout_cardinal_feminine((n % 100)))
              end))
            end
            if (n >= 50) then
              return ((format_spellout_cardinal_feminine((n / 50.0).floor) + "dhjetë") + ((n == 50) ? ("") : ((" e " + format_spellout_cardinal_feminine((n % 10))))))
            end
            if (n >= 40) then
              return ("dyzet" + ((n == 40) ? ("") : ((" e " + format_spellout_cardinal_feminine((n % 10))))))
            end
            if (n >= 30) then
              return ("tridhjetë" + ((n == 30) ? ("") : ((" e " + format_spellout_cardinal_feminine((n % 10))))))
            end
            if (n >= 20) then
              return ("njëzet" + ((n == 20) ? ("") : ((" e " + format_spellout_cardinal_feminine((n % 10))))))
            end
            return format_spellout_cardinal_masculine(n) if (n >= 4)
            return "tri" if (n >= 3)
            return "dy" if (n >= 2)
            return "një" if (n >= 1)
            return "zero" if (n >= 0)
          end
        end
      end
    end
  end
end