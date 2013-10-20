# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:ga] = Irish = Module.new { }
      
      class Irish::Spellout
        class << self
          def format_lenient_parse(n)
            return ((" ' ' " + " '") + "' ") if (n >= 0)
          end
          private(:format_lenient_parse)
          def format_2d_year(n)
            return format_spellout_numbering_no_a(n) if (n >= 10)
            return ("agus " + format_spellout_numbering(n)) if (n >= 0)
          end
          private(:format_2d_year)
          def format_spellout_numbering_year(n)
            is_fractional = (n != n.floor)
            return ("míneas " + format_spellout_numbering_year(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return format_spellout_numbering(n) if (n >= 10000)
            if (n >= 1000) then
              return ((format_spellout_numbering_no_a((n / 10000).floor) + " ") + format_2d_year((n % 10000)))
            end
            return format_spellout_numbering(n) if (n >= 0)
          end
          def format_spellout_numbering_no_a(n)
            return format_spellout_numbering(n) if (n >= 20)
            return (format_spellout_numbering_no_a((n % 100)) + " déag") if (n >= 13)
            return (format_spellout_numbering_no_a((n % 100)) + " dhéag") if (n >= 12)
            return (format_spellout_numbering_no_a((n % 100)) + " déag") if (n >= 11)
            return "deich" if (n >= 10)
            return "naoi" if (n >= 9)
            return "ocht" if (n >= 8)
            return "seacht" if (n >= 7)
            return "sé" if (n >= 6)
            return "cúig" if (n >= 5)
            return "ceathair" if (n >= 4)
            return "trí" if (n >= 3)
            return "dó" if (n >= 2)
            return "aon" if (n >= 1)
            return "náid" if (n >= 0)
          end
          private(:format_spellout_numbering_no_a)
          def format_spellout_numbering(n)
            is_fractional = (n != n.floor)
            return ("míneas " + format_spellout_numbering(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_numbering(n.floor) + " pointe ") + format_spellout_numbering((n % 10)))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 1000000000000000) then
              return (format_quadrillions((n / 1000000000000000).floor) + (if ((n == 1000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_numbering((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return (format_trillions((n / 1000000000000).floor) + (if ((n == 1000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_numbering((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000) then
              return (format_billions((n / 1000000000).floor) + (if ((n == 1000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_numbering((n % 1000000000)))
              end))
            end
            if (n >= 1000000) then
              return (format_millions((n / 1000000).floor) + (if ((n == 1000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_numbering((n % 1000000)))
              end))
            end
            if (n >= 1000) then
              return (format_thousands((n / 1000).floor) + (if ((n == 1000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_numbering((n % 1000)))
              end))
            end
            if (n >= 100) then
              return (format_hundreds((n / 100).floor) + (((n == 100) or ((n % 10) == 0)) ? ("") : (format_is_number((n % 100)))))
            end
            if (n >= 90) then
              return ("nócha" + (if ((n == 90) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_numbering((n % 100)))
              end))
            end
            if (n >= 80) then
              return ("ochtó" + (if ((n == 80) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_numbering((n % 100)))
              end))
            end
            if (n >= 70) then
              return ("seachtó" + (if ((n == 70) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_numbering((n % 100)))
              end))
            end
            if (n >= 60) then
              return ("seasca" + (if ((n == 60) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_numbering((n % 100)))
              end))
            end
            if (n >= 50) then
              return ("caoga" + (if ((n == 50) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_numbering((n % 100)))
              end))
            end
            if (n >= 40) then
              return ("daichead" + (if ((n == 40) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_numbering((n % 100)))
              end))
            end
            if (n >= 30) then
              return ("tríocha" + (if ((n == 30) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_numbering((n % 100)))
              end))
            end
            if (n >= 20) then
              return ("fiche" + (if ((n == 20) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_numbering((n % 100)))
              end))
            end
            return (format_spellout_numbering((n % 100)) + " déag") if (n >= 13)
            return (format_spellout_numbering((n % 100)) + " dhéag") if (n >= 12)
            return (format_spellout_numbering((n % 100)) + " déag") if (n >= 11)
            return "a deich" if (n >= 10)
            return "a naoi" if (n >= 9)
            return "a hocht" if (n >= 8)
            return "a seacht" if (n >= 7)
            return "a sé" if (n >= 6)
            return "a cúig" if (n >= 5)
            return "a ceathair" if (n >= 4)
            return "a trí" if (n >= 3)
            return "a dó" if (n >= 2)
            return "a haon" if (n >= 1)
            return "a náid" if (n >= 0)
          end
          def format_is_number(n)
            return (" " + format_spellout_numbering(n)) if (n >= 1)
            return (" is " + format_spellout_numbering(n)) if (n >= 0)
          end
          private(:format_is_number)
          def format_is_numberp(n)
            return (" " + format_numberp(n)) if (n >= 1)
            return (" is " + format_numberp(n)) if (n >= 0)
          end
          private(:format_is_numberp)
          def format_numberp(n)
            return format_spellout_cardinal_prefixpart(n) if (n >= 20)
            return (format_spellout_cardinal_prefixpart(n) + " déag") if (n >= 13)
            return "dó dhéag" if (n >= 12)
            return format_spellout_cardinal_prefixpart(n) if (n >= 0)
          end
          private(:format_numberp)
          def format_spellout_cardinal(n)
            return format_spellout_numbering(n) if (n >= 0)
          end
          def format_spellout_cardinal_prefixpart(n)
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 1000000000000000) then
              return (format_quadrillions((n / 1000000000000000).floor) + (if ((n == 1000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_numberp((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return (format_trillions((n / 1000000000000).floor) + (if ((n == 1000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_numberp((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000) then
              return (format_billions((n / 1000000000).floor) + (if ((n == 1000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_numberp((n % 1000000000)))
              end))
            end
            if (n >= 1000000) then
              return (format_millions((n / 1000000).floor) + (if ((n == 1000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_numberp((n % 1000000)))
              end))
            end
            if (n >= 1000) then
              return (format_thousands((n / 1000).floor) + (if ((n == 1000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_numberp((n % 1000)))
              end))
            end
            if (n >= 100) then
              return (format_hundreds((n / 100).floor) + (((n == 100) or ((n % 10) == 0)) ? ("") : (format_is_numberp((n % 100)))))
            end
            if (n >= 90) then
              return ("nócha" + (if ((n == 90) or ((n % 10) == 0)) then
                ""
              else
                (" is " + format_spellout_cardinal_prefixpart((n % 100)))
              end))
            end
            if (n >= 80) then
              return ("ochtó" + (if ((n == 80) or ((n % 10) == 0)) then
                ""
              else
                (" is " + format_spellout_cardinal_prefixpart((n % 100)))
              end))
            end
            if (n >= 70) then
              return ("seachtó" + (if ((n == 70) or ((n % 10) == 0)) then
                ""
              else
                (" is " + format_spellout_cardinal_prefixpart((n % 100)))
              end))
            end
            if (n >= 60) then
              return ("seasca" + (if ((n == 60) or ((n % 10) == 0)) then
                ""
              else
                (" is " + format_spellout_cardinal_prefixpart((n % 100)))
              end))
            end
            if (n >= 50) then
              return ("caoga" + (if ((n == 50) or ((n % 10) == 0)) then
                ""
              else
                (" is " + format_spellout_cardinal_prefixpart((n % 100)))
              end))
            end
            if (n >= 40) then
              return ("daichead" + (if ((n == 40) or ((n % 10) == 0)) then
                ""
              else
                (" is " + format_spellout_cardinal_prefixpart((n % 100)))
              end))
            end
            if (n >= 30) then
              return ("tríocha" + (if ((n == 30) or ((n % 10) == 0)) then
                ""
              else
                (" is " + format_spellout_cardinal_prefixpart((n % 100)))
              end))
            end
            if (n >= 20) then
              return ("fiche" + (if ((n == 20) or ((n % 10) == 0)) then
                ""
              else
                (" is " + format_spellout_cardinal_prefixpart((n % 100)))
              end))
            end
            return format_spellout_cardinal_prefixpart((n % 100)) if (n >= 11)
            return "deich" if (n >= 10)
            return "naoi" if (n >= 9)
            return "ocht" if (n >= 8)
            return "seacht" if (n >= 7)
            return "sé" if (n >= 6)
            return "cúig" if (n >= 5)
            return "ceithre" if (n >= 4)
            return "trí" if (n >= 3)
            return "dhá" if (n >= 2)
            return "aon" if (n >= 1)
            return "náid" if (n >= 0)
          end
          private(:format_spellout_cardinal_prefixpart)
          def format_is(n)
            return format_is((n % 10)) if (n >= 10)
            return "" if (n >= 1)
            return " is" if (n >= 0)
          end
          private(:format_is)
          def format_hundreds(n)
            return "naoi gcéad" if (n >= 9)
            return "ocht gcéad" if (n >= 8)
            return "seacht gcéad" if (n >= 7)
            return "sé chéad" if (n >= 6)
            return "cúig chéad" if (n >= 5)
            return "ceithre chéad" if (n >= 4)
            return "trí chéad" if (n >= 3)
            return "dhá chéad" if (n >= 2)
            return "céad" if (n >= 1)
          end
          private(:format_hundreds)
          def format_thousands(n)
            if (n >= 100) then
              return (format_hundreds((n / 100).floor) + format_is_thousands((n % 100)))
            end
            if (n >= 2) then
              return ((format_spellout_cardinal_prefixpart(n) + " ") + format_thousandp(n))
            end
            return "míle" if (n >= 1)
          end
          private(:format_thousands)
          def format_thousandp(n)
            return format_thousand(n) if (n >= 20)
            return (format_thousand(n) + " dhéag") if (n >= 11)
            return format_thousand(n) if (n >= 2)
          end
          private(:format_thousandp)
          def format_thousand(n)
            return format_thousand((n % 100)) if (n >= 11)
            return "míle" if (n >= 7)
            return "mhíle" if (n >= 1)
            return "míle" if (n >= 0)
          end
          private(:format_thousand)
          def format_is_thousands(n)
            return ((format_is(n) + " ") + format_thousands(n)) if (n >= 20)
            return (" is " + format_thousands(n)) if (n >= 11)
            if (n >= 1) then
              return (((" is " + format_spellout_cardinal_prefixpart(n)) + " ") + format_thousand(n))
            end
            return (" " + format_thousand(n)) if (n >= 0)
          end
          private(:format_is_thousands)
          def format_millions(n)
            if (n >= 100) then
              return (format_hundreds((n / 100).floor) + format_is_millions((n % 100)))
            end
            if (n >= 2) then
              return ((format_spellout_cardinal_prefixpart(n) + " ") + format_millionsp(n))
            end
            return "milliún" if (n >= 1)
          end
          private(:format_millions)
          def format_millionsp(n)
            return format_million(n) if (n >= 20)
            return (format_million(n) + " déag") if (n >= 11)
            return format_million(n) if (n >= 2)
          end
          private(:format_millionsp)
          def format_million(n)
            return format_million((n % 100)) if (n >= 11)
            return "milliún" if (n >= 7)
            return "mhilliún" if (n >= 1)
            return "milliún" if (n >= 0)
          end
          private(:format_million)
          def format_is_millions(n)
            return ((format_is(n) + " ") + format_millions(n)) if (n >= 20)
            return (" is " + format_millions(n)) if (n >= 11)
            if (n >= 1) then
              return (((" is " + format_spellout_cardinal_prefixpart(n)) + " ") + format_million(n))
            end
            return (" " + format_million(n)) if (n >= 0)
          end
          private(:format_is_millions)
          def format_billions(n)
            if (n >= 100) then
              return (format_hundreds((n / 100).floor) + format_is_billions((n % 100)))
            end
            return (format_spellout_cardinal_prefixpart(n) + " billiún") if (n >= 20)
            if (n >= 11) then
              return (format_spellout_cardinal_prefixpart(n) + " billiún déag")
            end
            return (format_spellout_cardinal_prefixpart(n) + " billiún") if (n >= 2)
            return "billiún" if (n >= 1)
          end
          private(:format_billions)
          def format_is_billions(n)
            return ((format_is(n) + " ") + format_billions(n)) if (n >= 20)
            return (" is " + format_billions(n)) if (n >= 11)
            if (n >= 1) then
              return ((" is " + format_spellout_cardinal_prefixpart(n)) + " billiún")
            end
            return " billiún" if (n >= 0)
          end
          private(:format_is_billions)
          def format_trillions(n)
            if (n >= 100) then
              return (format_hundreds((n / 100).floor) + format_is_trillions((n % 100)))
            end
            if (n >= 2) then
              return ((format_spellout_cardinal_prefixpart(n) + " ") + format_trillionsp(n))
            end
            return "thrilliún" if (n >= 1)
          end
          private(:format_trillions)
          def format_trillionsp(n)
            return format_trillion(n) if (n >= 20)
            return (format_trillion(n) + " déag") if (n >= 11)
            return format_trillion(n) if (n >= 2)
          end
          private(:format_trillionsp)
          def format_trillion(n)
            return format_trillion((n % 100)) if (n >= 11)
            return "dtrilliún" if (n >= 7)
            return "thrilliún" if (n >= 1)
            return "dtrilliún" if (n >= 0)
          end
          private(:format_trillion)
          def format_is_trillions(n)
            return ((format_is(n) + " ") + format_trillions(n)) if (n >= 20)
            return (" is " + format_trillions(n)) if (n >= 11)
            if (n >= 1) then
              return (((" is " + format_spellout_cardinal_prefixpart(n)) + " ") + format_trillion(n))
            end
            return (" " + format_trillion(n)) if (n >= 0)
          end
          private(:format_is_trillions)
          def format_quadrillions(n)
            if (n >= 100) then
              return (format_hundreds((n / 100).floor) + format_is_quadrillions((n % 100)))
            end
            if (n >= 20) then
              return (format_spellout_cardinal_prefixpart(n) + " quadrilliún")
            end
            if (n >= 11) then
              return (format_spellout_cardinal_prefixpart(n) + " quadrilliún déag")
            end
            if (n >= 2) then
              return (format_spellout_cardinal_prefixpart(n) + " quadrilliún")
            end
            return "quadrilliún" if (n >= 1)
          end
          private(:format_quadrillions)
          def format_is_quadrillions(n)
            return ((format_is(n) + " ") + format_quadrillions(n)) if (n >= 20)
            return (" is " + format_quadrillions(n)) if (n >= 11)
            if (n >= 1) then
              return ((" is " + format_spellout_cardinal_prefixpart(n)) + " quadrilliún")
            end
            return " quadrilliún" if (n >= 0)
          end
          private(:format_is_quadrillions)
        end
      end
      
      class Irish::Ordinal
        class << self
          def format_digits_ordinal(n)
            return ("−" + format_digits_ordinal(-n)) if (n < 0)
            return (n.to_s + "ú") if (n >= 0)
          end
        end
      end
    end
  end
end