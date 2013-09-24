# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:sv] = Swedish = Class.new do
        class << self
          (def renderLenientParse(n)
            if (n >= 0) then
              return ((((((((((((n == 0) ? ("") : ("last primary ignorable ")) + " ") + renderLenientParse((n / 0.0).floor)) + " ' ' ") + renderLenientParse((n / 0.0).floor)) + " '") + "' ") + renderLenientParse((n / 0.0).floor)) + " '-' ") + renderLenientParse((n / 0.0).floor)) + " '­'")
            end
          end
          private(:renderLenientParse)
          def renderSpelloutNumberingYear(n)
            is_fractional = (n != n.floor)
            return ("minus " + renderSpelloutNumberingYear(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return renderSpelloutNumbering(n) if (n >= 10000)
            if (n >= 1100) then
              return ((renderSpelloutNumberingYear((n / 1100.0).floor) + "­hundra") + ((n == 1100) ? ("") : (("­" + renderSpelloutNumberingYear((n % 100))))))
            end
            return renderSpelloutNumbering(n) if (n >= 0)
          end
          def renderSpelloutNumbering(n)
            is_fractional = (n != n.floor)
            return ("minus " + renderSpelloutNumbering(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((renderSpelloutNumbering(n.floor) + " komma ") + renderSpelloutNumbering(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((renderSpelloutCardinalReale((n / 2.0e+15).floor) + " biljarder") + (if (n == 2000000000000000) then
                ""
              else
                (" " + renderSpelloutNumbering((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("en biljard" + (if (n == 1000000000000000) then
                ""
              else
                (" " + renderSpelloutNumbering((n % 100000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((renderSpelloutCardinalReale((n / 2000000000000.0).floor) + " biljoner") + (if (n == 2000000000000) then
                ""
              else
                (" " + renderSpelloutNumbering((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("en biljon" + (if (n == 1000000000000) then
                ""
              else
                (" " + renderSpelloutNumbering((n % 100000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((renderSpelloutCardinalReale((n / 2000000000.0).floor) + " miljarder") + (if (n == 2000000000) then
                ""
              else
                (" " + renderSpelloutNumbering((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("en miljard" + (if (n == 1000000000) then
                ""
              else
                (" " + renderSpelloutNumbering((n % 100000000)))
              end))
            end
            if (n >= 2000000) then
              return ((renderSpelloutCardinalReale((n / 2000000.0).floor) + " miljoner") + ((n == 2000000) ? ("") : ((" " + renderSpelloutNumbering((n % 1000000))))))
            end
            if (n >= 1000000) then
              return ("en miljon" + ((n == 1000000) ? ("") : ((" " + renderSpelloutNumbering((n % 100000))))))
            end
            if (n >= 1000) then
              return ((renderSpelloutNumberingT((n / 1000.0).floor) + "­tusen") + ((n == 1000) ? ("") : ((" " + renderSpelloutNumbering((n % 100))))))
            end
            if (n >= 100) then
              return ((renderSpelloutNumbering((n / 100.0).floor) + "­hundra") + ((n == 100) ? ("") : (("­" + renderSpelloutNumbering((n % 100))))))
            end
            if (n >= 90) then
              return ("nittio" + ((n == 90) ? ("") : (("­" + renderSpelloutNumbering((n % 10))))))
            end
            if (n >= 80) then
              return ("åttio" + ((n == 80) ? ("") : (("­" + renderSpelloutNumbering((n % 10))))))
            end
            if (n >= 70) then
              return ("sjuttio" + ((n == 70) ? ("") : (("­" + renderSpelloutNumbering((n % 10))))))
            end
            if (n >= 60) then
              return ("sextio" + ((n == 60) ? ("") : (("­" + renderSpelloutNumbering((n % 10))))))
            end
            if (n >= 50) then
              return ("femtio" + ((n == 50) ? ("") : (("­" + renderSpelloutNumbering((n % 10))))))
            end
            if (n >= 40) then
              return ("fyrtio" + ((n == 40) ? ("") : (("­" + renderSpelloutNumbering((n % 10))))))
            end
            if (n >= 30) then
              return ("trettio" + ((n == 30) ? ("") : (("­" + renderSpelloutNumbering((n % 10))))))
            end
            if (n >= 20) then
              return ("tjugo" + ((n == 20) ? ("") : (("­" + renderSpelloutNumbering((n % 10))))))
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
          def renderSpelloutNumberingT(n)
            return "ERROR" if (n >= 1000)
            if (n >= 100) then
              return ((renderSpelloutNumbering((n / 100.0).floor) + "­hundra") + ((n == 100) ? ("") : (("­" + renderSpelloutNumberingT((n % 100))))))
            end
            if (n >= 90) then
              return ("nittio" + ((n == 90) ? ("") : (("­" + renderSpelloutNumberingT((n % 10))))))
            end
            if (n >= 80) then
              return ("åttio" + ((n == 80) ? ("") : (("­" + renderSpelloutNumberingT((n % 10))))))
            end
            if (n >= 70) then
              return ("sjuttio" + ((n == 70) ? ("") : (("­" + renderSpelloutNumberingT((n % 10))))))
            end
            if (n >= 60) then
              return ("sextio" + ((n == 60) ? ("") : (("­" + renderSpelloutNumberingT((n % 10))))))
            end
            if (n >= 50) then
              return ("femtio" + ((n == 50) ? ("") : (("­" + renderSpelloutNumberingT((n % 10))))))
            end
            if (n >= 40) then
              return ("fyrtio" + ((n == 40) ? ("") : (("­" + renderSpelloutNumberingT((n % 10))))))
            end
            if (n >= 30) then
              return ("trettio" + ((n == 30) ? ("") : (("­" + renderSpelloutNumberingT((n % 10))))))
            end
            if (n >= 20) then
              return ("tjugo" + ((n == 20) ? ("") : (("­" + renderSpelloutNumberingT((n % 10))))))
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
          private(:renderSpelloutNumberingT)
          def renderSpelloutCardinalNeuter(n)
            return renderSpelloutNumbering(n) if (n >= 0)
          end
          def renderSpelloutCardinalMasculine(n)
            return renderSpelloutCardinalReale(n) if (n >= 0)
          end
          def renderSpelloutCardinalFeminine(n)
            return renderSpelloutCardinalReale(n) if (n >= 0)
          end
          def renderSpelloutCardinalReale(n)
            is_fractional = (n != n.floor)
            return ("minus " + renderSpelloutCardinalReale(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((renderSpelloutCardinalReale(n.floor) + " komma ") + renderSpelloutCardinalReale(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((renderSpelloutCardinalReale((n / 2.0e+15).floor) + " biljarder") + (if (n == 2000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalReale((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("en biljard" + (if (n == 1000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalReale((n % 100000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((renderSpelloutCardinalReale((n / 2000000000000.0).floor) + " biljoner") + (if (n == 2000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalReale((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("en biljon" + (if (n == 1000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalReale((n % 100000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((renderSpelloutCardinalReale((n / 2000000000.0).floor) + " miljarder") + (if (n == 2000000000) then
                ""
              else
                (" " + renderSpelloutCardinalReale((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("en miljard" + (if (n == 1000000000) then
                ""
              else
                (" " + renderSpelloutCardinalReale((n % 100000000)))
              end))
            end
            if (n >= 2000000) then
              return ((renderSpelloutCardinalReale((n / 2000000.0).floor) + " miljoner") + (if (n == 2000000) then
                ""
              else
                (" " + renderSpelloutCardinalReale((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ("en miljon" + ((n == 1000000) ? ("") : ((" " + renderSpelloutCardinalReale((n % 100000))))))
            end
            if (n >= 2000) then
              return ((renderSpelloutCardinalReale((n / 2000.0).floor) + "­tusen") + ((n == 2000) ? ("") : ((" " + renderSpelloutCardinalReale((n % 1000))))))
            end
            if (n >= 1000) then
              return ("ettusen" + ((n == 1000) ? ("") : ((" " + renderSpelloutCardinalReale((n % 100))))))
            end
            if (n >= 100) then
              return ((renderSpelloutCardinalNeuter((n / 100.0).floor) + "­hundra") + ((n == 100) ? ("") : (("­" + renderSpelloutCardinalReale((n % 100))))))
            end
            if (n >= 90) then
              return ("nittio" + ((n == 90) ? ("") : (("­" + renderSpelloutCardinalReale((n % 10))))))
            end
            if (n >= 80) then
              return ("åttio" + ((n == 80) ? ("") : (("­" + renderSpelloutCardinalReale((n % 10))))))
            end
            if (n >= 70) then
              return ("sjuttio" + ((n == 70) ? ("") : (("­" + renderSpelloutCardinalReale((n % 10))))))
            end
            if (n >= 60) then
              return ("sextio" + ((n == 60) ? ("") : (("­" + renderSpelloutCardinalReale((n % 10))))))
            end
            if (n >= 50) then
              return ("femtio" + ((n == 50) ? ("") : (("­" + renderSpelloutCardinalReale((n % 10))))))
            end
            if (n >= 40) then
              return ("fyrtio" + ((n == 40) ? ("") : (("­" + renderSpelloutCardinalReale((n % 10))))))
            end
            if (n >= 30) then
              return ("trettio" + ((n == 30) ? ("") : (("­" + renderSpelloutCardinalReale((n % 10))))))
            end
            if (n >= 20) then
              return ("tjugo" + ((n == 20) ? ("") : (("­" + renderSpelloutCardinalReale((n % 10))))))
            end
            return renderSpelloutNumbering(n) if (n >= 2)
            return "en" if (n >= 1)
            return "noll" if (n >= 0)
          end
          def renderSpelloutOrdinalNeuter(n)
            is_fractional = (n != n.floor)
            return ("minus " + renderSpelloutOrdinalNeuter(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return (n.to_s + "':e") if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((renderSpelloutCardinalReale((n / 2.0e+15).floor) + " biljard") + renderOrdFemTeer((n % 1000000000000000)))
            end
            if (n >= 1000000000000000) then
              return ("en biljard" + renderOrdFemTe((n % 100000000000000)))
            end
            if (n >= 2000000000000) then
              return ((renderSpelloutCardinalReale((n / 2000000000000.0).floor) + " biljon") + renderOrdFemTeer((n % 1000000000000)))
            end
            if (n >= 1000000000000) then
              return ("en biljon" + renderOrdFemTe((n % 100000000000)))
            end
            if (n >= 2000000000) then
              return ((renderSpelloutCardinalReale((n / 2000000000.0).floor) + " miljard") + renderOrdFemTeer((n % 1000000000)))
            end
            if (n >= 1000000000) then
              return ("en miljard" + renderOrdFemTe((n % 100000000)))
            end
            if (n >= 2000000) then
              return ((renderSpelloutCardinalReale((n / 2000000.0).floor) + " miljon") + renderOrdFemTeer((n % 1000000)))
            end
            return ("en miljon" + renderOrdFemTe((n % 100000))) if (n >= 1000000)
            if (n >= 1000) then
              return ((renderSpelloutNumberingT((n / 1000.0).floor) + "­tusen") + renderOrdFemDe((n % 100)))
            end
            if (n >= 100) then
              return ((renderSpelloutNumbering((n / 100.0).floor) + "­hundra") + renderOrdFemDe((n % 100)))
            end
            return ("nittio" + renderOrdFemNde((n % 10))) if (n >= 90)
            return ("åttio" + renderOrdFemNde((n % 10))) if (n >= 80)
            return ("sjuttio" + renderOrdFemNde((n % 10))) if (n >= 70)
            return ("sextio" + renderOrdFemNde((n % 10))) if (n >= 60)
            return ("femtio" + renderOrdFemNde((n % 10))) if (n >= 50)
            return ("fyrtio" + renderOrdFemNde((n % 10))) if (n >= 40)
            return ("trettio" + renderOrdFemNde((n % 10))) if (n >= 30)
            return ("tjugo" + renderOrdFemNde((n % 10))) if (n >= 20)
            return renderSpelloutOrdinalMasculine(n) if (n >= 3)
            return "andra" if (n >= 2)
            return "första" if (n >= 1)
            return "nollte" if (n >= 0)
          end
          def renderOrdFemNde(n)
            return ("­" + renderSpelloutOrdinalFeminine(n)) if (n >= 1)
            return "nde" if (n >= 0)
          end
          private(:renderOrdFemNde)
          def renderOrdFemDe(n)
            return (" " + renderSpelloutOrdinalFeminine(n)) if (n >= 1)
            return "de" if (n >= 0)
          end
          private(:renderOrdFemDe)
          def renderOrdFemTe(n)
            return (" " + renderSpelloutOrdinalFeminine(n)) if (n >= 1)
            return "te" if (n >= 0)
          end
          private(:renderOrdFemTe)
          def renderOrdFemTeer(n)
            return ("er " + renderSpelloutOrdinalFeminine(n)) if (n >= 1)
            return "te" if (n >= 0)
          end
          private(:renderOrdFemTeer)
          def renderSpelloutOrdinalMasculine(n)
            is_fractional = (n != n.floor)
            return ("minus " + renderSpelloutOrdinalMasculine(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return (n.to_s + "':e") if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((renderSpelloutCardinalReale((n / 2.0e+15).floor) + " biljard") + renderOrdMascTeer((n % 1000000000000000)))
            end
            if (n >= 1000000000000000) then
              return ("en biljard" + renderOrdMascTe((n % 100000000000000)))
            end
            if (n >= 2000000000000) then
              return ((renderSpelloutCardinalReale((n / 2000000000000.0).floor) + " biljon") + renderOrdMascTeer((n % 1000000000000)))
            end
            if (n >= 1000000000000) then
              return ("en biljon" + renderOrdMascTe((n % 100000000000)))
            end
            if (n >= 2000000000) then
              return ((renderSpelloutCardinalReale((n / 2000000000.0).floor) + " miljard") + renderOrdMascTeer((n % 1000000000)))
            end
            if (n >= 1000000000) then
              return ("en miljard" + renderOrdMascTe((n % 100000000)))
            end
            if (n >= 2000000) then
              return ((renderSpelloutCardinalReale((n / 2000000.0).floor) + " miljon") + renderOrdMascTeer((n % 1000000)))
            end
            return ("en miljon" + renderOrdMascTe((n % 100000))) if (n >= 1000000)
            if (n >= 1000) then
              return ((renderSpelloutNumberingT((n / 1000.0).floor) + "­tusen") + renderOrdMascDe((n % 100)))
            end
            if (n >= 100) then
              return ((renderSpelloutNumbering((n / 100.0).floor) + "­hundra") + renderOrdMascDe((n % 100)))
            end
            return ("nittio" + renderOrdMascNde((n % 10))) if (n >= 90)
            return ("åttio" + renderOrdMascNde((n % 10))) if (n >= 80)
            return ("sjuttio" + renderOrdMascNde((n % 10))) if (n >= 70)
            return ("sextio" + renderOrdMascNde((n % 10))) if (n >= 60)
            return ("femtio" + renderOrdMascNde((n % 10))) if (n >= 50)
            return ("fyrtio" + renderOrdMascNde((n % 10))) if (n >= 40)
            return ("trettio" + renderOrdMascNde((n % 10))) if (n >= 30)
            return ("tjugo" + renderOrdMascNde((n % 10))) if (n >= 20)
            return (renderSpelloutCardinalNeuter(n) + "de") if (n >= 13)
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
          def renderOrdMascNde(n)
            return ("­" + renderSpelloutOrdinalMasculine(n)) if (n >= 1)
            return "nde" if (n >= 0)
          end
          private(:renderOrdMascNde)
          def renderOrdMascDe(n)
            return (" " + renderSpelloutOrdinalMasculine(n)) if (n >= 1)
            return "de" if (n >= 0)
          end
          private(:renderOrdMascDe)
          def renderOrdMascTe(n)
            return (" " + renderSpelloutOrdinalMasculine(n)) if (n >= 1)
            return "te" if (n >= 0)
          end
          private(:renderOrdMascTe)
          def renderOrdMascTeer(n)
            return ("er " + renderSpelloutOrdinalMasculine(n)) if (n >= 1)
            return "te" if (n >= 0)
          end
          private(:renderOrdMascTeer)
          def renderSpelloutOrdinalFeminine(n)
            return renderSpelloutOrdinalNeuter(n) if (n >= 0)
          end
          def renderSpelloutOrdinalReale(n)
            return renderSpelloutOrdinalNeuter(n) if (n >= 0)
          end
          def renderDigitsOrdinalNeuter(n)
            return renderDigitsOrdinalFeminine(n) if (n >= 0)
          end
          def renderDigitsOrdinalMasculine(n)
            return ("−" + renderDigitsOrdinalMasculine(-n)) if (n < 0)
            return (n.to_s + renderDordMascabbrev(n)) if (n >= 0)
          end
          def renderDordMascabbrev(n)
            return ":e" if (n >= 0)
          end
          private(:renderDordMascabbrev)
          def renderDigitsOrdinalFeminine(n)
            return ("−" + renderDigitsOrdinalFeminine(-n)) if (n < 0)
            return (n.to_s + renderDordFemabbrev(n)) if (n >= 0)
          end
          def renderDordFemabbrev(n)
            return renderDordFemabbrev((n % 100)) if (n >= 100)
            return renderDordFemabbrev((n % 10)) if (n >= 20)
            return ":e" if (n >= 3)
            return ":a" if (n >= 2)
            return ":a" if (n >= 1)
            return ":e" if (n >= 0)
          end
          private(:renderDordFemabbrev)
          def renderDigitsOrdinalReale(n)
            return renderDigitsOrdinalFeminine(n) if (n >= 0)
          end
          def renderDigitsOrdinal(n)
            return renderDigitsOrdinalMasculine(n) if (n >= 0)
          end)
        end
      end
    end
  end
end