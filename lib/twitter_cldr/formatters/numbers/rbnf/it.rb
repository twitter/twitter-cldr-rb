# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:it] = Italian = Class.new do
        class << self
          (def renderLenientParse(n)
            if (n >= 0) then
              return ((((((((((((n == 0) ? ("") : ("last primary ignorable ")) + " ") + renderLenientParse((n / 0.0).floor)) + " ' ' ") + renderLenientParse((n / 0.0).floor)) + " '") + "' ") + renderLenientParse((n / 0.0).floor)) + " '-' ") + renderLenientParse((n / 0.0).floor)) + " '­'")
            end
          end
          private(:renderLenientParse)
          def renderSpelloutNumberingYear(n)
            is_fractional = (n != n.floor)
            return n.to_s if is_fractional and (n > 1)
            return renderSpelloutNumbering(n) if (n >= 0)
          end
          def renderSpelloutNumbering(n)
            is_fractional = (n != n.floor)
            return ("meno " + renderSpelloutNumbering(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((renderSpelloutNumbering(n.floor) + " virgola ") + renderSpelloutNumbering(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2.0e+15).floor) + " biliardi") + (if (n == 2000000000000000) then
                ""
              else
                (" " + renderSpelloutNumbering((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("un biliardo" + (if (n == 1000000000000000) then
                ""
              else
                (" " + renderSpelloutNumbering((n % 100000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000000.0).floor) + " bilioni") + (if (n == 2000000000000) then
                ""
              else
                (" " + renderSpelloutNumbering((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("un bilione" + (if (n == 1000000000000) then
                ""
              else
                (" " + renderSpelloutNumbering((n % 100000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000.0).floor) + " miliardi") + (if (n == 2000000000) then
                ""
              else
                (" " + renderSpelloutNumbering((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("un miliardo" + (if (n == 1000000000) then
                ""
              else
                (" " + renderSpelloutNumbering((n % 100000000)))
              end))
            end
            if (n >= 2000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000.0).floor) + " milioni") + ((n == 2000000) ? ("") : ((" " + renderSpelloutNumbering((n % 1000000))))))
            end
            if (n >= 1000000) then
              return ("un milione" + ((n == 1000000) ? ("") : ((" " + renderSpelloutNumbering((n % 100000))))))
            end
            if (n >= 2000) then
              return ((renderMscNoFinal((n / 2000.0).floor) + "­mila") + ((n == 2000) ? ("") : (("­" + renderSpelloutNumbering((n % 1000))))))
            end
            if (n >= 1000) then
              return ("mille" + ((n == 1000) ? ("") : (("­" + renderSpelloutNumbering((n % 100))))))
            end
            if (n >= 200) then
              return ((renderSpelloutNumbering((n / 200.0).floor) + "­cent") + renderMscoWithO((n % 100)))
            end
            return ("cent" + renderMscoWithO((n % 100))) if (n >= 100)
            return ("novant" + renderMscoWithA((n % 10))) if (n >= 90)
            return ("ottant" + renderMscoWithA((n % 10))) if (n >= 80)
            return ("settant" + renderMscoWithA((n % 10))) if (n >= 70)
            return ("sessant" + renderMscoWithA((n % 10))) if (n >= 60)
            return ("cinquant" + renderMscoWithA((n % 10))) if (n >= 50)
            return ("quarant" + renderMscoWithA((n % 10))) if (n >= 40)
            return ("trent" + renderMscoWithA((n % 10))) if (n >= 30)
            return ("vent" + renderMscoWithI((n % 10))) if (n >= 20)
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
          def renderMscoWithI(n)
            return "ERROR" if (n >= 10)
            return "i­nove" if (n >= 9)
            return "­otto" if (n >= 8)
            return ("i­" + renderSpelloutNumbering(n)) if (n >= 4)
            return "i­tré" if (n >= 3)
            return "i­due" if (n >= 2)
            return "­uno" if (n >= 1)
            return "i" if (n >= 0)
          end
          private(:renderMscoWithI)
          def renderMscoWithA(n)
            return "ERROR" if (n >= 10)
            return "a­nove" if (n >= 9)
            return "­otto" if (n >= 8)
            return ("a­" + renderSpelloutNumbering(n)) if (n >= 4)
            return "a­tré" if (n >= 3)
            return "a­due" if (n >= 2)
            return "­uno" if (n >= 1)
            return "a" if (n >= 0)
          end
          private(:renderMscoWithA)
          def renderMscoWithO(n)
            return ("o­" + renderSpelloutNumbering(n)) if (n >= 90)
            return ("­" + renderSpelloutNumbering(n)) if (n >= 80)
            return ("o­" + renderSpelloutNumbering(n)) if (n >= 9)
            return "­otto" if (n >= 8)
            return ("o­" + renderSpelloutNumbering(n)) if (n >= 4)
            return "o­tré" if (n >= 3)
            return "o­due" if (n >= 2)
            return "o­uno" if (n >= 1)
            return "o" if (n >= 0)
          end
          private(:renderMscoWithO)
          def renderSpelloutCardinalMasculine(n)
            is_fractional = (n != n.floor)
            return ("meno " + renderSpelloutCardinalMasculine(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((renderSpelloutCardinalMasculine(n.floor) + " virgola ") + renderSpelloutCardinalMasculine(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2.0e+15).floor) + " biliardi") + (if (n == 2000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("un biliardo" + (if (n == 1000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 100000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000000.0).floor) + " bilioni") + (if (n == 2000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("un bilione" + (if (n == 1000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 100000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000.0).floor) + " miliardi") + (if (n == 2000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("un miliardo" + (if (n == 1000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 100000000)))
              end))
            end
            if (n >= 2000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000.0).floor) + " milioni") + (if (n == 2000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ("un milione" + (if (n == 1000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 100000)))
              end))
            end
            if (n >= 2000) then
              return ((renderMscNoFinal((n / 2000.0).floor) + "­mila") + ((n == 2000) ? ("") : (("­" + renderSpelloutCardinalMasculine((n % 1000))))))
            end
            if (n >= 1000) then
              return ("mille" + ((n == 1000) ? ("") : (("­" + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 200) then
              return ((renderSpelloutCardinalMasculine((n / 200.0).floor) + "­cent") + renderMscWithO((n % 100)))
            end
            return ("cent" + renderMscWithO((n % 100))) if (n >= 100)
            return ("novant" + renderMscWithA((n % 10))) if (n >= 90)
            return ("ottant" + renderMscWithA((n % 10))) if (n >= 80)
            return ("settant" + renderMscWithA((n % 10))) if (n >= 70)
            return ("sessant" + renderMscWithA((n % 10))) if (n >= 60)
            return ("cinquant" + renderMscWithA((n % 10))) if (n >= 50)
            return ("quarant" + renderMscWithA((n % 10))) if (n >= 40)
            return ("trent" + renderMscWithA((n % 10))) if (n >= 30)
            return ("vent" + renderMscWithI((n % 10))) if (n >= 20)
            return renderSpelloutNumbering(n) if (n >= 2)
            return "un" if (n >= 1)
            return "zero" if (n >= 0)
          end
          def renderMscWithI(n)
            return renderMscoWithI(n) if (n >= 2)
            return "­un" if (n >= 1)
            return "i" if (n >= 0)
          end
          private(:renderMscWithI)
          def renderMscWithA(n)
            return renderMscoWithA(n) if (n >= 2)
            return "­un" if (n >= 1)
            return "a" if (n >= 0)
          end
          private(:renderMscWithA)
          def renderMscWithO(n)
            return ("o­" + renderSpelloutNumbering(n)) if (n >= 90)
            return ("­" + renderSpelloutNumbering(n)) if (n >= 80)
            return ("o­" + renderSpelloutNumbering(n)) if (n >= 9)
            return "­otto" if (n >= 8)
            return ("o­" + renderSpelloutNumbering(n)) if (n >= 4)
            return "o­tré" if (n >= 3)
            return "o­due" if (n >= 2)
            return "o­uno" if (n >= 1)
            return "o" if (n >= 0)
          end
          private(:renderMscWithO)
          def renderMscNoFinal(n)
            return "ERROR" if (n >= 1000)
            if (n >= 200) then
              return ((renderMscNoFinal((n / 200.0).floor) + "­cent") + renderMscWithONofinal((n % 100)))
            end
            return ("cent" + renderMscWithONofinal((n % 100))) if (n >= 100)
            return ("novant" + renderMscWithANofinal((n % 10))) if (n >= 90)
            return ("ottant" + renderMscWithANofinal((n % 10))) if (n >= 80)
            return ("settant" + renderMscWithANofinal((n % 10))) if (n >= 70)
            return ("sessant" + renderMscWithANofinal((n % 10))) if (n >= 60)
            return ("cinquant" + renderMscWithANofinal((n % 10))) if (n >= 50)
            return ("quarant" + renderMscWithANofinal((n % 10))) if (n >= 40)
            return ("trent" + renderMscWithANofinal((n % 10))) if (n >= 30)
            return ("vent" + renderMscWithINofinal((n % 10))) if (n >= 20)
            return renderSpelloutCardinalMasculine(n) if (n >= 2)
            return "ERROR" if (n >= 0)
          end
          private(:renderMscNoFinal)
          def renderMscWithINofinal(n)
            return renderMscWithI(n) if (n >= 4)
            return "a­tre" if (n >= 3)
            return renderMscWithI(n) if (n >= 0)
          end
          private(:renderMscWithINofinal)
          def renderMscWithANofinal(n)
            return renderMscWithA(n) if (n >= 4)
            return "a­tre" if (n >= 3)
            return renderMscWithA(n) if (n >= 0)
          end
          private(:renderMscWithANofinal)
          def renderMscWithONofinal(n)
            return renderMscWithO(n) if (n >= 4)
            return "o­tre" if (n >= 3)
            return renderMscWithO(n) if (n >= 0)
          end
          private(:renderMscWithONofinal)
          def renderSpelloutCardinalFeminine(n)
            is_fractional = (n != n.floor)
            return ("meno " + renderSpelloutCardinalFeminine(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((renderSpelloutCardinalFeminine(n.floor) + " virgola ") + renderSpelloutCardinalFeminine(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2.0e+15).floor) + " biliardi") + (if (n == 2000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("un biliardo" + (if (n == 1000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 100000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000000.0).floor) + " bilioni") + (if (n == 2000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("un bilione" + (if (n == 1000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 100000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000.0).floor) + " miliardi") + (if (n == 2000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("un miliardo" + (if (n == 1000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 100000000)))
              end))
            end
            if (n >= 2000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000.0).floor) + " milioni") + (if (n == 2000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ("un milione" + (if (n == 1000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 100000)))
              end))
            end
            if (n >= 2000) then
              return ((renderMscNoFinal((n / 2000.0).floor) + "­mila") + ((n == 2000) ? ("") : (("­" + renderSpelloutCardinalFeminine((n % 1000))))))
            end
            if (n >= 1000) then
              return ("mille" + ((n == 1000) ? ("") : (("­" + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 200) then
              return ((renderSpelloutCardinalFeminine((n / 200.0).floor) + "­cent") + renderFemWithO((n % 100)))
            end
            return ("cent" + renderFemWithO((n % 100))) if (n >= 100)
            return ("novant" + renderFemWithA((n % 10))) if (n >= 90)
            return ("ottant" + renderFemWithA((n % 10))) if (n >= 80)
            return ("settant" + renderFemWithA((n % 10))) if (n >= 70)
            return ("sessant" + renderFemWithA((n % 10))) if (n >= 60)
            return ("cinquant" + renderFemWithA((n % 10))) if (n >= 50)
            return ("quarant" + renderFemWithA((n % 10))) if (n >= 40)
            return ("trent" + renderFemWithA((n % 10))) if (n >= 30)
            return ("vent" + renderFemWithI((n % 10))) if (n >= 20)
            return renderSpelloutNumbering(n) if (n >= 2)
            return "una" if (n >= 1)
            return "zero" if (n >= 0)
          end
          def renderFemWithI(n)
            return renderMscoWithI(n) if (n >= 2)
            return "­una" if (n >= 1)
            return "i" if (n >= 0)
          end
          private(:renderFemWithI)
          def renderFemWithA(n)
            return renderMscoWithA(n) if (n >= 2)
            return "­una" if (n >= 1)
            return "a" if (n >= 0)
          end
          private(:renderFemWithA)
          def renderFemWithO(n)
            return renderMscoWithO(n) if (n >= 2)
            return "o­una" if (n >= 1)
            return "o" if (n >= 0)
          end
          private(:renderFemWithO)
          def renderSpelloutOrdinalMasculine(n)
            is_fractional = (n != n.floor)
            return ("meno " + renderSpelloutOrdinalMasculine(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2.0e+15).floor) + "biliard­") + renderOrdinalEsimoWithO((n % 1000000000000000)))
            end
            if (n >= 1000000000000000) then
              return ("biliard­" + renderOrdinalEsimoWithO((n % 100000000000000)))
            end
            if (n >= 2000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000000.0).floor) + "bilion­") + renderOrdinalEsimo((n % 1000000000000)))
            end
            if (n >= 1000000000000) then
              return ("bilione­" + renderOrdinalEsimo((n % 100000000000)))
            end
            if (n >= 2000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000.0).floor) + "miliard­") + renderOrdinalEsimoWithO((n % 1000000000)))
            end
            if (n >= 1000000000) then
              return ("miliard­" + renderOrdinalEsimoWithO((n % 100000000)))
            end
            if (n >= 2000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000.0).floor) + "milion­") + renderOrdinalEsimo((n % 1000000)))
            end
            return ("milione­" + renderOrdinalEsimo((n % 100000))) if (n >= 1000000)
            if (n >= 2001) then
              return ((renderSpelloutCardinalMasculine((n / 2001.0).floor) + "­mila­") + renderOrdinalEsimo((n % 1000)))
            end
            if (n >= 2000) then
              return ((renderSpelloutCardinalMasculine((n / 2000.0).floor) + "­mille­") + renderOrdinalEsimo((n % 1000)))
            end
            return ("mille­" + renderOrdinalEsimo((n % 100))) if (n >= 1000)
            if (n >= 200) then
              return ((renderSpelloutCardinalMasculine((n / 200.0).floor) + "­cent") + renderOrdinalEsimoWithO((n % 100)))
            end
            return ("cent" + renderOrdinalEsimoWithO((n % 100))) if (n >= 100)
            return ("novant" + renderOrdinalEsimoWithA((n % 10))) if (n >= 90)
            return ("ottant" + renderOrdinalEsimoWithA((n % 10))) if (n >= 80)
            return ("settant" + renderOrdinalEsimoWithA((n % 10))) if (n >= 70)
            return ("sessant" + renderOrdinalEsimoWithA((n % 10))) if (n >= 60)
            return ("cinquant" + renderOrdinalEsimoWithA((n % 10))) if (n >= 50)
            return ("quarant" + renderOrdinalEsimoWithA((n % 10))) if (n >= 40)
            return ("trent" + renderOrdinalEsimoWithA((n % 10))) if (n >= 30)
            return ("vent" + renderOrdinalEsimoWithI((n % 10))) if (n >= 20)
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
          def renderOrdinalEsimo(n)
            return renderSpelloutOrdinalMasculine(n) if (n >= 10)
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
          private(:renderOrdinalEsimo)
          def renderOrdinalEsimoWithI(n)
            return renderSpelloutOrdinalMasculine(n) if (n >= 10)
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
          private(:renderOrdinalEsimoWithI)
          def renderOrdinalEsimoWithA(n)
            return renderSpelloutOrdinalMasculine(n) if (n >= 10)
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
          private(:renderOrdinalEsimoWithA)
          def renderOrdinalEsimoWithO(n)
            return ("o­" + renderSpelloutOrdinalMasculine(n)) if (n >= 10)
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
          private(:renderOrdinalEsimoWithO)
          def renderSpelloutOrdinalFeminine(n)
            is_fractional = (n != n.floor)
            return ("meno " + renderSpelloutOrdinalFeminine(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((renderSpelloutCardinalFeminine((n / 2.0e+15).floor) + "biliard­") + renderOrdinalEsimaWithO((n % 1000000000000000)))
            end
            if (n >= 1000000000000000) then
              return ("biliard­" + renderOrdinalEsimaWithO((n % 100000000000000)))
            end
            if (n >= 2000000000000) then
              return ((renderSpelloutCardinalFeminine((n / 2000000000000.0).floor) + "bilion­") + renderOrdinalEsima((n % 1000000000000)))
            end
            if (n >= 1000000000000) then
              return ("bilione­" + renderOrdinalEsima((n % 100000000000)))
            end
            if (n >= 2000000000) then
              return ((renderSpelloutCardinalFeminine((n / 2000000000.0).floor) + "miliard­") + renderOrdinalEsimaWithO((n % 1000000000)))
            end
            if (n >= 1000000000) then
              return ("miliard­" + renderOrdinalEsimaWithO((n % 100000000)))
            end
            if (n >= 2000000) then
              return ((renderSpelloutCardinalFeminine((n / 2000000.0).floor) + "milion­") + renderOrdinalEsima((n % 1000000)))
            end
            return ("milione­" + renderOrdinalEsima((n % 100000))) if (n >= 1000000)
            if (n >= 2001) then
              return ((renderSpelloutCardinalFeminine((n / 2001.0).floor) + "­mila­") + renderOrdinalEsima((n % 1000)))
            end
            if (n >= 2000) then
              return ((renderSpelloutCardinalFeminine((n / 2000.0).floor) + "­mille­") + renderOrdinalEsima((n % 1000)))
            end
            return ("mille­" + renderOrdinalEsima((n % 100))) if (n >= 1000)
            if (n >= 200) then
              return ((renderSpelloutCardinalFeminine((n / 200.0).floor) + "­cent") + renderOrdinalEsimaWithO((n % 100)))
            end
            return ("cent" + renderOrdinalEsimaWithO((n % 100))) if (n >= 100)
            return ("novant" + renderOrdinalEsimaWithA((n % 10))) if (n >= 90)
            return ("ottant" + renderOrdinalEsimaWithA((n % 10))) if (n >= 80)
            return ("settant" + renderOrdinalEsimaWithA((n % 10))) if (n >= 70)
            return ("sessant" + renderOrdinalEsimaWithA((n % 10))) if (n >= 60)
            return ("cinquant" + renderOrdinalEsimaWithA((n % 10))) if (n >= 50)
            return ("quarant" + renderOrdinalEsimaWithA((n % 10))) if (n >= 40)
            return ("trent" + renderOrdinalEsimaWithA((n % 10))) if (n >= 30)
            return ("vent" + renderOrdinalEsimaWithI((n % 10))) if (n >= 20)
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
          def renderOrdinalEsima(n)
            return renderSpelloutOrdinalFeminine(n) if (n >= 10)
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
          private(:renderOrdinalEsima)
          def renderOrdinalEsimaWithI(n)
            return renderSpelloutOrdinalFeminine(n) if (n >= 10)
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
          private(:renderOrdinalEsimaWithI)
          def renderOrdinalEsimaWithA(n)
            return renderSpelloutOrdinalFeminine(n) if (n >= 10)
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
          private(:renderOrdinalEsimaWithA)
          def renderOrdinalEsimaWithO(n)
            return ("o­" + renderSpelloutOrdinalFeminine(n)) if (n >= 10)
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
          private(:renderOrdinalEsimaWithO)
          def renderDordMascabbrev(n)
            return "º" if (n >= 0)
          end
          private(:renderDordMascabbrev)
          def renderDigitsOrdinalMasculine(n)
            return ("−" + renderDigitsOrdinalMasculine(-n)) if (n < 0)
            return (n.to_s + renderDordMascabbrev(n)) if (n >= 0)
          end
          def renderDordFemabbrev(n)
            return "ª" if (n >= 0)
          end
          private(:renderDordFemabbrev)
          def renderDigitsOrdinalFeminine(n)
            return ("−" + renderDigitsOrdinalFeminine(-n)) if (n < 0)
            return (n.to_s + renderDordFemabbrev(n)) if (n >= 0)
          end
          def renderDigitsOrdinal(n)
            return renderDigitsOrdinalMasculine(n) if (n >= 0)
          end)
        end
      end
    end
  end
end