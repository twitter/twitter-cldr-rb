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
              return ((format_spellout_cardinal_masculine(n.floor) + " zarez ") + format_spellout_cardinal_masculine(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 5000000000000000) then
              return ((format_spellout_cardinal_feminine((n / 5.0e+15).floor) + " bilijardi") + (if (n == 5000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000000000000)))
              end))
            end
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_feminine((n / 2.0e+15).floor) + " bilijarde") + (if (n == 2000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ((format_spellout_cardinal_feminine((n / 1.0e+15).floor) + " bilijarda") + (if (n == 1000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100000000000000)))
              end))
            end
            if (n >= 5000000000000) then
              return ((format_spellout_cardinal_masculine((n / 5000000000000.0).floor) + " bilijuna") + (if (n == 5000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000000000.0).floor) + " bilijuna") + (if (n == 2000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000000.0).floor) + " bilijun") + (if (n == 1000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100000000000)))
              end))
            end
            if (n >= 5000000000) then
              return ((format_spellout_cardinal_feminine((n / 5000000000.0).floor) + " milijardi") + (if (n == 5000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_feminine((n / 2000000000.0).floor) + " milijarde") + (if (n == 2000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((format_spellout_cardinal_feminine((n / 1000000000.0).floor) + " milijarda") + (if (n == 1000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100000000)))
              end))
            end
            if (n >= 5000000) then
              return ((format_spellout_cardinal_masculine((n / 5000000.0).floor) + " milijuna") + (if (n == 5000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000.0).floor) + " milijuna") + (if (n == 2000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000.0).floor) + " milijun") + (if (n == 1000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100000)))
              end))
            end
            if (n >= 5000) then
              return ((format_spellout_cardinal_feminine((n / 5000.0).floor) + " tisuća") + (if (n == 5000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000)))
              end))
            end
            if (n >= 2000) then
              return ((format_spellout_cardinal_feminine((n / 2000.0).floor) + " tisuće") + (if (n == 2000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000)))
              end))
            end
            if (n >= 1000) then
              return ("tisuću" + (if (n == 1000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100)))
              end))
            end
            if (n >= 900) then
              return ("devetsto" + ((n == 900) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 100))))))
            end
            if (n >= 800) then
              return ("osamsto" + ((n == 800) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 100))))))
            end
            if (n >= 700) then
              return ("sedamsto" + ((n == 700) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 100))))))
            end
            if (n >= 600) then
              return ("šeststo" + ((n == 600) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 100))))))
            end
            if (n >= 500) then
              return ("petsto" + ((n == 500) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 100))))))
            end
            if (n >= 400) then
              return ("četiristo" + ((n == 400) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 100))))))
            end
            if (n >= 300) then
              return ("tristo" + ((n == 300) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 100))))))
            end
            if (n >= 200) then
              return ("dvjesto" + ((n == 200) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 100))))))
            end
            if (n >= 100) then
              return ("sto" + ((n == 100) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 100))))))
            end
            if (n >= 90) then
              return ("devedeset" + ((n == 90) ? ("") : ((" i " + format_spellout_cardinal_masculine((n % 10))))))
            end
            if (n >= 80) then
              return ("osamdeset" + ((n == 80) ? ("") : ((" i " + format_spellout_cardinal_masculine((n % 10))))))
            end
            if (n >= 70) then
              return ("sedamdeset" + ((n == 70) ? ("") : ((" i " + format_spellout_cardinal_masculine((n % 10))))))
            end
            if (n >= 60) then
              return ("šezdeset" + ((n == 60) ? ("") : ((" i " + format_spellout_cardinal_masculine((n % 10))))))
            end
            if (n >= 50) then
              return ("pedeset" + ((n == 50) ? ("") : ((" i " + format_spellout_cardinal_masculine((n % 10))))))
            end
            if (n >= 40) then
              return ("četrdeset" + ((n == 40) ? ("") : ((" i " + format_spellout_cardinal_masculine((n % 10))))))
            end
            if (n >= 30) then
              return ("trideset" + ((n == 30) ? ("") : ((" i " + format_spellout_cardinal_masculine((n % 10))))))
            end
            if (n >= 20) then
              return ("dvadeset" + ((n == 20) ? ("") : ((" i " + format_spellout_cardinal_masculine((n % 10))))))
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
              return ((format_spellout_cardinal_neuter(n.floor) + " zarez ") + format_spellout_cardinal_neuter(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 5000000000000000) then
              return ((format_spellout_cardinal_feminine((n / 5.0e+15).floor) + " bilijardi") + (if (n == 5000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000000000000000)))
              end))
            end
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_feminine((n / 2.0e+15).floor) + " bilijarde") + (if (n == 2000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ((format_spellout_cardinal_feminine((n / 1.0e+15).floor) + " bilijarda") + (if (n == 1000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 100000000000000)))
              end))
            end
            if (n >= 5000000000000) then
              return ((format_spellout_cardinal_masculine((n / 5000000000000.0).floor) + " bilijuna") + (if (n == 5000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000000000.0).floor) + " bilijuna") + (if (n == 2000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000000.0).floor) + " bilijun") + (if (n == 1000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 100000000000)))
              end))
            end
            if (n >= 5000000000) then
              return ((format_spellout_cardinal_feminine((n / 5000000000.0).floor) + " milijardi") + (if (n == 5000000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_feminine((n / 2000000000.0).floor) + " milijarde") + (if (n == 2000000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((format_spellout_cardinal_feminine((n / 1000000000.0).floor) + " milijarda") + (if (n == 1000000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 100000000)))
              end))
            end
            if (n >= 5000000) then
              return ((format_spellout_cardinal_masculine((n / 5000000.0).floor) + " milijuna") + (if (n == 5000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000.0).floor) + " milijuna") + (if (n == 2000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000.0).floor) + " milijun") + (if (n == 1000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter((n % 100000)))
              end))
            end
            if (n >= 5000) then
              return ((format_spellout_cardinal_feminine((n / 5000.0).floor) + " tisuća") + ((n == 5000) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 1000))))))
            end
            if (n >= 2000) then
              return ((format_spellout_cardinal_feminine((n / 2000.0).floor) + " tisuće") + ((n == 2000) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 1000))))))
            end
            if (n >= 1000) then
              return ("tisuću" + ((n == 1000) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 100))))))
            end
            if (n >= 900) then
              return ("devetsto" + ((n == 900) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 100))))))
            end
            if (n >= 800) then
              return ("osamsto" + ((n == 800) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 100))))))
            end
            if (n >= 700) then
              return ("sedamsto" + ((n == 700) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 100))))))
            end
            if (n >= 600) then
              return ("šeststo" + ((n == 600) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 100))))))
            end
            if (n >= 500) then
              return ("petsto" + ((n == 500) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 100))))))
            end
            if (n >= 400) then
              return ("četiristo" + ((n == 400) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 100))))))
            end
            if (n >= 300) then
              return ("tristo" + ((n == 300) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 100))))))
            end
            if (n >= 200) then
              return ("dvjesto" + ((n == 200) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 100))))))
            end
            if (n >= 100) then
              return ("sto" + ((n == 100) ? ("") : ((" " + format_spellout_cardinal_neuter((n % 100))))))
            end
            if (n >= 90) then
              return ("devedeset" + ((n == 90) ? ("") : ((" i " + format_spellout_cardinal_neuter((n % 10))))))
            end
            if (n >= 80) then
              return ("osamdeset" + ((n == 80) ? ("") : ((" i " + format_spellout_cardinal_neuter((n % 10))))))
            end
            if (n >= 70) then
              return ("sedamdeset" + ((n == 70) ? ("") : ((" i " + format_spellout_cardinal_neuter((n % 10))))))
            end
            if (n >= 60) then
              return ("šezdeset" + ((n == 60) ? ("") : ((" i " + format_spellout_cardinal_neuter((n % 10))))))
            end
            if (n >= 50) then
              return ("pedeset" + ((n == 50) ? ("") : ((" i " + format_spellout_cardinal_neuter((n % 10))))))
            end
            if (n >= 40) then
              return ("četrdeset" + ((n == 40) ? ("") : ((" i " + format_spellout_cardinal_neuter((n % 10))))))
            end
            if (n >= 30) then
              return ("trideset" + ((n == 30) ? ("") : ((" i " + format_spellout_cardinal_neuter((n % 10))))))
            end
            if (n >= 20) then
              return ("dvadeset" + ((n == 20) ? ("") : ((" i " + format_spellout_cardinal_neuter((n % 10))))))
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
              return ((format_spellout_cardinal_feminine(n.floor) + " zarez ") + format_spellout_cardinal_feminine(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 5000000000000000) then
              return ((format_spellout_cardinal_feminine((n / 5.0e+15).floor) + " bilijardi") + (if (n == 5000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000000000000)))
              end))
            end
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_feminine((n / 2.0e+15).floor) + " bilijarde") + (if (n == 2000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ((format_spellout_cardinal_feminine((n / 1.0e+15).floor) + " bilijarda") + (if (n == 1000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100000000000000)))
              end))
            end
            if (n >= 5000000000000) then
              return ((format_spellout_cardinal_masculine((n / 5000000000000.0).floor) + " bilijuna") + (if (n == 5000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000000000.0).floor) + " bilijuna") + (if (n == 2000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000000.0).floor) + " bilijun") + (if (n == 1000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100000000000)))
              end))
            end
            if (n >= 5000000000) then
              return ((format_spellout_cardinal_feminine((n / 5000000000.0).floor) + " milijardi") + (if (n == 5000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_feminine((n / 2000000000.0).floor) + " milijarde") + (if (n == 2000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((format_spellout_cardinal_feminine((n / 1000000000.0).floor) + " milijarda") + (if (n == 1000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100000000)))
              end))
            end
            if (n >= 5000000) then
              return ((format_spellout_cardinal_masculine((n / 5000000.0).floor) + " milijuna") + (if (n == 5000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000.0).floor) + " milijuna") + (if (n == 2000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000.0).floor) + " milijun") + (if (n == 1000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 100000)))
              end))
            end
            if (n >= 5000) then
              return ((format_spellout_cardinal_feminine((n / 5000.0).floor) + " tisuća") + (if (n == 5000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000)))
              end))
            end
            if (n >= 2000) then
              return ((format_spellout_cardinal_feminine((n / 2000.0).floor) + " tisuće") + (if (n == 2000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine((n % 1000)))
              end))
            end
            if (n >= 1000) then
              return ("tisuću" + ((n == 1000) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 100))))))
            end
            if (n >= 900) then
              return ("devetsto" + ((n == 900) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 100))))))
            end
            if (n >= 800) then
              return ("osamsto" + ((n == 800) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 100))))))
            end
            if (n >= 700) then
              return ("sedamsto" + ((n == 700) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 100))))))
            end
            if (n >= 600) then
              return ("šeststo" + ((n == 600) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 100))))))
            end
            if (n >= 500) then
              return ("petsto" + ((n == 500) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 100))))))
            end
            if (n >= 400) then
              return ("četiristo" + ((n == 400) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 100))))))
            end
            if (n >= 300) then
              return ("tristo" + ((n == 300) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 100))))))
            end
            if (n >= 200) then
              return ("dvjesto" + ((n == 200) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 100))))))
            end
            if (n >= 100) then
              return ("sto" + ((n == 100) ? ("") : ((" " + format_spellout_cardinal_feminine((n % 100))))))
            end
            if (n >= 90) then
              return ("devedeset" + ((n == 90) ? ("") : ((" i " + format_spellout_cardinal_feminine((n % 10))))))
            end
            if (n >= 80) then
              return ("osamdeset" + ((n == 80) ? ("") : ((" i " + format_spellout_cardinal_feminine((n % 10))))))
            end
            if (n >= 70) then
              return ("sedamdeset" + ((n == 70) ? ("") : ((" i " + format_spellout_cardinal_feminine((n % 10))))))
            end
            if (n >= 60) then
              return ("šezdeset" + ((n == 60) ? ("") : ((" i " + format_spellout_cardinal_feminine((n % 10))))))
            end
            if (n >= 50) then
              return ("pedeset" + ((n == 50) ? ("") : ((" i " + format_spellout_cardinal_feminine((n % 10))))))
            end
            if (n >= 40) then
              return ("četrdeset" + ((n == 40) ? ("") : ((" i " + format_spellout_cardinal_feminine((n % 10))))))
            end
            if (n >= 30) then
              return ("trideset" + ((n == 30) ? ("") : ((" i " + format_spellout_cardinal_feminine((n % 10))))))
            end
            if (n >= 20) then
              return ("dvadeset" + ((n == 20) ? ("") : ((" i " + format_spellout_cardinal_feminine((n % 10))))))
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
              return ((format_spellout_cardinal_masculine((n / 5.0e+15).floor) + " biliarda") + (if (n == 5000000000000000) then
                ""
              else
                (" " + format_spellout_ordinal_base((n % 1000000000000000)))
              end))
            end
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 2.0e+15).floor) + " biliardy") + (if (n == 2000000000000000) then
                ""
              else
                (" " + format_spellout_ordinal_base((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 1.0e+15).floor) + " biliarda") + (if (n == 1000000000000000) then
                ""
              else
                (" " + format_spellout_ordinal_base((n % 100000000000000)))
              end))
            end
            if (n >= 5000000000000) then
              return ((format_spellout_cardinal_masculine((n / 5000000000000.0).floor) + " bilijun") + (if (n == 5000000000000) then
                ""
              else
                (" " + format_spellout_ordinal_base((n % 1000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000000000.0).floor) + " bilijuny") + (if (n == 2000000000000) then
                ""
              else
                (" " + format_spellout_ordinal_base((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000000.0).floor) + " bilijun") + (if (n == 1000000000000) then
                ""
              else
                (" " + format_spellout_ordinal_base((n % 100000000000)))
              end))
            end
            if (n >= 5000000000) then
              return ((format_spellout_cardinal_masculine((n / 5000000000.0).floor) + " miliarda") + (if (n == 5000000000) then
                ""
              else
                (" " + format_spellout_ordinal_base((n % 1000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000000.0).floor) + " miliardy") + (if (n == 2000000000) then
                ""
              else
                (" " + format_spellout_ordinal_base((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000.0).floor) + " miliarda") + (if (n == 1000000000) then
                ""
              else
                (" " + format_spellout_ordinal_base((n % 100000000)))
              end))
            end
            if (n >= 5000000) then
              return ((format_spellout_cardinal_masculine((n / 5000000.0).floor) + " milijun") + (if (n == 5000000) then
                ""
              else
                (" " + format_spellout_ordinal_base((n % 1000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000.0).floor) + " milijuny") + (if (n == 2000000) then
                ""
              else
                (" " + format_spellout_ordinal_base((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000.0).floor) + " milijun") + (if (n == 1000000) then
                ""
              else
                (" " + format_spellout_ordinal_base((n % 100000)))
              end))
            end
            if (n >= 5000) then
              return ((format_spellout_cardinal_feminine((n / 5000.0).floor) + " tisuću") + ((n == 5000) ? ("") : ((" " + format_spellout_ordinal_base((n % 1000))))))
            end
            if (n >= 2000) then
              return ((format_spellout_cardinal_feminine((n / 2000.0).floor) + " tisuće") + ((n == 2000) ? ("") : ((" " + format_spellout_ordinal_base((n % 1000))))))
            end
            if (n >= 1000) then
              return ("tisuću" + ((n == 1000) ? ("") : ((" " + format_spellout_ordinal_base((n % 100))))))
            end
            if (n >= 900) then
              return ("devetst" + ((n == 900) ? ("") : ((" " + format_spellout_ordinal_base((n % 100))))))
            end
            if (n >= 800) then
              return ("osamst" + ((n == 800) ? ("") : ((" " + format_spellout_ordinal_base((n % 100))))))
            end
            if (n >= 700) then
              return ("sedamst" + ((n == 700) ? ("") : ((" " + format_spellout_ordinal_base((n % 100))))))
            end
            if (n >= 600) then
              return ("šest" + ((n == 600) ? ("") : ((" " + format_spellout_ordinal_base((n % 100))))))
            end
            if (n >= 500) then
              return ("petst" + ((n == 500) ? ("") : ((" " + format_spellout_ordinal_base((n % 100))))))
            end
            if (n >= 400) then
              return ("četrist" + ((n == 400) ? ("") : ((" " + format_spellout_ordinal_base((n % 100))))))
            end
            if (n >= 300) then
              return ("trist" + ((n == 300) ? ("") : ((" " + format_spellout_ordinal_base((n % 100))))))
            end
            if (n >= 200) then
              return ("dvest" + ((n == 200) ? ("") : ((" " + format_spellout_ordinal_base((n % 100))))))
            end
            if (n >= 100) then
              return ("st" + ((n == 100) ? ("") : ((" " + format_spellout_ordinal_base((n % 100))))))
            end
            if (n >= 90) then
              return ("devedeset" + ((n == 90) ? ("") : ((" " + format_spellout_ordinal_base((n % 10))))))
            end
            if (n >= 80) then
              return ("osamdeset" + ((n == 80) ? ("") : ((" " + format_spellout_ordinal_base((n % 10))))))
            end
            if (n >= 70) then
              return ("sedamdeset" + ((n == 70) ? ("") : ((" " + format_spellout_ordinal_base((n % 10))))))
            end
            if (n >= 60) then
              return ("šezdeset" + ((n == 60) ? ("") : ((" " + format_spellout_ordinal_base((n % 10))))))
            end
            if (n >= 50) then
              return ("pedeset" + ((n == 50) ? ("") : ((" " + format_spellout_ordinal_base((n % 10))))))
            end
            if (n >= 40) then
              return ("četrdeset" + ((n == 40) ? ("") : ((" " + format_spellout_ordinal_base((n % 10))))))
            end
            if (n >= 30) then
              return ("trideset" + ((n == 30) ? ("") : ((" " + format_spellout_ordinal_base((n % 10))))))
            end
            if (n >= 20) then
              return ("dvadeset" + ((n == 20) ? ("") : ((" " + format_spellout_ordinal_base((n % 10))))))
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