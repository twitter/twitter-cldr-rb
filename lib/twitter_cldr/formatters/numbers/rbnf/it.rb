# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:it] = Italian = Module.new { }
      
      class Italian::Spellout
        class << self
          def format_lenient_parse(n)
            if (n >= 0) then
              return ((((((((((((n == 0) ? ("") : ("last primary ignorable ")) + " ") + format_lenient_parse((n / 0.0).floor)) + " ' ' ") + format_lenient_parse((n / 0.0).floor)) + " '") + "' ") + format_lenient_parse((n / 0.0).floor)) + " '-' ") + format_lenient_parse((n / 0.0).floor)) + " '­'")
            end
          end
          private(:format_lenient_parse)
          def format_spellout_numbering_year(n)
            is_fractional = (n != n.floor)
            return n.to_s if is_fractional and (n > 1)
            return format_spellout_numbering(n) if (n >= 0)
          end
          def format_spellout_numbering(n)
            is_fractional = (n != n.floor)
            return ("meno " + format_spellout_numbering(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_numbering(n.floor) + " virgola ") + format_spellout_numbering(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 2.0e+15).floor) + " biliardi") + (if (n == 2000000000000000) then
                ""
              else
                (" " + format_spellout_numbering((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("un biliardo" + (if (n == 1000000000000000) then
                ""
              else
                (" " + format_spellout_numbering((n % 100000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000000000.0).floor) + " bilioni") + (if (n == 2000000000000) then
                ""
              else
                (" " + format_spellout_numbering((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("un bilione" + (if (n == 1000000000000) then
                ""
              else
                (" " + format_spellout_numbering((n % 100000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000000.0).floor) + " miliardi") + (if (n == 2000000000) then
                ""
              else
                (" " + format_spellout_numbering((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("un miliardo" + (if (n == 1000000000) then
                ""
              else
                (" " + format_spellout_numbering((n % 100000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000.0).floor) + " milioni") + ((n == 2000000) ? ("") : ((" " + format_spellout_numbering((n % 1000000))))))
            end
            if (n >= 1000000) then
              return ("un milione" + ((n == 1000000) ? ("") : ((" " + format_spellout_numbering((n % 100000))))))
            end
            if (n >= 2000) then
              return ((format_msc_no_final((n / 2000.0).floor) + "­mila") + ((n == 2000) ? ("") : (("­" + format_spellout_numbering((n % 1000))))))
            end
            if (n >= 1000) then
              return ("mille" + ((n == 1000) ? ("") : (("­" + format_spellout_numbering((n % 100))))))
            end
            if (n >= 200) then
              return ((format_spellout_numbering((n / 200.0).floor) + "­cent") + format_msco_with_o((n % 100)))
            end
            return ("cent" + format_msco_with_o((n % 100))) if (n >= 100)
            return ("novant" + format_msco_with_a((n % 10))) if (n >= 90)
            return ("ottant" + format_msco_with_a((n % 10))) if (n >= 80)
            return ("settant" + format_msco_with_a((n % 10))) if (n >= 70)
            return ("sessant" + format_msco_with_a((n % 10))) if (n >= 60)
            return ("cinquant" + format_msco_with_a((n % 10))) if (n >= 50)
            return ("quarant" + format_msco_with_a((n % 10))) if (n >= 40)
            return ("trent" + format_msco_with_a((n % 10))) if (n >= 30)
            return ("vent" + format_msco_with_i((n % 10))) if (n >= 20)
            return "diciannove" if (n >= 19)
            return "diciotto" if (n >= 18)
            return "diciassette" if (n >= 17)
            return "sedici" if (n >= 16)
            return "quindici" if (n >= 15)
            return "quattordici" if (n >= 14)
            return "tredici" if (n >= 13)
            return "dodici" if (n >= 12)
            return "undici" if (n >= 11)
            return "dieci" if (n >= 10)
            return "nove" if (n >= 9)
            return "otto" if (n >= 8)
            return "sette" if (n >= 7)
            return "sei" if (n >= 6)
            return "cinque" if (n >= 5)
            return "quattro" if (n >= 4)
            return "tre" if (n >= 3)
            return "due" if (n >= 2)
            return "uno" if (n >= 1)
            return "zero" if (n >= 0)
          end
          def format_msco_with_i(n)
            return "ERROR" if (n >= 10)
            return "i­nove" if (n >= 9)
            return "­otto" if (n >= 8)
            return ("i­" + format_spellout_numbering(n)) if (n >= 4)
            return "i­tré" if (n >= 3)
            return "i­due" if (n >= 2)
            return "­uno" if (n >= 1)
            return "i" if (n >= 0)
          end
          private(:format_msco_with_i)
          def format_msco_with_a(n)
            return "ERROR" if (n >= 10)
            return "a­nove" if (n >= 9)
            return "­otto" if (n >= 8)
            return ("a­" + format_spellout_numbering(n)) if (n >= 4)
            return "a­tré" if (n >= 3)
            return "a­due" if (n >= 2)
            return "­uno" if (n >= 1)
            return "a" if (n >= 0)
          end
          private(:format_msco_with_a)
          def format_msco_with_o(n)
            return ("o­" + format_spellout_numbering(n)) if (n >= 90)
            return ("­" + format_spellout_numbering(n)) if (n >= 80)
            return ("o­" + format_spellout_numbering(n)) if (n >= 9)
            return "­otto" if (n >= 8)
            return ("o­" + format_spellout_numbering(n)) if (n >= 4)
            return "o­tré" if (n >= 3)
            return "o­due" if (n >= 2)
            return "o­uno" if (n >= 1)
            return "o" if (n >= 0)
          end
          private(:format_msco_with_o)
          def format_spellout_cardinal_masculine(n)
            is_fractional = (n != n.floor)
            return ("meno " + format_spellout_cardinal_masculine(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_cardinal_masculine(n.floor) + " virgola ") + format_spellout_cardinal_masculine(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 2.0e+15).floor) + " biliardi") + (if (n == 2000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("un biliardo" + (if (n == 1000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000000000.0).floor) + " bilioni") + (if (n == 2000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("un bilione" + (if (n == 1000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000000.0).floor) + " miliardi") + (if (n == 2000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("un miliardo" + (if (n == 1000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000.0).floor) + " milioni") + (if (n == 2000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ("un milione" + (if (n == 1000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100000)))
              end))
            end
            if (n >= 2000) then
              return ((format_msc_no_final((n / 2000.0).floor) + "­mila") + (if (n == 2000) then
                ""
              else
                ("­" + format_spellout_cardinal_masculine((n % 1000)))
              end))
            end
            if (n >= 1000) then
              return ("mille" + (if (n == 1000) then
                ""
              else
                ("­" + format_spellout_cardinal_masculine((n % 100)))
              end))
            end
            if (n >= 200) then
              return ((format_spellout_cardinal_masculine((n / 200.0).floor) + "­cent") + format_msc_with_o((n % 100)))
            end
            return ("cent" + format_msc_with_o((n % 100))) if (n >= 100)
            return ("novant" + format_msc_with_a((n % 10))) if (n >= 90)
            return ("ottant" + format_msc_with_a((n % 10))) if (n >= 80)
            return ("settant" + format_msc_with_a((n % 10))) if (n >= 70)
            return ("sessant" + format_msc_with_a((n % 10))) if (n >= 60)
            return ("cinquant" + format_msc_with_a((n % 10))) if (n >= 50)
            return ("quarant" + format_msc_with_a((n % 10))) if (n >= 40)
            return ("trent" + format_msc_with_a((n % 10))) if (n >= 30)
            return ("vent" + format_msc_with_i((n % 10))) if (n >= 20)
            return format_spellout_numbering(n) if (n >= 2)
            return "un" if (n >= 1)
            return "zero" if (n >= 0)
          end
          def format_msc_with_i(n)
            return format_msco_with_i(n) if (n >= 2)
            return "­un" if (n >= 1)
            return "i" if (n >= 0)
          end
          private(:format_msc_with_i)
          def format_msc_with_a(n)
            return format_msco_with_a(n) if (n >= 2)
            return "­un" if (n >= 1)
            return "a" if (n >= 0)
          end
          private(:format_msc_with_a)
          def format_msc_with_o(n)
            return ("o­" + format_spellout_numbering(n)) if (n >= 90)
            return ("­" + format_spellout_numbering(n)) if (n >= 80)
            return ("o­" + format_spellout_numbering(n)) if (n >= 9)
            return "­otto" if (n >= 8)
            return ("o­" + format_spellout_numbering(n)) if (n >= 4)
            return "o­tré" if (n >= 3)
            return "o­due" if (n >= 2)
            return "o­uno" if (n >= 1)
            return "o" if (n >= 0)
          end
          private(:format_msc_with_o)
          def format_msc_no_final(n)
            return "ERROR" if (n >= 1000)
            if (n >= 200) then
              return ((format_msc_no_final((n / 200.0).floor) + "­cent") + format_msc_with_o_nofinal((n % 100)))
            end
            return ("cent" + format_msc_with_o_nofinal((n % 100))) if (n >= 100)
            return ("novant" + format_msc_with_a_nofinal((n % 10))) if (n >= 90)
            return ("ottant" + format_msc_with_a_nofinal((n % 10))) if (n >= 80)
            return ("settant" + format_msc_with_a_nofinal((n % 10))) if (n >= 70)
            return ("sessant" + format_msc_with_a_nofinal((n % 10))) if (n >= 60)
            return ("cinquant" + format_msc_with_a_nofinal((n % 10))) if (n >= 50)
            return ("quarant" + format_msc_with_a_nofinal((n % 10))) if (n >= 40)
            return ("trent" + format_msc_with_a_nofinal((n % 10))) if (n >= 30)
            return ("vent" + format_msc_with_i_nofinal((n % 10))) if (n >= 20)
            return format_spellout_cardinal_masculine(n) if (n >= 2)
            return "ERROR" if (n >= 0)
          end
          private(:format_msc_no_final)
          def format_msc_with_i_nofinal(n)
            return format_msc_with_i(n) if (n >= 4)
            return "a­tre" if (n >= 3)
            return format_msc_with_i(n) if (n >= 0)
          end
          private(:format_msc_with_i_nofinal)
          def format_msc_with_a_nofinal(n)
            return format_msc_with_a(n) if (n >= 4)
            return "a­tre" if (n >= 3)
            return format_msc_with_a(n) if (n >= 0)
          end
          private(:format_msc_with_a_nofinal)
          def format_msc_with_o_nofinal(n)
            return format_msc_with_o(n) if (n >= 4)
            return "o­tre" if (n >= 3)
            return format_msc_with_o(n) if (n >= 0)
          end
          private(:format_msc_with_o_nofinal)
          def format_spellout_cardinal_feminine(n)
            is_fractional = (n != n.floor)
            return ("meno " + format_spellout_cardinal_feminine(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_cardinal_feminine(n.floor) + " virgola ") + format_spellout_cardinal_feminine(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 2.0e+15).floor) + " biliardi") + (if (n == 2000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("un biliardo" + (if (n == 1000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000000000.0).floor) + " bilioni") + (if (n == 2000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("un bilione" + (if (n == 1000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000000.0).floor) + " miliardi") + (if (n == 2000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("un miliardo" + (if (n == 1000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000.0).floor) + " milioni") + (if (n == 2000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ("un milione" + (if (n == 1000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100000)))
              end))
            end
            if (n >= 2000) then
              return ((format_msc_no_final((n / 2000.0).floor) + "­mila") + (if (n == 2000) then
                ""
              else
                ("­" + format_spellout_cardinal_feminine((n % 1000)))
              end))
            end
            if (n >= 1000) then
              return ("mille" + ((n == 1000) ? ("") : (("­" + format_spellout_cardinal_feminine((n % 100))))))
            end
            if (n >= 200) then
              return ((format_spellout_cardinal_feminine((n / 200.0).floor) + "­cent") + format_fem_with_o((n % 100)))
            end
            return ("cent" + format_fem_with_o((n % 100))) if (n >= 100)
            return ("novant" + format_fem_with_a((n % 10))) if (n >= 90)
            return ("ottant" + format_fem_with_a((n % 10))) if (n >= 80)
            return ("settant" + format_fem_with_a((n % 10))) if (n >= 70)
            return ("sessant" + format_fem_with_a((n % 10))) if (n >= 60)
            return ("cinquant" + format_fem_with_a((n % 10))) if (n >= 50)
            return ("quarant" + format_fem_with_a((n % 10))) if (n >= 40)
            return ("trent" + format_fem_with_a((n % 10))) if (n >= 30)
            return ("vent" + format_fem_with_i((n % 10))) if (n >= 20)
            return format_spellout_numbering(n) if (n >= 2)
            return "una" if (n >= 1)
            return "zero" if (n >= 0)
          end
          def format_fem_with_i(n)
            return format_msco_with_i(n) if (n >= 2)
            return "­una" if (n >= 1)
            return "i" if (n >= 0)
          end
          private(:format_fem_with_i)
          def format_fem_with_a(n)
            return format_msco_with_a(n) if (n >= 2)
            return "­una" if (n >= 1)
            return "a" if (n >= 0)
          end
          private(:format_fem_with_a)
          def format_fem_with_o(n)
            return format_msco_with_o(n) if (n >= 2)
            return "o­una" if (n >= 1)
            return "o" if (n >= 0)
          end
          private(:format_fem_with_o)
          def format_spellout_ordinal_masculine(n)
            is_fractional = (n != n.floor)
            return ("meno " + format_spellout_ordinal_masculine(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 2.0e+15).floor) + "biliard­") + format_ordinal_esimo_with_o((n % 1000000000000000)))
            end
            if (n >= 1000000000000000) then
              return ("biliard­" + format_ordinal_esimo_with_o((n % 100000000000000)))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000000000.0).floor) + "bilion­") + format_ordinal_esimo((n % 1000000000000)))
            end
            if (n >= 1000000000000) then
              return ("bilione­" + format_ordinal_esimo((n % 100000000000)))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000000.0).floor) + "miliard­") + format_ordinal_esimo_with_o((n % 1000000000)))
            end
            if (n >= 1000000000) then
              return ("miliard­" + format_ordinal_esimo_with_o((n % 100000000)))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000.0).floor) + "milion­") + format_ordinal_esimo((n % 1000000)))
            end
            return ("milione­" + format_ordinal_esimo((n % 100000))) if (n >= 1000000)
            if (n >= 2001) then
              return ((format_spellout_cardinal_masculine((n / 2001.0).floor) + "­mila­") + format_ordinal_esimo((n % 1000)))
            end
            if (n >= 2000) then
              return ((format_spellout_cardinal_masculine((n / 2000.0).floor) + "­mille­") + format_ordinal_esimo((n % 1000)))
            end
            return ("mille­" + format_ordinal_esimo((n % 100))) if (n >= 1000)
            if (n >= 200) then
              return ((format_spellout_cardinal_masculine((n / 200.0).floor) + "­cent") + format_ordinal_esimo_with_o((n % 100)))
            end
            return ("cent" + format_ordinal_esimo_with_o((n % 100))) if (n >= 100)
            return ("novant" + format_ordinal_esimo_with_a((n % 10))) if (n >= 90)
            return ("ottant" + format_ordinal_esimo_with_a((n % 10))) if (n >= 80)
            return ("settant" + format_ordinal_esimo_with_a((n % 10))) if (n >= 70)
            return ("sessant" + format_ordinal_esimo_with_a((n % 10))) if (n >= 60)
            return ("cinquant" + format_ordinal_esimo_with_a((n % 10))) if (n >= 50)
            return ("quarant" + format_ordinal_esimo_with_a((n % 10))) if (n >= 40)
            return ("trent" + format_ordinal_esimo_with_a((n % 10))) if (n >= 30)
            return ("vent" + format_ordinal_esimo_with_i((n % 10))) if (n >= 20)
            return "diciannovesimo" if (n >= 19)
            return "diciottesimo" if (n >= 18)
            return "diciassettesimo" if (n >= 17)
            return "sedicesimo" if (n >= 16)
            return "quindicesimo" if (n >= 15)
            return "quattordicesimo" if (n >= 14)
            return "tredicesimo" if (n >= 13)
            return "dodicesimo" if (n >= 12)
            return "undicesimo" if (n >= 11)
            return "decimo" if (n >= 10)
            return "nono" if (n >= 9)
            return "ottavo" if (n >= 8)
            return "settimo" if (n >= 7)
            return "sesto" if (n >= 6)
            return "quinto" if (n >= 5)
            return "quarto" if (n >= 4)
            return "terzo" if (n >= 3)
            return "secondo" if (n >= 2)
            return "primo" if (n >= 1)
            return "zero" if (n >= 0)
          end
          def format_ordinal_esimo(n)
            return format_spellout_ordinal_masculine(n) if (n >= 10)
            return "­novesimo" if (n >= 9)
            return "­ottesimo" if (n >= 8)
            return "­settesimo" if (n >= 7)
            return "­seiesimo" if (n >= 6)
            return "­cinquesimo" if (n >= 5)
            return "­quattresimo" if (n >= 4)
            return "­treesimo" if (n >= 3)
            return "­duesimo" if (n >= 2)
            return "­unesimo" if (n >= 1)
            return "simo" if (n >= 0)
          end
          private(:format_ordinal_esimo)
          def format_ordinal_esimo_with_i(n)
            return format_spellout_ordinal_masculine(n) if (n >= 10)
            return "i­novesimo" if (n >= 9)
            return "­ottesimo" if (n >= 8)
            return "i­settesimo" if (n >= 7)
            return "i­seiesimo" if (n >= 6)
            return "i­cinquesimo" if (n >= 5)
            return "i­quattresimo" if (n >= 4)
            return "i­treesimo" if (n >= 3)
            return "i­duesimo" if (n >= 2)
            return "­unesimo" if (n >= 1)
            return "esimo" if (n >= 0)
          end
          private(:format_ordinal_esimo_with_i)
          def format_ordinal_esimo_with_a(n)
            return format_spellout_ordinal_masculine(n) if (n >= 10)
            return "a­novesimo" if (n >= 9)
            return "­ottesimo" if (n >= 8)
            return "a­settesimo" if (n >= 7)
            return "a­seiesimo" if (n >= 6)
            return "a­cinquesimo" if (n >= 5)
            return "a­quattresimo" if (n >= 4)
            return "a­treesimo" if (n >= 3)
            return "a­duesimo" if (n >= 2)
            return "­unesimo" if (n >= 1)
            return "esimo" if (n >= 0)
          end
          private(:format_ordinal_esimo_with_a)
          def format_ordinal_esimo_with_o(n)
            return ("o­" + format_spellout_ordinal_masculine(n)) if (n >= 10)
            return "o­novesimo" if (n >= 9)
            return "­ottesimo" if (n >= 8)
            return "o­settesimo" if (n >= 7)
            return "o­seiesimo" if (n >= 6)
            return "o­cinquesimo" if (n >= 5)
            return "o­quattresimo" if (n >= 4)
            return "o­treesimo" if (n >= 3)
            return "o­duesimo" if (n >= 2)
            return "­unesimo" if (n >= 1)
            return "esimo" if (n >= 0)
          end
          private(:format_ordinal_esimo_with_o)
          def format_spellout_ordinal_feminine(n)
            is_fractional = (n != n.floor)
            return ("meno " + format_spellout_ordinal_feminine(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_feminine((n / 2.0e+15).floor) + "biliard­") + format_ordinal_esima_with_o((n % 1000000000000000)))
            end
            if (n >= 1000000000000000) then
              return ("biliard­" + format_ordinal_esima_with_o((n % 100000000000000)))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_feminine((n / 2000000000000.0).floor) + "bilion­") + format_ordinal_esima((n % 1000000000000)))
            end
            if (n >= 1000000000000) then
              return ("bilione­" + format_ordinal_esima((n % 100000000000)))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_feminine((n / 2000000000.0).floor) + "miliard­") + format_ordinal_esima_with_o((n % 1000000000)))
            end
            if (n >= 1000000000) then
              return ("miliard­" + format_ordinal_esima_with_o((n % 100000000)))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_feminine((n / 2000000.0).floor) + "milion­") + format_ordinal_esima((n % 1000000)))
            end
            return ("milione­" + format_ordinal_esima((n % 100000))) if (n >= 1000000)
            if (n >= 2001) then
              return ((format_spellout_cardinal_feminine((n / 2001.0).floor) + "­mila­") + format_ordinal_esima((n % 1000)))
            end
            if (n >= 2000) then
              return ((format_spellout_cardinal_feminine((n / 2000.0).floor) + "­mille­") + format_ordinal_esima((n % 1000)))
            end
            return ("mille­" + format_ordinal_esima((n % 100))) if (n >= 1000)
            if (n >= 200) then
              return ((format_spellout_cardinal_feminine((n / 200.0).floor) + "­cent") + format_ordinal_esima_with_o((n % 100)))
            end
            return ("cent" + format_ordinal_esima_with_o((n % 100))) if (n >= 100)
            return ("novant" + format_ordinal_esima_with_a((n % 10))) if (n >= 90)
            return ("ottant" + format_ordinal_esima_with_a((n % 10))) if (n >= 80)
            return ("settant" + format_ordinal_esima_with_a((n % 10))) if (n >= 70)
            return ("sessant" + format_ordinal_esima_with_a((n % 10))) if (n >= 60)
            return ("cinquant" + format_ordinal_esima_with_a((n % 10))) if (n >= 50)
            return ("quarant" + format_ordinal_esima_with_a((n % 10))) if (n >= 40)
            return ("trent" + format_ordinal_esima_with_a((n % 10))) if (n >= 30)
            return ("vent" + format_ordinal_esima_with_i((n % 10))) if (n >= 20)
            return "diciannovesima" if (n >= 19)
            return "diciottesima" if (n >= 18)
            return "diciassettesima" if (n >= 17)
            return "sedicesima" if (n >= 16)
            return "quindicesima" if (n >= 15)
            return "quattordicesima" if (n >= 14)
            return "tredicesima" if (n >= 13)
            return "dodicesima" if (n >= 12)
            return "undicesima" if (n >= 11)
            return "decima" if (n >= 10)
            return "nona" if (n >= 9)
            return "ottava" if (n >= 8)
            return "settima" if (n >= 7)
            return "sesta" if (n >= 6)
            return "quinta" if (n >= 5)
            return "quarta" if (n >= 4)
            return "terza" if (n >= 3)
            return "seconda" if (n >= 2)
            return "prima" if (n >= 1)
            return "zero" if (n >= 0)
          end
          def format_ordinal_esima(n)
            return format_spellout_ordinal_feminine(n) if (n >= 10)
            return "­novesima" if (n >= 9)
            return "­ottesima" if (n >= 8)
            return "­settesima" if (n >= 7)
            return "­seiesima" if (n >= 6)
            return "­cinquesima" if (n >= 5)
            return "­quattresima" if (n >= 4)
            return "­treesima" if (n >= 3)
            return "­duesima" if (n >= 2)
            return "­unesima" if (n >= 1)
            return "sima" if (n >= 0)
          end
          private(:format_ordinal_esima)
          def format_ordinal_esima_with_i(n)
            return format_spellout_ordinal_feminine(n) if (n >= 10)
            return "i­novesima" if (n >= 9)
            return "­ottesima" if (n >= 8)
            return "i­settesima" if (n >= 7)
            return "i­seiesima" if (n >= 6)
            return "i­cinquesima" if (n >= 5)
            return "i­quattresima" if (n >= 4)
            return "i­treesima" if (n >= 3)
            return "i­duesima" if (n >= 2)
            return "­unesima" if (n >= 1)
            return "esima" if (n >= 0)
          end
          private(:format_ordinal_esima_with_i)
          def format_ordinal_esima_with_a(n)
            return format_spellout_ordinal_feminine(n) if (n >= 10)
            return "a­novesima" if (n >= 9)
            return "­ottesima" if (n >= 8)
            return "a­settesima" if (n >= 7)
            return "a­seiesima" if (n >= 6)
            return "a­cinquesima" if (n >= 5)
            return "a­quattresima" if (n >= 4)
            return "a­treesima" if (n >= 3)
            return "a­duesima" if (n >= 2)
            return "­unesima" if (n >= 1)
            return "esima" if (n >= 0)
          end
          private(:format_ordinal_esima_with_a)
          def format_ordinal_esima_with_o(n)
            return ("o­" + format_spellout_ordinal_feminine(n)) if (n >= 10)
            return "o­novesima" if (n >= 9)
            return "­ottesima" if (n >= 8)
            return "o­settesima" if (n >= 7)
            return "o­seiesima" if (n >= 6)
            return "o­cinquesima" if (n >= 5)
            return "o­quattresima" if (n >= 4)
            return "o­treesima" if (n >= 3)
            return "o­duesima" if (n >= 2)
            return "­unesima" if (n >= 1)
            return "esima" if (n >= 0)
          end
          private(:format_ordinal_esima_with_o)
        end
      end
      
      class Italian::Ordinal
        class << self
          def format_dord_mascabbrev(n)
            return "º" if (n >= 0)
          end
          private(:format_dord_mascabbrev)
          def format_digits_ordinal_masculine(n)
            return ("−" + format_digits_ordinal_masculine(-n)) if (n < 0)
            return (n.to_s + format_dord_mascabbrev(n)) if (n >= 0)
          end
          def format_dord_femabbrev(n)
            return "ª" if (n >= 0)
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