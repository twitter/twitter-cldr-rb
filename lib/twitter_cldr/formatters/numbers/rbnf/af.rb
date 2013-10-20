# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:af] = Afrikaans = Module.new { }
      
      class Afrikaans::Spellout
        class << self
          def format_2d_year(n)
            return format_spellout_numbering(n) if (n >= 10)
            return ("nul " + format_spellout_numbering(n)) if (n >= 1)
            if (n >= 0) then
              return ("honderd" + (if ((n == 0) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_numbering((n % 10)))
              end))
            end
          end
          private(:format_2d_year)
          def format_spellout_numbering_year(n)
            is_fractional = (n != n.floor)
            return ("min " + format_spellout_numbering_year(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return format_spellout_numbering(n) if (n >= 10000)
            if (n >= 1100) then
              return ((format_spellout_numbering_year((n / 10000).floor) + " ") + format_2d_year((n % 10000)))
            end
            return format_spellout_numbering(n) if (n >= 0)
          end
          def format_spellout_numbering(n)
            return format_spellout_cardinal(n) if (n >= 0)
          end
          def format_spellout_cardinal(n)
            is_fractional = (n != n.floor)
            return ("min " + format_spellout_cardinal(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_cardinal(n.floor) + " komma ") + format_spellout_cardinal((n % 10)))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 1000000000000000) then
              return ((format_spellout_cardinal((n / 1000000000000000).floor) + " biljard") + (if ((n == 1000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal((n / 1000000000000).floor) + " biljoen") + (if ((n == 1000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((format_spellout_cardinal((n / 1000000000).floor) + " miljard") + (if ((n == 1000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal((n % 1000000000)))
              end))
            end
            if (n >= 1000000) then
              return ((format_spellout_cardinal((n / 1000000).floor) + " miljoen") + (if ((n == 1000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal((n % 1000000)))
              end))
            end
            if (n >= 21000) then
              return ((format_spellout_cardinal((n / 1000000).floor) + " duisend") + (if ((n == 21000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal((n % 1000000)))
              end))
            end
            if (n >= 2000) then
              return ((format_spellout_cardinal((n / 10000).floor) + "­duisend") + (if ((n == 2000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal((n % 10000)))
              end))
            end
            if (n >= 1000) then
              return ("duisend" + (if ((n == 1000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal((n % 1000)))
              end))
            end
            if (n >= 200) then
              return ((format_spellout_cardinal((n / 1000).floor) + "honderd") + (if ((n == 200) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal((n % 1000)))
              end))
            end
            if (n >= 100) then
              return ("honderd" + (if ((n == 100) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal((n % 100)))
              end))
            end
            if (n >= 90) then
              return ((if ((n == 90) or ((n % 10) == 0)) then
                ""
              else
                (format_spellout_cardinal((n % 100)) + "-en-")
              end) + "negentig")
            end
            if (n >= 80) then
              return ((if ((n == 80) or ((n % 10) == 0)) then
                ""
              else
                (format_spellout_cardinal((n % 100)) + "-en-")
              end) + "tagtig")
            end
            if (n >= 70) then
              return ((if ((n == 70) or ((n % 10) == 0)) then
                ""
              else
                (format_spellout_cardinal((n % 100)) + "-en-")
              end) + "sewentig")
            end
            if (n >= 60) then
              return ((if ((n == 60) or ((n % 10) == 0)) then
                ""
              else
                (format_spellout_cardinal((n % 100)) + "-en-")
              end) + "sestig")
            end
            if (n >= 50) then
              return ((if ((n == 50) or ((n % 10) == 0)) then
                ""
              else
                (format_spellout_cardinal((n % 100)) + "-en-")
              end) + "vyftig")
            end
            if (n >= 40) then
              return ((if ((n == 40) or ((n % 10) == 0)) then
                ""
              else
                (format_spellout_cardinal((n % 100)) + "-en-")
              end) + "veertig")
            end
            if (n >= 30) then
              return ((if ((n == 30) or ((n % 10) == 0)) then
                ""
              else
                (format_spellout_cardinal((n % 100)) + "-en-")
              end) + "dertig")
            end
            if (n >= 20) then
              return ((if ((n == 20) or ((n % 10) == 0)) then
                ""
              else
                (format_spellout_cardinal((n % 100)) + "-en-")
              end) + "twintig")
            end
            return "negentien" if (n >= 19)
            return "agttien" if (n >= 18)
            return "sewentien" if (n >= 17)
            return "sestien" if (n >= 16)
            return "vyftien" if (n >= 15)
            return "veertien" if (n >= 14)
            return "dertien" if (n >= 13)
            return "twaalf" if (n >= 12)
            return "elf" if (n >= 11)
            return "tien" if (n >= 10)
            return "nege" if (n >= 9)
            return "agt" if (n >= 8)
            return "sewe" if (n >= 7)
            return "ses" if (n >= 6)
            return "vyf" if (n >= 5)
            return "vier" if (n >= 4)
            return "drie" if (n >= 3)
            return "twee" if (n >= 2)
            return "een" if (n >= 1)
            return "nul" if (n >= 0)
          end
          def format_ord_ste(n)
            return (" " + format_spellout_ordinal(n)) if (n >= 2)
            return (" en " + format_spellout_ordinal(n)) if (n >= 1)
            return "ste" if (n >= 0)
          end
          private(:format_ord_ste)
          def format_spellout_ordinal(n)
            is_fractional = (n != n.floor)
            return ("min " + format_spellout_ordinal(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return (n.to_s + ".") if (n >= 1000000000000000000)
            if (n >= 1000000000000000) then
              return ((format_spellout_numbering((n / 1000000000000000).floor) + " biljard") + format_ord_ste((n % 1000000000000000)))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_numbering((n / 1000000000000).floor) + " biljoen") + format_ord_ste((n % 1000000000000)))
            end
            if (n >= 1000000000) then
              return ((format_spellout_numbering((n / 1000000000).floor) + " miljard") + format_ord_ste((n % 1000000000)))
            end
            if (n >= 1000000) then
              return ((format_spellout_numbering((n / 1000000).floor) + " miljoen") + format_ord_ste((n % 1000000)))
            end
            if (n >= 1000) then
              return ((format_spellout_numbering((n / 1000).floor) + " duisend") + format_ord_ste((n % 1000)))
            end
            if (n >= 102) then
              return ((format_spellout_numbering((n / 1000).floor) + " honderd") + format_ord_ste((n % 1000)))
            end
            return (format_spellout_numbering(n) + "ste") if (n >= 20)
            return (format_spellout_numbering(n) + "de") if (n >= 4)
            return "derde" if (n >= 3)
            return "tweede" if (n >= 2)
            return "eerste" if (n >= 1)
            return "nulste" if (n >= 0)
          end
        end
      end
      
      class Afrikaans::Ordinal
        class << self
          def format_digits_ordinal_indicator(n)
            return format_digits_ordinal_indicator((n % 100)) if (n >= 100)
            return "ste" if (n >= 20)
            return "de" if (n >= 2)
            return "ste" if (n >= 1)
            return "ste" if (n >= 0)
          end
          private(:format_digits_ordinal_indicator)
          def format_digits_ordinal(n)
            return ("−" + format_digits_ordinal(-n)) if (n < 0)
            return (n.to_s + format_digits_ordinal_indicator(n)) if (n >= 0)
          end
        end
      end
    end
  end
end