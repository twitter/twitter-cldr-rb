# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:el] = Greek = Module.new { }
      
      class Greek::Spellout
        class << self
          def format_spellout_numbering_year(n)
            is_fractional = (n != n.floor)
            return n.to_s if is_fractional and (n > 1)
            return format_spellout_numbering(n) if (n >= 0)
          end
          def format_spellout_numbering(n)
            return format_spellout_cardinal_neuter(n) if (n >= 0)
          end
          def format_spellout_cardinal_masculine(n)
            is_fractional = (n != n.floor)
            return ("μείον " + format_spellout_cardinal_masculine(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_cardinal_masculine(n.floor) + " κόμμα ") + format_spellout_cardinal_masculine(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_neuter((n / 2.0e+15).floor) + " τετράκις εκατομμύρια") + (if (n == 2000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ((format_spellout_cardinal_neuter((n / 1.0e+15).floor) + " τετράκις εκατομμύριο") + (if (n == 1000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_neuter((n / 2000000000000.0).floor) + " τρισεκατομμύρια") + (if (n == 2000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal_neuter((n / 1000000000000.0).floor) + " τρισεκατομμύριο") + (if (n == 1000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_neuter((n / 2000000000.0).floor) + " δισεκατομμύρια") + (if (n == 2000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((format_spellout_cardinal_neuter((n / 1000000000.0).floor) + " δισεκατομμύριο") + (if (n == 1000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_neuter((n / 2000000.0).floor) + " εκατομμύρια") + (if (n == 2000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ((format_spellout_cardinal_neuter((n / 1000000.0).floor) + " εκατομμύριο") + (if (n == 1000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100000)))
              end))
            end
            if (n >= 2000) then
              return ((format_spellout_cardinal_feminine((n / 2000.0).floor) + " χίλιάδες") + (if (n == 2000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000)))
              end))
            end
            if (n >= 1000) then
              return ("χίλιοι" + (if (n == 1000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100)))
              end))
            end
            if (n >= 900) then
              return ("εννιακόσιοι" + ((n == 900) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 100))))))
            end
            if (n >= 800) then
              return ("οκτακόσιοι" + ((n == 800) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 100))))))
            end
            if (n >= 700) then
              return ("επτακόσιοι" + ((n == 700) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 100))))))
            end
            if (n >= 600) then
              return ("εξακόσιοι" + ((n == 600) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 100))))))
            end
            if (n >= 500) then
              return ("πεντακόσιοι" + ((n == 500) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 100))))))
            end
            if (n >= 400) then
              return ("τετρακόσιοι" + ((n == 400) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 100))))))
            end
            if (n >= 300) then
              return ("τριακόσιοι" + ((n == 300) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 100))))))
            end
            if (n >= 200) then
              return ("διακόσιοι" + ((n == 200) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 100))))))
            end
            if (n >= 100) then
              return ("εκατό" + (if (n == 100) then
                ""
              else
                ("ν " + format_spellout_cardinal_masculine((n % 100)))
              end))
            end
            if (n >= 90) then
              return ("εννενήντα" + ((n == 90) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 10))))))
            end
            if (n >= 80) then
              return ("ογδόντα" + ((n == 80) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 10))))))
            end
            if (n >= 70) then
              return ("εβδομήντα" + ((n == 70) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 10))))))
            end
            if (n >= 60) then
              return ("εξήντα" + ((n == 60) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 10))))))
            end
            if (n >= 50) then
              return ("πενήντα" + ((n == 50) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 10))))))
            end
            if (n >= 40) then
              return ("σαράντα" + ((n == 40) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 10))))))
            end
            if (n >= 30) then
              return ("τριάντα" + ((n == 30) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 10))))))
            end
            if (n >= 20) then
              return ("είκοσι" + ((n == 20) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 10))))))
            end
            if (n >= 13) then
              return ("δεκα­" + format_spellout_cardinal_masculine((n % 10)))
            end
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
          def format_spellout_cardinal_feminine(n)
            is_fractional = (n != n.floor)
            return ("μείον " + format_spellout_cardinal_feminine(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_cardinal_feminine(n.floor) + " κόμμα ") + format_spellout_cardinal_feminine(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_neuter((n / 2.0e+15).floor) + " τετράκις εκατομμύρια") + (if (n == 2000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ((format_spellout_cardinal_neuter((n / 1.0e+15).floor) + " τετράκις εκατομμύριο") + (if (n == 1000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_neuter((n / 2000000000000.0).floor) + " τρισεκατομμύρια") + (if (n == 2000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal_neuter((n / 1000000000000.0).floor) + " τρισεκατομμύριο") + (if (n == 1000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_neuter((n / 2000000000.0).floor) + " δισεκατομμύρια") + (if (n == 2000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((format_spellout_cardinal_neuter((n / 1000000000.0).floor) + " δισεκατομμύριο") + (if (n == 1000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_neuter((n / 2000000.0).floor) + " εκατομμύρια") + (if (n == 2000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ((format_spellout_cardinal_neuter((n / 1000000.0).floor) + " εκατομμύριο") + (if (n == 1000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100000)))
              end))
            end
            if (n >= 2000) then
              return ((format_spellout_cardinal_feminine((n / 2000.0).floor) + " χίλιάδες") + (if (n == 2000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000)))
              end))
            end
            if (n >= 1000) then
              return ("χίλιες" + ((n == 1000) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 100))))))
            end
            if (n >= 900) then
              return ("εννιακόσιες" + ((n == 900) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 100))))))
            end
            if (n >= 800) then
              return ("οκτακόσιες" + ((n == 800) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 100))))))
            end
            if (n >= 700) then
              return ("επτακόσιες" + ((n == 700) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 100))))))
            end
            if (n >= 600) then
              return ("εξακόσιες" + ((n == 600) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 100))))))
            end
            if (n >= 500) then
              return ("πεντακόσιες" + ((n == 500) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 100))))))
            end
            if (n >= 400) then
              return ("τετρακόσιες" + ((n == 400) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 100))))))
            end
            if (n >= 300) then
              return ("τριακόσιες" + ((n == 300) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 100))))))
            end
            if (n >= 200) then
              return ("διακόσιες" + ((n == 200) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 100))))))
            end
            if (n >= 100) then
              return ("εκατό" + ((n == 100) ? ("") : (("ν " + format_spellout_cardinal_feminine((n % 100))))))
            end
            if (n >= 90) then
              return ("εννενήντα" + ((n == 90) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 10))))))
            end
            if (n >= 80) then
              return ("ογδόντα" + ((n == 80) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 10))))))
            end
            if (n >= 70) then
              return ("εβδομήντα" + ((n == 70) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 10))))))
            end
            if (n >= 60) then
              return ("εξήντα" + ((n == 60) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 10))))))
            end
            if (n >= 50) then
              return ("πενήντα" + ((n == 50) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 10))))))
            end
            if (n >= 40) then
              return ("σαράντα" + ((n == 40) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 10))))))
            end
            if (n >= 30) then
              return ("τριάντα" + ((n == 30) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 10))))))
            end
            if (n >= 20) then
              return ("είκοσι" + ((n == 20) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 10))))))
            end
            return ("δεκα­" + format_spellout_cardinal_feminine((n % 10))) if (n >= 13)
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
          def format_spellout_cardinal_neuter(n)
            is_fractional = (n != n.floor)
            return ("μείον " + format_spellout_cardinal_neuter(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_cardinal_neuter(n.floor) + " κόμμα ") + format_spellout_cardinal_neuter(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_neuter((n / 2.0e+15).floor) + " τετράκις εκατομμύρια") + (if (n == 2000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ((format_spellout_cardinal_neuter((n / 1.0e+15).floor) + " τετράκις εκατομμύριο") + (if (n == 1000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 100000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_neuter((n / 2000000000000.0).floor) + " τρισεκατομμύρια") + (if (n == 2000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal_neuter((n / 1000000000000.0).floor) + " τρισεκατομμύριο") + (if (n == 1000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 100000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_neuter((n / 2000000000.0).floor) + " δισεκατομμύρια") + (if (n == 2000000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((format_spellout_cardinal_neuter((n / 1000000000.0).floor) + " δισεκατομμύριο") + (if (n == 1000000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 100000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_neuter((n / 2000000.0).floor) + " εκατομμύρια") + (if (n == 2000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ((format_spellout_cardinal_neuter((n / 1000000.0).floor) + " εκατομμύριο") + (if (n == 1000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 100000)))
              end))
            end
            if (n >= 2000) then
              return ((format_spellout_cardinal_feminine((n / 2000.0).floor) + " χίλιάδες") + ((n == 2000) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 1000))))))
            end
            if (n >= 1000) then
              return ("χίλια" + ((n == 1000) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 100))))))
            end
            if (n >= 900) then
              return ("εννιακόσια" + ((n == 900) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 100))))))
            end
            if (n >= 800) then
              return ("οκτακόσια" + ((n == 800) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 100))))))
            end
            if (n >= 700) then
              return ("επτακόσια" + ((n == 700) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 100))))))
            end
            if (n >= 600) then
              return ("εξακόσια" + ((n == 600) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 100))))))
            end
            if (n >= 500) then
              return ("πεντακόσια" + ((n == 500) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 100))))))
            end
            if (n >= 400) then
              return ("τετρακόσια" + ((n == 400) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 100))))))
            end
            if (n >= 300) then
              return ("τριακόσια" + ((n == 300) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 100))))))
            end
            if (n >= 200) then
              return ("διακόσια" + ((n == 200) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 100))))))
            end
            if (n >= 100) then
              return ("εκατό" + ((n == 100) ? ("") : (("ν " + format_spellout_cardinal_neuter((n % 100))))))
            end
            if (n >= 90) then
              return ("εννενήντα" + ((n == 90) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 10))))))
            end
            if (n >= 80) then
              return ("ογδόντα" + ((n == 80) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 10))))))
            end
            if (n >= 70) then
              return ("εβδομήντα" + ((n == 70) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 10))))))
            end
            if (n >= 60) then
              return ("εξήντα" + ((n == 60) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 10))))))
            end
            if (n >= 50) then
              return ("πενήντα" + ((n == 50) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 10))))))
            end
            if (n >= 40) then
              return ("σαράντα" + ((n == 40) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 10))))))
            end
            if (n >= 30) then
              return ("τριάντα" + ((n == 30) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 10))))))
            end
            if (n >= 20) then
              return ("είκοσι" + ((n == 20) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 10))))))
            end
            return ("δεκα­" + format_spellout_cardinal_neuter((n % 10))) if (n >= 13)
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
          def format_spellout_ordinal_masculine(n)
            is_fractional = (n != n.floor)
            return ("μείον " + format_spellout_ordinal_masculine(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return (n.to_s + ".") if (n >= 1000000000000000000)
            if (n >= 1000000000000000) then
              return ((format_spellout_cardinal_neuter((n / 1.0e+15).floor) + " τετράκις εκατομμυριοστός") + (if (n == 1000000000000000) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 100000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal_neuter((n / 1000000000000.0).floor) + " τρισεκατομμυριοστός") + (if (n == 1000000000000) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 100000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((format_spellout_cardinal_neuter((n / 1000000000.0).floor) + " δισεκατομμυριοστός") + (if (n == 1000000000) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 100000000)))
              end))
            end
            if (n >= 1000000) then
              return ((format_spellout_cardinal_neuter((n / 1000000.0).floor) + " εκατομμυριοστός ") + (if (n == 1000000) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 100000)))
              end))
            end
            if (n >= 11000) then
              return ((format_spellout_cardinal_neuter((n / 11000.0).floor) + " χιλιοστός") + (if (n == 11000) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 1000)))
              end))
            end
            if (n >= 10000) then
              return ("δεκάκις χιλιοστός" + (if (n == 10000) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 1000)))
              end))
            end
            if (n >= 9000) then
              return ("εννεάκις χιλιοστός" + (if (n == 9000) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 1000)))
              end))
            end
            if (n >= 8000) then
              return ("οκτάκις χιλιοστός" + (if (n == 8000) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 1000)))
              end))
            end
            if (n >= 7000) then
              return ("επτάκις χιλιοστός" + (if (n == 7000) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 1000)))
              end))
            end
            if (n >= 6000) then
              return ("εξάκις χιλιοστός" + (if (n == 6000) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 1000)))
              end))
            end
            if (n >= 5000) then
              return ("πεντάκις χιλιοστός" + (if (n == 5000) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 1000)))
              end))
            end
            if (n >= 4000) then
              return ("τετράκις χιλιοστός" + (if (n == 4000) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 1000)))
              end))
            end
            if (n >= 3000) then
              return ("τρισχιλιοστός" + (if (n == 3000) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 1000)))
              end))
            end
            if (n >= 2000) then
              return ("δισχιλιοστός" + (if (n == 2000) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 1000)))
              end))
            end
            if (n >= 1000) then
              return ("χιλιοστός" + ((n == 1000) ? ("") : ((" " + format_spellout_ordinal_masculine((n % 100))))))
            end
            if (n >= 900) then
              return ("εννεακοσιοστός" + ((n == 900) ? ("") : ((" " + format_spellout_ordinal_masculine((n % 100))))))
            end
            if (n >= 800) then
              return ("οκτακοσιοστός" + ((n == 800) ? ("") : ((" " + format_spellout_ordinal_masculine((n % 100))))))
            end
            if (n >= 700) then
              return ("επτακοσιοστός" + ((n == 700) ? ("") : ((" " + format_spellout_ordinal_masculine((n % 100))))))
            end
            if (n >= 600) then
              return ("εξακοσιοστός" + ((n == 600) ? ("") : ((" " + format_spellout_ordinal_masculine((n % 100))))))
            end
            if (n >= 500) then
              return ("πεντακοσιοστός" + ((n == 500) ? ("") : ((" " + format_spellout_ordinal_masculine((n % 100))))))
            end
            if (n >= 400) then
              return ("τετρακοσιοστός" + ((n == 400) ? ("") : ((" " + format_spellout_ordinal_masculine((n % 100))))))
            end
            if (n >= 300) then
              return ("τριακοσιοστός" + ((n == 300) ? ("") : ((" " + format_spellout_ordinal_masculine((n % 100))))))
            end
            if (n >= 200) then
              return ("διακοσιοστός" + ((n == 200) ? ("") : ((" " + format_spellout_ordinal_masculine((n % 100))))))
            end
            if (n >= 100) then
              return ("εκατοστός" + ((n == 100) ? ("") : ((" " + format_spellout_ordinal_masculine((n % 100))))))
            end
            if (n >= 90) then
              return ("εννενηκοστός" + ((n == 90) ? ("") : ((" " + format_spellout_ordinal_masculine((n % 10))))))
            end
            if (n >= 80) then
              return ("ογδοηκοστός" + ((n == 80) ? ("") : ((" " + format_spellout_ordinal_masculine((n % 10))))))
            end
            if (n >= 70) then
              return ("εβδομηκοστός" + ((n == 70) ? ("") : ((" " + format_spellout_ordinal_masculine((n % 10))))))
            end
            if (n >= 60) then
              return ("εξηκοστός" + ((n == 60) ? ("") : ((" " + format_spellout_ordinal_masculine((n % 10))))))
            end
            if (n >= 50) then
              return ("πεντηκοστός" + ((n == 50) ? ("") : ((" " + format_spellout_ordinal_masculine((n % 10))))))
            end
            if (n >= 40) then
              return ("τεσσαρακοστός" + ((n == 40) ? ("") : ((" " + format_spellout_ordinal_masculine((n % 10))))))
            end
            if (n >= 30) then
              return ("τριακοστός" + ((n == 30) ? ("") : ((" " + format_spellout_ordinal_masculine((n % 10))))))
            end
            if (n >= 20) then
              return ("εικοστός" + ((n == 20) ? ("") : ((" " + format_spellout_ordinal_masculine((n % 10))))))
            end
            if (n >= 13) then
              return ("δέκατος" + ((n == 13) ? ("") : ((" " + format_spellout_ordinal_masculine((n % 10))))))
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
          def format_spellout_ordinal_feminine(n)
            is_fractional = (n != n.floor)
            return ("μείον " + format_spellout_ordinal_feminine(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return (n.to_s + ".") if (n >= 1000000000000000000)
            if (n >= 1000000000000000) then
              return ((format_spellout_cardinal_neuter((n / 1.0e+15).floor) + " τετράκις εκατομμυριοστή") + (if (n == 1000000000000000) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 100000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal_neuter((n / 1000000000000.0).floor) + " τρισεκατομμυριοστή") + (if (n == 1000000000000) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 100000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((format_spellout_cardinal_neuter((n / 1000000000.0).floor) + " δισεκατομμυριοστή") + (if (n == 1000000000) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 100000000)))
              end))
            end
            if (n >= 1000000) then
              return ((format_spellout_cardinal_neuter((n / 1000000.0).floor) + " εκατομμυριοστή ") + (if (n == 1000000) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 100000)))
              end))
            end
            if (n >= 11000) then
              return ((format_spellout_cardinal_neuter((n / 11000.0).floor) + " χιλιοστή") + (if (n == 11000) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 1000)))
              end))
            end
            if (n >= 10000) then
              return ("δεκάκις χιλιοστή" + (if (n == 10000) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 1000)))
              end))
            end
            if (n >= 9000) then
              return ("εννεάκις χιλιοστή" + ((n == 9000) ? ("") : ((" " + format_spellout_ordinal_feminine((n % 1000))))))
            end
            if (n >= 8000) then
              return ("οκτάκις χιλιοστή" + ((n == 8000) ? ("") : ((" " + format_spellout_ordinal_feminine((n % 1000))))))
            end
            if (n >= 7000) then
              return ("επτάκις χιλιοστή" + ((n == 7000) ? ("") : ((" " + format_spellout_ordinal_feminine((n % 1000))))))
            end
            if (n >= 6000) then
              return ("εξάκις χιλιοστή" + ((n == 6000) ? ("") : ((" " + format_spellout_ordinal_feminine((n % 1000))))))
            end
            if (n >= 5000) then
              return ("πεντάκις χιλιοστή" + ((n == 5000) ? ("") : ((" " + format_spellout_ordinal_feminine((n % 1000))))))
            end
            if (n >= 4000) then
              return ("τετράκις χιλιοστή" + ((n == 4000) ? ("") : ((" " + format_spellout_ordinal_feminine((n % 1000))))))
            end
            if (n >= 3000) then
              return ("τρισχιλιοστή" + ((n == 3000) ? ("") : ((" " + format_spellout_ordinal_feminine((n % 1000))))))
            end
            if (n >= 2000) then
              return ("δισχιλιοστή" + ((n == 2000) ? ("") : ((" " + format_spellout_ordinal_feminine((n % 1000))))))
            end
            if (n >= 1000) then
              return ("χιλιοστή" + ((n == 1000) ? ("") : ((" " + format_spellout_ordinal_feminine((n % 100))))))
            end
            if (n >= 900) then
              return ("εννεακοσιοστή" + ((n == 900) ? ("") : ((" " + format_spellout_ordinal_feminine((n % 100))))))
            end
            if (n >= 800) then
              return ("οκτακοσιοστή" + ((n == 800) ? ("") : ((" " + format_spellout_ordinal_feminine((n % 100))))))
            end
            if (n >= 700) then
              return ("επτακοσιοστή" + ((n == 700) ? ("") : ((" " + format_spellout_ordinal_feminine((n % 100))))))
            end
            if (n >= 600) then
              return ("εξακοσιοστή" + ((n == 600) ? ("") : ((" " + format_spellout_ordinal_feminine((n % 100))))))
            end
            if (n >= 500) then
              return ("πεντακοσιοστή" + ((n == 500) ? ("") : ((" " + format_spellout_ordinal_feminine((n % 100))))))
            end
            if (n >= 400) then
              return ("τρετρακοσιοστή" + ((n == 400) ? ("") : ((" " + format_spellout_ordinal_feminine((n % 100))))))
            end
            if (n >= 300) then
              return ("τριακοσιοστή" + ((n == 300) ? ("") : ((" " + format_spellout_ordinal_feminine((n % 100))))))
            end
            if (n >= 200) then
              return ("διακοσιοστή" + ((n == 200) ? ("") : ((" " + format_spellout_ordinal_feminine((n % 100))))))
            end
            if (n >= 100) then
              return ("εκατοστή" + ((n == 100) ? ("") : ((" " + format_spellout_ordinal_feminine((n % 100))))))
            end
            if (n >= 90) then
              return ("εννενηκοστή" + ((n == 90) ? ("") : ((" " + format_spellout_ordinal_feminine((n % 10))))))
            end
            if (n >= 80) then
              return ("ογδοηκοστή" + ((n == 80) ? ("") : ((" " + format_spellout_ordinal_feminine((n % 10))))))
            end
            if (n >= 70) then
              return ("εβδομηκοστή" + ((n == 70) ? ("") : ((" " + format_spellout_ordinal_feminine((n % 10))))))
            end
            if (n >= 60) then
              return ("εξηκοστή" + ((n == 60) ? ("") : ((" " + format_spellout_ordinal_feminine((n % 10))))))
            end
            if (n >= 50) then
              return ("πεντηκοστή" + ((n == 50) ? ("") : ((" " + format_spellout_ordinal_feminine((n % 10))))))
            end
            if (n >= 40) then
              return ("τεσσαρακοστή" + ((n == 40) ? ("") : ((" " + format_spellout_ordinal_feminine((n % 10))))))
            end
            if (n >= 30) then
              return ("τριακοστή" + ((n == 30) ? ("") : ((" " + format_spellout_ordinal_feminine((n % 10))))))
            end
            if (n >= 20) then
              return ("εικοστή" + ((n == 20) ? ("") : ((" " + format_spellout_ordinal_feminine((n % 10))))))
            end
            if (n >= 13) then
              return ("δέκατη" + ((n == 13) ? ("") : ((" " + format_spellout_ordinal_feminine((n % 10))))))
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
          def format_spellout_ordinal_neuter(n)
            return ("μείον " + format_spellout_ordinal_neuter(-n)) if (n < 0)
            return (n.to_s + ".") if (n >= 1000000000000000000)
            if (n >= 1000000000000000) then
              return ((format_spellout_cardinal_neuter((n / 1.0e+15).floor) + " τετράκις εκατομμυριοστό") + (if (n == 1000000000000000) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 100000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal_neuter((n / 1000000000000.0).floor) + " τρισεκατομμυριοστό") + (if (n == 1000000000000) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 100000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((format_spellout_cardinal_neuter((n / 1000000000.0).floor) + " δισεκατομμυριοστό") + (if (n == 1000000000) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 100000000)))
              end))
            end
            if (n >= 1000000) then
              return ((format_spellout_cardinal_neuter((n / 1000000.0).floor) + " εκατομμυριοστό ") + (if (n == 1000000) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 100000)))
              end))
            end
            if (n >= 11000) then
              return ((format_spellout_cardinal_neuter((n / 11000.0).floor) + " χιλιοστό") + ((n == 11000) ? ("") : ((" " + format_spellout_ordinal_neuter((n % 1000))))))
            end
            if (n >= 10000) then
              return ("δεκάκις χιλιοστό" + ((n == 10000) ? ("") : ((" " + format_spellout_ordinal_neuter((n % 1000))))))
            end
            if (n >= 9000) then
              return ("εννεάκις χιλιοστό" + ((n == 9000) ? ("") : ((" " + format_spellout_ordinal_neuter((n % 1000))))))
            end
            if (n >= 8000) then
              return ("οκτάκις χιλιοστό" + ((n == 8000) ? ("") : ((" " + format_spellout_ordinal_neuter((n % 1000))))))
            end
            if (n >= 7000) then
              return ("επτάκις χιλιοστό" + ((n == 7000) ? ("") : ((" " + format_spellout_ordinal_neuter((n % 1000))))))
            end
            if (n >= 6000) then
              return ("εξάκις χιλιοστό" + ((n == 6000) ? ("") : ((" " + format_spellout_ordinal_neuter((n % 1000))))))
            end
            if (n >= 5000) then
              return ("πεντάκις χιλιοστό" + ((n == 5000) ? ("") : ((" " + format_spellout_ordinal_neuter((n % 1000))))))
            end
            if (n >= 4000) then
              return ("τετράκις χιλιοστό" + ((n == 4000) ? ("") : ((" " + format_spellout_ordinal_neuter((n % 1000))))))
            end
            if (n >= 3000) then
              return ("τρισχιλιοστό" + ((n == 3000) ? ("") : ((" " + format_spellout_ordinal_neuter((n % 1000))))))
            end
            if (n >= 2000) then
              return ("δισχιλιοστό" + ((n == 2000) ? ("") : ((" " + format_spellout_ordinal_neuter((n % 1000))))))
            end
            if (n >= 1000) then
              return ("χιλιοστό" + ((n == 1000) ? ("") : ((" " + format_spellout_ordinal_neuter((n % 100))))))
            end
            if (n >= 900) then
              return ("εννεακοσιοστό" + ((n == 900) ? ("") : ((" " + format_spellout_ordinal_neuter((n % 100))))))
            end
            if (n >= 800) then
              return ("οκτακοσιοστό" + ((n == 800) ? ("") : ((" " + format_spellout_ordinal_neuter((n % 100))))))
            end
            if (n >= 700) then
              return ("επτακοσιοστό" + ((n == 700) ? ("") : ((" " + format_spellout_ordinal_neuter((n % 100))))))
            end
            if (n >= 600) then
              return ("εξακοσιοστός" + ((n == 600) ? ("") : ((" " + format_spellout_ordinal_neuter((n % 100))))))
            end
            if (n >= 500) then
              return ("πεντακοσιοστό" + ((n == 500) ? ("") : ((" " + format_spellout_ordinal_neuter((n % 100))))))
            end
            if (n >= 400) then
              return ("τετρακοσιοστό" + ((n == 400) ? ("") : ((" " + format_spellout_ordinal_neuter((n % 100))))))
            end
            if (n >= 300) then
              return ("τριακοσιοστό" + ((n == 300) ? ("") : ((" " + format_spellout_ordinal_neuter((n % 100))))))
            end
            if (n >= 200) then
              return ("διακοσιοστό" + ((n == 200) ? ("") : ((" " + format_spellout_ordinal_neuter((n % 100))))))
            end
            if (n >= 100) then
              return ("εκατοστό" + ((n == 100) ? ("") : ((" " + format_spellout_ordinal_neuter((n % 100))))))
            end
            if (n >= 90) then
              return ("εννενηκοστό" + ((n == 90) ? ("") : ((" " + format_spellout_ordinal_neuter((n % 10))))))
            end
            if (n >= 80) then
              return ("ογδοηκοστό" + ((n == 80) ? ("") : ((" " + format_spellout_ordinal_neuter((n % 10))))))
            end
            if (n >= 70) then
              return ("εβδομηκοστό" + ((n == 70) ? ("") : ((" " + format_spellout_ordinal_neuter((n % 10))))))
            end
            if (n >= 60) then
              return ("εξηκοστό" + ((n == 60) ? ("") : ((" " + format_spellout_ordinal_neuter((n % 10))))))
            end
            if (n >= 50) then
              return ("πεντηκοστό" + ((n == 50) ? ("") : ((" " + format_spellout_ordinal_neuter((n % 10))))))
            end
            if (n >= 40) then
              return ("τεσσαρακοστό" + ((n == 40) ? ("") : ((" " + format_spellout_ordinal_neuter((n % 10))))))
            end
            if (n >= 30) then
              return ("τριακοστό" + ((n == 30) ? ("") : ((" " + format_spellout_ordinal_neuter((n % 10))))))
            end
            if (n >= 20) then
              return ("εικοστό" + ((n == 20) ? ("") : ((" " + format_spellout_ordinal_neuter((n % 10))))))
            end
            if (n >= 13) then
              return ("δέκατο" + ((n == 13) ? ("") : ((" " + format_spellout_ordinal_neuter((n % 10))))))
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
          end
        end
      end
    end
  end
end