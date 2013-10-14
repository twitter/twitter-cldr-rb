# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:lv] = Latvian = Module.new { }
      
      class Latvian::Spellout
        class << self
          def format_spellout_numbering_year(n)
            is_fractional = (n != n.floor)
            return n.to_s if is_fractional and (n > 1)
            return format_spellout_numbering(n) if (n >= 0)
          end
          def format_spellout_numbering(n)
            return format_spellout_cardinal_masculine(n) if (n >= 0)
          end
          def format_spellout_prefixed(n)
            return "ERROR" if (n >= 10)
            return "deviņ" if (n >= 9)
            return "astoņ" if (n >= 8)
            return "septiņ" if (n >= 7)
            return "seš" if (n >= 6)
            return "piec" if (n >= 5)
            return "četr" if (n >= 4)
            return "trīs" if (n >= 3)
            return "div" if (n >= 2)
            return "vien" if (n >= 1)
            return "ERROR" if (n >= 0)
          end
          private(:format_spellout_prefixed)
          def format_spellout_cardinal_masculine(n)
            is_fractional = (n != n.floor)
            return ("mīnus " + format_spellout_cardinal_masculine(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_cardinal_masculine(n.floor) + " komats ") + format_spellout_cardinal_masculine(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 2.0e+15).floor) + " biljardi") + (if (n == 2000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("viens biljards" + (if (n == 1000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000000000.0).floor) + " biljoni") + (if (n == 2000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("viens biljons" + (if (n == 1000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000000.0).floor) + " miljardi") + (if (n == 2000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("viens miljards" + (if (n == 1000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000.0).floor) + " miljoni") + (if (n == 2000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ("viens miljons" + (if (n == 1000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100000)))
              end))
            end
            if (n >= 10000) then
              return ((format_spellout_cardinal_masculine((n / 10000.0).floor) + " tūkstoši") + (if (n == 10000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000)))
              end))
            end
            if (n >= 2000) then
              return ((format_spellout_prefixed((n / 2000.0).floor) + "tūkstoš") + (if (n == 2000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000)))
              end))
            end
            if (n >= 1000) then
              return ("tūkstoš" + (if (n == 1000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100)))
              end))
            end
            if (n >= 200) then
              return ((format_spellout_prefixed((n / 200.0).floor) + "simt") + ((n == 200) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 100))))))
            end
            if (n >= 100) then
              return ("simt" + ((n == 100) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 100))))))
            end
            if (n >= 20) then
              return ((format_spellout_prefixed((n / 20.0).floor) + "desmit") + ((n == 20) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 10))))))
            end
            return (format_spellout_prefixed((n % 10)) + "padsmit") if (n >= 11)
            return "desmit" if (n >= 10)
            return "deviņi" if (n >= 9)
            return "astoņi" if (n >= 8)
            return "septiņi" if (n >= 7)
            return "seši" if (n >= 6)
            return "pieci" if (n >= 5)
            return "četri" if (n >= 4)
            return "trīs" if (n >= 3)
            return "divi" if (n >= 2)
            return "viens" if (n >= 1)
            return "nulle" if (n >= 0)
          end
          def format_spellout_cardinal_feminine(n)
            is_fractional = (n != n.floor)
            return ("mīnus " + format_spellout_cardinal_feminine(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_cardinal_feminine(n.floor) + " komats ") + format_spellout_cardinal_feminine(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 2.0e+15).floor) + " biljardi") + (if (n == 2000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("viens biljards" + (if (n == 1000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000000000.0).floor) + " biljoni") + (if (n == 2000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("viens biljons" + (if (n == 1000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000000.0).floor) + " miljardi") + (if (n == 2000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("viens miljards" + (if (n == 1000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000.0).floor) + " miljoni") + (if (n == 2000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ("viens miljons" + (if (n == 1000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100000)))
              end))
            end
            if (n >= 10000) then
              return ((format_spellout_cardinal_masculine((n / 10000.0).floor) + " tūkstoši") + (if (n == 10000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000)))
              end))
            end
            if (n >= 2000) then
              return ((format_spellout_prefixed((n / 2000.0).floor) + "tūkstoš") + (if (n == 2000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000)))
              end))
            end
            if (n >= 1000) then
              return ("tūkstoš" + ((n == 1000) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 100))))))
            end
            if (n >= 200) then
              return ((format_spellout_prefixed((n / 200.0).floor) + "simt") + ((n == 200) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 100))))))
            end
            if (n >= 100) then
              return ("simt" + ((n == 100) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 100))))))
            end
            if (n >= 20) then
              return ((format_spellout_prefixed((n / 20.0).floor) + "desmit") + ((n == 20) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 10))))))
            end
            return format_spellout_cardinal_masculine(n) if (n >= 10)
            return "deviņas" if (n >= 9)
            return "astoņas" if (n >= 8)
            return "septiņas" if (n >= 7)
            return "sešas" if (n >= 6)
            return "piecas" if (n >= 5)
            return "četras" if (n >= 4)
            return "trīs" if (n >= 3)
            return "divas" if (n >= 2)
            return "viena" if (n >= 1)
            return "nulle" if (n >= 0)
          end
        end
      end
    end
  end
end