# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:en] = English = Module.new { }
      
      class English::Spellout
        class << self
          def format_2d_year(n)
            return format_spellout_numbering(n) if (n >= 10)
            return ("oh-" + format_spellout_numbering(n)) if (n >= 1)
            return "hundred" if (n >= 0)
          end
          private(:format_2d_year)
          def format_spellout_numbering_year(n)
            is_fractional = (n != n.floor)
            return ("minus " + format_spellout_numbering_year(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return format_spellout_numbering(n) if (n >= 10000)
            if (n >= 9100) then
              return ((format_spellout_numbering_year((n / 9100.0).floor) + " ") + format_2d_year((n % 100)))
            end
            if (n >= 9010) then
              return ((format_spellout_numbering_year((n / 9010.0).floor) + " ") + format_2d_year((n % 100)))
            end
            return format_spellout_numbering(n) if (n >= 9000)
            if (n >= 8100) then
              return ((format_spellout_numbering_year((n / 8100.0).floor) + " ") + format_2d_year((n % 100)))
            end
            if (n >= 8010) then
              return ((format_spellout_numbering_year((n / 8010.0).floor) + " ") + format_2d_year((n % 100)))
            end
            return format_spellout_numbering(n) if (n >= 8000)
            if (n >= 7100) then
              return ((format_spellout_numbering_year((n / 7100.0).floor) + " ") + format_2d_year((n % 100)))
            end
            if (n >= 7010) then
              return ((format_spellout_numbering_year((n / 7010.0).floor) + " ") + format_2d_year((n % 100)))
            end
            return format_spellout_numbering(n) if (n >= 7000)
            if (n >= 6100) then
              return ((format_spellout_numbering_year((n / 6100.0).floor) + " ") + format_2d_year((n % 100)))
            end
            if (n >= 6010) then
              return ((format_spellout_numbering_year((n / 6010.0).floor) + " ") + format_2d_year((n % 100)))
            end
            return format_spellout_numbering(n) if (n >= 6000)
            if (n >= 5100) then
              return ((format_spellout_numbering_year((n / 5100.0).floor) + " ") + format_2d_year((n % 100)))
            end
            if (n >= 5010) then
              return ((format_spellout_numbering_year((n / 5010.0).floor) + " ") + format_2d_year((n % 100)))
            end
            return format_spellout_numbering(n) if (n >= 5000)
            if (n >= 4100) then
              return ((format_spellout_numbering_year((n / 4100.0).floor) + " ") + format_2d_year((n % 100)))
            end
            if (n >= 4010) then
              return ((format_spellout_numbering_year((n / 4010.0).floor) + " ") + format_2d_year((n % 100)))
            end
            return format_spellout_numbering(n) if (n >= 4000)
            if (n >= 3100) then
              return ((format_spellout_numbering_year((n / 3100.0).floor) + " ") + format_2d_year((n % 100)))
            end
            if (n >= 3010) then
              return ((format_spellout_numbering_year((n / 3010.0).floor) + " ") + format_2d_year((n % 100)))
            end
            return format_spellout_numbering(n) if (n >= 3000)
            if (n >= 2100) then
              return ((format_spellout_numbering_year((n / 2100.0).floor) + " ") + format_2d_year((n % 100)))
            end
            if (n >= 2010) then
              return ((format_spellout_numbering_year((n / 2010.0).floor) + " ") + format_2d_year((n % 100)))
            end
            return format_spellout_numbering(n) if (n >= 2000)
            if (n >= 1100) then
              return ((format_spellout_numbering_year((n / 1100.0).floor) + " ") + format_2d_year((n % 100)))
            end
            if (n >= 1010) then
              return ((format_spellout_numbering_year((n / 1010.0).floor) + " ") + format_2d_year((n % 100)))
            end
            return format_spellout_numbering(n) if (n >= 0)
          end
          def format_spellout_numbering(n)
            return format_spellout_cardinal(n) if (n >= 0)
          end
          def format_spellout_numbering_verbose(n)
            return format_spellout_cardinal_verbose(n) if (n >= 0)
          end
          def format_spellout_cardinal(n)
            is_fractional = (n != n.floor)
            return ("minus " + format_spellout_cardinal(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_cardinal(n.floor) + " point ") + format_spellout_cardinal(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 1000000000000000) then
              return ((format_spellout_cardinal((n / 1.0e+15).floor) + " quadrillion") + (if ((n == 1000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal((n % 100000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal((n / 1000000000000.0).floor) + " trillion") + (if ((n == 1000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal((n % 100000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((format_spellout_cardinal((n / 1000000000.0).floor) + " billion") + (if ((n == 1000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal((n % 100000000)))
              end))
            end
            if (n >= 1000000) then
              return ((format_spellout_cardinal((n / 1000000.0).floor) + " million") + (if ((n == 1000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal((n % 100000)))
              end))
            end
            if (n >= 1000) then
              return ((format_spellout_cardinal((n / 1000.0).floor) + " thousand") + (if ((n == 1000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal((n % 100)))
              end))
            end
            if (n >= 100) then
              return ((format_spellout_cardinal((n / 100.0).floor) + " hundred") + (if ((n == 100) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal((n % 100)))
              end))
            end
            if (n >= 90) then
              return ("ninety" + (if ((n == 90) or ((n % 10) == 0)) then
                ""
              else
                ("-" + format_spellout_cardinal((n % 10)))
              end))
            end
            if (n >= 80) then
              return ("eighty" + (if ((n == 80) or ((n % 10) == 0)) then
                ""
              else
                ("-" + format_spellout_cardinal((n % 10)))
              end))
            end
            if (n >= 70) then
              return ("seventy" + (if ((n == 70) or ((n % 10) == 0)) then
                ""
              else
                ("-" + format_spellout_cardinal((n % 10)))
              end))
            end
            if (n >= 60) then
              return ("sixty" + (if ((n == 60) or ((n % 10) == 0)) then
                ""
              else
                ("-" + format_spellout_cardinal((n % 10)))
              end))
            end
            if (n >= 50) then
              return ("fifty" + (if ((n == 50) or ((n % 10) == 0)) then
                ""
              else
                ("-" + format_spellout_cardinal((n % 10)))
              end))
            end
            if (n >= 40) then
              return ("forty" + (if ((n == 40) or ((n % 10) == 0)) then
                ""
              else
                ("-" + format_spellout_cardinal((n % 10)))
              end))
            end
            if (n >= 30) then
              return ("thirty" + (if ((n == 30) or ((n % 10) == 0)) then
                ""
              else
                ("-" + format_spellout_cardinal((n % 10)))
              end))
            end
            if (n >= 20) then
              return ("twenty" + (if ((n == 20) or ((n % 10) == 0)) then
                ""
              else
                ("-" + format_spellout_cardinal((n % 10)))
              end))
            end
            return "nineteen" if (n >= 19)
            return "eighteen" if (n >= 18)
            return "seventeen" if (n >= 17)
            return "sixteen" if (n >= 16)
            return "fifteen" if (n >= 15)
            return "fourteen" if (n >= 14)
            return "thirteen" if (n >= 13)
            return "twelve" if (n >= 12)
            return "eleven" if (n >= 11)
            return "ten" if (n >= 10)
            return "nine" if (n >= 9)
            return "eight" if (n >= 8)
            return "seven" if (n >= 7)
            return "six" if (n >= 6)
            return "five" if (n >= 5)
            return "four" if (n >= 4)
            return "three" if (n >= 3)
            return "two" if (n >= 2)
            return "one" if (n >= 1)
            return "zero" if (n >= 0)
          end
          def format_and(n)
            return (" " + format_spellout_cardinal_verbose(n)) if (n >= 100)
            return (" and " + format_spellout_cardinal_verbose(n)) if (n >= 1)
          end
          private(:format_and)
          def format_commas(n)
            return (" " + format_spellout_cardinal_verbose(n)) if (n >= 1000000)
            if (n >= 1000) then
              return (((" " + format_spellout_cardinal_verbose((n / 1000.0).floor)) + " thousand") + (((n == 1000) or ((n % 10) == 0)) ? ("") : (format_commas((n % 100)))))
            end
            return (" " + format_spellout_cardinal_verbose(n)) if (n >= 100)
            return (" and " + format_spellout_cardinal_verbose(n)) if (n >= 1)
          end
          private(:format_commas)
          def format_spellout_cardinal_verbose(n)
            is_fractional = (n != n.floor)
            return ("minus " + format_spellout_cardinal_verbose(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_cardinal_verbose(n.floor) + " point ") + format_spellout_cardinal_verbose(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 1000000000000000) then
              return ((format_spellout_cardinal_verbose((n / 1.0e+15).floor) + " quadrillion") + (if ((n == 1000000000000000) or ((n % 10) == 0)) then
                ""
              else
                format_commas((n % 100000000000000))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal_verbose((n / 1000000000000.0).floor) + " trillion") + (if ((n == 1000000000000) or ((n % 10) == 0)) then
                ""
              else
                format_commas((n % 100000000000))
              end))
            end
            if (n >= 1000000000) then
              return ((format_spellout_cardinal_verbose((n / 1000000000.0).floor) + " billion") + (if ((n == 1000000000) or ((n % 10) == 0)) then
                ""
              else
                format_commas((n % 100000000))
              end))
            end
            if (n >= 1000000) then
              return ((format_spellout_cardinal_verbose((n / 1000000.0).floor) + " million") + (((n == 1000000) or ((n % 10) == 0)) ? ("") : (format_commas((n % 100000)))))
            end
            if (n >= 100000) then
              return ((format_spellout_cardinal_verbose((n / 100000.0).floor) + " thousand") + (((n == 100000) or ((n % 10) == 0)) ? ("") : (format_commas((n % 1000)))))
            end
            if (n >= 1000) then
              return ((format_spellout_cardinal_verbose((n / 1000.0).floor) + " thousand") + (((n == 1000) or ((n % 10) == 0)) ? ("") : (format_and((n % 100)))))
            end
            if (n >= 100) then
              return ((format_spellout_cardinal_verbose((n / 100.0).floor) + " hundred") + (((n == 100) or ((n % 10) == 0)) ? ("") : (format_and((n % 100)))))
            end
            return format_spellout_numbering(n) if (n >= 0)
          end
          def format_tieth(n)
            return ("ty-" + format_spellout_ordinal(n)) if (n >= 1)
            return "tieth" if (n >= 0)
          end
          private(:format_tieth)
          def format_th(n)
            return (" " + format_spellout_ordinal(n)) if (n >= 1)
            return "th" if (n >= 0)
          end
          private(:format_th)
          def format_spellout_ordinal(n)
            is_fractional = (n != n.floor)
            return ("minus " + format_spellout_ordinal(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return (n.to_s + ".") if (n >= 1000000000000000000)
            if (n >= 1000000000000000) then
              return ((format_spellout_numbering((n / 1.0e+15).floor) + " quadrillion") + format_th((n % 100000000000000)))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_numbering((n / 1000000000000.0).floor) + " trillion") + format_th((n % 100000000000)))
            end
            if (n >= 1000000000) then
              return ((format_spellout_numbering((n / 1000000000.0).floor) + " billion") + format_th((n % 100000000)))
            end
            if (n >= 1000000) then
              return ((format_spellout_numbering((n / 1000000.0).floor) + " million") + format_th((n % 100000)))
            end
            if (n >= 1000) then
              return ((format_spellout_numbering((n / 1000.0).floor) + " thousand") + format_th((n % 100)))
            end
            if (n >= 100) then
              return ((format_spellout_numbering((n / 100.0).floor) + " hundred") + format_th((n % 100)))
            end
            return ("nine" + format_tieth((n % 10))) if (n >= 90)
            return ("eigh" + format_tieth((n % 10))) if (n >= 80)
            return ("seven" + format_tieth((n % 10))) if (n >= 70)
            return ("six" + format_tieth((n % 10))) if (n >= 60)
            return ("fif" + format_tieth((n % 10))) if (n >= 50)
            return ("for" + format_tieth((n % 10))) if (n >= 40)
            return ("thir" + format_tieth((n % 10))) if (n >= 30)
            return ("twen" + format_tieth((n % 10))) if (n >= 20)
            return (format_spellout_numbering(n) + "th") if (n >= 13)
            return "twelfth" if (n >= 12)
            return "eleventh" if (n >= 11)
            return "tenth" if (n >= 10)
            return "ninth" if (n >= 9)
            return "eighth" if (n >= 8)
            return "seventh" if (n >= 7)
            return "sixth" if (n >= 6)
            return "fifth" if (n >= 5)
            return "fourth" if (n >= 4)
            return "third" if (n >= 3)
            return "second" if (n >= 2)
            return "first" if (n >= 1)
            return "zeroth" if (n >= 0)
          end
          def format_and_o(n)
            return (" " + format_spellout_ordinal_verbose(n)) if (n >= 100)
            return (" and " + format_spellout_ordinal_verbose(n)) if (n >= 1)
            return "th" if (n >= 0)
          end
          private(:format_and_o)
          def format_commas_o(n)
            return (" " + format_spellout_ordinal_verbose(n)) if (n >= 1000000)
            if (n >= 1000) then
              return (((" " + format_spellout_cardinal_verbose((n / 1000.0).floor)) + " thousand") + format_commas_o((n % 100)))
            end
            return (" " + format_spellout_ordinal_verbose(n)) if (n >= 100)
            return (" and " + format_spellout_ordinal_verbose(n)) if (n >= 1)
            return "th" if (n >= 0)
          end
          private(:format_commas_o)
          def format_spellout_ordinal_verbose(n)
            is_fractional = (n != n.floor)
            return ("minus " + format_spellout_ordinal_verbose(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return (n.to_s + ".") if (n >= 1000000000000000000)
            if (n >= 1000000000000000) then
              return ((format_spellout_numbering_verbose((n / 1.0e+15).floor) + " quadrillion") + format_commas_o((n % 100000000000000)))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_numbering_verbose((n / 1000000000000.0).floor) + " trillion") + format_commas_o((n % 100000000000)))
            end
            if (n >= 1000000000) then
              return ((format_spellout_numbering_verbose((n / 1000000000.0).floor) + " billion") + format_commas_o((n % 100000000)))
            end
            if (n >= 1000000) then
              return ((format_spellout_numbering_verbose((n / 1000000.0).floor) + " million") + format_commas_o((n % 100000)))
            end
            if (n >= 100000) then
              return ((format_spellout_numbering_verbose((n / 100000.0).floor) + " thousand") + format_commas_o((n % 1000)))
            end
            if (n >= 1000) then
              return ((format_spellout_numbering_verbose((n / 1000.0).floor) + " thousand") + format_and_o((n % 100)))
            end
            if (n >= 100) then
              return ((format_spellout_numbering_verbose((n / 100.0).floor) + " hundred") + format_and_o((n % 100)))
            end
            return format_spellout_ordinal(n) if (n >= 0)
          end
        end
      end
      
      class English::Ordinal
        class << self
          def format_digits_ordinal_indicator(n)
            return format_digits_ordinal_indicator((n % 100)) if (n >= 100)
            return format_digits_ordinal_indicator((n % 10)) if (n >= 20)
            return "th" if (n >= 4)
            return "rd" if (n >= 3)
            return "nd" if (n >= 2)
            return "st" if (n >= 1)
            return "th" if (n >= 0)
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