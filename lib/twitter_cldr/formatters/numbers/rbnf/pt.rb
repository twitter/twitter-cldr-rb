# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:pt] = Portuguese = Class.new do
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
            return renderSpelloutCardinalMasculine(n) if (n >= 0)
          end
          def renderSpelloutCardinalMasculine(n)
            is_fractional = (n != n.floor)
            return ("menos " + renderSpelloutCardinalMasculine(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((renderSpelloutCardinalMasculine(n.floor) + " vírgula ") + renderSpelloutCardinalMasculine(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2.0e+15).floor) + " quatrilhões") + (if (n == 2000000000000000) then
                ""
              else
                (" e " + renderSpelloutCardinalMasculine((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("um quatrilhão" + (if (n == 1000000000000000) then
                ""
              else
                (" e " + renderSpelloutCardinalMasculine((n % 100000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000000.0).floor) + " trilhões") + (if (n == 2000000000000) then
                ""
              else
                (" e " + renderSpelloutCardinalMasculine((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("um trilhão" + (if (n == 1000000000000) then
                ""
              else
                (" e " + renderSpelloutCardinalMasculine((n % 100000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000.0).floor) + " bilhões") + (if (n == 2000000000) then
                ""
              else
                (" e " + renderSpelloutCardinalMasculine((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("um bilhão" + (if (n == 1000000000) then
                ""
              else
                (" e " + renderSpelloutCardinalMasculine((n % 100000000)))
              end))
            end
            if (n >= 2000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000.0).floor) + " milhões") + (if (n == 2000000) then
                ""
              else
                (" e " + renderSpelloutCardinalMasculine((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ("um milhão" + (if (n == 1000000) then
                ""
              else
                (" e " + renderSpelloutCardinalMasculine((n % 100000)))
              end))
            end
            if (n >= 2000) then
              return ((renderSpelloutCardinalMasculine((n / 2000.0).floor) + " mil") + (if (n == 2000) then
                ""
              else
                (" e " + renderSpelloutCardinalMasculine((n % 1000)))
              end))
            end
            if (n >= 1000) then
              return ("mil" + ((n == 1000) ? ("") : ((" e " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 900) then
              return ("novecentos" + ((n == 900) ? ("") : ((" e " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 800) then
              return ("oitocentos" + ((n == 800) ? ("") : ((" e " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 700) then
              return ("setecentos" + ((n == 700) ? ("") : ((" e " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 600) then
              return ("seiscentos" + ((n == 600) ? ("") : ((" e " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 500) then
              return ("quinhentos" + ((n == 500) ? ("") : ((" e " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 400) then
              return ("quatrocentos" + ((n == 400) ? ("") : ((" e " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 300) then
              return ("trezentos" + ((n == 300) ? ("") : ((" e " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 200) then
              return ("duzentos" + ((n == 200) ? ("") : ((" e " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 101) then
              return ("cento e " + renderSpelloutCardinalMasculine((n % 100)))
            end
            return "cem" if (n >= 100)
            if (n >= 90) then
              return ("noventa" + ((n == 90) ? ("") : ((" e " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 80) then
              return ("oitenta" + ((n == 80) ? ("") : ((" e " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 70) then
              return ("setenta" + ((n == 70) ? ("") : ((" e " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 60) then
              return ("sessenta" + ((n == 60) ? ("") : ((" e " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 50) then
              return ("cinquenta" + ((n == 50) ? ("") : ((" e " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 40) then
              return ("quarenta" + ((n == 40) ? ("") : ((" e " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 30) then
              return ("trinta" + ((n == 30) ? ("") : ((" e " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 20) then
              return ("vinte" + ((n == 20) ? ("") : ((" e " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            return "dezenove" if (n >= 19)
            return "dezoito" if (n >= 18)
            return "dezessete" if (n >= 17)
            return "dezesseis" if (n >= 16)
            return "quinze" if (n >= 15)
            return "catorze" if (n >= 14)
            return "treze" if (n >= 13)
            return "doze" if (n >= 12)
            return "onze" if (n >= 11)
            return "dez" if (n >= 10)
            return "nove" if (n >= 9)
            return "oito" if (n >= 8)
            return "sete" if (n >= 7)
            return "seis" if (n >= 6)
            return "cinco" if (n >= 5)
            return "quatro" if (n >= 4)
            return "três" if (n >= 3)
            return "dois" if (n >= 2)
            return "um" if (n >= 1)
            return "zero" if (n >= 0)
          end
          def renderSpelloutCardinalFeminine(n)
            is_fractional = (n != n.floor)
            return ("menos " + renderSpelloutCardinalFeminine(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((renderSpelloutCardinalFeminine(n.floor) + " vírgula ") + renderSpelloutCardinalFeminine(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2.0e+15).floor) + " quatrilhões") + (if (n == 2000000000000000) then
                ""
              else
                (" e " + renderSpelloutCardinalFeminine((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("um quatrilhão" + (if (n == 1000000000000000) then
                ""
              else
                (" e " + renderSpelloutCardinalFeminine((n % 100000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000000.0).floor) + " trilhões") + (if (n == 2000000000000) then
                ""
              else
                (" e " + renderSpelloutCardinalFeminine((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("um trilhão" + (if (n == 1000000000000) then
                ""
              else
                (" e " + renderSpelloutCardinalFeminine((n % 100000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000.0).floor) + " bilhões") + (if (n == 2000000000) then
                ""
              else
                (" e " + renderSpelloutCardinalFeminine((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("um bilhão" + (if (n == 1000000000) then
                ""
              else
                (" e " + renderSpelloutCardinalFeminine((n % 100000000)))
              end))
            end
            if (n >= 2000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000.0).floor) + " milhões") + (if (n == 2000000) then
                ""
              else
                (" e " + renderSpelloutCardinalFeminine((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ("um milhão" + (if (n == 1000000) then
                ""
              else
                (" e " + renderSpelloutCardinalFeminine((n % 100000)))
              end))
            end
            if (n >= 2000) then
              return ((renderSpelloutCardinalMasculine((n / 2000.0).floor) + " mil") + ((n == 2000) ? ("") : ((" e " + renderSpelloutCardinalFeminine((n % 1000))))))
            end
            if (n >= 1000) then
              return ("mil" + ((n == 1000) ? ("") : ((" e " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 900) then
              return ("novecentas" + ((n == 900) ? ("") : ((" e " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 800) then
              return ("oitocentas" + ((n == 800) ? ("") : ((" e " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 700) then
              return ("setecentas" + ((n == 700) ? ("") : ((" e " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 600) then
              return ("seiscentas" + ((n == 600) ? ("") : ((" e " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 500) then
              return ("quinhentas" + ((n == 500) ? ("") : ((" e " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 400) then
              return ("quatrocentas" + ((n == 400) ? ("") : ((" e " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 300) then
              return ("trezentas" + ((n == 300) ? ("") : ((" e " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 200) then
              return ("duzentas" + ((n == 200) ? ("") : ((" e " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 101) then
              return ("cento e " + renderSpelloutCardinalFeminine((n % 100)))
            end
            return "cem" if (n >= 100)
            if (n >= 90) then
              return ("noventa" + ((n == 90) ? ("") : ((" e " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 80) then
              return ("oitenta" + ((n == 80) ? ("") : ((" e " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 70) then
              return ("setenta" + ((n == 70) ? ("") : ((" e " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 60) then
              return ("sessenta" + ((n == 60) ? ("") : ((" e " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 50) then
              return ("cinquenta" + ((n == 50) ? ("") : ((" e " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 40) then
              return ("quarenta" + ((n == 40) ? ("") : ((" e " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 30) then
              return ("trinta" + ((n == 30) ? ("") : ((" e " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 20) then
              return ("vinte" + ((n == 20) ? ("") : ((" e " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            return renderSpelloutCardinalMasculine(n) if (n >= 3)
            return "duas" if (n >= 2)
            return "uma" if (n >= 1)
            return "zero" if (n >= 0)
          end
          def renderSpelloutOrdinalMasculine(n)
            is_fractional = (n != n.floor)
            return ("menos " + renderSpelloutOrdinalMasculine(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return (n.to_s + "º") if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2.0e+15).floor) + " quadrilionésimo") + (if (n == 2000000000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalMasculine((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("um quadrilionésimo" + (if (n == 1000000000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalMasculine((n % 100000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000000.0).floor) + " trilionésima") + (if (n == 2000000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalMasculine((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("um trilionésimo" + (if (n == 1000000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalMasculine((n % 100000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000.0).floor) + " bilionésimo") + (if (n == 2000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalMasculine((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("um bilionésimo" + (if (n == 1000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalMasculine((n % 100000000)))
              end))
            end
            if (n >= 2000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000.0).floor) + " milionésimo") + (if (n == 2000000) then
                ""
              else
                (" " + renderSpelloutOrdinalMasculine((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ("um milionésimo" + (if (n == 1000000) then
                ""
              else
                (" " + renderSpelloutOrdinalMasculine((n % 100000)))
              end))
            end
            if (n >= 2000) then
              return ((renderSpelloutCardinalMasculine((n / 2000.0).floor) + " ­milésimo") + ((n == 2000) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 1000))))))
            end
            if (n >= 1000) then
              return ("milésimo" + ((n == 1000) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 100))))))
            end
            if (n >= 900) then
              return ("noningentésimo" + ((n == 900) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 100))))))
            end
            if (n >= 800) then
              return ("octingentésimo" + ((n == 800) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 100))))))
            end
            if (n >= 700) then
              return ("septingentésimo" + ((n == 700) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 100))))))
            end
            if (n >= 600) then
              return ("sexcentésimo" + ((n == 600) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 100))))))
            end
            if (n >= 500) then
              return ("quingentésimo" + ((n == 500) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 100))))))
            end
            if (n >= 400) then
              return ("quadringentésimo" + ((n == 400) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 100))))))
            end
            if (n >= 300) then
              return ("tricentésimo" + ((n == 300) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 100))))))
            end
            if (n >= 200) then
              return ("ducentésimo" + ((n == 200) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 100))))))
            end
            if (n >= 100) then
              return ("centésimo" + ((n == 100) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 100))))))
            end
            if (n >= 90) then
              return ("nonagésimo" + ((n == 90) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 10))))))
            end
            if (n >= 80) then
              return ("octogésimo" + ((n == 80) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 10))))))
            end
            if (n >= 70) then
              return ("septuagésimo" + ((n == 70) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 10))))))
            end
            if (n >= 60) then
              return ("sexagésimo" + ((n == 60) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 10))))))
            end
            if (n >= 50) then
              return ("quinquagésimo" + ((n == 50) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 10))))))
            end
            if (n >= 40) then
              return ("quadragésimo" + ((n == 40) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 10))))))
            end
            if (n >= 30) then
              return ("trigésimo" + ((n == 30) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 10))))))
            end
            if (n >= 20) then
              return ("vigésimo" + ((n == 20) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 10))))))
            end
            if (n >= 10) then
              return ("décimo" + ((n == 10) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 10))))))
            end
            return "nono" if (n >= 9)
            return "oitavo" if (n >= 8)
            return "sétimo" if (n >= 7)
            return "sexto" if (n >= 6)
            return "quinto" if (n >= 5)
            return "quarto" if (n >= 4)
            return "terceiro" if (n >= 3)
            return "segundo" if (n >= 2)
            return "primeiro" if (n >= 1)
            return "zero" if (n >= 0)
          end
          def renderSpelloutOrdinalFeminine(n)
            is_fractional = (n != n.floor)
            return ("menos " + renderSpelloutOrdinalFeminine(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return (n.to_s + "ª") if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((renderSpelloutCardinalFeminine((n / 2.0e+15).floor) + " quadrilionésima") + (if (n == 2000000000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalFeminine((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("uma quadrilionésima" + (if (n == 1000000000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalFeminine((n % 100000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((renderSpelloutCardinalFeminine((n / 2000000000000.0).floor) + " trilionésima") + (if (n == 2000000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalFeminine((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("uma trilionésima" + (if (n == 1000000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalFeminine((n % 100000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((renderSpelloutCardinalFeminine((n / 2000000000.0).floor) + " bilionésima") + (if (n == 2000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalFeminine((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("uma bilionésima" + (if (n == 1000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalFeminine((n % 100000000)))
              end))
            end
            if (n >= 2000000) then
              return ((renderSpelloutCardinalFeminine((n / 2000000.0).floor) + " milionésima") + (if (n == 2000000) then
                ""
              else
                (" " + renderSpelloutOrdinalFeminine((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ("uma milionésima" + (if (n == 1000000) then
                ""
              else
                (" " + renderSpelloutOrdinalFeminine((n % 100000)))
              end))
            end
            if (n >= 2000) then
              return ((renderSpelloutCardinalFeminine((n / 2000.0).floor) + " ­milésima") + ((n == 2000) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 1000))))))
            end
            if (n >= 1000) then
              return ("milésima" + ((n == 1000) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 100))))))
            end
            if (n >= 900) then
              return ("noningentésima" + ((n == 900) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 100))))))
            end
            if (n >= 800) then
              return ("octingentésima" + ((n == 800) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 100))))))
            end
            if (n >= 700) then
              return ("septingentésima" + ((n == 700) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 100))))))
            end
            if (n >= 600) then
              return ("sexcentésima" + ((n == 600) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 100))))))
            end
            if (n >= 500) then
              return ("quingentésima" + ((n == 500) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 100))))))
            end
            if (n >= 400) then
              return ("quadringentésima" + ((n == 400) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 100))))))
            end
            if (n >= 300) then
              return ("tricentésima" + ((n == 300) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 100))))))
            end
            if (n >= 200) then
              return ("ducentésima" + ((n == 200) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 100))))))
            end
            if (n >= 100) then
              return ("centésima" + ((n == 100) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 100))))))
            end
            if (n >= 90) then
              return ("nonagésima" + ((n == 90) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 10))))))
            end
            if (n >= 80) then
              return ("octogésima" + ((n == 80) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 10))))))
            end
            if (n >= 70) then
              return ("septuagésima" + ((n == 70) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 10))))))
            end
            if (n >= 60) then
              return ("sexagésima" + ((n == 60) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 10))))))
            end
            if (n >= 50) then
              return ("quinquagésima" + ((n == 50) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 10))))))
            end
            if (n >= 40) then
              return ("quadragésima" + ((n == 40) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 10))))))
            end
            if (n >= 30) then
              return ("trigésima" + ((n == 30) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 10))))))
            end
            if (n >= 20) then
              return ("vigésima" + ((n == 20) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 10))))))
            end
            if (n >= 10) then
              return ("décima" + ((n == 10) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 10))))))
            end
            return "nona" if (n >= 9)
            return "oitava" if (n >= 8)
            return "sétima" if (n >= 7)
            return "sexta" if (n >= 6)
            return "quinta" if (n >= 5)
            return "quarta" if (n >= 4)
            return "terceira" if (n >= 3)
            return "segunda" if (n >= 2)
            return "primeira" if (n >= 1)
            return "zero" if (n >= 0)
          end
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