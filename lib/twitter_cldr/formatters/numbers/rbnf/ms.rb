# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:ms] = Malay = Module.new { }
      
      class Malay::Spellout
        class << self
          def format_spellout_numbering_year(n)
            is_fractional = (n != n.floor)
            return n.to_s if is_fractional and (n > 1)
            return format_spellout_numbering(n) if (n >= 0)
          end
          def format_spellout_numbering(n)
            return format_spellout_cardinal(n) if (n >= 0)
          end
          def format_spellout_cardinal(n)
            is_fractional = (n != n.floor)
            return ("minus " + format_spellout_cardinal(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_cardinal(n.floor) + " titik ") + format_spellout_cardinal((n % 10)))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 1000000000000000) then
              return ((format_spellout_cardinal((n / 1000000000000000).floor) + " bilyar") + (if ((n == 1000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal((n / 1000000000000).floor) + " bilyun") + (if ((n == 1000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((format_spellout_cardinal((n / 1000000000).floor) + " milyar") + (if ((n == 1000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal((n % 1000000000)))
              end))
            end
            if (n >= 1000000) then
              return ((format_spellout_cardinal((n / 1000000).floor) + " juta") + (if ((n == 1000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal((n % 1000000)))
              end))
            end
            if (n >= 2000) then
              return ((format_spellout_cardinal((n / 10000).floor) + " ribu") + (if ((n == 2000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal((n % 10000)))
              end))
            end
            if (n >= 1000) then
              return ("seribu" + (if ((n == 1000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal((n % 1000)))
              end))
            end
            if (n >= 200) then
              return ((format_spellout_cardinal((n / 1000).floor) + " ratus") + (if ((n == 200) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal((n % 1000)))
              end))
            end
            if (n >= 100) then
              return ("seratus" + (if ((n == 100) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal((n % 100)))
              end))
            end
            if (n >= 20) then
              return ((format_spellout_cardinal((n / 100).floor) + " puluh") + (if ((n == 20) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal((n % 100)))
              end))
            end
            return (format_spellout_cardinal((n % 100)) + " belas") if (n >= 12)
            return "sebelas" if (n >= 11)
            return "sepuluh" if (n >= 10)
            return "sembilan" if (n >= 9)
            return "lapan" if (n >= 8)
            return "tujuh" if (n >= 7)
            return "enam" if (n >= 6)
            return "lima" if (n >= 5)
            return "empat" if (n >= 4)
            return "tiga" if (n >= 3)
            return "dua" if (n >= 2)
            return "satu" if (n >= 1)
            return "kosong" if (n >= 0)
          end
          def format_spellout_ordinal(n)
            is_fractional = (n != n.floor)
            return ("minus " + format_spellout_ordinal(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return ("ke" + format_spellout_cardinal(n)) if (n >= 2)
            return "pertama" if (n >= 1)
            return "kekosong" if (n >= 0)
          end
        end
      end
      
      class Malay::Ordinal
        class << self
          def format_digits_ordinal(n)
            return ("ke−" + -n.to_s) if (n < 0)
            return ("ke" + n.to_s) if (n >= 0)
          end
        end
      end
    end
  end
end