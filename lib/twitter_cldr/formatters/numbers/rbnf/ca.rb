# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:ca] = Catalan = Module.new { }
      
      class Catalan::Spellout
        class << self
          def format_spellout_numbering_year(n)
            is_fractional = (n != n.floor)
            return n.to_s if is_fractional and (n > 1)
            return format_spellout_numbering(n) if (n >= 0)
          end
          def format_spellout_numbering_cents(n)
            return (" " + format_spellout_cardinal_masculine(n)) if (n >= 1)
            return "s" if (n >= 0)
          end
          private(:format_spellout_numbering_cents)
          def format_spellout_numbering(n)
            is_fractional = (n != n.floor)
            return ("menys " + format_spellout_numbering(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_numbering(n.floor) + " coma ") + format_spellout_numbering(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 2.0e+15).floor) + " biliards") + (if (n == 2000000000000000) then
                ""
              else
                (" " + format_spellout_numbering((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("un biliard" + (if (n == 1000000000000000) then
                ""
              else
                (" " + format_spellout_numbering((n % 100000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000000000.0).floor) + " bilions") + (if (n == 2000000000000) then
                ""
              else
                (" " + format_spellout_numbering((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("un bilió" + (if (n == 1000000000000) then
                ""
              else
                (" " + format_spellout_numbering((n % 100000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000000.0).floor) + " miliards") + (if (n == 2000000000) then
                ""
              else
                (" " + format_spellout_numbering((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("un miliard" + (if (n == 1000000000) then
                ""
              else
                (" " + format_spellout_numbering((n % 100000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000.0).floor) + " milions") + ((n == 2000000) ? ("") : ((" " + format_spellout_numbering((n % 1000000))))))
            end
            if (n >= 1000000) then
              return ("un milió" + ((n == 1000000) ? ("") : ((" " + format_spellout_numbering((n % 100000))))))
            end
            if (n >= 2000) then
              return ((format_spellout_cardinal_masculine((n / 2000.0).floor) + " mil") + ((n == 2000) ? ("") : ((" " + format_spellout_numbering((n % 1000))))))
            end
            if (n >= 1000) then
              return ("mil" + ((n == 1000) ? ("") : ((" " + format_spellout_numbering((n % 100))))))
            end
            if (n >= 200) then
              return ((format_spellout_cardinal_masculine((n / 200.0).floor) + "-cent") + format_spellout_numbering_cents((n % 100)))
            end
            if (n >= 100) then
              return ("cent" + ((n == 100) ? ("") : (("-" + format_spellout_numbering((n % 100))))))
            end
            if (n >= 90) then
              return ("noranta" + ((n == 90) ? ("") : (("-" + format_spellout_numbering((n % 10))))))
            end
            if (n >= 80) then
              return ("vuitanta" + ((n == 80) ? ("") : (("-" + format_spellout_numbering((n % 10))))))
            end
            if (n >= 70) then
              return ("setanta" + ((n == 70) ? ("") : (("-" + format_spellout_numbering((n % 10))))))
            end
            if (n >= 60) then
              return ("seixanta" + ((n == 60) ? ("") : (("-" + format_spellout_numbering((n % 10))))))
            end
            if (n >= 50) then
              return ("cinquanta" + ((n == 50) ? ("") : (("-" + format_spellout_numbering((n % 10))))))
            end
            if (n >= 40) then
              return ("quaranta" + ((n == 40) ? ("") : (("-" + format_spellout_numbering((n % 10))))))
            end
            if (n >= 30) then
              return ("trenta" + ((n == 30) ? ("") : (("-" + format_spellout_numbering((n % 10))))))
            end
            if (n >= 20) then
              return ("vint" + ((n == 20) ? ("") : (("-i-" + format_spellout_numbering((n % 10))))))
            end
            return format_spellout_cardinal_masculine(n) if (n >= 2)
            return "u" if (n >= 1)
            return "zero" if (n >= 0)
          end
          def format_spellout_cardinal_masculine_cents(n)
            return (" " + format_spellout_cardinal_masculine(n)) if (n >= 1)
            return "s" if (n >= 0)
          end
          private(:format_spellout_cardinal_masculine_cents)
          def format_spellout_cardinal_masculine(n)
            is_fractional = (n != n.floor)
            return ("menys " + format_spellout_cardinal_masculine(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_cardinal_masculine(n.floor) + " coma ") + format_spellout_cardinal_masculine(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 2.0e+15).floor) + " biliards") + (if (n == 2000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("un biliard" + (if (n == 1000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000000000.0).floor) + " bilions") + (if (n == 2000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("un bilió" + (if (n == 1000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000000.0).floor) + " miliards") + (if (n == 2000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("un miliard" + (if (n == 1000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000.0).floor) + " milions") + (if (n == 2000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ("un milió" + (if (n == 1000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100000)))
              end))
            end
            if (n >= 2000) then
              return ((format_spellout_cardinal_masculine((n / 2000.0).floor) + " mil") + (if (n == 2000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000)))
              end))
            end
            if (n >= 1000) then
              return ("mil" + (if (n == 1000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100)))
              end))
            end
            if (n >= 200) then
              return ((format_spellout_cardinal_masculine((n / 200.0).floor) + "-cent") + format_spellout_cardinal_masculine_cents((n % 100)))
            end
            if (n >= 100) then
              return ("cent" + ((n == 100) ? ("") : (("-" + format_spellout_cardinal_masculine((n % 100))))))
            end
            if (n >= 90) then
              return ("noranta" + ((n == 90) ? ("") : (("-" + format_spellout_cardinal_masculine((n % 10))))))
            end
            if (n >= 80) then
              return ("vuitanta" + ((n == 80) ? ("") : (("-" + format_spellout_cardinal_masculine((n % 10))))))
            end
            if (n >= 70) then
              return ("setanta" + ((n == 70) ? ("") : (("-" + format_spellout_cardinal_masculine((n % 10))))))
            end
            if (n >= 60) then
              return ("seixanta" + ((n == 60) ? ("") : (("-" + format_spellout_cardinal_masculine((n % 10))))))
            end
            if (n >= 50) then
              return ("cinquanta" + ((n == 50) ? ("") : (("-" + format_spellout_cardinal_masculine((n % 10))))))
            end
            if (n >= 40) then
              return ("quaranta" + ((n == 40) ? ("") : (("-" + format_spellout_cardinal_masculine((n % 10))))))
            end
            if (n >= 30) then
              return ("trenta" + ((n == 30) ? ("") : (("-" + format_spellout_cardinal_masculine((n % 10))))))
            end
            if (n >= 20) then
              return ("vint" + ((n == 20) ? ("") : (("-i-" + format_spellout_cardinal_masculine((n % 10))))))
            end
            return "dinou" if (n >= 19)
            return "divuit" if (n >= 18)
            return "disset" if (n >= 17)
            return "setze" if (n >= 16)
            return "quinze" if (n >= 15)
            return "catorze" if (n >= 14)
            return "tretze" if (n >= 13)
            return "dotze" if (n >= 12)
            return "onze" if (n >= 11)
            return "deu" if (n >= 10)
            return "nou" if (n >= 9)
            return "vuit" if (n >= 8)
            return "set" if (n >= 7)
            return "sis" if (n >= 6)
            return "cinc" if (n >= 5)
            return "quatre" if (n >= 4)
            return "tres" if (n >= 3)
            return "dos" if (n >= 2)
            return "un" if (n >= 1)
            return "zero" if (n >= 0)
          end
          def format_spellout_cardinal_feminine_cents(n)
            return (" " + format_spellout_cardinal_feminine(n)) if (n >= 1)
            return "s" if (n >= 0)
          end
          private(:format_spellout_cardinal_feminine_cents)
          def format_spellout_cardinal_feminine(n)
            is_fractional = (n != n.floor)
            return ("menys " + format_spellout_cardinal_feminine(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_cardinal_feminine(n.floor) + " coma ") + format_spellout_cardinal_feminine(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 2.0e+15).floor) + " biliards") + (if (n == 2000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("un biliard" + (if (n == 1000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000000000.0).floor) + " bilions") + (if (n == 2000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("un bilió" + (if (n == 1000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000000.0).floor) + " miliards") + (if (n == 2000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("un miliard" + (if (n == 1000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000.0).floor) + " milions") + (if (n == 2000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ("un milió" + (if (n == 1000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100000)))
              end))
            end
            if (n >= 2000) then
              return ((format_spellout_cardinal_masculine((n / 2000.0).floor) + " mil") + (if (n == 2000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000)))
              end))
            end
            if (n >= 1000) then
              return ("mil" + ((n == 1000) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 100))))))
            end
            if (n >= 200) then
              return ((format_spellout_cardinal_masculine((n / 200.0).floor) + "-cent") + format_spellout_cardinal_feminine_cents((n % 100)))
            end
            if (n >= 100) then
              return ("cent" + ((n == 100) ? ("") : (("-" + format_spellout_cardinal_feminine((n % 100))))))
            end
            if (n >= 90) then
              return ("noranta" + ((n == 90) ? ("") : (("-" + format_spellout_cardinal_feminine((n % 10))))))
            end
            if (n >= 80) then
              return ("vuitanta" + ((n == 80) ? ("") : (("-" + format_spellout_cardinal_feminine((n % 10))))))
            end
            if (n >= 70) then
              return ("setanta" + ((n == 70) ? ("") : (("-" + format_spellout_cardinal_feminine((n % 10))))))
            end
            if (n >= 60) then
              return ("seixanta" + ((n == 60) ? ("") : (("-" + format_spellout_cardinal_feminine((n % 10))))))
            end
            if (n >= 50) then
              return ("cinquanta" + ((n == 50) ? ("") : (("-" + format_spellout_cardinal_feminine((n % 10))))))
            end
            if (n >= 40) then
              return ("quaranta" + ((n == 40) ? ("") : (("-" + format_spellout_cardinal_feminine((n % 10))))))
            end
            if (n >= 30) then
              return ("trenta" + ((n == 30) ? ("") : (("-" + format_spellout_cardinal_feminine((n % 10))))))
            end
            if (n >= 20) then
              return ("vint" + ((n == 20) ? ("") : (("-i-" + format_spellout_cardinal_feminine((n % 10))))))
            end
            return format_spellout_cardinal_masculine(n) if (n >= 3)
            return "dues" if (n >= 2)
            return "una" if (n >= 1)
            return "zero" if (n >= 0)
          end
          def format_spellout_ordinal_masculine_cont(n)
            return (" " + format_spellout_ordinal_masculine(n)) if (n >= 1)
            return "è" if (n >= 0)
          end
          private(:format_spellout_ordinal_masculine_cont)
          def format_spellout_ordinal_masculine_conts(n)
            return ("s " + format_spellout_ordinal_masculine(n)) if (n >= 1)
            return "è" if (n >= 0)
          end
          private(:format_spellout_ordinal_masculine_conts)
          def format_spellout_ordinal_masculine(n)
            is_fractional = (n != n.floor)
            return ("menys " + format_spellout_ordinal_masculine(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return (n.to_s + "è") if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 2.0e+15).floor) + " biliard") + format_spellout_ordinal_masculine_conts((n % 1000000000000000)))
            end
            if (n >= 1000000000000000) then
              return ("un biliard" + format_spellout_ordinal_masculine_cont((n % 100000000000000)))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000000000.0).floor) + " bilion") + format_spellout_ordinal_masculine_conts((n % 1000000000000)))
            end
            if (n >= 1000000000000) then
              return ("un bilion" + format_spellout_ordinal_masculine_cont((n % 100000000000)))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000000.0).floor) + " miliard") + format_spellout_ordinal_masculine_conts((n % 1000000000)))
            end
            if (n >= 1000000000) then
              return ("un miliard" + format_spellout_ordinal_masculine_cont((n % 100000000)))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000.0).floor) + " milion") + format_spellout_ordinal_masculine_conts((n % 1000000)))
            end
            if (n >= 1000000) then
              return ("un milion" + format_spellout_ordinal_masculine_cont((n % 100000)))
            end
            if (n >= 2000) then
              return ((format_spellout_cardinal_masculine((n / 2000.0).floor) + " mil") + format_spellout_ordinal_masculine_cont((n % 1000)))
            end
            if (n >= 1000) then
              return ("mil" + format_spellout_ordinal_masculine_cont((n % 100)))
            end
            if (n >= 200) then
              return ((format_spellout_cardinal_masculine((n / 200.0).floor) + "-cent") + format_spellout_ordinal_masculine_cont((n % 100)))
            end
            if (n >= 101) then
              return ("cent-" + format_spellout_ordinal_masculine((n % 100)))
            end
            return "centè" if (n >= 100)
            if (n >= 91) then
              return ("noranta-" + format_spellout_ordinal_masculine((n % 10)))
            end
            return "norantè" if (n >= 90)
            if (n >= 81) then
              return ("vuitanta-" + format_spellout_ordinal_masculine((n % 10)))
            end
            return "vuitantè" if (n >= 80)
            if (n >= 71) then
              return ("setanta-" + format_spellout_ordinal_masculine((n % 10)))
            end
            return "setantè" if (n >= 70)
            if (n >= 61) then
              return ("seixanta-" + format_spellout_ordinal_masculine((n % 10)))
            end
            return "seixantè" if (n >= 60)
            if (n >= 51) then
              return ("cinquanta-" + format_spellout_ordinal_masculine((n % 10)))
            end
            return "cinquantè" if (n >= 50)
            if (n >= 41) then
              return ("quaranta-" + format_spellout_ordinal_masculine((n % 10)))
            end
            return "quarantè" if (n >= 40)
            if (n >= 31) then
              return ("trenta-" + format_spellout_ordinal_masculine((n % 10)))
            end
            return "trentè" if (n >= 30)
            if (n >= 21) then
              return ("vint-i-" + format_spellout_ordinal_masculine((n % 10)))
            end
            return "vintè" if (n >= 20)
            return "dinovè" if (n >= 19)
            return "divuitè" if (n >= 18)
            return "dissetè" if (n >= 17)
            return "setzè" if (n >= 16)
            return "quinzè" if (n >= 15)
            return "catorzè" if (n >= 14)
            return "tretzè" if (n >= 13)
            return "dotzè" if (n >= 12)
            return "onzè" if (n >= 11)
            return "desè" if (n >= 10)
            return "novè" if (n >= 9)
            return "vuitè" if (n >= 8)
            return "setè" if (n >= 7)
            return "sisè" if (n >= 6)
            return "cinquè" if (n >= 5)
            return "quart" if (n >= 4)
            return "tercer" if (n >= 3)
            return "segon" if (n >= 2)
            return "primer" if (n >= 1)
            return "zeroè" if (n >= 0)
          end
          def format_spellout_ordinal_feminine_cont(n)
            return (" " + format_spellout_ordinal_feminine(n)) if (n >= 1)
            return "ena" if (n >= 0)
          end
          private(:format_spellout_ordinal_feminine_cont)
          def format_spellout_ordinal_feminine_conts(n)
            return ("s " + format_spellout_ordinal_feminine(n)) if (n >= 1)
            return "ena" if (n >= 0)
          end
          private(:format_spellout_ordinal_feminine_conts)
          def format_spellout_ordinal_feminine(n)
            is_fractional = (n != n.floor)
            return ("menys " + format_spellout_ordinal_feminine(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return (n.to_s + "ena") if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 2.0e+15).floor) + " biliard") + format_spellout_ordinal_feminine_conts((n % 1000000000000000)))
            end
            if (n >= 1000000000000000) then
              return ("un biliard" + format_spellout_ordinal_feminine_cont((n % 100000000000000)))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000000000.0).floor) + " bilion") + format_spellout_ordinal_feminine_conts((n % 1000000000000)))
            end
            if (n >= 1000000000000) then
              return ("un bilion" + format_spellout_ordinal_feminine_cont((n % 100000000000)))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000000.0).floor) + " miliard") + format_spellout_ordinal_feminine_conts((n % 1000000000)))
            end
            if (n >= 1000000000) then
              return ("un miliard" + format_spellout_ordinal_feminine_cont((n % 100000000)))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000.0).floor) + " milion") + format_spellout_ordinal_feminine_conts((n % 1000000)))
            end
            if (n >= 1000000) then
              return ("un milion" + format_spellout_ordinal_feminine_cont((n % 100000)))
            end
            if (n >= 2000) then
              return ((format_spellout_cardinal_masculine((n / 2000.0).floor) + " mil") + format_spellout_ordinal_feminine_cont((n % 1000)))
            end
            if (n >= 1000) then
              return ("mil" + format_spellout_ordinal_feminine_cont((n % 100)))
            end
            if (n >= 200) then
              return ((format_spellout_cardinal_masculine((n / 200.0).floor) + "-cent") + format_spellout_ordinal_feminine_cont((n % 100)))
            end
            if (n >= 101) then
              return ("cent-" + format_spellout_ordinal_feminine((n % 100)))
            end
            return "centena" if (n >= 100)
            if (n >= 91) then
              return ("noranta-" + format_spellout_ordinal_feminine((n % 10)))
            end
            return "norantena" if (n >= 90)
            if (n >= 81) then
              return ("vuitanta-" + format_spellout_ordinal_feminine((n % 10)))
            end
            return "vuitantena" if (n >= 80)
            if (n >= 71) then
              return ("setanta-" + format_spellout_ordinal_feminine((n % 10)))
            end
            return "setantena" if (n >= 70)
            if (n >= 61) then
              return ("seixanta-" + format_spellout_ordinal_feminine((n % 10)))
            end
            return "seixantena" if (n >= 60)
            if (n >= 51) then
              return ("cinquanta-" + format_spellout_ordinal_feminine((n % 10)))
            end
            return "cinquantena" if (n >= 50)
            if (n >= 41) then
              return ("quaranta-" + format_spellout_ordinal_feminine((n % 10)))
            end
            return "quarantena" if (n >= 40)
            if (n >= 31) then
              return ("trenta-" + format_spellout_ordinal_feminine((n % 10)))
            end
            return "trentena" if (n >= 30)
            if (n >= 21) then
              return ("vint-i-" + format_spellout_ordinal_feminine((n % 10)))
            end
            return "vintena" if (n >= 20)
            return "dinovena" if (n >= 19)
            return "divuitena" if (n >= 18)
            return "dissetena" if (n >= 17)
            return "setzena" if (n >= 16)
            return "quinzena" if (n >= 15)
            return "catorzena" if (n >= 14)
            return "tretzena" if (n >= 13)
            return "dotzena" if (n >= 12)
            return "onzena" if (n >= 11)
            return "desena" if (n >= 10)
            return "novena" if (n >= 9)
            return "vuitena" if (n >= 8)
            return "setena" if (n >= 7)
            return "sisena" if (n >= 6)
            return "cinquena" if (n >= 5)
            return "quarta" if (n >= 4)
            return "tercera" if (n >= 3)
            return "segona" if (n >= 2)
            return "primera" if (n >= 1)
            return "zerona" if (n >= 0)
          end
        end
      end
      
      class Catalan::Ordinal
        class << self
          def format_digits_ordinal_indicator_m(n)
            return format_digits_ordinal_indicator_m((n % 100)) if (n >= 100)
            return format_digits_ordinal_indicator_m((n % 10)) if (n >= 20)
            return "è" if (n >= 5)
            return "t" if (n >= 4)
            return "r" if (n >= 3)
            return "n" if (n >= 2)
            return "r" if (n >= 1)
            return "è" if (n >= 0)
          end
          private(:format_digits_ordinal_indicator_m)
          def format_digits_ordinal_masculine(n)
            return ("−" + format_digits_ordinal_masculine(-n)) if (n < 0)
            return (n.to_s + format_digits_ordinal_indicator_m(n)) if (n >= 0)
          end
          def format_digits_ordinal_feminine(n)
            return ("−" + format_digits_ordinal_feminine(-n)) if (n < 0)
            return (n.to_s + "a") if (n >= 0)
          end
          def format_digits_ordinal(n)
            return format_digits_ordinal_masculine(n) if (n >= 0)
          end
        end
      end
    end
  end
end