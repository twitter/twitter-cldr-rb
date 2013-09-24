# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:es] = Spanish = Class.new do
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
            return ("menos " + renderSpelloutNumbering(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((renderSpelloutNumbering(n.floor) + " coma ") + renderSpelloutNumbering(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2.0e+15).floor) + " billardos") + (if (n == 2000000000000000) then
                ""
              else
                (" " + renderSpelloutNumbering((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("un billardo" + (if (n == 1000000000000000) then
                ""
              else
                (" " + renderSpelloutNumbering((n % 100000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000000.0).floor) + " billiones") + (if (n == 2000000000000) then
                ""
              else
                (" " + renderSpelloutNumbering((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("un billón" + (if (n == 1000000000000) then
                ""
              else
                (" " + renderSpelloutNumbering((n % 100000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000.0).floor) + " millardos") + (if (n == 2000000000) then
                ""
              else
                (" " + renderSpelloutNumbering((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("un millardo" + (if (n == 1000000000) then
                ""
              else
                (" " + renderSpelloutNumbering((n % 100000000)))
              end))
            end
            if (n >= 2000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000.0).floor) + " millones") + ((n == 2000000) ? ("") : ((" " + renderSpelloutNumbering((n % 1000000))))))
            end
            if (n >= 1000000) then
              return ("un millón" + ((n == 1000000) ? ("") : ((" " + renderSpelloutNumbering((n % 100000))))))
            end
            if (n >= 2000) then
              return ((renderSpelloutCardinalMasculine((n / 2000.0).floor) + " mil") + ((n == 2000) ? ("") : ((" " + renderSpelloutNumbering((n % 1000))))))
            end
            if (n >= 1000) then
              return ("mil" + ((n == 1000) ? ("") : ((" " + renderSpelloutNumbering((n % 100))))))
            end
            if (n >= 900) then
              return ("novecientos" + ((n == 900) ? ("") : ((" " + renderSpelloutNumbering((n % 100))))))
            end
            if (n >= 800) then
              return ("ochocientos" + ((n == 800) ? ("") : ((" " + renderSpelloutNumbering((n % 100))))))
            end
            if (n >= 700) then
              return ("setecientos" + ((n == 700) ? ("") : ((" " + renderSpelloutNumbering((n % 100))))))
            end
            if (n >= 600) then
              return ("seiscientos" + ((n == 600) ? ("") : ((" " + renderSpelloutNumbering((n % 100))))))
            end
            if (n >= 500) then
              return ("quinientos" + ((n == 500) ? ("") : ((" " + renderSpelloutNumbering((n % 100))))))
            end
            if (n >= 400) then
              return ("cuatrocientos" + ((n == 400) ? ("") : ((" " + renderSpelloutNumbering((n % 100))))))
            end
            if (n >= 300) then
              return ("trescientos" + ((n == 300) ? ("") : ((" " + renderSpelloutNumbering((n % 100))))))
            end
            if (n >= 200) then
              return ("doscientos" + ((n == 200) ? ("") : ((" " + renderSpelloutNumbering((n % 100))))))
            end
            return ("ciento " + renderSpelloutNumbering((n % 100))) if (n >= 101)
            return "cien" if (n >= 100)
            if (n >= 90) then
              return ("noventa" + ((n == 90) ? ("") : ((" y " + renderSpelloutNumbering((n % 10))))))
            end
            if (n >= 80) then
              return ("ochenta" + ((n == 80) ? ("") : ((" y " + renderSpelloutNumbering((n % 10))))))
            end
            if (n >= 70) then
              return ("setenta" + ((n == 70) ? ("") : ((" y " + renderSpelloutNumbering((n % 10))))))
            end
            if (n >= 60) then
              return ("sesenta" + ((n == 60) ? ("") : ((" y " + renderSpelloutNumbering((n % 10))))))
            end
            if (n >= 50) then
              return ("cincuenta" + ((n == 50) ? ("") : ((" y " + renderSpelloutNumbering((n % 10))))))
            end
            if (n >= 40) then
              return ("cuarenta" + ((n == 40) ? ("") : ((" y " + renderSpelloutNumbering((n % 10))))))
            end
            if (n >= 30) then
              return ("treinta" + ((n == 30) ? ("") : ((" y " + renderSpelloutNumbering((n % 10))))))
            end
            return ("veinti" + renderSpelloutNumbering((n % 10))) if (n >= 27)
            return "veintiséis" if (n >= 26)
            return "veinticinco" if (n >= 25)
            return "veinticuatro" if (n >= 24)
            return "veintitrés" if (n >= 23)
            return "veintidós" if (n >= 22)
            return "veintiuno" if (n >= 21)
            return "veinte" if (n >= 20)
            return ("dieci" + renderSpelloutNumbering((n % 10))) if (n >= 17)
            return "dieciséis" if (n >= 16)
            return "quince" if (n >= 15)
            return "catorce" if (n >= 14)
            return "trece" if (n >= 13)
            return "doce" if (n >= 12)
            return "once" if (n >= 11)
            return "diez" if (n >= 10)
            return "nueve" if (n >= 9)
            return "ocho" if (n >= 8)
            return "siete" if (n >= 7)
            return "seis" if (n >= 6)
            return "cinco" if (n >= 5)
            return "cuatro" if (n >= 4)
            return "tres" if (n >= 3)
            return "dos" if (n >= 2)
            return "uno" if (n >= 1)
            return "cero" if (n >= 0)
          end
          def renderSpelloutCardinalMasculine(n)
            is_fractional = (n != n.floor)
            return ("menos " + renderSpelloutCardinalMasculine(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((renderSpelloutCardinalMasculine(n.floor) + " coma ") + renderSpelloutCardinalMasculine(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2.0e+15).floor) + " billardos") + (if (n == 2000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("un billardo" + (if (n == 1000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 100000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000000.0).floor) + " billiones") + (if (n == 2000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("un billón" + (if (n == 1000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 100000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000.0).floor) + " millardos") + (if (n == 2000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("un millardo" + (if (n == 1000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 100000000)))
              end))
            end
            if (n >= 2000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000.0).floor) + " millones") + (if (n == 2000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ("un millón" + (if (n == 1000000) then
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
            if (n >= 900) then
              return ("nove­cientos" + ((n == 900) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 800) then
              return ("ocho­cientos" + ((n == 800) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 700) then
              return ("sete­cientos" + ((n == 700) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 600) then
              return ("seis­cientos" + ((n == 600) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 500) then
              return ("quinientos" + ((n == 500) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 400) then
              return ("cuatrocientos" + ((n == 400) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 300) then
              return ("trescientos" + ((n == 300) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 200) then
              return ("doscientos" + ((n == 200) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 101) then
              return ("ciento " + renderSpelloutCardinalMasculine((n % 100)))
            end
            return "cien" if (n >= 100)
            if (n >= 90) then
              return ("noventa" + ((n == 90) ? ("") : ((" y " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 80) then
              return ("ochenta" + ((n == 80) ? ("") : ((" y " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 70) then
              return ("setenta" + ((n == 70) ? ("") : ((" y " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 60) then
              return ("sesenta" + ((n == 60) ? ("") : ((" y " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 50) then
              return ("cincuenta" + ((n == 50) ? ("") : ((" y " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 40) then
              return ("cuarenta" + ((n == 40) ? ("") : ((" y " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 30) then
              return ("treinta" + ((n == 30) ? ("") : ((" y " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            return renderSpelloutNumbering(n) if (n >= 22)
            return "veintiún" if (n >= 21)
            return renderSpelloutNumbering(n) if (n >= 2)
            return "un" if (n >= 1)
            return "cero" if (n >= 0)
          end
          def renderSpelloutCardinalFeminine(n)
            is_fractional = (n != n.floor)
            return ("menos " + renderSpelloutCardinalFeminine(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((renderSpelloutCardinalFeminine(n.floor) + " coma ") + renderSpelloutCardinalFeminine(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2.0e+15).floor) + " billardos") + (if (n == 2000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("un billardo" + (if (n == 1000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 100000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000000.0).floor) + " billiones") + (if (n == 2000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("un billón" + (if (n == 1000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 100000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000.0).floor) + " millardos") + (if (n == 2000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("un millardo" + (if (n == 1000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 100000000)))
              end))
            end
            if (n >= 2000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000.0).floor) + " millones") + (if (n == 2000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ("un millón" + (if (n == 1000000) then
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
            if (n >= 900) then
              return ("nove­cientas" + ((n == 900) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 800) then
              return ("ocho­cientas" + ((n == 800) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 700) then
              return ("sete­cientas" + ((n == 700) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 600) then
              return ("seis­cientas" + ((n == 600) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 500) then
              return ("quinientas" + ((n == 500) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 400) then
              return ("cuatro­cientas" + ((n == 400) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 300) then
              return ("tres­cientas" + ((n == 300) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 200) then
              return ("dos­cientas" + ((n == 200) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 101) then
              return ("cienta " + renderSpelloutCardinalFeminine((n % 100)))
            end
            return "cien" if (n >= 100)
            if (n >= 90) then
              return ("noventa" + ((n == 90) ? ("") : ((" y " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 80) then
              return ("ochenta" + ((n == 80) ? ("") : ((" y " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 70) then
              return ("setenta" + ((n == 70) ? ("") : ((" y " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 60) then
              return ("sesenta" + ((n == 60) ? ("") : ((" y " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 50) then
              return ("cincuenta" + ((n == 50) ? ("") : ((" y " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 40) then
              return ("cuarenta" + ((n == 40) ? ("") : ((" y " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 30) then
              return ("treinta" + ((n == 30) ? ("") : ((" y " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            return renderSpelloutNumbering(n) if (n >= 22)
            return "veintiuna" if (n >= 21)
            return renderSpelloutNumbering(n) if (n >= 2)
            return "una" if (n >= 1)
            return "cero" if (n >= 0)
          end
          def renderSpelloutOrdinalMasculineAdjective(n)
            is_fractional = (n != n.floor)
            return ("menos " + renderSpelloutOrdinalMasculineAdjective(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return (n.to_s + "º") if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2.0e+15).floor) + " billardésimo") + (if (n == 2000000000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalMasculineAdjective((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("un billardésimo" + (if (n == 1000000000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalMasculineAdjective((n % 100000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000000.0).floor) + " billonésimo") + (if (n == 2000000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalMasculineAdjective((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("un billonésimo" + (if (n == 1000000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalMasculineAdjective((n % 100000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000.0).floor) + " millardésimo") + (if (n == 2000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalMasculineAdjective((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("un millardésimo" + (if (n == 1000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalMasculineAdjective((n % 100000000)))
              end))
            end
            if (n >= 2000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000.0).floor) + " millonésimo") + (if (n == 2000000) then
                ""
              else
                (" " + renderSpelloutOrdinalMasculineAdjective((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ("un millonésimo" + (if (n == 1000000) then
                ""
              else
                (" " + renderSpelloutOrdinalMasculineAdjective((n % 100000)))
              end))
            end
            if (n >= 2000) then
              return ((renderSpelloutCardinalMasculine((n / 2000.0).floor) + " milésimo") + (if (n == 2000) then
                ""
              else
                (" " + renderSpelloutOrdinalMasculineAdjective((n % 1000)))
              end))
            end
            if (n >= 1000) then
              return ("milésimo" + (if (n == 1000) then
                ""
              else
                (" " + renderSpelloutOrdinalMasculineAdjective((n % 100)))
              end))
            end
            if (n >= 900) then
              return ("noningentésimo" + (if (n == 900) then
                ""
              else
                (" " + renderSpelloutOrdinalMasculineAdjective((n % 100)))
              end))
            end
            if (n >= 800) then
              return ("octingésimo" + (if (n == 800) then
                ""
              else
                (" " + renderSpelloutOrdinalMasculineAdjective((n % 100)))
              end))
            end
            if (n >= 700) then
              return ("septingentésimo" + (if (n == 700) then
                ""
              else
                (" " + renderSpelloutOrdinalMasculineAdjective((n % 100)))
              end))
            end
            if (n >= 600) then
              return ("sexcentésimo" + (if (n == 600) then
                ""
              else
                (" " + renderSpelloutOrdinalMasculineAdjective((n % 100)))
              end))
            end
            if (n >= 500) then
              return ("quingentésimo" + (if (n == 500) then
                ""
              else
                (" " + renderSpelloutOrdinalMasculineAdjective((n % 100)))
              end))
            end
            if (n >= 400) then
              return ("cuadringentésimo" + (if (n == 400) then
                ""
              else
                (" " + renderSpelloutOrdinalMasculineAdjective((n % 100)))
              end))
            end
            if (n >= 300) then
              return ("tricentésimo" + (if (n == 300) then
                ""
              else
                (" " + renderSpelloutOrdinalMasculineAdjective((n % 100)))
              end))
            end
            if (n >= 200) then
              return ("ducentésimo" + (if (n == 200) then
                ""
              else
                (" " + renderSpelloutOrdinalMasculineAdjective((n % 100)))
              end))
            end
            if (n >= 100) then
              return ("centésimo" + (if (n == 100) then
                ""
              else
                (" " + renderSpelloutOrdinalMasculineAdjective((n % 100)))
              end))
            end
            if (n >= 90) then
              return ("nonagésimo" + (if (n == 90) then
                ""
              else
                (" " + renderSpelloutOrdinalMasculineAdjective((n % 10)))
              end))
            end
            if (n >= 80) then
              return ("octogésimo" + (if (n == 80) then
                ""
              else
                (" " + renderSpelloutOrdinalMasculineAdjective((n % 10)))
              end))
            end
            if (n >= 70) then
              return ("septuagésimo" + (if (n == 70) then
                ""
              else
                (" " + renderSpelloutOrdinalMasculineAdjective((n % 10)))
              end))
            end
            if (n >= 60) then
              return ("sexagésimo" + (if (n == 60) then
                ""
              else
                (" " + renderSpelloutOrdinalMasculineAdjective((n % 10)))
              end))
            end
            if (n >= 50) then
              return ("quincuagésimo" + (if (n == 50) then
                ""
              else
                (" " + renderSpelloutOrdinalMasculineAdjective((n % 10)))
              end))
            end
            if (n >= 40) then
              return ("cuadragésimo" + (if (n == 40) then
                ""
              else
                (" " + renderSpelloutOrdinalMasculineAdjective((n % 10)))
              end))
            end
            if (n >= 30) then
              return ("trigésimo" + (if (n == 30) then
                ""
              else
                (" " + renderSpelloutOrdinalMasculineAdjective((n % 10)))
              end))
            end
            if (n >= 20) then
              return ("vigésimo" + (if (n == 20) then
                ""
              else
                (" " + renderSpelloutOrdinalMasculineAdjective((n % 10)))
              end))
            end
            if (n >= 13) then
              return ("decimo" + renderSpelloutOrdinalMasculineAdjective((n % 10)))
            end
            return "duodécimo" if (n >= 12)
            return "undécimo" if (n >= 11)
            return "décimo" if (n >= 10)
            return "noveno" if (n >= 9)
            return "octavo" if (n >= 8)
            return "séptimo" if (n >= 7)
            return "sexto" if (n >= 6)
            return "quinto" if (n >= 5)
            return "cuarto" if (n >= 4)
            return "tercer" if (n >= 3)
            return "segundo" if (n >= 2)
            return "primer" if (n >= 1)
            return "cero" if (n >= 0)
          end
          def renderSpelloutOrdinalMasculinePlural(n)
            is_fractional = (n != n.floor)
            return n.to_s if is_fractional and (n > 1)
            return (n.to_s + "º") if (n >= 1000000000000000000)
            return (renderSpelloutOrdinalMasculine(n) + "s") if (n >= 1)
            return renderSpelloutOrdinalMasculine(n) if (n >= 0)
          end
          def renderSpelloutOrdinalMasculine(n)
            is_fractional = (n != n.floor)
            return ("menos " + renderSpelloutOrdinalMasculine(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return (n.to_s + "º") if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2.0e+15).floor) + " billardésimo") + (if (n == 2000000000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalMasculine((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("un billardésimo" + (if (n == 1000000000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalMasculine((n % 100000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000000.0).floor) + " billonésimo") + (if (n == 2000000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalMasculine((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("un billonésimo" + (if (n == 1000000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalMasculine((n % 100000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000.0).floor) + " millardésimo") + (if (n == 2000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalMasculine((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("un millardésimo" + (if (n == 1000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalMasculine((n % 100000000)))
              end))
            end
            if (n >= 2000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000.0).floor) + " millonésimo") + (if (n == 2000000) then
                ""
              else
                (" " + renderSpelloutOrdinalMasculine((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ("un millonésimo" + (if (n == 1000000) then
                ""
              else
                (" " + renderSpelloutOrdinalMasculine((n % 100000)))
              end))
            end
            if (n >= 2000) then
              return ((renderSpelloutCardinalMasculine((n / 2000.0).floor) + " milésimo") + ((n == 2000) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 1000))))))
            end
            if (n >= 1000) then
              return ("milésimo" + ((n == 1000) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 100))))))
            end
            if (n >= 900) then
              return ("noningentésimo" + ((n == 900) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 100))))))
            end
            if (n >= 800) then
              return ("octingésimo" + ((n == 800) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 100))))))
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
              return ("cuadringentésimo" + ((n == 400) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 100))))))
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
              return ("quincuagésimo" + ((n == 50) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 10))))))
            end
            if (n >= 40) then
              return ("cuadragésimo" + ((n == 40) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 10))))))
            end
            if (n >= 30) then
              return ("trigésimo" + ((n == 30) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 10))))))
            end
            if (n >= 20) then
              return ("vigésimo" + ((n == 20) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 10))))))
            end
            return ("decimo" + renderSpelloutOrdinalMasculine((n % 10))) if (n >= 13)
            return "duodécimo" if (n >= 12)
            return "undécimo" if (n >= 11)
            return "décimo" if (n >= 10)
            return "noveno" if (n >= 9)
            return "octavo" if (n >= 8)
            return "séptimo" if (n >= 7)
            return "sexto" if (n >= 6)
            return "quinto" if (n >= 5)
            return "cuarto" if (n >= 4)
            return "tercero" if (n >= 3)
            return "segundo" if (n >= 2)
            return "primero" if (n >= 1)
            return "cero" if (n >= 0)
          end
          def renderSpelloutOrdinalFemininePlural(n)
            is_fractional = (n != n.floor)
            return n.to_s if is_fractional and (n > 1)
            return (n.to_s + "ª") if (n >= 1000000000000000000)
            return (renderSpelloutOrdinalFeminine(n) + "s") if (n >= 1)
            return renderSpelloutOrdinalFeminine(n) if (n >= 0)
          end
          def renderSpelloutOrdinalFeminine(n)
            is_fractional = (n != n.floor)
            return ("menos " + renderSpelloutOrdinalFeminine(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return (n.to_s + "ª") if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2.0e+15).floor) + " billardésima") + (if (n == 2000000000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalFeminine((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("un billardésima" + (if (n == 1000000000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalFeminine((n % 100000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000000.0).floor) + " billonésima") + (if (n == 2000000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalFeminine((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("un billonésima" + (if (n == 1000000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalFeminine((n % 100000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000.0).floor) + " millardésima") + (if (n == 2000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalFeminine((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("un millardésimo" + (if (n == 1000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalFeminine((n % 100000000)))
              end))
            end
            if (n >= 2000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000.0).floor) + " millonésima") + (if (n == 2000000) then
                ""
              else
                (" " + renderSpelloutOrdinalFeminine((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ("un millonésima" + (if (n == 1000000) then
                ""
              else
                (" " + renderSpelloutOrdinalFeminine((n % 100000)))
              end))
            end
            if (n >= 2000) then
              return ((renderSpelloutCardinalMasculine((n / 2000.0).floor) + " milésima") + ((n == 2000) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 1000))))))
            end
            if (n >= 1000) then
              return ("milésima" + ((n == 1000) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 100))))))
            end
            if (n >= 900) then
              return ("noningentésima" + ((n == 900) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 100))))))
            end
            if (n >= 800) then
              return ("octingésima" + ((n == 800) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 100))))))
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
              return ("cuadringentésima" + ((n == 400) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 100))))))
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
              return ("quincuagésima" + ((n == 50) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 10))))))
            end
            if (n >= 40) then
              return ("cuadragésima" + ((n == 40) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 10))))))
            end
            if (n >= 30) then
              return ("trigésima" + ((n == 30) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 10))))))
            end
            if (n >= 20) then
              return ("vigésima" + ((n == 20) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 10))))))
            end
            return ("decima" + renderSpelloutOrdinalFeminine((n % 10))) if (n >= 13)
            return "duodécima" if (n >= 12)
            return "undécima" if (n >= 11)
            return "décima" if (n >= 10)
            return "novena" if (n >= 9)
            return "octava" if (n >= 8)
            return "séptima" if (n >= 7)
            return "sexta" if (n >= 6)
            return "quinta" if (n >= 5)
            return "cuarta" if (n >= 4)
            return "tercera" if (n >= 3)
            return "segunda" if (n >= 2)
            return "primera" if (n >= 1)
            return "cero" if (n >= 0)
          end
          def renderDordMascabbrev(n)
            return renderDordMascabbrev((n % 100)) if (n >= 100)
            return renderDordMascabbrev((n % 10)) if (n >= 20)
            return "º" if (n >= 4)
            return "ᵉʳ" if (n >= 3)
            return "º" if (n >= 2)
            return "ᵉʳ" if (n >= 1)
            return "º" if (n >= 0)
          end
          private(:renderDordMascabbrev)
          def renderDigitsOrdinalMasculineAdjective(n)
            return ("−" + renderDigitsOrdinalMasculineAdjective(-n)) if (n < 0)
            return (n.to_s + renderDordMascabbrev(n)) if (n >= 0)
          end
          def renderDigitsOrdinalMasculine(n)
            return ("−" + renderDigitsOrdinalMasculine(-n)) if (n < 0)
            return (n.to_s + "º") if (n >= 0)
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