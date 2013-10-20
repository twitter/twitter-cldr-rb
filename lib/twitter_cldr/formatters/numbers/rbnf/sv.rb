# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:sv] = Swedish = Module.new { }
      
      class Swedish::Spellout
        class << self
          def format_lenient_parse(n)
            if (n >= 0) then
              return (((((((((((((n == 0) or ((n % 10) == 0)) ? ("") : ("last primary ignorable ")) + " ") + format_lenient_parse((n / 10).floor)) + " ' ' ") + format_lenient_parse((n / 10).floor)) + " '") + "' ") + format_lenient_parse((n / 10).floor)) + " '-' ") + format_lenient_parse((n / 10).floor)) + " '­'")
            end
          end
          private(:format_lenient_parse)
          def format_spellout_numbering_year(n)
            is_fractional = (n != n.floor)
            return ("minus " + format_spellout_numbering_year(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return format_spellout_numbering(n) if (n >= 10000)
            if (n >= 1100) then
              return ((format_spellout_numbering_year((n / 10000).floor) + "­hundra") + (if ((n == 1100) or ((n % 10) == 0)) then
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
              return ((format_spellout_numbering(n.floor) + " komma ") + format_spellout_numbering((n % 10)))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_reale((n / 10000000000000000).floor) + " biljarder") + (if ((n == 2000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_numbering((n % 10000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("en biljard" + (if ((n == 1000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_numbering((n % 1000000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_reale((n / 10000000000000).floor) + " biljoner") + (if ((n == 2000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_numbering((n % 10000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("en biljon" + (if ((n == 1000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_numbering((n % 1000000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_reale((n / 10000000000).floor) + " miljarder") + (if ((n == 2000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_numbering((n % 10000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("en miljard" + (if ((n == 1000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_numbering((n % 1000000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_reale((n / 10000000).floor) + " miljoner") + (if ((n == 2000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_numbering((n % 10000000)))
              end))
            end
            if (n >= 1000000) then
              return ("en miljon" + (if ((n == 1000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_numbering((n % 1000000)))
              end))
            end
            if (n >= 1000) then
              return ((format_spellout_numbering_t((n / 1000).floor) + "­tusen") + (if ((n == 1000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_numbering((n % 1000)))
              end))
            end
            if (n >= 100) then
              return ((format_spellout_numbering((n / 100).floor) + "­hundra") + (if ((n == 100) or ((n % 10) == 0)) then
                ""
              else
                ("­" + format_spellout_numbering((n % 100)))
              end))
            end
            if (n >= 90) then
              return ("nittio" + (if ((n == 90) or ((n % 10) == 0)) then
                ""
              else
                ("­" + format_spellout_numbering((n % 100)))
              end))
            end
            if (n >= 80) then
              return ("åttio" + (if ((n == 80) or ((n % 10) == 0)) then
                ""
              else
                ("­" + format_spellout_numbering((n % 100)))
              end))
            end
            if (n >= 70) then
              return ("sjuttio" + (if ((n == 70) or ((n % 10) == 0)) then
                ""
              else
                ("­" + format_spellout_numbering((n % 100)))
              end))
            end
            if (n >= 60) then
              return ("sextio" + (if ((n == 60) or ((n % 10) == 0)) then
                ""
              else
                ("­" + format_spellout_numbering((n % 100)))
              end))
            end
            if (n >= 50) then
              return ("femtio" + (if ((n == 50) or ((n % 10) == 0)) then
                ""
              else
                ("­" + format_spellout_numbering((n % 100)))
              end))
            end
            if (n >= 40) then
              return ("fyrtio" + (if ((n == 40) or ((n % 10) == 0)) then
                ""
              else
                ("­" + format_spellout_numbering((n % 100)))
              end))
            end
            if (n >= 30) then
              return ("trettio" + (if ((n == 30) or ((n % 10) == 0)) then
                ""
              else
                ("­" + format_spellout_numbering((n % 100)))
              end))
            end
            if (n >= 20) then
              return ("tjugo" + (if ((n == 20) or ((n % 10) == 0)) then
                ""
              else
                ("­" + format_spellout_numbering((n % 100)))
              end))
            end
            return "nitton" if (n >= 19)
            return "arton" if (n >= 18)
            return "sjutton" if (n >= 17)
            return "sexton" if (n >= 16)
            return "femton" if (n >= 15)
            return "fjorton" if (n >= 14)
            return "tretton" if (n >= 13)
            return "tolv" if (n >= 12)
            return "elva" if (n >= 11)
            return "tio" if (n >= 10)
            return "nio" if (n >= 9)
            return "åtta" if (n >= 8)
            return "sju" if (n >= 7)
            return "sex" if (n >= 6)
            return "fem" if (n >= 5)
            return "fyra" if (n >= 4)
            return "tre" if (n >= 3)
            return "två" if (n >= 2)
            return "ett" if (n >= 1)
            return "noll" if (n >= 0)
          end
          def format_spellout_numbering_t(n)
            return "ERROR" if (n >= 1000)
            if (n >= 100) then
              return ((format_spellout_numbering((n / 100).floor) + "­hundra") + (if ((n == 100) or ((n % 10) == 0)) then
                ""
              else
                ("­" + format_spellout_numbering_t((n % 100)))
              end))
            end
            if (n >= 90) then
              return ("nittio" + (if ((n == 90) or ((n % 10) == 0)) then
                ""
              else
                ("­" + format_spellout_numbering_t((n % 100)))
              end))
            end
            if (n >= 80) then
              return ("åttio" + (if ((n == 80) or ((n % 10) == 0)) then
                ""
              else
                ("­" + format_spellout_numbering_t((n % 100)))
              end))
            end
            if (n >= 70) then
              return ("sjuttio" + (if ((n == 70) or ((n % 10) == 0)) then
                ""
              else
                ("­" + format_spellout_numbering_t((n % 100)))
              end))
            end
            if (n >= 60) then
              return ("sextio" + (if ((n == 60) or ((n % 10) == 0)) then
                ""
              else
                ("­" + format_spellout_numbering_t((n % 100)))
              end))
            end
            if (n >= 50) then
              return ("femtio" + (if ((n == 50) or ((n % 10) == 0)) then
                ""
              else
                ("­" + format_spellout_numbering_t((n % 100)))
              end))
            end
            if (n >= 40) then
              return ("fyrtio" + (if ((n == 40) or ((n % 10) == 0)) then
                ""
              else
                ("­" + format_spellout_numbering_t((n % 100)))
              end))
            end
            if (n >= 30) then
              return ("trettio" + (if ((n == 30) or ((n % 10) == 0)) then
                ""
              else
                ("­" + format_spellout_numbering_t((n % 100)))
              end))
            end
            if (n >= 20) then
              return ("tjugo" + (if ((n == 20) or ((n % 10) == 0)) then
                ""
              else
                ("­" + format_spellout_numbering_t((n % 100)))
              end))
            end
            return "nitton" if (n >= 19)
            return "arton" if (n >= 18)
            return "sjutton" if (n >= 17)
            return "sexton" if (n >= 16)
            return "femton" if (n >= 15)
            return "fjorton" if (n >= 14)
            return "tretton" if (n >= 13)
            return "tolv" if (n >= 12)
            return "elva" if (n >= 11)
            return "tio" if (n >= 10)
            return "nio" if (n >= 9)
            return "åtta" if (n >= 8)
            return "sju" if (n >= 7)
            return "sex" if (n >= 6)
            return "fem" if (n >= 5)
            return "fyra" if (n >= 4)
            return "tre" if (n >= 3)
            return "två" if (n >= 2)
            return "et" if (n >= 1)
          end
          private(:format_spellout_numbering_t)
          def format_spellout_cardinal_neuter(n)
            return format_spellout_numbering(n) if (n >= 0)
          end
          def format_spellout_cardinal_masculine(n)
            return format_spellout_cardinal_reale(n) if (n >= 0)
          end
          def format_spellout_cardinal_feminine(n)
            return format_spellout_cardinal_reale(n) if (n >= 0)
          end
          def format_spellout_cardinal_reale(n)
            is_fractional = (n != n.floor)
            return ("minus " + format_spellout_cardinal_reale(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_cardinal_reale(n.floor) + " komma ") + format_spellout_cardinal_reale((n % 10)))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_reale((n / 10000000000000000).floor) + " biljarder") + (if ((n == 2000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_reale((n % 10000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("en biljard" + (if ((n == 1000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_reale((n % 1000000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_reale((n / 10000000000000).floor) + " biljoner") + (if ((n == 2000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_reale((n % 10000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("en biljon" + (if ((n == 1000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_reale((n % 1000000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_reale((n / 10000000000).floor) + " miljarder") + (if ((n == 2000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_reale((n % 10000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("en miljard" + (if ((n == 1000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_reale((n % 1000000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_reale((n / 10000000).floor) + " miljoner") + (if ((n == 2000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_reale((n % 10000000)))
              end))
            end
            if (n >= 1000000) then
              return ("en miljon" + (if ((n == 1000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_reale((n % 1000000)))
              end))
            end
            if (n >= 2000) then
              return ((format_spellout_cardinal_reale((n / 10000).floor) + "­tusen") + (if ((n == 2000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_reale((n % 10000)))
              end))
            end
            if (n >= 1000) then
              return ("ettusen" + (if ((n == 1000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_reale((n % 1000)))
              end))
            end
            if (n >= 100) then
              return ((format_spellout_cardinal_neuter((n / 100).floor) + "­hundra") + (if ((n == 100) or ((n % 10) == 0)) then
                ""
              else
                ("­" + format_spellout_cardinal_reale((n % 100)))
              end))
            end
            if (n >= 90) then
              return ("nittio" + (if ((n == 90) or ((n % 10) == 0)) then
                ""
              else
                ("­" + format_spellout_cardinal_reale((n % 100)))
              end))
            end
            if (n >= 80) then
              return ("åttio" + (if ((n == 80) or ((n % 10) == 0)) then
                ""
              else
                ("­" + format_spellout_cardinal_reale((n % 100)))
              end))
            end
            if (n >= 70) then
              return ("sjuttio" + (if ((n == 70) or ((n % 10) == 0)) then
                ""
              else
                ("­" + format_spellout_cardinal_reale((n % 100)))
              end))
            end
            if (n >= 60) then
              return ("sextio" + (if ((n == 60) or ((n % 10) == 0)) then
                ""
              else
                ("­" + format_spellout_cardinal_reale((n % 100)))
              end))
            end
            if (n >= 50) then
              return ("femtio" + (if ((n == 50) or ((n % 10) == 0)) then
                ""
              else
                ("­" + format_spellout_cardinal_reale((n % 100)))
              end))
            end
            if (n >= 40) then
              return ("fyrtio" + (if ((n == 40) or ((n % 10) == 0)) then
                ""
              else
                ("­" + format_spellout_cardinal_reale((n % 100)))
              end))
            end
            if (n >= 30) then
              return ("trettio" + (if ((n == 30) or ((n % 10) == 0)) then
                ""
              else
                ("­" + format_spellout_cardinal_reale((n % 100)))
              end))
            end
            if (n >= 20) then
              return ("tjugo" + (if ((n == 20) or ((n % 10) == 0)) then
                ""
              else
                ("­" + format_spellout_cardinal_reale((n % 100)))
              end))
            end
            return format_spellout_numbering(n) if (n >= 2)
            return "en" if (n >= 1)
            return "noll" if (n >= 0)
          end
          def format_spellout_ordinal_neuter(n)
            is_fractional = (n != n.floor)
            return ("minus " + format_spellout_ordinal_neuter(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return (n.to_s + "':e") if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_reale((n / 10000000000000000).floor) + " biljard") + format_ord_fem_teer((n % 10000000000000000)))
            end
            if (n >= 1000000000000000) then
              return ("en biljard" + format_ord_fem_te((n % 1000000000000000)))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_reale((n / 10000000000000).floor) + " biljon") + format_ord_fem_teer((n % 10000000000000)))
            end
            if (n >= 1000000000000) then
              return ("en biljon" + format_ord_fem_te((n % 1000000000000)))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_reale((n / 10000000000).floor) + " miljard") + format_ord_fem_teer((n % 10000000000)))
            end
            if (n >= 1000000000) then
              return ("en miljard" + format_ord_fem_te((n % 1000000000)))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_reale((n / 10000000).floor) + " miljon") + format_ord_fem_teer((n % 10000000)))
            end
            return ("en miljon" + format_ord_fem_te((n % 1000000))) if (n >= 1000000)
            if (n >= 1000) then
              return ((format_spellout_numbering_t((n / 1000).floor) + "­tusen") + format_ord_fem_de((n % 1000)))
            end
            if (n >= 100) then
              return ((format_spellout_numbering((n / 100).floor) + "­hundra") + format_ord_fem_de((n % 100)))
            end
            return ("nittio" + format_ord_fem_nde((n % 100))) if (n >= 90)
            return ("åttio" + format_ord_fem_nde((n % 100))) if (n >= 80)
            return ("sjuttio" + format_ord_fem_nde((n % 100))) if (n >= 70)
            return ("sextio" + format_ord_fem_nde((n % 100))) if (n >= 60)
            return ("femtio" + format_ord_fem_nde((n % 100))) if (n >= 50)
            return ("fyrtio" + format_ord_fem_nde((n % 100))) if (n >= 40)
            return ("trettio" + format_ord_fem_nde((n % 100))) if (n >= 30)
            return ("tjugo" + format_ord_fem_nde((n % 100))) if (n >= 20)
            return format_spellout_ordinal_masculine(n) if (n >= 3)
            return "andra" if (n >= 2)
            return "första" if (n >= 1)
            return "nollte" if (n >= 0)
          end
          def format_ord_fem_nde(n)
            return ("­" + format_spellout_ordinal_feminine(n)) if (n >= 1)
            return "nde" if (n >= 0)
          end
          private(:format_ord_fem_nde)
          def format_ord_fem_de(n)
            return (" " + format_spellout_ordinal_feminine(n)) if (n >= 1)
            return "de" if (n >= 0)
          end
          private(:format_ord_fem_de)
          def format_ord_fem_te(n)
            return (" " + format_spellout_ordinal_feminine(n)) if (n >= 1)
            return "te" if (n >= 0)
          end
          private(:format_ord_fem_te)
          def format_ord_fem_teer(n)
            return ("er " + format_spellout_ordinal_feminine(n)) if (n >= 1)
            return "te" if (n >= 0)
          end
          private(:format_ord_fem_teer)
          def format_spellout_ordinal_masculine(n)
            is_fractional = (n != n.floor)
            return ("minus " + format_spellout_ordinal_masculine(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return (n.to_s + "':e") if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_reale((n / 10000000000000000).floor) + " biljard") + format_ord_masc_teer((n % 10000000000000000)))
            end
            if (n >= 1000000000000000) then
              return ("en biljard" + format_ord_masc_te((n % 1000000000000000)))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_reale((n / 10000000000000).floor) + " biljon") + format_ord_masc_teer((n % 10000000000000)))
            end
            if (n >= 1000000000000) then
              return ("en biljon" + format_ord_masc_te((n % 1000000000000)))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_reale((n / 10000000000).floor) + " miljard") + format_ord_masc_teer((n % 10000000000)))
            end
            if (n >= 1000000000) then
              return ("en miljard" + format_ord_masc_te((n % 1000000000)))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_reale((n / 10000000).floor) + " miljon") + format_ord_masc_teer((n % 10000000)))
            end
            return ("en miljon" + format_ord_masc_te((n % 1000000))) if (n >= 1000000)
            if (n >= 1000) then
              return ((format_spellout_numbering_t((n / 1000).floor) + "­tusen") + format_ord_masc_de((n % 1000)))
            end
            if (n >= 100) then
              return ((format_spellout_numbering((n / 100).floor) + "­hundra") + format_ord_masc_de((n % 100)))
            end
            return ("nittio" + format_ord_masc_nde((n % 100))) if (n >= 90)
            return ("åttio" + format_ord_masc_nde((n % 100))) if (n >= 80)
            return ("sjuttio" + format_ord_masc_nde((n % 100))) if (n >= 70)
            return ("sextio" + format_ord_masc_nde((n % 100))) if (n >= 60)
            return ("femtio" + format_ord_masc_nde((n % 100))) if (n >= 50)
            return ("fyrtio" + format_ord_masc_nde((n % 100))) if (n >= 40)
            return ("trettio" + format_ord_masc_nde((n % 100))) if (n >= 30)
            return ("tjugo" + format_ord_masc_nde((n % 100))) if (n >= 20)
            return (format_spellout_cardinal_neuter(n) + "de") if (n >= 13)
            return "tolfte" if (n >= 12)
            return "elfte" if (n >= 11)
            return "tionde" if (n >= 10)
            return "nionde" if (n >= 9)
            return "åttonde" if (n >= 8)
            return "sjunde" if (n >= 7)
            return "sjätte" if (n >= 6)
            return "femte" if (n >= 5)
            return "fjärde" if (n >= 4)
            return "tredje" if (n >= 3)
            return "andre" if (n >= 2)
            return "förste" if (n >= 1)
            return "nollte" if (n >= 0)
          end
          def format_ord_masc_nde(n)
            return ("­" + format_spellout_ordinal_masculine(n)) if (n >= 1)
            return "nde" if (n >= 0)
          end
          private(:format_ord_masc_nde)
          def format_ord_masc_de(n)
            return (" " + format_spellout_ordinal_masculine(n)) if (n >= 1)
            return "de" if (n >= 0)
          end
          private(:format_ord_masc_de)
          def format_ord_masc_te(n)
            return (" " + format_spellout_ordinal_masculine(n)) if (n >= 1)
            return "te" if (n >= 0)
          end
          private(:format_ord_masc_te)
          def format_ord_masc_teer(n)
            return ("er " + format_spellout_ordinal_masculine(n)) if (n >= 1)
            return "te" if (n >= 0)
          end
          private(:format_ord_masc_teer)
          def format_spellout_ordinal_feminine(n)
            return format_spellout_ordinal_neuter(n) if (n >= 0)
          end
          def format_spellout_ordinal_reale(n)
            return format_spellout_ordinal_neuter(n) if (n >= 0)
          end
        end
      end
      
      class Swedish::Ordinal
        class << self
          def format_digits_ordinal_neuter(n)
            return format_digits_ordinal_feminine(n) if (n >= 0)
          end
          def format_digits_ordinal_masculine(n)
            return ("−" + format_digits_ordinal_masculine(-n)) if (n < 0)
            return (n.to_s + format_dord_mascabbrev(n)) if (n >= 0)
          end
          def format_dord_mascabbrev(n)
            return ":e" if (n >= 0)
          end
          private(:format_dord_mascabbrev)
          def format_digits_ordinal_feminine(n)
            return ("−" + format_digits_ordinal_feminine(-n)) if (n < 0)
            return (n.to_s + format_dord_femabbrev(n)) if (n >= 0)
          end
          def format_dord_femabbrev(n)
            return format_dord_femabbrev((n % 100)) if (n >= 100)
            return format_dord_femabbrev((n % 100)) if (n >= 20)
            return ":e" if (n >= 3)
            return ":a" if (n >= 2)
            return ":a" if (n >= 1)
            return ":e" if (n >= 0)
          end
          private(:format_dord_femabbrev)
          def format_digits_ordinal_reale(n)
            return format_digits_ordinal_feminine(n) if (n >= 0)
          end
          def format_digits_ordinal(n)
            return format_digits_ordinal_masculine(n) if (n >= 0)
          end
        end
      end
    end
  end
end