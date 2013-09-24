# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:el] = Greek = Class.new do
        class << self
          (def renderSpelloutNumberingYear(n)
            is_fractional = (n != n.floor)
            return n.to_s if is_fractional and (n > 1)
            return renderSpelloutNumbering(n) if (n >= 0)
          end
          def renderSpelloutNumbering(n)
            return renderSpelloutCardinalNeuter(n) if (n >= 0)
          end
          def renderSpelloutCardinalMasculine(n)
            is_fractional = (n != n.floor)
            return ("μείον " + renderSpelloutCardinalMasculine(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((renderSpelloutCardinalMasculine(n.floor) + " κόμμα ") + renderSpelloutCardinalMasculine(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((renderSpelloutCardinalNeuter((n / 2.0e+15).floor) + " τετράκις εκατομμύρια") + (if (n == 2000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ((renderSpelloutCardinalNeuter((n / 1.0e+15).floor) + " τετράκις εκατομμύριο") + (if (n == 1000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 100000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((renderSpelloutCardinalNeuter((n / 2000000000000.0).floor) + " τρισεκατομμύρια") + (if (n == 2000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((renderSpelloutCardinalNeuter((n / 1000000000000.0).floor) + " τρισεκατομμύριο") + (if (n == 1000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 100000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((renderSpelloutCardinalNeuter((n / 2000000000.0).floor) + " δισεκατομμύρια") + (if (n == 2000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((renderSpelloutCardinalNeuter((n / 1000000000.0).floor) + " δισεκατομμύριο") + (if (n == 1000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 100000000)))
              end))
            end
            if (n >= 2000000) then
              return ((renderSpelloutCardinalNeuter((n / 2000000.0).floor) + " εκατομμύρια") + (if (n == 2000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ((renderSpelloutCardinalNeuter((n / 1000000.0).floor) + " εκατομμύριο") + (if (n == 1000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 100000)))
              end))
            end
            if (n >= 2000) then
              return ((renderSpelloutCardinalFeminine((n / 2000.0).floor) + " χίλιάδες") + ((n == 2000) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 1000))))))
            end
            if (n >= 1000) then
              return ("χίλιοι" + ((n == 1000) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 900) then
              return ("εννιακόσιοι" + ((n == 900) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 800) then
              return ("οκτακόσιοι" + ((n == 800) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 700) then
              return ("επτακόσιοι" + ((n == 700) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 600) then
              return ("εξακόσιοι" + ((n == 600) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 500) then
              return ("πεντακόσιοι" + ((n == 500) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 400) then
              return ("τετρακόσιοι" + ((n == 400) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 300) then
              return ("τριακόσιοι" + ((n == 300) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 200) then
              return ("διακόσιοι" + ((n == 200) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 100) then
              return ("εκατό" + ((n == 100) ? ("") : (("ν " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 90) then
              return ("εννενήντα" + ((n == 90) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 80) then
              return ("ογδόντα" + ((n == 80) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 70) then
              return ("εβδομήντα" + ((n == 70) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 60) then
              return ("εξήντα" + ((n == 60) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 50) then
              return ("πενήντα" + ((n == 50) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 40) then
              return ("σαράντα" + ((n == 40) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 30) then
              return ("τριάντα" + ((n == 30) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 20) then
              return ("είκοσι" + ((n == 20) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            return ("δεκα­" + renderSpelloutCardinalMasculine((n % 10))) if (n >= 13)
            return "δώδεκα" if (n >= 12)
            return "έντεκα" if (n >= 11)
            return "δέκα" if (n >= 10)
            return "εννέα" if (n >= 9)
            return "οκτώ" if (n >= 8)
            return "επτά" if (n >= 7)
            return "έξι" if (n >= 6)
            return "πέντε" if (n >= 5)
            return "τέσσερις" if (n >= 4)
            return "τρεις" if (n >= 3)
            return "δύο" if (n >= 2)
            return "ένας" if (n >= 1)
            return "μηδέν" if (n >= 0)
          end
          def renderSpelloutCardinalFeminine(n)
            is_fractional = (n != n.floor)
            return ("μείον " + renderSpelloutCardinalFeminine(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((renderSpelloutCardinalFeminine(n.floor) + " κόμμα ") + renderSpelloutCardinalFeminine(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((renderSpelloutCardinalNeuter((n / 2.0e+15).floor) + " τετράκις εκατομμύρια") + (if (n == 2000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ((renderSpelloutCardinalNeuter((n / 1.0e+15).floor) + " τετράκις εκατομμύριο") + (if (n == 1000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 100000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((renderSpelloutCardinalNeuter((n / 2000000000000.0).floor) + " τρισεκατομμύρια") + (if (n == 2000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((renderSpelloutCardinalNeuter((n / 1000000000000.0).floor) + " τρισεκατομμύριο") + (if (n == 1000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 100000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((renderSpelloutCardinalNeuter((n / 2000000000.0).floor) + " δισεκατομμύρια") + (if (n == 2000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((renderSpelloutCardinalNeuter((n / 1000000000.0).floor) + " δισεκατομμύριο") + (if (n == 1000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 100000000)))
              end))
            end
            if (n >= 2000000) then
              return ((renderSpelloutCardinalNeuter((n / 2000000.0).floor) + " εκατομμύρια") + (if (n == 2000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ((renderSpelloutCardinalNeuter((n / 1000000.0).floor) + " εκατομμύριο") + (if (n == 1000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 100000)))
              end))
            end
            if (n >= 2000) then
              return ((renderSpelloutCardinalFeminine((n / 2000.0).floor) + " χίλιάδες") + ((n == 2000) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 1000))))))
            end
            if (n >= 1000) then
              return ("χίλιες" + ((n == 1000) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 900) then
              return ("εννιακόσιες" + ((n == 900) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 800) then
              return ("οκτακόσιες" + ((n == 800) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 700) then
              return ("επτακόσιες" + ((n == 700) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 600) then
              return ("εξακόσιες" + ((n == 600) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 500) then
              return ("πεντακόσιες" + ((n == 500) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 400) then
              return ("τετρακόσιες" + ((n == 400) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 300) then
              return ("τριακόσιες" + ((n == 300) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 200) then
              return ("διακόσιες" + ((n == 200) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 100) then
              return ("εκατό" + ((n == 100) ? ("") : (("ν " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 90) then
              return ("εννενήντα" + ((n == 90) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 80) then
              return ("ογδόντα" + ((n == 80) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 70) then
              return ("εβδομήντα" + ((n == 70) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 60) then
              return ("εξήντα" + ((n == 60) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 50) then
              return ("πενήντα" + ((n == 50) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 40) then
              return ("σαράντα" + ((n == 40) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 30) then
              return ("τριάντα" + ((n == 30) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 20) then
              return ("είκοσι" + ((n == 20) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            return ("δεκα­" + renderSpelloutCardinalFeminine((n % 10))) if (n >= 13)
            return "δώδεκα" if (n >= 12)
            return "έντεκα" if (n >= 11)
            return "δέκα" if (n >= 10)
            return "εννέα" if (n >= 9)
            return "οκτώ" if (n >= 8)
            return "επτά" if (n >= 7)
            return "έξι" if (n >= 6)
            return "πέντε" if (n >= 5)
            return "τέσσερις" if (n >= 4)
            return "τρεις" if (n >= 3)
            return "δύο" if (n >= 2)
            return "μία" if (n >= 1)
            return "μηδέν" if (n >= 0)
          end
          def renderSpelloutCardinalNeuter(n)
            is_fractional = (n != n.floor)
            return ("μείον " + renderSpelloutCardinalNeuter(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((renderSpelloutCardinalNeuter(n.floor) + " κόμμα ") + renderSpelloutCardinalNeuter(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((renderSpelloutCardinalNeuter((n / 2.0e+15).floor) + " τετράκις εκατομμύρια") + (if (n == 2000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ((renderSpelloutCardinalNeuter((n / 1.0e+15).floor) + " τετράκις εκατομμύριο") + (if (n == 1000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 100000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((renderSpelloutCardinalNeuter((n / 2000000000000.0).floor) + " τρισεκατομμύρια") + (if (n == 2000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((renderSpelloutCardinalNeuter((n / 1000000000000.0).floor) + " τρισεκατομμύριο") + (if (n == 1000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 100000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((renderSpelloutCardinalNeuter((n / 2000000000.0).floor) + " δισεκατομμύρια") + (if (n == 2000000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((renderSpelloutCardinalNeuter((n / 1000000000.0).floor) + " δισεκατομμύριο") + (if (n == 1000000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 100000000)))
              end))
            end
            if (n >= 2000000) then
              return ((renderSpelloutCardinalNeuter((n / 2000000.0).floor) + " εκατομμύρια") + (if (n == 2000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ((renderSpelloutCardinalNeuter((n / 1000000.0).floor) + " εκατομμύριο") + (if (n == 1000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 100000)))
              end))
            end
            if (n >= 2000) then
              return ((renderSpelloutCardinalFeminine((n / 2000.0).floor) + " χίλιάδες") + ((n == 2000) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 1000))))))
            end
            if (n >= 1000) then
              return ("χίλια" + ((n == 1000) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 100))))))
            end
            if (n >= 900) then
              return ("εννιακόσια" + ((n == 900) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 100))))))
            end
            if (n >= 800) then
              return ("οκτακόσια" + ((n == 800) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 100))))))
            end
            if (n >= 700) then
              return ("επτακόσια" + ((n == 700) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 100))))))
            end
            if (n >= 600) then
              return ("εξακόσια" + ((n == 600) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 100))))))
            end
            if (n >= 500) then
              return ("πεντακόσια" + ((n == 500) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 100))))))
            end
            if (n >= 400) then
              return ("τετρακόσια" + ((n == 400) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 100))))))
            end
            if (n >= 300) then
              return ("τριακόσια" + ((n == 300) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 100))))))
            end
            if (n >= 200) then
              return ("διακόσια" + ((n == 200) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 100))))))
            end
            if (n >= 100) then
              return ("εκατό" + ((n == 100) ? ("") : (("ν " + renderSpelloutCardinalNeuter((n % 100))))))
            end
            if (n >= 90) then
              return ("εννενήντα" + ((n == 90) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 10))))))
            end
            if (n >= 80) then
              return ("ογδόντα" + ((n == 80) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 10))))))
            end
            if (n >= 70) then
              return ("εβδομήντα" + ((n == 70) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 10))))))
            end
            if (n >= 60) then
              return ("εξήντα" + ((n == 60) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 10))))))
            end
            if (n >= 50) then
              return ("πενήντα" + ((n == 50) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 10))))))
            end
            if (n >= 40) then
              return ("σαράντα" + ((n == 40) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 10))))))
            end
            if (n >= 30) then
              return ("τριάντα" + ((n == 30) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 10))))))
            end
            if (n >= 20) then
              return ("είκοσι" + ((n == 20) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 10))))))
            end
            return ("δεκα­" + renderSpelloutCardinalNeuter((n % 10))) if (n >= 13)
            return "δώδεκα" if (n >= 12)
            return "έντεκα" if (n >= 11)
            return "δέκα" if (n >= 10)
            return "εννέα" if (n >= 9)
            return "οκτώ" if (n >= 8)
            return "επτά" if (n >= 7)
            return "έξι" if (n >= 6)
            return "πέντε" if (n >= 5)
            return "τέσσερα" if (n >= 4)
            return "τρία" if (n >= 3)
            return "δύο" if (n >= 2)
            return "ένα" if (n >= 1)
            return "μηδέν" if (n >= 0)
          end
          def renderSpelloutOrdinalMasculine(n)
            is_fractional = (n != n.floor)
            return ("μείον " + renderSpelloutOrdinalMasculine(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return (n.to_s + ".") if (n >= 1000000000000000000)
            if (n >= 1000000000000000) then
              return ((renderSpelloutCardinalNeuter((n / 1.0e+15).floor) + " τετράκις εκατομμυριοστός") + (if (n == 1000000000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalMasculine((n % 100000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((renderSpelloutCardinalNeuter((n / 1000000000000.0).floor) + " τρισεκατομμυριοστός") + (if (n == 1000000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalMasculine((n % 100000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((renderSpelloutCardinalNeuter((n / 1000000000.0).floor) + " δισεκατομμυριοστός") + (if (n == 1000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalMasculine((n % 100000000)))
              end))
            end
            if (n >= 1000000) then
              return ((renderSpelloutCardinalNeuter((n / 1000000.0).floor) + " εκατομμυριοστός ") + (if (n == 1000000) then
                ""
              else
                (" " + renderSpelloutOrdinalMasculine((n % 100000)))
              end))
            end
            if (n >= 11000) then
              return ((renderSpelloutCardinalNeuter((n / 11000.0).floor) + " χιλιοστός") + ((n == 11000) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 1000))))))
            end
            if (n >= 10000) then
              return ("δεκάκις χιλιοστός" + ((n == 10000) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 1000))))))
            end
            if (n >= 9000) then
              return ("εννεάκις χιλιοστός" + ((n == 9000) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 1000))))))
            end
            if (n >= 8000) then
              return ("οκτάκις χιλιοστός" + ((n == 8000) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 1000))))))
            end
            if (n >= 7000) then
              return ("επτάκις χιλιοστός" + ((n == 7000) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 1000))))))
            end
            if (n >= 6000) then
              return ("εξάκις χιλιοστός" + ((n == 6000) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 1000))))))
            end
            if (n >= 5000) then
              return ("πεντάκις χιλιοστός" + ((n == 5000) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 1000))))))
            end
            if (n >= 4000) then
              return ("τετράκις χιλιοστός" + ((n == 4000) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 1000))))))
            end
            if (n >= 3000) then
              return ("τρισχιλιοστός" + ((n == 3000) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 1000))))))
            end
            if (n >= 2000) then
              return ("δισχιλιοστός" + ((n == 2000) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 1000))))))
            end
            if (n >= 1000) then
              return ("χιλιοστός" + ((n == 1000) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 100))))))
            end
            if (n >= 900) then
              return ("εννεακοσιοστός" + ((n == 900) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 100))))))
            end
            if (n >= 800) then
              return ("οκτακοσιοστός" + ((n == 800) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 100))))))
            end
            if (n >= 700) then
              return ("επτακοσιοστός" + ((n == 700) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 100))))))
            end
            if (n >= 600) then
              return ("εξακοσιοστός" + ((n == 600) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 100))))))
            end
            if (n >= 500) then
              return ("πεντακοσιοστός" + ((n == 500) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 100))))))
            end
            if (n >= 400) then
              return ("τετρακοσιοστός" + ((n == 400) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 100))))))
            end
            if (n >= 300) then
              return ("τριακοσιοστός" + ((n == 300) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 100))))))
            end
            if (n >= 200) then
              return ("διακοσιοστός" + ((n == 200) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 100))))))
            end
            if (n >= 100) then
              return ("εκατοστός" + ((n == 100) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 100))))))
            end
            if (n >= 90) then
              return ("εννενηκοστός" + ((n == 90) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 10))))))
            end
            if (n >= 80) then
              return ("ογδοηκοστός" + ((n == 80) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 10))))))
            end
            if (n >= 70) then
              return ("εβδομηκοστός" + ((n == 70) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 10))))))
            end
            if (n >= 60) then
              return ("εξηκοστός" + ((n == 60) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 10))))))
            end
            if (n >= 50) then
              return ("πεντηκοστός" + ((n == 50) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 10))))))
            end
            if (n >= 40) then
              return ("τεσσαρακοστός" + ((n == 40) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 10))))))
            end
            if (n >= 30) then
              return ("τριακοστός" + ((n == 30) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 10))))))
            end
            if (n >= 20) then
              return ("εικοστός" + ((n == 20) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 10))))))
            end
            if (n >= 13) then
              return ("δέκατος" + ((n == 13) ? ("") : ((" " + renderSpelloutOrdinalMasculine((n % 10))))))
            end
            return "δωδέκατος" if (n >= 12)
            return "ενδέκατος" if (n >= 11)
            return "δέκατος" if (n >= 10)
            return "ένατος" if (n >= 9)
            return "όγδοος" if (n >= 8)
            return "έβδομος" if (n >= 7)
            return "έκτος" if (n >= 6)
            return "πέμπτος" if (n >= 5)
            return "τέταρτος" if (n >= 4)
            return "τρίτος" if (n >= 3)
            return "δεύτερος" if (n >= 2)
            return "πρώτος" if (n >= 1)
            return "μηδενικός" if (n >= 0)
          end
          def renderSpelloutOrdinalFeminine(n)
            is_fractional = (n != n.floor)
            return ("μείον " + renderSpelloutOrdinalFeminine(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return (n.to_s + ".") if (n >= 1000000000000000000)
            if (n >= 1000000000000000) then
              return ((renderSpelloutCardinalNeuter((n / 1.0e+15).floor) + " τετράκις εκατομμυριοστή") + (if (n == 1000000000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalFeminine((n % 100000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((renderSpelloutCardinalNeuter((n / 1000000000000.0).floor) + " τρισεκατομμυριοστή") + (if (n == 1000000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalFeminine((n % 100000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((renderSpelloutCardinalNeuter((n / 1000000000.0).floor) + " δισεκατομμυριοστή") + (if (n == 1000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalFeminine((n % 100000000)))
              end))
            end
            if (n >= 1000000) then
              return ((renderSpelloutCardinalNeuter((n / 1000000.0).floor) + " εκατομμυριοστή ") + (if (n == 1000000) then
                ""
              else
                (" " + renderSpelloutOrdinalFeminine((n % 100000)))
              end))
            end
            if (n >= 11000) then
              return ((renderSpelloutCardinalNeuter((n / 11000.0).floor) + " χιλιοστή") + ((n == 11000) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 1000))))))
            end
            if (n >= 10000) then
              return ("δεκάκις χιλιοστή" + ((n == 10000) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 1000))))))
            end
            if (n >= 9000) then
              return ("εννεάκις χιλιοστή" + ((n == 9000) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 1000))))))
            end
            if (n >= 8000) then
              return ("οκτάκις χιλιοστή" + ((n == 8000) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 1000))))))
            end
            if (n >= 7000) then
              return ("επτάκις χιλιοστή" + ((n == 7000) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 1000))))))
            end
            if (n >= 6000) then
              return ("εξάκις χιλιοστή" + ((n == 6000) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 1000))))))
            end
            if (n >= 5000) then
              return ("πεντάκις χιλιοστή" + ((n == 5000) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 1000))))))
            end
            if (n >= 4000) then
              return ("τετράκις χιλιοστή" + ((n == 4000) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 1000))))))
            end
            if (n >= 3000) then
              return ("τρισχιλιοστή" + ((n == 3000) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 1000))))))
            end
            if (n >= 2000) then
              return ("δισχιλιοστή" + ((n == 2000) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 1000))))))
            end
            if (n >= 1000) then
              return ("χιλιοστή" + ((n == 1000) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 100))))))
            end
            if (n >= 900) then
              return ("εννεακοσιοστή" + ((n == 900) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 100))))))
            end
            if (n >= 800) then
              return ("οκτακοσιοστή" + ((n == 800) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 100))))))
            end
            if (n >= 700) then
              return ("επτακοσιοστή" + ((n == 700) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 100))))))
            end
            if (n >= 600) then
              return ("εξακοσιοστή" + ((n == 600) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 100))))))
            end
            if (n >= 500) then
              return ("πεντακοσιοστή" + ((n == 500) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 100))))))
            end
            if (n >= 400) then
              return ("τρετρακοσιοστή" + ((n == 400) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 100))))))
            end
            if (n >= 300) then
              return ("τριακοσιοστή" + ((n == 300) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 100))))))
            end
            if (n >= 200) then
              return ("διακοσιοστή" + ((n == 200) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 100))))))
            end
            if (n >= 100) then
              return ("εκατοστή" + ((n == 100) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 100))))))
            end
            if (n >= 90) then
              return ("εννενηκοστή" + ((n == 90) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 10))))))
            end
            if (n >= 80) then
              return ("ογδοηκοστή" + ((n == 80) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 10))))))
            end
            if (n >= 70) then
              return ("εβδομηκοστή" + ((n == 70) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 10))))))
            end
            if (n >= 60) then
              return ("εξηκοστή" + ((n == 60) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 10))))))
            end
            if (n >= 50) then
              return ("πεντηκοστή" + ((n == 50) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 10))))))
            end
            if (n >= 40) then
              return ("τεσσαρακοστή" + ((n == 40) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 10))))))
            end
            if (n >= 30) then
              return ("τριακοστή" + ((n == 30) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 10))))))
            end
            if (n >= 20) then
              return ("εικοστή" + ((n == 20) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 10))))))
            end
            if (n >= 13) then
              return ("δέκατη" + ((n == 13) ? ("") : ((" " + renderSpelloutOrdinalFeminine((n % 10))))))
            end
            return "δωδέκατη" if (n >= 12)
            return "ενδέκατη" if (n >= 11)
            return "δέκατη" if (n >= 10)
            return "ένατη" if (n >= 9)
            return "όγδοη" if (n >= 8)
            return "έβδομη" if (n >= 7)
            return "έκτη" if (n >= 6)
            return "πέμπτη" if (n >= 5)
            return "τέταρτη" if (n >= 4)
            return "τρίτη" if (n >= 3)
            return "δεύτερη" if (n >= 2)
            return "πρώτη" if (n >= 1)
            return "μηδενική" if (n >= 0)
          end
          def renderSpelloutOrdinalNeuter(n)
            return ("μείον " + renderSpelloutOrdinalNeuter(-n)) if (n < 0)
            return (n.to_s + ".") if (n >= 1000000000000000000)
            if (n >= 1000000000000000) then
              return ((renderSpelloutCardinalNeuter((n / 1.0e+15).floor) + " τετράκις εκατομμυριοστό") + (if (n == 1000000000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalNeuter((n % 100000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((renderSpelloutCardinalNeuter((n / 1000000000000.0).floor) + " τρισεκατομμυριοστό") + (if (n == 1000000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalNeuter((n % 100000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((renderSpelloutCardinalNeuter((n / 1000000000.0).floor) + " δισεκατομμυριοστό") + (if (n == 1000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalNeuter((n % 100000000)))
              end))
            end
            if (n >= 1000000) then
              return ((renderSpelloutCardinalNeuter((n / 1000000.0).floor) + " εκατομμυριοστό ") + ((n == 1000000) ? ("") : ((" " + renderSpelloutOrdinalNeuter((n % 100000))))))
            end
            if (n >= 11000) then
              return ((renderSpelloutCardinalNeuter((n / 11000.0).floor) + " χιλιοστό") + ((n == 11000) ? ("") : ((" " + renderSpelloutOrdinalNeuter((n % 1000))))))
            end
            if (n >= 10000) then
              return ("δεκάκις χιλιοστό" + ((n == 10000) ? ("") : ((" " + renderSpelloutOrdinalNeuter((n % 1000))))))
            end
            if (n >= 9000) then
              return ("εννεάκις χιλιοστό" + ((n == 9000) ? ("") : ((" " + renderSpelloutOrdinalNeuter((n % 1000))))))
            end
            if (n >= 8000) then
              return ("οκτάκις χιλιοστό" + ((n == 8000) ? ("") : ((" " + renderSpelloutOrdinalNeuter((n % 1000))))))
            end
            if (n >= 7000) then
              return ("επτάκις χιλιοστό" + ((n == 7000) ? ("") : ((" " + renderSpelloutOrdinalNeuter((n % 1000))))))
            end
            if (n >= 6000) then
              return ("εξάκις χιλιοστό" + ((n == 6000) ? ("") : ((" " + renderSpelloutOrdinalNeuter((n % 1000))))))
            end
            if (n >= 5000) then
              return ("πεντάκις χιλιοστό" + ((n == 5000) ? ("") : ((" " + renderSpelloutOrdinalNeuter((n % 1000))))))
            end
            if (n >= 4000) then
              return ("τετράκις χιλιοστό" + ((n == 4000) ? ("") : ((" " + renderSpelloutOrdinalNeuter((n % 1000))))))
            end
            if (n >= 3000) then
              return ("τρισχιλιοστό" + ((n == 3000) ? ("") : ((" " + renderSpelloutOrdinalNeuter((n % 1000))))))
            end
            if (n >= 2000) then
              return ("δισχιλιοστό" + ((n == 2000) ? ("") : ((" " + renderSpelloutOrdinalNeuter((n % 1000))))))
            end
            if (n >= 1000) then
              return ("χιλιοστό" + ((n == 1000) ? ("") : ((" " + renderSpelloutOrdinalNeuter((n % 100))))))
            end
            if (n >= 900) then
              return ("εννεακοσιοστό" + ((n == 900) ? ("") : ((" " + renderSpelloutOrdinalNeuter((n % 100))))))
            end
            if (n >= 800) then
              return ("οκτακοσιοστό" + ((n == 800) ? ("") : ((" " + renderSpelloutOrdinalNeuter((n % 100))))))
            end
            if (n >= 700) then
              return ("επτακοσιοστό" + ((n == 700) ? ("") : ((" " + renderSpelloutOrdinalNeuter((n % 100))))))
            end
            if (n >= 600) then
              return ("εξακοσιοστός" + ((n == 600) ? ("") : ((" " + renderSpelloutOrdinalNeuter((n % 100))))))
            end
            if (n >= 500) then
              return ("πεντακοσιοστό" + ((n == 500) ? ("") : ((" " + renderSpelloutOrdinalNeuter((n % 100))))))
            end
            if (n >= 400) then
              return ("τετρακοσιοστό" + ((n == 400) ? ("") : ((" " + renderSpelloutOrdinalNeuter((n % 100))))))
            end
            if (n >= 300) then
              return ("τριακοσιοστό" + ((n == 300) ? ("") : ((" " + renderSpelloutOrdinalNeuter((n % 100))))))
            end
            if (n >= 200) then
              return ("διακοσιοστό" + ((n == 200) ? ("") : ((" " + renderSpelloutOrdinalNeuter((n % 100))))))
            end
            if (n >= 100) then
              return ("εκατοστό" + ((n == 100) ? ("") : ((" " + renderSpelloutOrdinalNeuter((n % 100))))))
            end
            if (n >= 90) then
              return ("εννενηκοστό" + ((n == 90) ? ("") : ((" " + renderSpelloutOrdinalNeuter((n % 10))))))
            end
            if (n >= 80) then
              return ("ογδοηκοστό" + ((n == 80) ? ("") : ((" " + renderSpelloutOrdinalNeuter((n % 10))))))
            end
            if (n >= 70) then
              return ("εβδομηκοστό" + ((n == 70) ? ("") : ((" " + renderSpelloutOrdinalNeuter((n % 10))))))
            end
            if (n >= 60) then
              return ("εξηκοστό" + ((n == 60) ? ("") : ((" " + renderSpelloutOrdinalNeuter((n % 10))))))
            end
            if (n >= 50) then
              return ("πεντηκοστό" + ((n == 50) ? ("") : ((" " + renderSpelloutOrdinalNeuter((n % 10))))))
            end
            if (n >= 40) then
              return ("τεσσαρακοστό" + ((n == 40) ? ("") : ((" " + renderSpelloutOrdinalNeuter((n % 10))))))
            end
            if (n >= 30) then
              return ("τριακοστό" + ((n == 30) ? ("") : ((" " + renderSpelloutOrdinalNeuter((n % 10))))))
            end
            if (n >= 20) then
              return ("εικοστό" + ((n == 20) ? ("") : ((" " + renderSpelloutOrdinalNeuter((n % 10))))))
            end
            if (n >= 13) then
              return ("δέκατο" + ((n == 13) ? ("") : ((" " + renderSpelloutOrdinalNeuter((n % 10))))))
            end
            return "δωδέκατο" if (n >= 12)
            return "ενδέκατο" if (n >= 11)
            return "δέκατο" if (n >= 10)
            return "ένατο" if (n >= 9)
            return "όγδο" if (n >= 8)
            return "έβδομο" if (n >= 7)
            return "έκτο" if (n >= 6)
            return "πέμπτο" if (n >= 5)
            return "τέταρτο" if (n >= 4)
            return "τρίτο" if (n >= 3)
            return "δεύτερο" if (n >= 2)
            return "πρώτο" if (n >= 1)
            return "μηδενικό" if (n >= 0)
          end)
        end
      end
    end
  end
end