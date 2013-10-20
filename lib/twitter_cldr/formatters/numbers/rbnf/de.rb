# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:de] = German = Module.new { }
      
      class German::Spellout
        class << self
          def format_spellout_numbering_year(n)
            is_fractional = (n != n.floor)
            return ("minus " + format_spellout_numbering_year(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return format_spellout_numbering(n) if (n >= 10000)
            if (n >= 1100) then
              return ((format_spellout_cardinal_masculine((n / 10000).floor) + "­hundert") + (if ((n == 1100) or ((n % 10) == 0)) then
                ""
              else
                ("­" + format_spellout_numbering_year((n % 10000)))
              end))
            end
            return format_spellout_numbering(n) if (n >= 0)
          end
          def format_spellout_numbering(n)
            is_fractional = (n != n.floor)
            return ("minus " + format_spellout_numbering(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_numbering(n.floor) + " Komma ") + format_spellout_numbering((n % 10)))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_feminine((n / 10000000000000000).floor) + " Billiarden") + (if ((n == 2000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_numbering((n % 10000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("eine Billiarde" + (if ((n == 1000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_numbering((n % 1000000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_feminine((n / 10000000000000).floor) + " Billionen") + (if ((n == 2000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_numbering((n % 10000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("eine Billion" + (if ((n == 1000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_numbering((n % 1000000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_feminine((n / 10000000000).floor) + " Milliarden") + (if ((n == 2000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_numbering((n % 10000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("eine Milliarde" + (if ((n == 1000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_numbering((n % 1000000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_feminine((n / 10000000).floor) + " Millionen") + (if ((n == 2000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_numbering((n % 10000000)))
              end))
            end
            if (n >= 1000000) then
              return ("eine Million" + (if ((n == 1000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_numbering((n % 1000000)))
              end))
            end
            if (n >= 1000) then
              return ((format_spellout_cardinal_masculine((n / 1000).floor) + "­tausend") + (if ((n == 1000) or ((n % 10) == 0)) then
                ""
              else
                ("­" + format_spellout_numbering((n % 1000)))
              end))
            end
            if (n >= 100) then
              return ((format_spellout_cardinal_masculine((n / 100).floor) + "­hundert") + (if ((n == 100) or ((n % 10) == 0)) then
                ""
              else
                ("­" + format_spellout_numbering((n % 100)))
              end))
            end
            if (n >= 90) then
              return ((if ((n == 90) or ((n % 10) == 0)) then
                ""
              else
                (format_spellout_cardinal_masculine((n % 100)) + "­und­")
              end) + "neunzig")
            end
            if (n >= 80) then
              return ((if ((n == 80) or ((n % 10) == 0)) then
                ""
              else
                (format_spellout_cardinal_masculine((n % 100)) + "­und­")
              end) + "achtzig")
            end
            if (n >= 70) then
              return ((if ((n == 70) or ((n % 10) == 0)) then
                ""
              else
                (format_spellout_cardinal_masculine((n % 100)) + "­und­")
              end) + "siebzig")
            end
            if (n >= 60) then
              return ((if ((n == 60) or ((n % 10) == 0)) then
                ""
              else
                (format_spellout_cardinal_masculine((n % 100)) + "­und­")
              end) + "sechzig")
            end
            if (n >= 50) then
              return ((if ((n == 50) or ((n % 10) == 0)) then
                ""
              else
                (format_spellout_cardinal_masculine((n % 100)) + "­und­")
              end) + "fünfzig")
            end
            if (n >= 40) then
              return ((if ((n == 40) or ((n % 10) == 0)) then
                ""
              else
                (format_spellout_cardinal_masculine((n % 100)) + "­und­")
              end) + "vierzig")
            end
            if (n >= 30) then
              return ((if ((n == 30) or ((n % 10) == 0)) then
                ""
              else
                (format_spellout_cardinal_masculine((n % 100)) + "­und­")
              end) + "dreißig")
            end
            if (n >= 20) then
              return ((if ((n == 20) or ((n % 10) == 0)) then
                ""
              else
                (format_spellout_cardinal_masculine((n % 100)) + "­und­")
              end) + "zwanzig")
            end
            return (format_spellout_numbering((n % 100)) + "zehn") if (n >= 18)
            return "siebzehn" if (n >= 17)
            return "sechzehn" if (n >= 16)
            return (format_spellout_numbering((n % 100)) + "zehn") if (n >= 13)
            return "zwölf" if (n >= 12)
            return "elf" if (n >= 11)
            return "zehn" if (n >= 10)
            return "neun" if (n >= 9)
            return "acht" if (n >= 8)
            return "sieben" if (n >= 7)
            return "sechs" if (n >= 6)
            return "fünf" if (n >= 5)
            return "vier" if (n >= 4)
            return "drei" if (n >= 3)
            return "zwei" if (n >= 2)
            return "eins" if (n >= 1)
            return "null" if (n >= 0)
          end
          def format_spellout_cardinal_neuter(n)
            return format_spellout_cardinal_masculine(n) if (n >= 0)
          end
          def format_spellout_cardinal_masculine(n)
            is_fractional = (n != n.floor)
            return ("minus " + format_spellout_cardinal_masculine(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_cardinal_masculine(n.floor) + " Komma ") + format_spellout_cardinal_masculine((n % 10)))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_feminine((n / 10000000000000000).floor) + " Billiarden") + (if ((n == 2000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 10000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("eine Billiarde" + (if ((n == 1000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_feminine((n / 10000000000000).floor) + " Billionen") + (if ((n == 2000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 10000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("eine Billion" + (if ((n == 1000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_feminine((n / 10000000000).floor) + " Milliarden") + (if ((n == 2000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 10000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("eine Milliarde" + (if ((n == 1000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_feminine((n / 10000000).floor) + " Millionen") + (if ((n == 2000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 10000000)))
              end))
            end
            if (n >= 1000000) then
              return ("eine Million" + (if ((n == 1000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000)))
              end))
            end
            if (n >= 1000) then
              return ((format_spellout_cardinal_masculine((n / 1000).floor) + "­tausend") + (if ((n == 1000) or ((n % 10) == 0)) then
                ""
              else
                ("­" + format_spellout_cardinal_masculine((n % 1000)))
              end))
            end
            if (n >= 100) then
              return ((format_spellout_cardinal_masculine((n / 100).floor) + "­hundert") + (if ((n == 100) or ((n % 10) == 0)) then
                ""
              else
                ("­" + format_spellout_cardinal_masculine((n % 100)))
              end))
            end
            return format_spellout_numbering(n) if (n >= 2)
            return "ein" if (n >= 1)
            return "null" if (n >= 0)
          end
          def format_spellout_cardinal_feminine(n)
            is_fractional = (n != n.floor)
            return ("minus " + format_spellout_cardinal_feminine(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_cardinal_feminine(n.floor) + " Komma ") + format_spellout_cardinal_feminine((n % 10)))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_feminine((n / 10000000000000000).floor) + " Billiarden") + (if ((n == 2000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 10000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("eine Billiarde" + (if ((n == 1000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_feminine((n / 10000000000000).floor) + " Billionen") + (if ((n == 2000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 10000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("eine Billion" + (if ((n == 1000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_feminine((n / 10000000000).floor) + " Milliarden") + (if ((n == 2000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 10000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("eine Milliarde" + (if ((n == 1000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_feminine((n / 10000000).floor) + " Millionen") + (if ((n == 2000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 10000000)))
              end))
            end
            if (n >= 1000000) then
              return ("eine Million" + (if ((n == 1000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000)))
              end))
            end
            if (n >= 1000) then
              return ((format_spellout_cardinal_masculine((n / 1000).floor) + "­tausend") + (if ((n == 1000) or ((n % 10) == 0)) then
                ""
              else
                ("­" + format_spellout_cardinal_feminine((n % 1000)))
              end))
            end
            if (n >= 100) then
              return ((format_spellout_cardinal_masculine((n / 100).floor) + "­hundert") + (if ((n == 100) or ((n % 10) == 0)) then
                ""
              else
                ("­" + format_spellout_cardinal_feminine((n % 100)))
              end))
            end
            return format_spellout_numbering(n) if (n >= 2)
            return "eine" if (n >= 1)
            return "null" if (n >= 0)
          end
          def format_ste(n)
            return ("­" + format_spellout_ordinal(n)) if (n >= 1)
            return "ste" if (n >= 0)
          end
          private(:format_ste)
          def format_ste2(n)
            return (" " + format_spellout_ordinal(n)) if (n >= 1)
            return "ste" if (n >= 0)
          end
          private(:format_ste2)
          def format_spellout_ordinal(n)
            is_fractional = (n != n.floor)
            return ("minus " + format_spellout_ordinal(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return (n.to_s + ".") if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_feminine((n / 10000000000000000).floor) + " Billiarden") + format_ste2((n % 10000000000000000)))
            end
            if (n >= 1000000000000000) then
              return ("eine Billiarde" + format_ste2((n % 1000000000000000)))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_feminine((n / 10000000000000).floor) + " Billionen") + format_ste2((n % 10000000000000)))
            end
            if (n >= 1000000000000) then
              return ("eine Billion" + format_ste((n % 1000000000000)))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_feminine((n / 10000000000).floor) + " Milliarden") + format_ste2((n % 10000000000)))
            end
            if (n >= 1000000000) then
              return ("eine Milliarde" + format_ste2((n % 1000000000)))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_feminine((n / 10000000).floor) + " Millionen") + format_ste2((n % 10000000)))
            end
            return ("eine Million" + format_ste2((n % 1000000))) if (n >= 1000000)
            if (n >= 1000) then
              return ((format_spellout_cardinal_masculine((n / 1000).floor) + "­tausend") + format_ste((n % 1000)))
            end
            if (n >= 100) then
              return ((format_spellout_cardinal_masculine((n / 100).floor) + "­hundert") + format_ste((n % 100)))
            end
            return (format_spellout_numbering(n) + "ste") if (n >= 20)
            return (format_spellout_numbering(n) + "te") if (n >= 9)
            return "achte" if (n >= 8)
            return "siebte" if (n >= 7)
            return "sechste" if (n >= 6)
            return "fünfte" if (n >= 5)
            return "vierte" if (n >= 4)
            return "dritte" if (n >= 3)
            return "zweite" if (n >= 2)
            return "erste" if (n >= 1)
            return "nullte" if (n >= 0)
          end
        end
      end
    end
  end
end