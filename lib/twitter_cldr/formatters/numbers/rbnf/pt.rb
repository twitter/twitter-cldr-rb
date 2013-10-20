# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:pt] = Portuguese = Module.new { }
      
      class Portuguese::Spellout
        class << self
          def format_lenient_parse(n)
            if (n >= 0) then
              return (((((((((((((n == 0) or ((n % 10) == 0)) ? ("") : ("last primary ignorable ")) + " ") + format_lenient_parse((n / 10).floor)) + " ' ' ") + format_lenient_parse((n / 10).floor)) + " '") + "' ") + format_lenient_parse((n / 10).floor)) + " '-' ") + format_lenient_parse((n / 10).floor)) + " '­'")
            end
          end
          private(:format_lenient_parse)
          def format_spellout_numbering_year(n)
            is_fractional = (n != n.floor)
            return n.to_s if is_fractional and (n > 1)
            return format_spellout_numbering(n) if (n >= 0)
          end
          def format_spellout_numbering(n)
            return format_spellout_cardinal_masculine(n) if (n >= 0)
          end
          def format_spellout_cardinal_masculine(n)
            is_fractional = (n != n.floor)
            return ("menos " + format_spellout_cardinal_masculine(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_cardinal_masculine(n.floor) + " vírgula ") + format_spellout_cardinal_masculine((n % 10)))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000000000).floor) + " quatrilhões") + (if ((n == 2000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" e " + format_spellout_cardinal_masculine((n % 10000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("um quatrilhão" + (if ((n == 1000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" e " + format_spellout_cardinal_masculine((n % 1000000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000000).floor) + " trilhões") + (if ((n == 2000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" e " + format_spellout_cardinal_masculine((n % 10000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("um trilhão" + (if ((n == 1000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" e " + format_spellout_cardinal_masculine((n % 1000000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000).floor) + " bilhões") + (if ((n == 2000000000) or ((n % 10) == 0)) then
                ""
              else
                (" e " + format_spellout_cardinal_masculine((n % 10000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("um bilhão" + (if ((n == 1000000000) or ((n % 10) == 0)) then
                ""
              else
                (" e " + format_spellout_cardinal_masculine((n % 1000000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000).floor) + " milhões") + (if ((n == 2000000) or ((n % 10) == 0)) then
                ""
              else
                (" e " + format_spellout_cardinal_masculine((n % 10000000)))
              end))
            end
            if (n >= 1000000) then
              return ("um milhão" + (if ((n == 1000000) or ((n % 10) == 0)) then
                ""
              else
                (" e " + format_spellout_cardinal_masculine((n % 1000000)))
              end))
            end
            if (n >= 2000) then
              return ((format_spellout_cardinal_masculine((n / 10000).floor) + " mil") + (if ((n == 2000) or ((n % 10) == 0)) then
                ""
              else
                (" e " + format_spellout_cardinal_masculine((n % 10000)))
              end))
            end
            if (n >= 1000) then
              return ("mil" + (if ((n == 1000) or ((n % 10) == 0)) then
                ""
              else
                (" e " + format_spellout_cardinal_masculine((n % 1000)))
              end))
            end
            if (n >= 900) then
              return ("novecentos" + (if ((n == 900) or ((n % 10) == 0)) then
                ""
              else
                (" e " + format_spellout_cardinal_masculine((n % 1000)))
              end))
            end
            if (n >= 800) then
              return ("oitocentos" + (if ((n == 800) or ((n % 10) == 0)) then
                ""
              else
                (" e " + format_spellout_cardinal_masculine((n % 1000)))
              end))
            end
            if (n >= 700) then
              return ("setecentos" + (if ((n == 700) or ((n % 10) == 0)) then
                ""
              else
                (" e " + format_spellout_cardinal_masculine((n % 1000)))
              end))
            end
            if (n >= 600) then
              return ("seiscentos" + (if ((n == 600) or ((n % 10) == 0)) then
                ""
              else
                (" e " + format_spellout_cardinal_masculine((n % 1000)))
              end))
            end
            if (n >= 500) then
              return ("quinhentos" + (if ((n == 500) or ((n % 10) == 0)) then
                ""
              else
                (" e " + format_spellout_cardinal_masculine((n % 1000)))
              end))
            end
            if (n >= 400) then
              return ("quatrocentos" + (if ((n == 400) or ((n % 10) == 0)) then
                ""
              else
                (" e " + format_spellout_cardinal_masculine((n % 1000)))
              end))
            end
            if (n >= 300) then
              return ("trezentos" + (if ((n == 300) or ((n % 10) == 0)) then
                ""
              else
                (" e " + format_spellout_cardinal_masculine((n % 1000)))
              end))
            end
            if (n >= 200) then
              return ("duzentos" + (if ((n == 200) or ((n % 10) == 0)) then
                ""
              else
                (" e " + format_spellout_cardinal_masculine((n % 1000)))
              end))
            end
            if (n >= 101) then
              return ("cento e " + format_spellout_cardinal_masculine((n % 1000)))
            end
            return "cem" if (n >= 100)
            if (n >= 90) then
              return ("noventa" + (if ((n == 90) or ((n % 10) == 0)) then
                ""
              else
                (" e " + format_spellout_cardinal_masculine((n % 100)))
              end))
            end
            if (n >= 80) then
              return ("oitenta" + (if ((n == 80) or ((n % 10) == 0)) then
                ""
              else
                (" e " + format_spellout_cardinal_masculine((n % 100)))
              end))
            end
            if (n >= 70) then
              return ("setenta" + (if ((n == 70) or ((n % 10) == 0)) then
                ""
              else
                (" e " + format_spellout_cardinal_masculine((n % 100)))
              end))
            end
            if (n >= 60) then
              return ("sessenta" + (if ((n == 60) or ((n % 10) == 0)) then
                ""
              else
                (" e " + format_spellout_cardinal_masculine((n % 100)))
              end))
            end
            if (n >= 50) then
              return ("cinquenta" + (if ((n == 50) or ((n % 10) == 0)) then
                ""
              else
                (" e " + format_spellout_cardinal_masculine((n % 100)))
              end))
            end
            if (n >= 40) then
              return ("quarenta" + (if ((n == 40) or ((n % 10) == 0)) then
                ""
              else
                (" e " + format_spellout_cardinal_masculine((n % 100)))
              end))
            end
            if (n >= 30) then
              return ("trinta" + (if ((n == 30) or ((n % 10) == 0)) then
                ""
              else
                (" e " + format_spellout_cardinal_masculine((n % 100)))
              end))
            end
            if (n >= 20) then
              return ("vinte" + (if ((n == 20) or ((n % 10) == 0)) then
                ""
              else
                (" e " + format_spellout_cardinal_masculine((n % 100)))
              end))
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
          def format_spellout_cardinal_feminine(n)
            is_fractional = (n != n.floor)
            return ("menos " + format_spellout_cardinal_feminine(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_cardinal_feminine(n.floor) + " vírgula ") + format_spellout_cardinal_feminine((n % 10)))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000000000).floor) + " quatrilhões") + (if ((n == 2000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" e " + format_spellout_cardinal_feminine((n % 10000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("um quatrilhão" + (if ((n == 1000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" e " + format_spellout_cardinal_feminine((n % 1000000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000000).floor) + " trilhões") + (if ((n == 2000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" e " + format_spellout_cardinal_feminine((n % 10000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("um trilhão" + (if ((n == 1000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" e " + format_spellout_cardinal_feminine((n % 1000000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000).floor) + " bilhões") + (if ((n == 2000000000) or ((n % 10) == 0)) then
                ""
              else
                (" e " + format_spellout_cardinal_feminine((n % 10000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("um bilhão" + (if ((n == 1000000000) or ((n % 10) == 0)) then
                ""
              else
                (" e " + format_spellout_cardinal_feminine((n % 1000000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000).floor) + " milhões") + (if ((n == 2000000) or ((n % 10) == 0)) then
                ""
              else
                (" e " + format_spellout_cardinal_feminine((n % 10000000)))
              end))
            end
            if (n >= 1000000) then
              return ("um milhão" + (if ((n == 1000000) or ((n % 10) == 0)) then
                ""
              else
                (" e " + format_spellout_cardinal_feminine((n % 1000000)))
              end))
            end
            if (n >= 2000) then
              return ((format_spellout_cardinal_masculine((n / 10000).floor) + " mil") + (if ((n == 2000) or ((n % 10) == 0)) then
                ""
              else
                (" e " + format_spellout_cardinal_feminine((n % 10000)))
              end))
            end
            if (n >= 1000) then
              return ("mil" + (if ((n == 1000) or ((n % 10) == 0)) then
                ""
              else
                (" e " + format_spellout_cardinal_feminine((n % 1000)))
              end))
            end
            if (n >= 900) then
              return ("novecentas" + (if ((n == 900) or ((n % 10) == 0)) then
                ""
              else
                (" e " + format_spellout_cardinal_feminine((n % 1000)))
              end))
            end
            if (n >= 800) then
              return ("oitocentas" + (if ((n == 800) or ((n % 10) == 0)) then
                ""
              else
                (" e " + format_spellout_cardinal_feminine((n % 1000)))
              end))
            end
            if (n >= 700) then
              return ("setecentas" + (if ((n == 700) or ((n % 10) == 0)) then
                ""
              else
                (" e " + format_spellout_cardinal_feminine((n % 1000)))
              end))
            end
            if (n >= 600) then
              return ("seiscentas" + (if ((n == 600) or ((n % 10) == 0)) then
                ""
              else
                (" e " + format_spellout_cardinal_feminine((n % 1000)))
              end))
            end
            if (n >= 500) then
              return ("quinhentas" + (if ((n == 500) or ((n % 10) == 0)) then
                ""
              else
                (" e " + format_spellout_cardinal_feminine((n % 1000)))
              end))
            end
            if (n >= 400) then
              return ("quatrocentas" + (if ((n == 400) or ((n % 10) == 0)) then
                ""
              else
                (" e " + format_spellout_cardinal_feminine((n % 1000)))
              end))
            end
            if (n >= 300) then
              return ("trezentas" + (if ((n == 300) or ((n % 10) == 0)) then
                ""
              else
                (" e " + format_spellout_cardinal_feminine((n % 1000)))
              end))
            end
            if (n >= 200) then
              return ("duzentas" + (if ((n == 200) or ((n % 10) == 0)) then
                ""
              else
                (" e " + format_spellout_cardinal_feminine((n % 1000)))
              end))
            end
            if (n >= 101) then
              return ("cento e " + format_spellout_cardinal_feminine((n % 1000)))
            end
            return "cem" if (n >= 100)
            if (n >= 90) then
              return ("noventa" + (if ((n == 90) or ((n % 10) == 0)) then
                ""
              else
                (" e " + format_spellout_cardinal_feminine((n % 100)))
              end))
            end
            if (n >= 80) then
              return ("oitenta" + (if ((n == 80) or ((n % 10) == 0)) then
                ""
              else
                (" e " + format_spellout_cardinal_feminine((n % 100)))
              end))
            end
            if (n >= 70) then
              return ("setenta" + (if ((n == 70) or ((n % 10) == 0)) then
                ""
              else
                (" e " + format_spellout_cardinal_feminine((n % 100)))
              end))
            end
            if (n >= 60) then
              return ("sessenta" + (if ((n == 60) or ((n % 10) == 0)) then
                ""
              else
                (" e " + format_spellout_cardinal_feminine((n % 100)))
              end))
            end
            if (n >= 50) then
              return ("cinquenta" + (if ((n == 50) or ((n % 10) == 0)) then
                ""
              else
                (" e " + format_spellout_cardinal_feminine((n % 100)))
              end))
            end
            if (n >= 40) then
              return ("quarenta" + (if ((n == 40) or ((n % 10) == 0)) then
                ""
              else
                (" e " + format_spellout_cardinal_feminine((n % 100)))
              end))
            end
            if (n >= 30) then
              return ("trinta" + (if ((n == 30) or ((n % 10) == 0)) then
                ""
              else
                (" e " + format_spellout_cardinal_feminine((n % 100)))
              end))
            end
            if (n >= 20) then
              return ("vinte" + (if ((n == 20) or ((n % 10) == 0)) then
                ""
              else
                (" e " + format_spellout_cardinal_feminine((n % 100)))
              end))
            end
            return format_spellout_cardinal_masculine(n) if (n >= 3)
            return "duas" if (n >= 2)
            return "uma" if (n >= 1)
            return "zero" if (n >= 0)
          end
          def format_spellout_ordinal_masculine(n)
            is_fractional = (n != n.floor)
            return ("menos " + format_spellout_ordinal_masculine(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return (n.to_s + "º") if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000000000).floor) + " quadrilionésimo") + (if ((n == 2000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 10000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("um quadrilionésimo" + (if ((n == 1000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 1000000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000000).floor) + " trilionésima") + (if ((n == 2000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 10000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("um trilionésimo" + (if ((n == 1000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 1000000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000).floor) + " bilionésimo") + (if ((n == 2000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 10000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("um bilionésimo" + (if ((n == 1000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 1000000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000).floor) + " milionésimo") + (if ((n == 2000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 10000000)))
              end))
            end
            if (n >= 1000000) then
              return ("um milionésimo" + (if ((n == 1000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 1000000)))
              end))
            end
            if (n >= 2000) then
              return ((format_spellout_cardinal_masculine((n / 10000).floor) + " ­milésimo") + (if ((n == 2000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 10000)))
              end))
            end
            if (n >= 1000) then
              return ("milésimo" + (if ((n == 1000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 1000)))
              end))
            end
            if (n >= 900) then
              return ("noningentésimo" + (if ((n == 900) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 1000)))
              end))
            end
            if (n >= 800) then
              return ("octingentésimo" + (if ((n == 800) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 1000)))
              end))
            end
            if (n >= 700) then
              return ("septingentésimo" + (if ((n == 700) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 1000)))
              end))
            end
            if (n >= 600) then
              return ("sexcentésimo" + (if ((n == 600) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 1000)))
              end))
            end
            if (n >= 500) then
              return ("quingentésimo" + (if ((n == 500) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 1000)))
              end))
            end
            if (n >= 400) then
              return ("quadringentésimo" + (if ((n == 400) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 1000)))
              end))
            end
            if (n >= 300) then
              return ("tricentésimo" + (if ((n == 300) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 1000)))
              end))
            end
            if (n >= 200) then
              return ("ducentésimo" + (if ((n == 200) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 1000)))
              end))
            end
            if (n >= 100) then
              return ("centésimo" + (if ((n == 100) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 100)))
              end))
            end
            if (n >= 90) then
              return ("nonagésimo" + (if ((n == 90) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 100)))
              end))
            end
            if (n >= 80) then
              return ("octogésimo" + (if ((n == 80) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 100)))
              end))
            end
            if (n >= 70) then
              return ("septuagésimo" + (if ((n == 70) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 100)))
              end))
            end
            if (n >= 60) then
              return ("sexagésimo" + (if ((n == 60) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 100)))
              end))
            end
            if (n >= 50) then
              return ("quinquagésimo" + (if ((n == 50) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 100)))
              end))
            end
            if (n >= 40) then
              return ("quadragésimo" + (if ((n == 40) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 100)))
              end))
            end
            if (n >= 30) then
              return ("trigésimo" + (if ((n == 30) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 100)))
              end))
            end
            if (n >= 20) then
              return ("vigésimo" + (if ((n == 20) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 100)))
              end))
            end
            if (n >= 10) then
              return ("décimo" + (if ((n == 10) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 10)))
              end))
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
          def format_spellout_ordinal_feminine(n)
            is_fractional = (n != n.floor)
            return ("menos " + format_spellout_ordinal_feminine(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return (n.to_s + "ª") if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_feminine((n / 10000000000000000).floor) + " quadrilionésima") + (if ((n == 2000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 10000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("uma quadrilionésima" + (if ((n == 1000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 1000000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_feminine((n / 10000000000000).floor) + " trilionésima") + (if ((n == 2000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 10000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("uma trilionésima" + (if ((n == 1000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 1000000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_feminine((n / 10000000000).floor) + " bilionésima") + (if ((n == 2000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 10000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("uma bilionésima" + (if ((n == 1000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 1000000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_feminine((n / 10000000).floor) + " milionésima") + (if ((n == 2000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 10000000)))
              end))
            end
            if (n >= 1000000) then
              return ("uma milionésima" + (if ((n == 1000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 1000000)))
              end))
            end
            if (n >= 2000) then
              return ((format_spellout_cardinal_feminine((n / 10000).floor) + " ­milésima") + (if ((n == 2000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 10000)))
              end))
            end
            if (n >= 1000) then
              return ("milésima" + (if ((n == 1000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 1000)))
              end))
            end
            if (n >= 900) then
              return ("noningentésima" + (if ((n == 900) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 1000)))
              end))
            end
            if (n >= 800) then
              return ("octingentésima" + (if ((n == 800) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 1000)))
              end))
            end
            if (n >= 700) then
              return ("septingentésima" + (if ((n == 700) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 1000)))
              end))
            end
            if (n >= 600) then
              return ("sexcentésima" + (if ((n == 600) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 1000)))
              end))
            end
            if (n >= 500) then
              return ("quingentésima" + (if ((n == 500) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 1000)))
              end))
            end
            if (n >= 400) then
              return ("quadringentésima" + (if ((n == 400) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 1000)))
              end))
            end
            if (n >= 300) then
              return ("tricentésima" + (if ((n == 300) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 1000)))
              end))
            end
            if (n >= 200) then
              return ("ducentésima" + (if ((n == 200) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 1000)))
              end))
            end
            if (n >= 100) then
              return ("centésima" + (if ((n == 100) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 100)))
              end))
            end
            if (n >= 90) then
              return ("nonagésima" + (if ((n == 90) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 100)))
              end))
            end
            if (n >= 80) then
              return ("octogésima" + (if ((n == 80) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 100)))
              end))
            end
            if (n >= 70) then
              return ("septuagésima" + (if ((n == 70) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 100)))
              end))
            end
            if (n >= 60) then
              return ("sexagésima" + (if ((n == 60) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 100)))
              end))
            end
            if (n >= 50) then
              return ("quinquagésima" + (if ((n == 50) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 100)))
              end))
            end
            if (n >= 40) then
              return ("quadragésima" + (if ((n == 40) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 100)))
              end))
            end
            if (n >= 30) then
              return ("trigésima" + (if ((n == 30) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 100)))
              end))
            end
            if (n >= 20) then
              return ("vigésima" + (if ((n == 20) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 100)))
              end))
            end
            if (n >= 10) then
              return ("décima" + (if ((n == 10) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 10)))
              end))
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
        end
      end
      
      class Portuguese::Ordinal
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