# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:ca] = Catalan = Class.new do
        class << self
          (def renderSpelloutNumberingYear(n)
            is_fractional = (n != n.floor)
            return n.to_s if is_fractional and (n > 1)
            return renderSpelloutNumbering(n) if (n >= 0)
          end
          def renderSpelloutNumberingCents(n)
            return (" " + renderSpelloutCardinalMasculine(n)) if (n >= 1)
            return "s" if (n >= 0)
          end
          private(:renderSpelloutNumberingCents)
          def renderSpelloutNumbering(n)
            is_fractional = (n != n.floor)
            return ("menys " + renderSpelloutNumbering(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((renderSpelloutNumbering(n.floor) + " coma ") + renderSpelloutNumbering(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2.0e+15).floor) + " biliards") + (if (n == 2000000000000000) then
                ""
              else
                (" " + renderSpelloutNumbering((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("un biliard" + (if (n == 1000000000000000) then
                ""
              else
                (" " + renderSpelloutNumbering((n % 100000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000000.0).floor) + " bilions") + (if (n == 2000000000000) then
                ""
              else
                (" " + renderSpelloutNumbering((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("un bilió" + (if (n == 1000000000000) then
                ""
              else
                (" " + renderSpelloutNumbering((n % 100000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000.0).floor) + " miliards") + (if (n == 2000000000) then
                ""
              else
                (" " + renderSpelloutNumbering((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("un miliard" + (if (n == 1000000000) then
                ""
              else
                (" " + renderSpelloutNumbering((n % 100000000)))
              end))
            end
            if (n >= 2000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000.0).floor) + " milions") + ((n == 2000000) ? ("") : ((" " + renderSpelloutNumbering((n % 1000000))))))
            end
            if (n >= 1000000) then
              return ("un milió" + ((n == 1000000) ? ("") : ((" " + renderSpelloutNumbering((n % 100000))))))
            end
            if (n >= 2000) then
              return ((renderSpelloutCardinalMasculine((n / 2000.0).floor) + " mil") + ((n == 2000) ? ("") : ((" " + renderSpelloutNumbering((n % 1000))))))
            end
            if (n >= 1000) then
              return ("mil" + ((n == 1000) ? ("") : ((" " + renderSpelloutNumbering((n % 100))))))
            end
            if (n >= 200) then
              return ((renderSpelloutCardinalMasculine((n / 200.0).floor) + "-cent") + renderSpelloutNumberingCents((n % 100)))
            end
            if (n >= 100) then
              return ("cent" + ((n == 100) ? ("") : (("-" + renderSpelloutNumbering((n % 100))))))
            end
            if (n >= 90) then
              return ("noranta" + ((n == 90) ? ("") : (("-" + renderSpelloutNumbering((n % 10))))))
            end
            if (n >= 80) then
              return ("vuitanta" + ((n == 80) ? ("") : (("-" + renderSpelloutNumbering((n % 10))))))
            end
            if (n >= 70) then
              return ("setanta" + ((n == 70) ? ("") : (("-" + renderSpelloutNumbering((n % 10))))))
            end
            if (n >= 60) then
              return ("seixanta" + ((n == 60) ? ("") : (("-" + renderSpelloutNumbering((n % 10))))))
            end
            if (n >= 50) then
              return ("cinquanta" + ((n == 50) ? ("") : (("-" + renderSpelloutNumbering((n % 10))))))
            end
            if (n >= 40) then
              return ("quaranta" + ((n == 40) ? ("") : (("-" + renderSpelloutNumbering((n % 10))))))
            end
            if (n >= 30) then
              return ("trenta" + ((n == 30) ? ("") : (("-" + renderSpelloutNumbering((n % 10))))))
            end
            if (n >= 20) then
              return ("vint" + ((n == 20) ? ("") : (("-i-" + renderSpelloutNumbering((n % 10))))))
            end
            return renderSpelloutCardinalMasculine(n) if (n >= 2)
            return "u" if (n >= 1)
            return "zero" if (n >= 0)
          end
          def renderSpelloutCardinalMasculineCents(n)
            return (" " + renderSpelloutCardinalMasculine(n)) if (n >= 1)
            return "s" if (n >= 0)
          end
          private(:renderSpelloutCardinalMasculineCents)
          def renderSpelloutCardinalMasculine(n)
            is_fractional = (n != n.floor)
            return ("menys " + renderSpelloutCardinalMasculine(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((renderSpelloutCardinalMasculine(n.floor) + " coma ") + renderSpelloutCardinalMasculine(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2.0e+15).floor) + " biliards") + (if (n == 2000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("un biliard" + (if (n == 1000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 100000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000000.0).floor) + " bilions") + (if (n == 2000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("un bilió" + (if (n == 1000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 100000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000.0).floor) + " miliards") + (if (n == 2000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("un miliard" + (if (n == 1000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 100000000)))
              end))
            end
            if (n >= 2000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000.0).floor) + " milions") + (if (n == 2000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ("un milió" + (if (n == 1000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 100000)))
              end))
            end
            if (n >= 2000) then
              return ((renderSpelloutCardinalMasculine((n / 2000.0).floor) + " mil") + ((n == 2000) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 1000))))))
            end
            if (n >= 1000) then
              return ("mil" + ((n == 1000) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 200) then
              return ((renderSpelloutCardinalMasculine((n / 200.0).floor) + "-cent") + renderSpelloutCardinalMasculineCents((n % 100)))
            end
            if (n >= 100) then
              return ("cent" + ((n == 100) ? ("") : (("-" + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 90) then
              return ("noranta" + ((n == 90) ? ("") : (("-" + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 80) then
              return ("vuitanta" + ((n == 80) ? ("") : (("-" + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 70) then
              return ("setanta" + ((n == 70) ? ("") : (("-" + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 60) then
              return ("seixanta" + ((n == 60) ? ("") : (("-" + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 50) then
              return ("cinquanta" + ((n == 50) ? ("") : (("-" + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 40) then
              return ("quaranta" + ((n == 40) ? ("") : (("-" + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 30) then
              return ("trenta" + ((n == 30) ? ("") : (("-" + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 20) then
              return ("vint" + ((n == 20) ? ("") : (("-i-" + renderSpelloutCardinalMasculine((n % 10))))))
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
          def renderSpelloutCardinalFeminineCents(n)
            return (" " + renderSpelloutCardinalFeminine(n)) if (n >= 1)
            return "s" if (n >= 0)
          end
          private(:renderSpelloutCardinalFeminineCents)
          def renderSpelloutCardinalFeminine(n)
            is_fractional = (n != n.floor)
            return ("menys " + renderSpelloutCardinalFeminine(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((renderSpelloutCardinalFeminine(n.floor) + " coma ") + renderSpelloutCardinalFeminine(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2.0e+15).floor) + " biliards") + (if (n == 2000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("un biliard" + (if (n == 1000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 100000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000000.0).floor) + " bilions") + (if (n == 2000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("un bilió" + (if (n == 1000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 100000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000.0).floor) + " miliards") + (if (n == 2000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("un miliard" + (if (n == 1000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 100000000)))
              end))
            end
            if (n >= 2000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000.0).floor) + " milions") + (if (n == 2000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ("un milió" + (if (n == 1000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 100000)))
              end))
            end
            if (n >= 2000) then
              return ((renderSpelloutCardinalMasculine((n / 2000.0).floor) + " mil") + ((n == 2000) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 1000))))))
            end
            if (n >= 1000) then
              return ("mil" + ((n == 1000) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 200) then
              return ((renderSpelloutCardinalMasculine((n / 200.0).floor) + "-cent") + renderSpelloutCardinalFeminineCents((n % 100)))
            end
            if (n >= 100) then
              return ("cent" + ((n == 100) ? ("") : (("-" + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 90) then
              return ("noranta" + ((n == 90) ? ("") : (("-" + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 80) then
              return ("vuitanta" + ((n == 80) ? ("") : (("-" + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 70) then
              return ("setanta" + ((n == 70) ? ("") : (("-" + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 60) then
              return ("seixanta" + ((n == 60) ? ("") : (("-" + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 50) then
              return ("cinquanta" + ((n == 50) ? ("") : (("-" + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 40) then
              return ("quaranta" + ((n == 40) ? ("") : (("-" + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 30) then
              return ("trenta" + ((n == 30) ? ("") : (("-" + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 20) then
              return ("vint" + ((n == 20) ? ("") : (("-i-" + renderSpelloutCardinalFeminine((n % 10))))))
            end
            return renderSpelloutCardinalMasculine(n) if (n >= 3)
            return "dues" if (n >= 2)
            return "una" if (n >= 1)
            return "zero" if (n >= 0)
          end
          def renderSpelloutOrdinalMasculineCont(n)
            return (" " + renderSpelloutOrdinalMasculine(n)) if (n >= 1)
            return "è" if (n >= 0)
          end
          private(:renderSpelloutOrdinalMasculineCont)
          def renderSpelloutOrdinalMasculineConts(n)
            return ("s " + renderSpelloutOrdinalMasculine(n)) if (n >= 1)
            return "è" if (n >= 0)
          end
          private(:renderSpelloutOrdinalMasculineConts)
          def renderSpelloutOrdinalMasculine(n)
            is_fractional = (n != n.floor)
            return ("menys " + renderSpelloutOrdinalMasculine(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return (n.to_s + "è") if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2.0e+15).floor) + " biliard") + renderSpelloutOrdinalMasculineConts((n % 1000000000000000)))
            end
            if (n >= 1000000000000000) then
              return ("un biliard" + renderSpelloutOrdinalMasculineCont((n % 100000000000000)))
            end
            if (n >= 2000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000000.0).floor) + " bilion") + renderSpelloutOrdinalMasculineConts((n % 1000000000000)))
            end
            if (n >= 1000000000000) then
              return ("un bilion" + renderSpelloutOrdinalMasculineCont((n % 100000000000)))
            end
            if (n >= 2000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000.0).floor) + " miliard") + renderSpelloutOrdinalMasculineConts((n % 1000000000)))
            end
            if (n >= 1000000000) then
              return ("un miliard" + renderSpelloutOrdinalMasculineCont((n % 100000000)))
            end
            if (n >= 2000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000.0).floor) + " milion") + renderSpelloutOrdinalMasculineConts((n % 1000000)))
            end
            if (n >= 1000000) then
              return ("un milion" + renderSpelloutOrdinalMasculineCont((n % 100000)))
            end
            if (n >= 2000) then
              return ((renderSpelloutCardinalMasculine((n / 2000.0).floor) + " mil") + renderSpelloutOrdinalMasculineCont((n % 1000)))
            end
            if (n >= 1000) then
              return ("mil" + renderSpelloutOrdinalMasculineCont((n % 100)))
            end
            if (n >= 200) then
              return ((renderSpelloutCardinalMasculine((n / 200.0).floor) + "-cent") + renderSpelloutOrdinalMasculineCont((n % 100)))
            end
            return ("cent-" + renderSpelloutOrdinalMasculine((n % 100))) if (n >= 101)
            return "centè" if (n >= 100)
            return ("noranta-" + renderSpelloutOrdinalMasculine((n % 10))) if (n >= 91)
            return "norantè" if (n >= 90)
            if (n >= 81) then
              return ("vuitanta-" + renderSpelloutOrdinalMasculine((n % 10)))
            end
            return "vuitantè" if (n >= 80)
            return ("setanta-" + renderSpelloutOrdinalMasculine((n % 10))) if (n >= 71)
            return "setantè" if (n >= 70)
            if (n >= 61) then
              return ("seixanta-" + renderSpelloutOrdinalMasculine((n % 10)))
            end
            return "seixantè" if (n >= 60)
            if (n >= 51) then
              return ("cinquanta-" + renderSpelloutOrdinalMasculine((n % 10)))
            end
            return "cinquantè" if (n >= 50)
            if (n >= 41) then
              return ("quaranta-" + renderSpelloutOrdinalMasculine((n % 10)))
            end
            return "quarantè" if (n >= 40)
            return ("trenta-" + renderSpelloutOrdinalMasculine((n % 10))) if (n >= 31)
            return "trentè" if (n >= 30)
            return ("vint-i-" + renderSpelloutOrdinalMasculine((n % 10))) if (n >= 21)
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
          def renderSpelloutOrdinalFeminineCont(n)
            return (" " + renderSpelloutOrdinalFeminine(n)) if (n >= 1)
            return "ena" if (n >= 0)
          end
          private(:renderSpelloutOrdinalFeminineCont)
          def renderSpelloutOrdinalFeminineConts(n)
            return ("s " + renderSpelloutOrdinalFeminine(n)) if (n >= 1)
            return "ena" if (n >= 0)
          end
          private(:renderSpelloutOrdinalFeminineConts)
          def renderSpelloutOrdinalFeminine(n)
            is_fractional = (n != n.floor)
            return ("menys " + renderSpelloutOrdinalFeminine(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return (n.to_s + "ena") if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2.0e+15).floor) + " biliard") + renderSpelloutOrdinalFeminineConts((n % 1000000000000000)))
            end
            if (n >= 1000000000000000) then
              return ("un biliard" + renderSpelloutOrdinalFeminineCont((n % 100000000000000)))
            end
            if (n >= 2000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000000.0).floor) + " bilion") + renderSpelloutOrdinalFeminineConts((n % 1000000000000)))
            end
            if (n >= 1000000000000) then
              return ("un bilion" + renderSpelloutOrdinalFeminineCont((n % 100000000000)))
            end
            if (n >= 2000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000.0).floor) + " miliard") + renderSpelloutOrdinalFeminineConts((n % 1000000000)))
            end
            if (n >= 1000000000) then
              return ("un miliard" + renderSpelloutOrdinalFeminineCont((n % 100000000)))
            end
            if (n >= 2000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000.0).floor) + " milion") + renderSpelloutOrdinalFeminineConts((n % 1000000)))
            end
            if (n >= 1000000) then
              return ("un milion" + renderSpelloutOrdinalFeminineCont((n % 100000)))
            end
            if (n >= 2000) then
              return ((renderSpelloutCardinalMasculine((n / 2000.0).floor) + " mil") + renderSpelloutOrdinalFeminineCont((n % 1000)))
            end
            if (n >= 1000) then
              return ("mil" + renderSpelloutOrdinalFeminineCont((n % 100)))
            end
            if (n >= 200) then
              return ((renderSpelloutCardinalMasculine((n / 200.0).floor) + "-cent") + renderSpelloutOrdinalFeminineCont((n % 100)))
            end
            return ("cent-" + renderSpelloutOrdinalFeminine((n % 100))) if (n >= 101)
            return "centena" if (n >= 100)
            return ("noranta-" + renderSpelloutOrdinalFeminine((n % 10))) if (n >= 91)
            return "norantena" if (n >= 90)
            return ("vuitanta-" + renderSpelloutOrdinalFeminine((n % 10))) if (n >= 81)
            return "vuitantena" if (n >= 80)
            return ("setanta-" + renderSpelloutOrdinalFeminine((n % 10))) if (n >= 71)
            return "setantena" if (n >= 70)
            return ("seixanta-" + renderSpelloutOrdinalFeminine((n % 10))) if (n >= 61)
            return "seixantena" if (n >= 60)
            if (n >= 51) then
              return ("cinquanta-" + renderSpelloutOrdinalFeminine((n % 10)))
            end
            return "cinquantena" if (n >= 50)
            return ("quaranta-" + renderSpelloutOrdinalFeminine((n % 10))) if (n >= 41)
            return "quarantena" if (n >= 40)
            return ("trenta-" + renderSpelloutOrdinalFeminine((n % 10))) if (n >= 31)
            return "trentena" if (n >= 30)
            return ("vint-i-" + renderSpelloutOrdinalFeminine((n % 10))) if (n >= 21)
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
          def renderDigitsOrdinalIndicatorM(n)
            return renderDigitsOrdinalIndicatorM((n % 100)) if (n >= 100)
            return renderDigitsOrdinalIndicatorM((n % 10)) if (n >= 20)
            return "è" if (n >= 5)
            return "t" if (n >= 4)
            return "r" if (n >= 3)
            return "n" if (n >= 2)
            return "r" if (n >= 1)
            return "è" if (n >= 0)
          end
          private(:renderDigitsOrdinalIndicatorM)
          def renderDigitsOrdinalMasculine(n)
            return ("−" + renderDigitsOrdinalMasculine(-n)) if (n < 0)
            return (n.to_s + renderDigitsOrdinalIndicatorM(n)) if (n >= 0)
          end
          def renderDigitsOrdinalFeminine(n)
            return ("−" + renderDigitsOrdinalFeminine(-n)) if (n < 0)
            return (n.to_s + "a") if (n >= 0)
          end
          def renderDigitsOrdinal(n)
            return renderDigitsOrdinalMasculine(n) if (n >= 0)
          end)
        end
      end
    end
  end
end