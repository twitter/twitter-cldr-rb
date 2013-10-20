# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:fr] = French = Module.new { }
      
      class French::Spellout
        class << self
          def format_lenient_parse(n)
            if (n >= 0) then
              return (((((((((((((n == 0) or ((n % 10) == 0)) ? ("") : ("last primary ignorable ")) + " ") + format_lenient_parse((n / 10).floor)) + " ' ' ") + format_lenient_parse((n / 10).floor)) + " '") + "' ") + format_lenient_parse((n / 10).floor)) + " '-' ") + format_lenient_parse((n / 10).floor)) + " '­'")
            end
          end
          private(:format_lenient_parse)
          def format_spellout_numbering_year(n)
            is_fractional = (n != n.floor)
            return ("moins " + format_spellout_numbering_year(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return format_spellout_numbering(n) if (n >= 10000)
            if (n >= 1100) then
              return ((format_spellout_cardinal_masculine((n / 10000).floor) + "-cent") + format_cents_m((n % 10000)))
            end
            return format_spellout_numbering(n) if (n >= 0)
          end
          def format_spellout_numbering(n)
            return format_spellout_cardinal_masculine(n) if (n >= 0)
          end
          def format_et_un(n)
            return format_spellout_cardinal_masculine(n) if (n >= 12)
            return "et-onze" if (n >= 11)
            return format_spellout_cardinal_masculine(n) if (n >= 2)
            return "et-un" if (n >= 1)
          end
          private(:format_et_un)
          def format_cents_m(n)
            return ("-" + format_spellout_cardinal_masculine(n)) if (n >= 1)
            return "s" if (n >= 0)
          end
          private(:format_cents_m)
          def format_spellout_leading(n)
            return format_spellout_cardinal_masculine(n) if (n >= 1000)
            if (n >= 200) then
              return ((format_spellout_leading((n / 1000).floor) + "-cent") + (if ((n == 200) or ((n % 10) == 0)) then
                ""
              else
                ("-" + format_spellout_leading((n % 1000)))
              end))
            end
            if (n >= 100) then
              return ("cent" + (if ((n == 100) or ((n % 10) == 0)) then
                ""
              else
                ("-" + format_spellout_leading((n % 100)))
              end))
            end
            if (n >= 80) then
              return ("quatre-vingt" + (if ((n == 80) or ((n % 10) == 0)) then
                ""
              else
                ("-" + format_spellout_leading((n % 400)))
              end))
            end
            return format_spellout_cardinal_masculine(n) if (n >= 0)
          end
          private(:format_spellout_leading)
          def format_spellout_cardinal_masculine(n)
            is_fractional = (n != n.floor)
            return ("moins " + format_spellout_cardinal_masculine(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_cardinal_masculine(n.floor) + " virgule ") + format_spellout_cardinal_masculine((n % 10)))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((format_spellout_leading((n / 10000000000000000).floor) + " billiards") + (if ((n == 2000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 10000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("un billiard" + (if ((n == 1000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_leading((n / 10000000000000).floor) + " billions") + (if ((n == 2000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 10000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("un billion" + (if ((n == 1000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_leading((n / 10000000000).floor) + " milliards") + (if ((n == 2000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 10000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("un milliard" + (if ((n == 1000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_leading((n / 10000000).floor) + " millions") + (if ((n == 2000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 10000000)))
              end))
            end
            if (n >= 1000000) then
              return ("un million" + (if ((n == 1000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000)))
              end))
            end
            if (n >= 2000) then
              return ((format_spellout_leading((n / 10000).floor) + "-mille") + (if ((n == 2000) or ((n % 10) == 0)) then
                ""
              else
                ("-" + format_spellout_cardinal_masculine((n % 10000)))
              end))
            end
            if (n >= 1000) then
              return ("mille" + (if ((n == 1000) or ((n % 10) == 0)) then
                ""
              else
                ("-" + format_spellout_cardinal_masculine((n % 1000)))
              end))
            end
            if (n >= 200) then
              return ((format_spellout_cardinal_masculine((n / 1000).floor) + "-cent") + format_cents_m((n % 1000)))
            end
            if (n >= 100) then
              return ("cent" + (if ((n == 100) or ((n % 10) == 0)) then
                ""
              else
                ("-" + format_spellout_cardinal_masculine((n % 100)))
              end))
            end
            return ("quatre-vingt" + format_cents_m((n % 400))) if (n >= 80)
            if (n >= 60) then
              return ("soixante" + (((n == 60) or ((n % 10) == 0)) ? ("") : (("-" + format_et_un((n % 400))))))
            end
            if (n >= 50) then
              return ("cinquante" + (((n == 50) or ((n % 10) == 0)) ? ("") : (("-" + format_et_un((n % 100))))))
            end
            if (n >= 40) then
              return ("quarante" + (((n == 40) or ((n % 10) == 0)) ? ("") : (("-" + format_et_un((n % 100))))))
            end
            if (n >= 30) then
              return ("trente" + (((n == 30) or ((n % 10) == 0)) ? ("") : (("-" + format_et_un((n % 100))))))
            end
            if (n >= 20) then
              return ("vingt" + (((n == 20) or ((n % 10) == 0)) ? ("") : (("-" + format_et_un((n % 100))))))
            end
            if (n >= 17) then
              return ("dix-" + format_spellout_cardinal_masculine((n % 100)))
            end
            return "seize" if (n >= 16)
            return "quinze" if (n >= 15)
            return "quatorze" if (n >= 14)
            return "treize" if (n >= 13)
            return "douze" if (n >= 12)
            return "onze" if (n >= 11)
            return "dix" if (n >= 10)
            return "neuf" if (n >= 9)
            return "huit" if (n >= 8)
            return "sept" if (n >= 7)
            return "six" if (n >= 6)
            return "cinq" if (n >= 5)
            return "quatre" if (n >= 4)
            return "trois" if (n >= 3)
            return "deux" if (n >= 2)
            return "un" if (n >= 1)
            return "zéro" if (n >= 0)
          end
          def format_et_une(n)
            return format_spellout_cardinal_feminine(n) if (n >= 12)
            return "et-onze" if (n >= 11)
            return format_spellout_cardinal_feminine(n) if (n >= 2)
            return "et-une" if (n >= 1)
          end
          private(:format_et_une)
          def format_cents_f(n)
            return ("-" + format_spellout_cardinal_feminine(n)) if (n >= 1)
            return "s" if (n >= 0)
          end
          private(:format_cents_f)
          def format_spellout_cardinal_feminine(n)
            is_fractional = (n != n.floor)
            return ("moins " + format_spellout_cardinal_feminine(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_cardinal_feminine(n.floor) + " virgule ") + format_spellout_cardinal_feminine((n % 10)))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((format_spellout_leading((n / 10000000000000000).floor) + " billiards") + (if ((n == 2000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 10000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("un billiard" + (if ((n == 1000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_leading((n / 10000000000000).floor) + " billions") + (if ((n == 2000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 10000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("un billion" + (if ((n == 1000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_leading((n / 10000000000).floor) + " milliards") + (if ((n == 2000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 10000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("un milliard" + (if ((n == 1000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_leading((n / 10000000).floor) + " millions") + (if ((n == 2000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 10000000)))
              end))
            end
            if (n >= 1000000) then
              return ("un million" + (if ((n == 1000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000)))
              end))
            end
            if (n >= 2000) then
              return ((format_spellout_leading((n / 10000).floor) + "-mille") + (if ((n == 2000) or ((n % 10) == 0)) then
                ""
              else
                ("-" + format_spellout_cardinal_feminine((n % 10000)))
              end))
            end
            if (n >= 1000) then
              return ("mille" + (if ((n == 1000) or ((n % 10) == 0)) then
                ""
              else
                ("-" + format_spellout_cardinal_feminine((n % 1000)))
              end))
            end
            if (n >= 200) then
              return ((format_spellout_cardinal_masculine((n / 1000).floor) + "-cent") + format_cents_f((n % 1000)))
            end
            if (n >= 100) then
              return ("cent" + (if ((n == 100) or ((n % 10) == 0)) then
                ""
              else
                ("-" + format_spellout_cardinal_feminine((n % 100)))
              end))
            end
            return ("quatre-vingt" + format_cents_f((n % 400))) if (n >= 80)
            if (n >= 60) then
              return ("soixante" + (((n == 60) or ((n % 10) == 0)) ? ("") : (("-" + format_et_une((n % 400))))))
            end
            if (n >= 50) then
              return ("cinquante" + (((n == 50) or ((n % 10) == 0)) ? ("") : (("-" + format_et_une((n % 100))))))
            end
            if (n >= 40) then
              return ("quarante" + (((n == 40) or ((n % 10) == 0)) ? ("") : (("-" + format_et_une((n % 100))))))
            end
            if (n >= 30) then
              return ("trente" + (((n == 30) or ((n % 10) == 0)) ? ("") : (("-" + format_et_une((n % 100))))))
            end
            if (n >= 20) then
              return ("vingt" + (((n == 20) or ((n % 10) == 0)) ? ("") : (("-" + format_et_une((n % 100))))))
            end
            return format_spellout_cardinal_masculine(n) if (n >= 2)
            return "une" if (n >= 1)
            return "zéro" if (n >= 0)
          end
          def format_et_unieme(n)
            return format_spellout_ordinal(n) if (n >= 12)
            return "et-onzième" if (n >= 11)
            return format_spellout_ordinal(n) if (n >= 2)
            return "et-unième" if (n >= 1)
          end
          private(:format_et_unieme)
          def format_cents_o(n)
            return ("-" + format_et_unieme(n)) if (n >= 1)
            return "ième" if (n >= 0)
          end
          private(:format_cents_o)
          def format_mille_o(n)
            return ("e-" + format_et_unieme(n)) if (n >= 1)
            return "ième" if (n >= 0)
          end
          private(:format_mille_o)
          def format_spellout_ordinal(n)
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 1000000000000000) then
              return ((format_spellout_leading((n / 1000000000000000).floor) + "-billiard") + format_cents_o((n % 1000000000000000)))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_leading((n / 1000000000000).floor) + "-billion") + format_cents_o((n % 1000000000000)))
            end
            if (n >= 1000000000) then
              return ((format_spellout_leading((n / 1000000000).floor) + "-milliard") + format_cents_o((n % 1000000000)))
            end
            if (n >= 1000000) then
              return ((format_spellout_leading((n / 1000000).floor) + "-million") + format_cents_o((n % 1000000)))
            end
            if (n >= 2000) then
              return ((format_spellout_leading((n / 10000).floor) + "-mill") + format_mille_o((n % 10000)))
            end
            return ("mill" + format_mille_o((n % 1000))) if (n >= 1000)
            if (n >= 200) then
              return ((format_spellout_cardinal_masculine((n / 1000).floor) + "-cent") + format_cents_o((n % 1000)))
            end
            return ("cent" + format_cents_o((n % 100))) if (n >= 100)
            return ("quatre-vingt" + format_cents_o((n % 400))) if (n >= 80)
            return ("soixante-" + format_et_unieme((n % 400))) if (n >= 61)
            return "soixantième" if (n >= 60)
            return ("cinquante-" + format_et_unieme((n % 100))) if (n >= 51)
            return "cinquantième" if (n >= 50)
            return ("quarante-" + format_et_unieme((n % 100))) if (n >= 41)
            return "quarantième" if (n >= 40)
            return ("trente-" + format_et_unieme((n % 100))) if (n >= 31)
            return "trentième" if (n >= 30)
            return ("vingt-" + format_et_unieme((n % 100))) if (n >= 21)
            return "vingtième" if (n >= 20)
            return ("dix-" + format_spellout_ordinal((n % 100))) if (n >= 17)
            return "seizième" if (n >= 16)
            return "quinzième" if (n >= 15)
            return "quatorzième" if (n >= 14)
            return "treizième" if (n >= 13)
            return "douzième" if (n >= 12)
            return "onzième" if (n >= 11)
            return "dixième" if (n >= 10)
            return "neuvième" if (n >= 9)
            return "huitième" if (n >= 8)
            return "septième" if (n >= 7)
            return "sixième" if (n >= 6)
            return "cinquième" if (n >= 5)
            return "quatrième" if (n >= 4)
            return "troisième" if (n >= 3)
            return "deuxième" if (n >= 2)
            return "unième" if (n >= 1)
          end
          private(:format_spellout_ordinal)
          def format_spellout_ordinal_masculine_plural(n)
            return (format_spellout_ordinal_masculine(n) + "s") if (n >= 0)
          end
          def format_spellout_ordinal_masculine(n)
            is_fractional = (n != n.floor)
            return ("moins " + format_spellout_ordinal_masculine(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return format_spellout_ordinal(n) if (n >= 2)
            return "premier" if (n >= 1)
            return "zéroième" if (n >= 0)
          end
          def format_spellout_ordinal_feminine_plural(n)
            return (format_spellout_ordinal_feminine(n) + "s") if (n >= 0)
          end
          def format_spellout_ordinal_feminine(n)
            is_fractional = (n != n.floor)
            return ("moins " + format_spellout_ordinal_feminine(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return format_spellout_ordinal(n) if (n >= 2)
            return "première" if (n >= 1)
            return "zéroième" if (n >= 0)
          end
        end
      end
      
      class French::Ordinal
        class << self
          def format_dord_mascabbrev(n)
            return "e" if (n >= 2)
            return "er" if (n >= 1)
            return "e" if (n >= 0)
          end
          private(:format_dord_mascabbrev)
          def format_digits_ordinal_masculine(n)
            return ("−" + format_digits_ordinal_masculine(-n)) if (n < 0)
            return (n.to_s + format_dord_mascabbrev(n)) if (n >= 0)
          end
          def format_dord_femabbrev(n)
            return "e" if (n >= 2)
            return "re" if (n >= 1)
            return "e" if (n >= 0)
          end
          private(:format_dord_femabbrev)
          def format_digits_ordinal_feminine(n)
            return ("−" + format_digits_ordinal_feminine(-n)) if (n < 0)
            return (n.to_s + format_dord_femabbrev(n)) if (n >= 0)
          end
          def format_digits_ordinal(n)
            return format_digits_ordinal_masculine(n) if (n >= 0)
          end
        end
      end
    end
  end
end