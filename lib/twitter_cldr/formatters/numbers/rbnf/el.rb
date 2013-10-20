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
              return ((format_spellout_cardinal_masculine(n.floor) + " κόμμα ") + format_spellout_cardinal_masculine((n % 10)))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_neuter((n / 10000000000000000).floor) + " τετράκις εκατομμύρια") + (if ((n == 2000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 10000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ((format_spellout_cardinal_neuter((n / 1000000000000000).floor) + " τετράκις εκατομμύριο") + (if ((n == 1000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_neuter((n / 10000000000000).floor) + " τρισεκατομμύρια") + (if ((n == 2000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 10000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal_neuter((n / 1000000000000).floor) + " τρισεκατομμύριο") + (if ((n == 1000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_neuter((n / 10000000000).floor) + " δισεκατομμύρια") + (if ((n == 2000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 10000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((format_spellout_cardinal_neuter((n / 1000000000).floor) + " δισεκατομμύριο") + (if ((n == 1000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_neuter((n / 10000000).floor) + " εκατομμύρια") + (if ((n == 2000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 10000000)))
              end))
            end
            if (n >= 1000000) then
              return ((format_spellout_cardinal_neuter((n / 1000000).floor) + " εκατομμύριο") + (if ((n == 1000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000)))
              end))
            end
            if (n >= 2000) then
              return ((format_spellout_cardinal_feminine((n / 10000).floor) + " χίλιάδες") + (if ((n == 2000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 10000)))
              end))
            end
            if (n >= 1000) then
              return ("χίλιοι" + (if ((n == 1000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000)))
              end))
            end
            if (n >= 900) then
              return ("εννιακόσιοι" + (if ((n == 900) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000)))
              end))
            end
            if (n >= 800) then
              return ("οκτακόσιοι" + (if ((n == 800) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000)))
              end))
            end
            if (n >= 700) then
              return ("επτακόσιοι" + (if ((n == 700) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000)))
              end))
            end
            if (n >= 600) then
              return ("εξακόσιοι" + (if ((n == 600) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000)))
              end))
            end
            if (n >= 500) then
              return ("πεντακόσιοι" + (if ((n == 500) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000)))
              end))
            end
            if (n >= 400) then
              return ("τετρακόσιοι" + (if ((n == 400) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000)))
              end))
            end
            if (n >= 300) then
              return ("τριακόσιοι" + (if ((n == 300) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000)))
              end))
            end
            if (n >= 200) then
              return ("διακόσιοι" + (if ((n == 200) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000)))
              end))
            end
            if (n >= 100) then
              return ("εκατό" + (if ((n == 100) or ((n % 10) == 0)) then
                ""
              else
                ("ν " + format_spellout_cardinal_masculine((n % 100)))
              end))
            end
            if (n >= 90) then
              return ("εννενήντα" + (if ((n == 90) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100)))
              end))
            end
            if (n >= 80) then
              return ("ογδόντα" + (if ((n == 80) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100)))
              end))
            end
            if (n >= 70) then
              return ("εβδομήντα" + (if ((n == 70) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100)))
              end))
            end
            if (n >= 60) then
              return ("εξήντα" + (if ((n == 60) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100)))
              end))
            end
            if (n >= 50) then
              return ("πενήντα" + (if ((n == 50) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100)))
              end))
            end
            if (n >= 40) then
              return ("σαράντα" + (if ((n == 40) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100)))
              end))
            end
            if (n >= 30) then
              return ("τριάντα" + (if ((n == 30) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100)))
              end))
            end
            if (n >= 20) then
              return ("είκοσι" + (if ((n == 20) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100)))
              end))
            end
            if (n >= 13) then
              return ("δεκα­" + format_spellout_cardinal_masculine((n % 100)))
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
              return ((format_spellout_cardinal_feminine(n.floor) + " κόμμα ") + format_spellout_cardinal_feminine((n % 10)))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_neuter((n / 10000000000000000).floor) + " τετράκις εκατομμύρια") + (if ((n == 2000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 10000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ((format_spellout_cardinal_neuter((n / 1000000000000000).floor) + " τετράκις εκατομμύριο") + (if ((n == 1000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_neuter((n / 10000000000000).floor) + " τρισεκατομμύρια") + (if ((n == 2000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 10000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal_neuter((n / 1000000000000).floor) + " τρισεκατομμύριο") + (if ((n == 1000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_neuter((n / 10000000000).floor) + " δισεκατομμύρια") + (if ((n == 2000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 10000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((format_spellout_cardinal_neuter((n / 1000000000).floor) + " δισεκατομμύριο") + (if ((n == 1000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_neuter((n / 10000000).floor) + " εκατομμύρια") + (if ((n == 2000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 10000000)))
              end))
            end
            if (n >= 1000000) then
              return ((format_spellout_cardinal_neuter((n / 1000000).floor) + " εκατομμύριο") + (if ((n == 1000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000)))
              end))
            end
            if (n >= 2000) then
              return ((format_spellout_cardinal_feminine((n / 10000).floor) + " χίλιάδες") + (if ((n == 2000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 10000)))
              end))
            end
            if (n >= 1000) then
              return ("χίλιες" + (if ((n == 1000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000)))
              end))
            end
            if (n >= 900) then
              return ("εννιακόσιες" + (if ((n == 900) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000)))
              end))
            end
            if (n >= 800) then
              return ("οκτακόσιες" + (if ((n == 800) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000)))
              end))
            end
            if (n >= 700) then
              return ("επτακόσιες" + (if ((n == 700) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000)))
              end))
            end
            if (n >= 600) then
              return ("εξακόσιες" + (if ((n == 600) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000)))
              end))
            end
            if (n >= 500) then
              return ("πεντακόσιες" + (if ((n == 500) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000)))
              end))
            end
            if (n >= 400) then
              return ("τετρακόσιες" + (if ((n == 400) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000)))
              end))
            end
            if (n >= 300) then
              return ("τριακόσιες" + (if ((n == 300) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000)))
              end))
            end
            if (n >= 200) then
              return ("διακόσιες" + (if ((n == 200) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000)))
              end))
            end
            if (n >= 100) then
              return ("εκατό" + (if ((n == 100) or ((n % 10) == 0)) then
                ""
              else
                ("ν " + format_spellout_cardinal_feminine((n % 100)))
              end))
            end
            if (n >= 90) then
              return ("εννενήντα" + (if ((n == 90) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100)))
              end))
            end
            if (n >= 80) then
              return ("ογδόντα" + (if ((n == 80) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100)))
              end))
            end
            if (n >= 70) then
              return ("εβδομήντα" + (if ((n == 70) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100)))
              end))
            end
            if (n >= 60) then
              return ("εξήντα" + (if ((n == 60) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100)))
              end))
            end
            if (n >= 50) then
              return ("πενήντα" + (if ((n == 50) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100)))
              end))
            end
            if (n >= 40) then
              return ("σαράντα" + (if ((n == 40) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100)))
              end))
            end
            if (n >= 30) then
              return ("τριάντα" + (if ((n == 30) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100)))
              end))
            end
            if (n >= 20) then
              return ("είκοσι" + (if ((n == 20) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100)))
              end))
            end
            if (n >= 13) then
              return ("δεκα­" + format_spellout_cardinal_feminine((n % 100)))
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
            return "μία" if (n >= 1)
            return "μηδέν" if (n >= 0)
          end
          def format_spellout_cardinal_neuter(n)
            is_fractional = (n != n.floor)
            return ("μείον " + format_spellout_cardinal_neuter(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_cardinal_neuter(n.floor) + " κόμμα ") + format_spellout_cardinal_neuter((n % 10)))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_neuter((n / 10000000000000000).floor) + " τετράκις εκατομμύρια") + (if ((n == 2000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 10000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ((format_spellout_cardinal_neuter((n / 1000000000000000).floor) + " τετράκις εκατομμύριο") + (if ((n == 1000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_neuter((n / 10000000000000).floor) + " τρισεκατομμύρια") + (if ((n == 2000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 10000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal_neuter((n / 1000000000000).floor) + " τρισεκατομμύριο") + (if ((n == 1000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_neuter((n / 10000000000).floor) + " δισεκατομμύρια") + (if ((n == 2000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 10000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((format_spellout_cardinal_neuter((n / 1000000000).floor) + " δισεκατομμύριο") + (if ((n == 1000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_neuter((n / 10000000).floor) + " εκατομμύρια") + (if ((n == 2000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 10000000)))
              end))
            end
            if (n >= 1000000) then
              return ((format_spellout_cardinal_neuter((n / 1000000).floor) + " εκατομμύριο") + (if ((n == 1000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000000)))
              end))
            end
            if (n >= 2000) then
              return ((format_spellout_cardinal_feminine((n / 10000).floor) + " χίλιάδες") + (if ((n == 2000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 10000)))
              end))
            end
            if (n >= 1000) then
              return ("χίλια" + (if ((n == 1000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000)))
              end))
            end
            if (n >= 900) then
              return ("εννιακόσια" + (if ((n == 900) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000)))
              end))
            end
            if (n >= 800) then
              return ("οκτακόσια" + (if ((n == 800) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000)))
              end))
            end
            if (n >= 700) then
              return ("επτακόσια" + (if ((n == 700) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000)))
              end))
            end
            if (n >= 600) then
              return ("εξακόσια" + (if ((n == 600) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000)))
              end))
            end
            if (n >= 500) then
              return ("πεντακόσια" + (if ((n == 500) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000)))
              end))
            end
            if (n >= 400) then
              return ("τετρακόσια" + (if ((n == 400) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000)))
              end))
            end
            if (n >= 300) then
              return ("τριακόσια" + (if ((n == 300) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000)))
              end))
            end
            if (n >= 200) then
              return ("διακόσια" + (if ((n == 200) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000)))
              end))
            end
            if (n >= 100) then
              return ("εκατό" + (if ((n == 100) or ((n % 10) == 0)) then
                ""
              else
                ("ν " + format_spellout_cardinal_neuter((n % 100)))
              end))
            end
            if (n >= 90) then
              return ("εννενήντα" + (if ((n == 90) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 100)))
              end))
            end
            if (n >= 80) then
              return ("ογδόντα" + (if ((n == 80) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 100)))
              end))
            end
            if (n >= 70) then
              return ("εβδομήντα" + (if ((n == 70) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 100)))
              end))
            end
            if (n >= 60) then
              return ("εξήντα" + (if ((n == 60) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 100)))
              end))
            end
            if (n >= 50) then
              return ("πενήντα" + (if ((n == 50) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 100)))
              end))
            end
            if (n >= 40) then
              return ("σαράντα" + (if ((n == 40) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 100)))
              end))
            end
            if (n >= 30) then
              return ("τριάντα" + (if ((n == 30) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 100)))
              end))
            end
            if (n >= 20) then
              return ("είκοσι" + (if ((n == 20) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 100)))
              end))
            end
            return ("δεκα­" + format_spellout_cardinal_neuter((n % 100))) if (n >= 13)
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
              return ((format_spellout_cardinal_neuter((n / 1000000000000000).floor) + " τετράκις εκατομμυριοστός") + (if ((n == 1000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal_neuter((n / 1000000000000).floor) + " τρισεκατομμυριοστός") + (if ((n == 1000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((format_spellout_cardinal_neuter((n / 1000000000).floor) + " δισεκατομμυριοστός") + (if ((n == 1000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 1000000000)))
              end))
            end
            if (n >= 1000000) then
              return ((format_spellout_cardinal_neuter((n / 1000000).floor) + " εκατομμυριοστός ") + (if ((n == 1000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 1000000)))
              end))
            end
            if (n >= 11000) then
              return ((format_spellout_cardinal_neuter((n / 1000000).floor) + " χιλιοστός") + (if ((n == 11000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 1000000)))
              end))
            end
            if (n >= 10000) then
              return ("δεκάκις χιλιοστός" + (if ((n == 10000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 1000000)))
              end))
            end
            if (n >= 9000) then
              return ("εννεάκις χιλιοστός" + (if ((n == 9000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 10000)))
              end))
            end
            if (n >= 8000) then
              return ("οκτάκις χιλιοστός" + (if ((n == 8000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 10000)))
              end))
            end
            if (n >= 7000) then
              return ("επτάκις χιλιοστός" + (if ((n == 7000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 10000)))
              end))
            end
            if (n >= 6000) then
              return ("εξάκις χιλιοστός" + (if ((n == 6000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 10000)))
              end))
            end
            if (n >= 5000) then
              return ("πεντάκις χιλιοστός" + (if ((n == 5000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 10000)))
              end))
            end
            if (n >= 4000) then
              return ("τετράκις χιλιοστός" + (if ((n == 4000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 10000)))
              end))
            end
            if (n >= 3000) then
              return ("τρισχιλιοστός" + (if ((n == 3000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 10000)))
              end))
            end
            if (n >= 2000) then
              return ("δισχιλιοστός" + (if ((n == 2000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 10000)))
              end))
            end
            if (n >= 1000) then
              return ("χιλιοστός" + (if ((n == 1000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 1000)))
              end))
            end
            if (n >= 900) then
              return ("εννεακοσιοστός" + (if ((n == 900) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 1000)))
              end))
            end
            if (n >= 800) then
              return ("οκτακοσιοστός" + (if ((n == 800) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 1000)))
              end))
            end
            if (n >= 700) then
              return ("επτακοσιοστός" + (if ((n == 700) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 1000)))
              end))
            end
            if (n >= 600) then
              return ("εξακοσιοστός" + (if ((n == 600) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 1000)))
              end))
            end
            if (n >= 500) then
              return ("πεντακοσιοστός" + (if ((n == 500) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 1000)))
              end))
            end
            if (n >= 400) then
              return ("τετρακοσιοστός" + (if ((n == 400) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 1000)))
              end))
            end
            if (n >= 300) then
              return ("τριακοσιοστός" + (if ((n == 300) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 1000)))
              end))
            end
            if (n >= 200) then
              return ("διακοσιοστός" + (if ((n == 200) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 1000)))
              end))
            end
            if (n >= 100) then
              return ("εκατοστός" + (if ((n == 100) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 100)))
              end))
            end
            if (n >= 90) then
              return ("εννενηκοστός" + (if ((n == 90) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 100)))
              end))
            end
            if (n >= 80) then
              return ("ογδοηκοστός" + (if ((n == 80) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 100)))
              end))
            end
            if (n >= 70) then
              return ("εβδομηκοστός" + (if ((n == 70) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 100)))
              end))
            end
            if (n >= 60) then
              return ("εξηκοστός" + (if ((n == 60) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 100)))
              end))
            end
            if (n >= 50) then
              return ("πεντηκοστός" + (if ((n == 50) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 100)))
              end))
            end
            if (n >= 40) then
              return ("τεσσαρακοστός" + (if ((n == 40) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 100)))
              end))
            end
            if (n >= 30) then
              return ("τριακοστός" + (if ((n == 30) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 100)))
              end))
            end
            if (n >= 20) then
              return ("εικοστός" + (if ((n == 20) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 100)))
              end))
            end
            if (n >= 13) then
              return ("δέκατος" + (if ((n == 13) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_masculine((n % 100)))
              end))
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
              return ((format_spellout_cardinal_neuter((n / 1000000000000000).floor) + " τετράκις εκατομμυριοστή") + (if ((n == 1000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal_neuter((n / 1000000000000).floor) + " τρισεκατομμυριοστή") + (if ((n == 1000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((format_spellout_cardinal_neuter((n / 1000000000).floor) + " δισεκατομμυριοστή") + (if ((n == 1000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 1000000000)))
              end))
            end
            if (n >= 1000000) then
              return ((format_spellout_cardinal_neuter((n / 1000000).floor) + " εκατομμυριοστή ") + (if ((n == 1000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 1000000)))
              end))
            end
            if (n >= 11000) then
              return ((format_spellout_cardinal_neuter((n / 1000000).floor) + " χιλιοστή") + (if ((n == 11000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 1000000)))
              end))
            end
            if (n >= 10000) then
              return ("δεκάκις χιλιοστή" + (if ((n == 10000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 1000000)))
              end))
            end
            if (n >= 9000) then
              return ("εννεάκις χιλιοστή" + (if ((n == 9000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 10000)))
              end))
            end
            if (n >= 8000) then
              return ("οκτάκις χιλιοστή" + (if ((n == 8000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 10000)))
              end))
            end
            if (n >= 7000) then
              return ("επτάκις χιλιοστή" + (if ((n == 7000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 10000)))
              end))
            end
            if (n >= 6000) then
              return ("εξάκις χιλιοστή" + (if ((n == 6000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 10000)))
              end))
            end
            if (n >= 5000) then
              return ("πεντάκις χιλιοστή" + (if ((n == 5000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 10000)))
              end))
            end
            if (n >= 4000) then
              return ("τετράκις χιλιοστή" + (if ((n == 4000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 10000)))
              end))
            end
            if (n >= 3000) then
              return ("τρισχιλιοστή" + (if ((n == 3000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 10000)))
              end))
            end
            if (n >= 2000) then
              return ("δισχιλιοστή" + (if ((n == 2000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 10000)))
              end))
            end
            if (n >= 1000) then
              return ("χιλιοστή" + (if ((n == 1000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 1000)))
              end))
            end
            if (n >= 900) then
              return ("εννεακοσιοστή" + (if ((n == 900) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 1000)))
              end))
            end
            if (n >= 800) then
              return ("οκτακοσιοστή" + (if ((n == 800) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 1000)))
              end))
            end
            if (n >= 700) then
              return ("επτακοσιοστή" + (if ((n == 700) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 1000)))
              end))
            end
            if (n >= 600) then
              return ("εξακοσιοστή" + (if ((n == 600) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 1000)))
              end))
            end
            if (n >= 500) then
              return ("πεντακοσιοστή" + (if ((n == 500) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 1000)))
              end))
            end
            if (n >= 400) then
              return ("τρετρακοσιοστή" + (if ((n == 400) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 1000)))
              end))
            end
            if (n >= 300) then
              return ("τριακοσιοστή" + (if ((n == 300) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 1000)))
              end))
            end
            if (n >= 200) then
              return ("διακοσιοστή" + (if ((n == 200) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 1000)))
              end))
            end
            if (n >= 100) then
              return ("εκατοστή" + (if ((n == 100) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 100)))
              end))
            end
            if (n >= 90) then
              return ("εννενηκοστή" + (if ((n == 90) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 100)))
              end))
            end
            if (n >= 80) then
              return ("ογδοηκοστή" + (if ((n == 80) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 100)))
              end))
            end
            if (n >= 70) then
              return ("εβδομηκοστή" + (if ((n == 70) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 100)))
              end))
            end
            if (n >= 60) then
              return ("εξηκοστή" + (if ((n == 60) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 100)))
              end))
            end
            if (n >= 50) then
              return ("πεντηκοστή" + (if ((n == 50) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 100)))
              end))
            end
            if (n >= 40) then
              return ("τεσσαρακοστή" + (if ((n == 40) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 100)))
              end))
            end
            if (n >= 30) then
              return ("τριακοστή" + (if ((n == 30) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 100)))
              end))
            end
            if (n >= 20) then
              return ("εικοστή" + (if ((n == 20) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 100)))
              end))
            end
            if (n >= 13) then
              return ("δέκατη" + (if ((n == 13) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_feminine((n % 100)))
              end))
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
              return ((format_spellout_cardinal_neuter((n / 1000000000000000).floor) + " τετράκις εκατομμυριοστό") + (if ((n == 1000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal_neuter((n / 1000000000000).floor) + " τρισεκατομμυριοστό") + (if ((n == 1000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((format_spellout_cardinal_neuter((n / 1000000000).floor) + " δισεκατομμυριοστό") + (if ((n == 1000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 1000000000)))
              end))
            end
            if (n >= 1000000) then
              return ((format_spellout_cardinal_neuter((n / 1000000).floor) + " εκατομμυριοστό ") + (if ((n == 1000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 1000000)))
              end))
            end
            if (n >= 11000) then
              return ((format_spellout_cardinal_neuter((n / 1000000).floor) + " χιλιοστό") + (if ((n == 11000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 1000000)))
              end))
            end
            if (n >= 10000) then
              return ("δεκάκις χιλιοστό" + (if ((n == 10000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 1000000)))
              end))
            end
            if (n >= 9000) then
              return ("εννεάκις χιλιοστό" + (if ((n == 9000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 10000)))
              end))
            end
            if (n >= 8000) then
              return ("οκτάκις χιλιοστό" + (if ((n == 8000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 10000)))
              end))
            end
            if (n >= 7000) then
              return ("επτάκις χιλιοστό" + (if ((n == 7000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 10000)))
              end))
            end
            if (n >= 6000) then
              return ("εξάκις χιλιοστό" + (if ((n == 6000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 10000)))
              end))
            end
            if (n >= 5000) then
              return ("πεντάκις χιλιοστό" + (if ((n == 5000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 10000)))
              end))
            end
            if (n >= 4000) then
              return ("τετράκις χιλιοστό" + (if ((n == 4000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 10000)))
              end))
            end
            if (n >= 3000) then
              return ("τρισχιλιοστό" + (if ((n == 3000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 10000)))
              end))
            end
            if (n >= 2000) then
              return ("δισχιλιοστό" + (if ((n == 2000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 10000)))
              end))
            end
            if (n >= 1000) then
              return ("χιλιοστό" + (if ((n == 1000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 1000)))
              end))
            end
            if (n >= 900) then
              return ("εννεακοσιοστό" + (if ((n == 900) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 1000)))
              end))
            end
            if (n >= 800) then
              return ("οκτακοσιοστό" + (if ((n == 800) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 1000)))
              end))
            end
            if (n >= 700) then
              return ("επτακοσιοστό" + (if ((n == 700) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 1000)))
              end))
            end
            if (n >= 600) then
              return ("εξακοσιοστός" + (if ((n == 600) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 1000)))
              end))
            end
            if (n >= 500) then
              return ("πεντακοσιοστό" + (if ((n == 500) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 1000)))
              end))
            end
            if (n >= 400) then
              return ("τετρακοσιοστό" + (if ((n == 400) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 1000)))
              end))
            end
            if (n >= 300) then
              return ("τριακοσιοστό" + (if ((n == 300) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 1000)))
              end))
            end
            if (n >= 200) then
              return ("διακοσιοστό" + (if ((n == 200) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 1000)))
              end))
            end
            if (n >= 100) then
              return ("εκατοστό" + (if ((n == 100) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 100)))
              end))
            end
            if (n >= 90) then
              return ("εννενηκοστό" + (if ((n == 90) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 100)))
              end))
            end
            if (n >= 80) then
              return ("ογδοηκοστό" + (if ((n == 80) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 100)))
              end))
            end
            if (n >= 70) then
              return ("εβδομηκοστό" + (if ((n == 70) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 100)))
              end))
            end
            if (n >= 60) then
              return ("εξηκοστό" + (if ((n == 60) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 100)))
              end))
            end
            if (n >= 50) then
              return ("πεντηκοστό" + (if ((n == 50) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 100)))
              end))
            end
            if (n >= 40) then
              return ("τεσσαρακοστό" + (if ((n == 40) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 100)))
              end))
            end
            if (n >= 30) then
              return ("τριακοστό" + (if ((n == 30) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 100)))
              end))
            end
            if (n >= 20) then
              return ("εικοστό" + (if ((n == 20) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 100)))
              end))
            end
            if (n >= 13) then
              return ("δέκατο" + (if ((n == 13) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_neuter((n % 100)))
              end))
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