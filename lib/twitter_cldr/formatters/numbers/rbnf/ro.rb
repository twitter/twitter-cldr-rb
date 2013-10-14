# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:ro] = Romanian = Module.new { }
      
      class Romanian::Spellout
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
              return ((format_spellout_cardinal_masculine(n.floor) + " virgulă ") + format_spellout_cardinal_masculine(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_neuter((n / 2.0e+15).floor) + " biliarde") + (if (n == 2000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ((format_spellout_cardinal_neuter((n / 1.0e+15).floor) + " biliard") + (if (n == 1000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_neuter((n / 2000000000000.0).floor) + " bilioane") + (if (n == 2000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal_neuter((n / 1000000000000.0).floor) + " bilion") + (if (n == 1000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_neuter((n / 2000000000.0).floor) + " miliarde") + (if (n == 2000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((format_spellout_cardinal_neuter((n / 1000000000.0).floor) + " miliard") + (if (n == 1000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_neuter((n / 2000000.0).floor) + " milioane") + (if (n == 2000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ((format_spellout_cardinal_neuter((n / 1000000.0).floor) + " milion") + (if (n == 1000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100000)))
              end))
            end
            if (n >= 2000) then
              return ((format_spellout_cardinal_feminine((n / 2000.0).floor) + " mii") + (if (n == 2000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000)))
              end))
            end
            if (n >= 1000) then
              return ("una mie" + (if (n == 1000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100)))
              end))
            end
            if (n >= 200) then
              return ((format_spellout_cardinal_feminine((n / 200.0).floor) + " sute") + ((n == 200) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 100))))))
            end
            if (n >= 100) then
              return ("una sută" + ((n == 100) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 100))))))
            end
            if (n >= 20) then
              return ((format_spellout_cardinal_feminine((n / 20.0).floor) + "zeci") + (if (n == 20) then
                ""
              else
                (" şi " + format_spellout_cardinal_masculine((n % 10)))
              end))
            end
            if (n >= 12) then
              return (format_spellout_cardinal_masculine((n % 10)) + "sprezece")
            end
            return "unsprezece" if (n >= 11)
            return "zece" if (n >= 10)
            return "nouă" if (n >= 9)
            return "opt" if (n >= 8)
            return "şapte" if (n >= 7)
            return "şase" if (n >= 6)
            return "cinci" if (n >= 5)
            return "patru" if (n >= 4)
            return "trei" if (n >= 3)
            return "doi" if (n >= 2)
            return "unu" if (n >= 1)
            return "zero" if (n >= 0)
          end
          def format_spellout_cardinal_feminine(n)
            is_fractional = (n != n.floor)
            return ("minus " + format_spellout_cardinal_feminine(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_cardinal_feminine(n.floor) + " virgulă ") + format_spellout_cardinal_feminine(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_neuter((n / 2.0e+15).floor) + " biliarde") + (if (n == 2000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ((format_spellout_cardinal_neuter((n / 1.0e+15).floor) + " biliard") + (if (n == 1000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_neuter((n / 2000000000000.0).floor) + " bilioane") + (if (n == 2000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal_neuter((n / 1000000000000.0).floor) + " bilion") + (if (n == 1000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_neuter((n / 2000000000.0).floor) + " miliarde") + (if (n == 2000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((format_spellout_cardinal_neuter((n / 1000000000.0).floor) + " miliard") + (if (n == 1000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_neuter((n / 2000000.0).floor) + " milioane") + (if (n == 2000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ((format_spellout_cardinal_neuter((n / 1000000.0).floor) + " milion") + (if (n == 1000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100000)))
              end))
            end
            if (n >= 2000) then
              return ((format_spellout_cardinal_feminine((n / 2000.0).floor) + " mii") + (if (n == 2000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000)))
              end))
            end
            if (n >= 1000) then
              return ("una mie" + ((n == 1000) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 100))))))
            end
            if (n >= 200) then
              return ((format_spellout_cardinal_feminine((n / 200.0).floor) + " sute") + ((n == 200) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 100))))))
            end
            if (n >= 100) then
              return ("una sută" + ((n == 100) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 100))))))
            end
            if (n >= 20) then
              return ((format_spellout_cardinal_feminine((n / 20.0).floor) + "zeci") + ((n == 20) ? ("") : ((" şi " + format_spellout_cardinal_feminine((n % 10))))))
            end
            if (n >= 12) then
              return (format_spellout_cardinal_feminine((n % 10)) + "sprezece")
            end
            return format_spellout_cardinal_masculine(n) if (n >= 3)
            return "două" if (n >= 2)
            return "una" if (n >= 1)
            return "zero" if (n >= 0)
          end
          def format_spellout_cardinal_neuter(n)
            is_fractional = (n != n.floor)
            return ("minus " + format_spellout_cardinal_neuter(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_cardinal_neuter(n.floor) + " virgulă ") + format_spellout_cardinal_neuter(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_neuter((n / 2.0e+15).floor) + " biliarde") + (if (n == 2000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ((format_spellout_cardinal_neuter((n / 1.0e+15).floor) + " biliard") + (if (n == 1000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 100000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_neuter((n / 2000000000000.0).floor) + " bilioane") + (if (n == 2000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal_neuter((n / 1000000000000.0).floor) + " bilion") + (if (n == 1000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 100000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_neuter((n / 2000000000.0).floor) + " miliarde") + (if (n == 2000000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((format_spellout_cardinal_neuter((n / 1000000000.0).floor) + " miliard") + (if (n == 1000000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 100000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_neuter((n / 2000000.0).floor) + " milioane") + (if (n == 2000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ((format_spellout_cardinal_neuter((n / 1000000.0).floor) + " milion") + (if (n == 1000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 100000)))
              end))
            end
            if (n >= 2000) then
              return ((format_spellout_cardinal_feminine((n / 2000.0).floor) + " mii") + ((n == 2000) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 1000))))))
            end
            if (n >= 1000) then
              return ("una mie" + ((n == 1000) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 100))))))
            end
            if (n >= 200) then
              return ((format_spellout_cardinal_feminine((n / 200.0).floor) + " sute") + ((n == 200) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 100))))))
            end
            if (n >= 100) then
              return ("una sută" + ((n == 100) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 100))))))
            end
            if (n >= 20) then
              return ((format_spellout_cardinal_feminine((n / 20.0).floor) + "zeci") + ((n == 20) ? ("") : ((" şi " + format_spellout_cardinal_neuter((n % 10))))))
            end
            return format_spellout_cardinal_feminine(n) if (n >= 2)
            return "unu" if (n >= 1)
            return "zero" if (n >= 0)
          end
        end
      end
      
      class Romanian::Ordinal
        class << self
          def format_digits_ordinal(n)
            return ("−" + format_digits_ordinal(-n)) if (n < 0)
            return (n.to_s + "a") if (n >= 0)
          end
        end
      end
    end
  end
end