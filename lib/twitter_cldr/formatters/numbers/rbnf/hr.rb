# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:hr] = Croatian = Module.new { }
      
      class Croatian::Spellout
        class << self
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
            return ("minus " + format_spellout_cardinal_masculine(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_cardinal_masculine(n.floor) + " zarez ") + format_spellout_cardinal_masculine((n % 10)))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 5000000000000000) then
              return ((format_spellout_cardinal_feminine((n / 10000000000000000).floor) + " bilijardi") + (if ((n == 5000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 10000000000000000)))
              end))
            end
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_feminine((n / 10000000000000000).floor) + " bilijarde") + (if ((n == 2000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 10000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ((format_spellout_cardinal_feminine((n / 1000000000000000).floor) + " bilijarda") + (if ((n == 1000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000000000000)))
              end))
            end
            if (n >= 5000000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000000).floor) + " bilijuna") + (if ((n == 5000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 10000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000000).floor) + " bilijuna") + (if ((n == 2000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 10000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000000).floor) + " bilijun") + (if ((n == 1000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000000000)))
              end))
            end
            if (n >= 5000000000) then
              return ((format_spellout_cardinal_feminine((n / 10000000000).floor) + " milijardi") + (if ((n == 5000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 10000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_feminine((n / 10000000000).floor) + " milijarde") + (if ((n == 2000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 10000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((format_spellout_cardinal_feminine((n / 1000000000).floor) + " milijarda") + (if ((n == 1000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000000)))
              end))
            end
            if (n >= 5000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000).floor) + " milijuna") + (if ((n == 5000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 10000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000).floor) + " milijuna") + (if ((n == 2000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 10000000)))
              end))
            end
            if (n >= 1000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000).floor) + " milijun") + (if ((n == 1000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000)))
              end))
            end
            if (n >= 5000) then
              return ((format_spellout_cardinal_feminine((n / 10000).floor) + " tisuća") + (if ((n == 5000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 10000)))
              end))
            end
            if (n >= 2000) then
              return ((format_spellout_cardinal_feminine((n / 10000).floor) + " tisuće") + (if ((n == 2000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 10000)))
              end))
            end
            if (n >= 1000) then
              return ("tisuću" + (if ((n == 1000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000)))
              end))
            end
            if (n >= 900) then
              return ("devetsto" + (if ((n == 900) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000)))
              end))
            end
            if (n >= 800) then
              return ("osamsto" + (if ((n == 800) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000)))
              end))
            end
            if (n >= 700) then
              return ("sedamsto" + (if ((n == 700) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000)))
              end))
            end
            if (n >= 600) then
              return ("šeststo" + (if ((n == 600) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000)))
              end))
            end
            if (n >= 500) then
              return ("petsto" + (if ((n == 500) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000)))
              end))
            end
            if (n >= 400) then
              return ("četiristo" + (if ((n == 400) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000)))
              end))
            end
            if (n >= 300) then
              return ("tristo" + (if ((n == 300) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000)))
              end))
            end
            if (n >= 200) then
              return ("dvjesto" + (if ((n == 200) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000)))
              end))
            end
            if (n >= 100) then
              return ("sto" + (if ((n == 100) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100)))
              end))
            end
            if (n >= 90) then
              return ("devedeset" + (if ((n == 90) or ((n % 10) == 0)) then
                ""
              else
                (" i " + format_spellout_cardinal_masculine((n % 100)))
              end))
            end
            if (n >= 80) then
              return ("osamdeset" + (if ((n == 80) or ((n % 10) == 0)) then
                ""
              else
                (" i " + format_spellout_cardinal_masculine((n % 100)))
              end))
            end
            if (n >= 70) then
              return ("sedamdeset" + (if ((n == 70) or ((n % 10) == 0)) then
                ""
              else
                (" i " + format_spellout_cardinal_masculine((n % 100)))
              end))
            end
            if (n >= 60) then
              return ("šezdeset" + (if ((n == 60) or ((n % 10) == 0)) then
                ""
              else
                (" i " + format_spellout_cardinal_masculine((n % 100)))
              end))
            end
            if (n >= 50) then
              return ("pedeset" + (if ((n == 50) or ((n % 10) == 0)) then
                ""
              else
                (" i " + format_spellout_cardinal_masculine((n % 100)))
              end))
            end
            if (n >= 40) then
              return ("četrdeset" + (if ((n == 40) or ((n % 10) == 0)) then
                ""
              else
                (" i " + format_spellout_cardinal_masculine((n % 100)))
              end))
            end
            if (n >= 30) then
              return ("trideset" + (if ((n == 30) or ((n % 10) == 0)) then
                ""
              else
                (" i " + format_spellout_cardinal_masculine((n % 100)))
              end))
            end
            if (n >= 20) then
              return ("dvadeset" + (if ((n == 20) or ((n % 10) == 0)) then
                ""
              else
                (" i " + format_spellout_cardinal_masculine((n % 100)))
              end))
            end
            return "devetnaest" if (n >= 19)
            return "osamnaest" if (n >= 18)
            return "sedamnaest" if (n >= 17)
            return "šesnaest" if (n >= 16)
            return "petnaest" if (n >= 15)
            return "četrnaest" if (n >= 14)
            return "trinaest" if (n >= 13)
            return "dvanaest" if (n >= 12)
            return "jedanaest" if (n >= 11)
            return "deset" if (n >= 10)
            return "devet" if (n >= 9)
            return "osam" if (n >= 8)
            return "sedam" if (n >= 7)
            return "šest" if (n >= 6)
            return "pet" if (n >= 5)
            return "četiri" if (n >= 4)
            return "tri" if (n >= 3)
            return "dva" if (n >= 2)
            return "jedan" if (n >= 1)
            return "nula" if (n >= 0)
          end
          def format_spellout_cardinal_neuter(n)
            is_fractional = (n != n.floor)
            return ("minus " + format_spellout_cardinal_neuter(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_cardinal_neuter(n.floor) + " zarez ") + format_spellout_cardinal_neuter((n % 10)))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 5000000000000000) then
              return ((format_spellout_cardinal_feminine((n / 10000000000000000).floor) + " bilijardi") + (if ((n == 5000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 10000000000000000)))
              end))
            end
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_feminine((n / 10000000000000000).floor) + " bilijarde") + (if ((n == 2000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 10000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ((format_spellout_cardinal_feminine((n / 1000000000000000).floor) + " bilijarda") + (if ((n == 1000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000000000000000)))
              end))
            end
            if (n >= 5000000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000000).floor) + " bilijuna") + (if ((n == 5000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 10000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000000).floor) + " bilijuna") + (if ((n == 2000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 10000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000000).floor) + " bilijun") + (if ((n == 1000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000000000000)))
              end))
            end
            if (n >= 5000000000) then
              return ((format_spellout_cardinal_feminine((n / 10000000000).floor) + " milijardi") + (if ((n == 5000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 10000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_feminine((n / 10000000000).floor) + " milijarde") + (if ((n == 2000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 10000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((format_spellout_cardinal_feminine((n / 1000000000).floor) + " milijarda") + (if ((n == 1000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000000000)))
              end))
            end
            if (n >= 5000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000).floor) + " milijuna") + (if ((n == 5000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 10000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000).floor) + " milijuna") + (if ((n == 2000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 10000000)))
              end))
            end
            if (n >= 1000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000).floor) + " milijun") + (if ((n == 1000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000000)))
              end))
            end
            if (n >= 5000) then
              return ((format_spellout_cardinal_feminine((n / 10000).floor) + " tisuća") + (if ((n == 5000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 10000)))
              end))
            end
            if (n >= 2000) then
              return ((format_spellout_cardinal_feminine((n / 10000).floor) + " tisuće") + (if ((n == 2000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 10000)))
              end))
            end
            if (n >= 1000) then
              return ("tisuću" + (if ((n == 1000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000)))
              end))
            end
            if (n >= 900) then
              return ("devetsto" + (if ((n == 900) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000)))
              end))
            end
            if (n >= 800) then
              return ("osamsto" + (if ((n == 800) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000)))
              end))
            end
            if (n >= 700) then
              return ("sedamsto" + (if ((n == 700) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000)))
              end))
            end
            if (n >= 600) then
              return ("šeststo" + (if ((n == 600) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000)))
              end))
            end
            if (n >= 500) then
              return ("petsto" + (if ((n == 500) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000)))
              end))
            end
            if (n >= 400) then
              return ("četiristo" + (if ((n == 400) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000)))
              end))
            end
            if (n >= 300) then
              return ("tristo" + (if ((n == 300) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000)))
              end))
            end
            if (n >= 200) then
              return ("dvjesto" + (if ((n == 200) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000)))
              end))
            end
            if (n >= 100) then
              return ("sto" + (if ((n == 100) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 100)))
              end))
            end
            if (n >= 90) then
              return ("devedeset" + (if ((n == 90) or ((n % 10) == 0)) then
                ""
              else
                (" i " + format_spellout_cardinal_neuter((n % 100)))
              end))
            end
            if (n >= 80) then
              return ("osamdeset" + (if ((n == 80) or ((n % 10) == 0)) then
                ""
              else
                (" i " + format_spellout_cardinal_neuter((n % 100)))
              end))
            end
            if (n >= 70) then
              return ("sedamdeset" + (if ((n == 70) or ((n % 10) == 0)) then
                ""
              else
                (" i " + format_spellout_cardinal_neuter((n % 100)))
              end))
            end
            if (n >= 60) then
              return ("šezdeset" + (if ((n == 60) or ((n % 10) == 0)) then
                ""
              else
                (" i " + format_spellout_cardinal_neuter((n % 100)))
              end))
            end
            if (n >= 50) then
              return ("pedeset" + (if ((n == 50) or ((n % 10) == 0)) then
                ""
              else
                (" i " + format_spellout_cardinal_neuter((n % 100)))
              end))
            end
            if (n >= 40) then
              return ("četrdeset" + (if ((n == 40) or ((n % 10) == 0)) then
                ""
              else
                (" i " + format_spellout_cardinal_neuter((n % 100)))
              end))
            end
            if (n >= 30) then
              return ("trideset" + (if ((n == 30) or ((n % 10) == 0)) then
                ""
              else
                (" i " + format_spellout_cardinal_neuter((n % 100)))
              end))
            end
            if (n >= 20) then
              return ("dvadeset" + (if ((n == 20) or ((n % 10) == 0)) then
                ""
              else
                (" i " + format_spellout_cardinal_neuter((n % 100)))
              end))
            end
            return format_spellout_cardinal_masculine(n) if (n >= 3)
            return "dva" if (n >= 2)
            return "jedno" if (n >= 1)
            return "nula" if (n >= 0)
          end
          def format_spellout_cardinal_feminine(n)
            is_fractional = (n != n.floor)
            return ("minus " + format_spellout_cardinal_feminine(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_cardinal_feminine(n.floor) + " zarez ") + format_spellout_cardinal_feminine((n % 10)))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 5000000000000000) then
              return ((format_spellout_cardinal_feminine((n / 10000000000000000).floor) + " bilijardi") + (if ((n == 5000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 10000000000000000)))
              end))
            end
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_feminine((n / 10000000000000000).floor) + " bilijarde") + (if ((n == 2000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 10000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ((format_spellout_cardinal_feminine((n / 1000000000000000).floor) + " bilijarda") + (if ((n == 1000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000000000000)))
              end))
            end
            if (n >= 5000000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000000).floor) + " bilijuna") + (if ((n == 5000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 10000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000000).floor) + " bilijuna") + (if ((n == 2000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 10000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000000).floor) + " bilijun") + (if ((n == 1000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000000000)))
              end))
            end
            if (n >= 5000000000) then
              return ((format_spellout_cardinal_feminine((n / 10000000000).floor) + " milijardi") + (if ((n == 5000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 10000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_feminine((n / 10000000000).floor) + " milijarde") + (if ((n == 2000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 10000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((format_spellout_cardinal_feminine((n / 1000000000).floor) + " milijarda") + (if ((n == 1000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000000)))
              end))
            end
            if (n >= 5000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000).floor) + " milijuna") + (if ((n == 5000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 10000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000).floor) + " milijuna") + (if ((n == 2000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 10000000)))
              end))
            end
            if (n >= 1000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000).floor) + " milijun") + (if ((n == 1000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000)))
              end))
            end
            if (n >= 5000) then
              return ((format_spellout_cardinal_feminine((n / 10000).floor) + " tisuća") + (if ((n == 5000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 10000)))
              end))
            end
            if (n >= 2000) then
              return ((format_spellout_cardinal_feminine((n / 10000).floor) + " tisuće") + (if ((n == 2000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 10000)))
              end))
            end
            if (n >= 1000) then
              return ("tisuću" + (if ((n == 1000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000)))
              end))
            end
            if (n >= 900) then
              return ("devetsto" + (if ((n == 900) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000)))
              end))
            end
            if (n >= 800) then
              return ("osamsto" + (if ((n == 800) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000)))
              end))
            end
            if (n >= 700) then
              return ("sedamsto" + (if ((n == 700) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000)))
              end))
            end
            if (n >= 600) then
              return ("šeststo" + (if ((n == 600) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000)))
              end))
            end
            if (n >= 500) then
              return ("petsto" + (if ((n == 500) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000)))
              end))
            end
            if (n >= 400) then
              return ("četiristo" + (if ((n == 400) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000)))
              end))
            end
            if (n >= 300) then
              return ("tristo" + (if ((n == 300) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000)))
              end))
            end
            if (n >= 200) then
              return ("dvjesto" + (if ((n == 200) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000)))
              end))
            end
            if (n >= 100) then
              return ("sto" + (if ((n == 100) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100)))
              end))
            end
            if (n >= 90) then
              return ("devedeset" + (if ((n == 90) or ((n % 10) == 0)) then
                ""
              else
                (" i " + format_spellout_cardinal_feminine((n % 100)))
              end))
            end
            if (n >= 80) then
              return ("osamdeset" + (if ((n == 80) or ((n % 10) == 0)) then
                ""
              else
                (" i " + format_spellout_cardinal_feminine((n % 100)))
              end))
            end
            if (n >= 70) then
              return ("sedamdeset" + (if ((n == 70) or ((n % 10) == 0)) then
                ""
              else
                (" i " + format_spellout_cardinal_feminine((n % 100)))
              end))
            end
            if (n >= 60) then
              return ("šezdeset" + (if ((n == 60) or ((n % 10) == 0)) then
                ""
              else
                (" i " + format_spellout_cardinal_feminine((n % 100)))
              end))
            end
            if (n >= 50) then
              return ("pedeset" + (if ((n == 50) or ((n % 10) == 0)) then
                ""
              else
                (" i " + format_spellout_cardinal_feminine((n % 100)))
              end))
            end
            if (n >= 40) then
              return ("četrdeset" + (if ((n == 40) or ((n % 10) == 0)) then
                ""
              else
                (" i " + format_spellout_cardinal_feminine((n % 100)))
              end))
            end
            if (n >= 30) then
              return ("trideset" + (if ((n == 30) or ((n % 10) == 0)) then
                ""
              else
                (" i " + format_spellout_cardinal_feminine((n % 100)))
              end))
            end
            if (n >= 20) then
              return ("dvadeset" + (if ((n == 20) or ((n % 10) == 0)) then
                ""
              else
                (" i " + format_spellout_cardinal_feminine((n % 100)))
              end))
            end
            return format_spellout_cardinal_masculine(n) if (n >= 3)
            return "dvije" if (n >= 2)
            return "jedna" if (n >= 1)
            return "nula" if (n >= 0)
          end
          def format_spellout_ordinal_base(n)
            is_fractional = (n != n.floor)
            return ("minus " + format_spellout_ordinal_base(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 5000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000000000).floor) + " biliarda") + (if ((n == 5000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_base((n % 10000000000000000)))
              end))
            end
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000000000).floor) + " biliardy") + (if ((n == 2000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_base((n % 10000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000000000).floor) + " biliarda") + (if ((n == 1000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_base((n % 1000000000000000)))
              end))
            end
            if (n >= 5000000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000000).floor) + " bilijun") + (if ((n == 5000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_base((n % 10000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000000).floor) + " bilijuny") + (if ((n == 2000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_base((n % 10000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000000).floor) + " bilijun") + (if ((n == 1000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_base((n % 1000000000000)))
              end))
            end
            if (n >= 5000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000).floor) + " miliarda") + (if ((n == 5000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_base((n % 10000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000000).floor) + " miliardy") + (if ((n == 2000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_base((n % 10000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000).floor) + " miliarda") + (if ((n == 1000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_base((n % 1000000000)))
              end))
            end
            if (n >= 5000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000).floor) + " milijun") + (if ((n == 5000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_base((n % 10000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_masculine((n / 10000000).floor) + " milijuny") + (if ((n == 2000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_base((n % 10000000)))
              end))
            end
            if (n >= 1000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000).floor) + " milijun") + (if ((n == 1000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_base((n % 1000000)))
              end))
            end
            if (n >= 5000) then
              return ((format_spellout_cardinal_feminine((n / 10000).floor) + " tisuću") + (if ((n == 5000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_base((n % 10000)))
              end))
            end
            if (n >= 2000) then
              return ((format_spellout_cardinal_feminine((n / 10000).floor) + " tisuće") + (if ((n == 2000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_base((n % 10000)))
              end))
            end
            if (n >= 1000) then
              return ("tisuću" + (if ((n == 1000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_base((n % 1000)))
              end))
            end
            if (n >= 900) then
              return ("devetst" + (if ((n == 900) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_base((n % 1000)))
              end))
            end
            if (n >= 800) then
              return ("osamst" + (if ((n == 800) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_base((n % 1000)))
              end))
            end
            if (n >= 700) then
              return ("sedamst" + (if ((n == 700) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_base((n % 1000)))
              end))
            end
            if (n >= 600) then
              return ("šest" + (if ((n == 600) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_base((n % 1000)))
              end))
            end
            if (n >= 500) then
              return ("petst" + (if ((n == 500) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_base((n % 1000)))
              end))
            end
            if (n >= 400) then
              return ("četrist" + (if ((n == 400) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_base((n % 1000)))
              end))
            end
            if (n >= 300) then
              return ("trist" + (if ((n == 300) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_base((n % 1000)))
              end))
            end
            if (n >= 200) then
              return ("dvest" + (if ((n == 200) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_base((n % 1000)))
              end))
            end
            if (n >= 100) then
              return ("st" + (if ((n == 100) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_base((n % 100)))
              end))
            end
            if (n >= 90) then
              return ("devedeset" + (if ((n == 90) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_base((n % 100)))
              end))
            end
            if (n >= 80) then
              return ("osamdeset" + (if ((n == 80) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_base((n % 100)))
              end))
            end
            if (n >= 70) then
              return ("sedamdeset" + (if ((n == 70) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_base((n % 100)))
              end))
            end
            if (n >= 60) then
              return ("šezdeset" + (if ((n == 60) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_base((n % 100)))
              end))
            end
            if (n >= 50) then
              return ("pedeset" + (if ((n == 50) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_base((n % 100)))
              end))
            end
            if (n >= 40) then
              return ("četrdeset" + (if ((n == 40) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_base((n % 100)))
              end))
            end
            if (n >= 30) then
              return ("trideset" + (if ((n == 30) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_base((n % 100)))
              end))
            end
            if (n >= 20) then
              return ("dvadeset" + (if ((n == 20) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_base((n % 100)))
              end))
            end
            return format_spellout_numbering(n) if (n >= 11)
            return "deset" if (n >= 10)
            return "devet" if (n >= 9)
            return "osm" if (n >= 8)
            return "sedm" if (n >= 7)
            return "šest" if (n >= 6)
            return "pet" if (n >= 5)
            return "četvrt" if (n >= 4)
            return "treć" if (n >= 3)
            return "drug" if (n >= 2)
            return "prv" if (n >= 1)
            return "nula" if (n >= 0)
          end
          private(:format_spellout_ordinal_base)
          def format_spellout_ordinal_masculine(n)
            return (format_spellout_ordinal_base(n) + "i") if (n >= 0)
          end
          def format_spellout_ordinal_neuter(n)
            return (format_spellout_ordinal_base(n) + "o") if (n >= 4)
            return (format_spellout_ordinal_base(n) + "e") if (n >= 3)
            return (format_spellout_ordinal_base(n) + "o") if (n >= 0)
          end
          def format_spellout_ordinal_feminine(n)
            return (format_spellout_ordinal_base(n) + "a") if (n >= 0)
          end
        end
      end
    end
  end
end