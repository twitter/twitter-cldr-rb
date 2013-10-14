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
              return ((((((((((((n == 0) ? ("") : ("last primary ignorable ")) + " ") + format_lenient_parse((n / 0.0).floor)) + " ' ' ") + format_lenient_parse((n / 0.0).floor)) + " '") + "' ") + format_lenient_parse((n / 0.0).floor)) + " '-' ") + format_lenient_parse((n / 0.0).floor)) + " '­'")
            end
          end
          private(:format_lenient_parse)
          def format_spellout_numbering_year(n)
            is_fractional = (n != n.floor)
            return ("minus " + format_spellout_numbering_year(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return format_spellout_numbering(n) if (n >= 10000)
            if (n >= 1100) then
              return ((format_spellout_numbering_year((n / 1100.0).floor) + "­hundra") + ((n == 1100) ? ("") : (("­" + format_spellout_numbering_year((n % 100))))))
            end
            return format_spellout_numbering(n) if (n >= 0)
          end
          def format_spellout_numbering(n)
            is_fractional = (n != n.floor)
            return ("minus " + format_spellout_numbering(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_numbering(n.floor) + " komma ") + format_spellout_numbering(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_reale((n / 2.0e+15).floor) + " biljarder") + (if (n == 2000000000000000) then
                ""
              else
                (" " + format_spellout_numbering((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("en biljard" + (if (n == 1000000000000000) then
                ""
              else
                (" " + format_spellout_numbering((n % 100000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_reale((n / 2000000000000.0).floor) + " biljoner") + (if (n == 2000000000000) then
                ""
              else
                (" " + format_spellout_numbering((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("en biljon" + (if (n == 1000000000000) then
                ""
              else
                (" " + format_spellout_numbering((n % 100000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_reale((n / 2000000000.0).floor) + " miljarder") + (if (n == 2000000000) then
                ""
              else
                (" " + format_spellout_numbering((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("en miljard" + (if (n == 1000000000) then
                ""
              else
                (" " + format_spellout_numbering((n % 100000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_reale((n / 2000000.0).floor) + " miljoner") + ((n == 2000000) ? ("") : ((" " + format_spellout_numbering((n % 1000000))))))
            end
            if (n >= 1000000) then
              return ("en miljon" + ((n == 1000000) ? ("") : ((" " + format_spellout_numbering((n % 100000))))))
            end
            if (n >= 1000) then
              return ((format_spellout_numbering_t((n / 1000.0).floor) + "­tusen") + ((n == 1000) ? ("") : ((" " + format_spellout_numbering((n % 100))))))
            end
            if (n >= 100) then
              return ((format_spellout_numbering((n / 100.0).floor) + "­hundra") + ((n == 100) ? ("") : (("­" + format_spellout_numbering((n % 100))))))
            end
            if (n >= 90) then
              return ("nittio" + ((n == 90) ? ("") : (("­" + format_spellout_numbering((n % 10))))))
            end
            if (n >= 80) then
              return ("åttio" + ((n == 80) ? ("") : (("­" + format_spellout_numbering((n % 10))))))
            end
            if (n >= 70) then
              return ("sjuttio" + ((n == 70) ? ("") : (("­" + format_spellout_numbering((n % 10))))))
            end
            if (n >= 60) then
              return ("sextio" + ((n == 60) ? ("") : (("­" + format_spellout_numbering((n % 10))))))
            end
            if (n >= 50) then
              return ("femtio" + ((n == 50) ? ("") : (("­" + format_spellout_numbering((n % 10))))))
            end
            if (n >= 40) then
              return ("fyrtio" + ((n == 40) ? ("") : (("­" + format_spellout_numbering((n % 10))))))
            end
            if (n >= 30) then
              return ("trettio" + ((n == 30) ? ("") : (("­" + format_spellout_numbering((n % 10))))))
            end
            if (n >= 20) then
              return ("tjugo" + ((n == 20) ? ("") : (("­" + format_spellout_numbering((n % 10))))))
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
              return ((format_spellout_numbering((n / 100.0).floor) + "­hundra") + ((n == 100) ? ("") : (("­" + format_spellout_numbering_t((n % 100))))))
            end
            if (n >= 90) then
              return ("nittio" + ((n == 90) ? ("") : (("­" + format_spellout_numbering_t((n % 10))))))
            end
            if (n >= 80) then
              return ("åttio" + ((n == 80) ? ("") : (("­" + format_spellout_numbering_t((n % 10))))))
            end
            if (n >= 70) then
              return ("sjuttio" + ((n == 70) ? ("") : (("­" + format_spellout_numbering_t((n % 10))))))
            end
            if (n >= 60) then
              return ("sextio" + ((n == 60) ? ("") : (("­" + format_spellout_numbering_t((n % 10))))))
            end
            if (n >= 50) then
              return ("femtio" + ((n == 50) ? ("") : (("­" + format_spellout_numbering_t((n % 10))))))
            end
            if (n >= 40) then
              return ("fyrtio" + ((n == 40) ? ("") : (("­" + format_spellout_numbering_t((n % 10))))))
            end
            if (n >= 30) then
              return ("trettio" + ((n == 30) ? ("") : (("­" + format_spellout_numbering_t((n % 10))))))
            end
            if (n >= 20) then
              return ("tjugo" + ((n == 20) ? ("") : (("­" + format_spellout_numbering_t((n % 10))))))
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
              return ((format_spellout_cardinal_reale(n.floor) + " komma ") + format_spellout_cardinal_reale(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_reale((n / 2.0e+15).floor) + " biljarder") + (if (n == 2000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_reale((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("en biljard" + (if (n == 1000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_reale((n % 100000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_reale((n / 2000000000000.0).floor) + " biljoner") + (if (n == 2000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_reale((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("en biljon" + (if (n == 1000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_reale((n % 100000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_reale((n / 2000000000.0).floor) + " miljarder") + (if (n == 2000000000) then
                ""
              else
                (" " + format_spellout_cardinal_reale((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("en miljard" + (if (n == 1000000000) then
                ""
              else
                (" " + format_spellout_cardinal_reale((n % 100000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_reale((n / 2000000.0).floor) + " miljoner") + (if (n == 2000000) then
                ""
              else
                (" " + format_spellout_cardinal_reale((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ("en miljon" + (if (n == 1000000) then
                ""
              else
                (" " + format_spellout_cardinal_reale((n % 100000)))
              end))
            end
            if (n >= 2000) then
              return ((format_spellout_cardinal_reale((n / 2000.0).floor) + "­tusen") + ((n == 2000) ? ("") : ((" " + format_spellout_cardinal_reale((n % 1000))))))
            end
            if (n >= 1000) then
              return ("ettusen" + ((n == 1000) ? ("") : ((" " + format_spellout_cardinal_reale((n % 100))))))
            end
            if (n >= 100) then
              return ((format_spellout_cardinal_neuter((n / 100.0).floor) + "­hundra") + ((n == 100) ? ("") : (("­" + format_spellout_cardinal_reale((n % 100))))))
            end
            if (n >= 90) then
              return ("nittio" + ((n == 90) ? ("") : (("­" + format_spellout_cardinal_reale((n % 10))))))
            end
            if (n >= 80) then
              return ("åttio" + ((n == 80) ? ("") : (("­" + format_spellout_cardinal_reale((n % 10))))))
            end
            if (n >= 70) then
              return ("sjuttio" + ((n == 70) ? ("") : (("­" + format_spellout_cardinal_reale((n % 10))))))
            end
            if (n >= 60) then
              return ("sextio" + ((n == 60) ? ("") : (("­" + format_spellout_cardinal_reale((n % 10))))))
            end
            if (n >= 50) then
              return ("femtio" + ((n == 50) ? ("") : (("­" + format_spellout_cardinal_reale((n % 10))))))
            end
            if (n >= 40) then
              return ("fyrtio" + ((n == 40) ? ("") : (("­" + format_spellout_cardinal_reale((n % 10))))))
            end
            if (n >= 30) then
              return ("trettio" + ((n == 30) ? ("") : (("­" + format_spellout_cardinal_reale((n % 10))))))
            end
            if (n >= 20) then
              return ("tjugo" + ((n == 20) ? ("") : (("­" + format_spellout_cardinal_reale((n % 10))))))
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
              return ((format_spellout_cardinal_reale((n / 2.0e+15).floor) + " biljard") + format_ord_fem_teer((n % 1000000000000000)))
            end
            if (n >= 1000000000000000) then
              return ("en biljard" + format_ord_fem_te((n % 100000000000000)))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_reale((n / 2000000000000.0).floor) + " biljon") + format_ord_fem_teer((n % 1000000000000)))
            end
            if (n >= 1000000000000) then
              return ("en biljon" + format_ord_fem_te((n % 100000000000)))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_reale((n / 2000000000.0).floor) + " miljard") + format_ord_fem_teer((n % 1000000000)))
            end
            if (n >= 1000000000) then
              return ("en miljard" + format_ord_fem_te((n % 100000000)))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_reale((n / 2000000.0).floor) + " miljon") + format_ord_fem_teer((n % 1000000)))
            end
            return ("en miljon" + format_ord_fem_te((n % 100000))) if (n >= 1000000)
            if (n >= 1000) then
              return ((format_spellout_numbering_t((n / 1000.0).floor) + "­tusen") + format_ord_fem_de((n % 100)))
            end
            if (n >= 100) then
              return ((format_spellout_numbering((n / 100.0).floor) + "­hundra") + format_ord_fem_de((n % 100)))
            end
            return ("nittio" + format_ord_fem_nde((n % 10))) if (n >= 90)
            return ("åttio" + format_ord_fem_nde((n % 10))) if (n >= 80)
            return ("sjuttio" + format_ord_fem_nde((n % 10))) if (n >= 70)
            return ("sextio" + format_ord_fem_nde((n % 10))) if (n >= 60)
            return ("femtio" + format_ord_fem_nde((n % 10))) if (n >= 50)
            return ("fyrtio" + format_ord_fem_nde((n % 10))) if (n >= 40)
            return ("trettio" + format_ord_fem_nde((n % 10))) if (n >= 30)
            return ("tjugo" + format_ord_fem_nde((n % 10))) if (n >= 20)
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
              return ((format_spellout_cardinal_reale((n / 2.0e+15).floor) + " biljard") + format_ord_masc_teer((n % 1000000000000000)))
            end
            if (n >= 1000000000000000) then
              return ("en biljard" + format_ord_masc_te((n % 100000000000000)))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_reale((n / 2000000000000.0).floor) + " biljon") + format_ord_masc_teer((n % 1000000000000)))
            end
            if (n >= 1000000000000) then
              return ("en biljon" + format_ord_masc_te((n % 100000000000)))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_reale((n / 2000000000.0).floor) + " miljard") + format_ord_masc_teer((n % 1000000000)))
            end
            if (n >= 1000000000) then
              return ("en miljard" + format_ord_masc_te((n % 100000000)))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_reale((n / 2000000.0).floor) + " miljon") + format_ord_masc_teer((n % 1000000)))
            end
            return ("en miljon" + format_ord_masc_te((n % 100000))) if (n >= 1000000)
            if (n >= 1000) then
              return ((format_spellout_numbering_t((n / 1000.0).floor) + "­tusen") + format_ord_masc_de((n % 100)))
            end
            if (n >= 100) then
              return ((format_spellout_numbering((n / 100.0).floor) + "­hundra") + format_ord_masc_de((n % 100)))
            end
            return ("nittio" + format_ord_masc_nde((n % 10))) if (n >= 90)
            return ("åttio" + format_ord_masc_nde((n % 10))) if (n >= 80)
            return ("sjuttio" + format_ord_masc_nde((n % 10))) if (n >= 70)
            return ("sextio" + format_ord_masc_nde((n % 10))) if (n >= 60)
            return ("femtio" + format_ord_masc_nde((n % 10))) if (n >= 50)
            return ("fyrtio" + format_ord_masc_nde((n % 10))) if (n >= 40)
            return ("trettio" + format_ord_masc_nde((n % 10))) if (n >= 30)
            return ("tjugo" + format_ord_masc_nde((n % 10))) if (n >= 20)
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
            return format_dord_femabbrev((n % 10)) if (n >= 20)
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