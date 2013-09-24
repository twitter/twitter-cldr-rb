# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:hr] = Croatian = Class.new do
        class << self
          (def renderSpelloutNumberingYear(n)
            is_fractional = (n != n.floor)
            return n.to_s if is_fractional and (n > 1)
            return renderSpelloutNumbering(n) if (n >= 0)
          end
          def renderSpelloutNumbering(n)
            return renderSpelloutCardinalMasculine(n) if (n >= 0)
          end
          def renderSpelloutCardinalMasculine(n)
            is_fractional = (n != n.floor)
            return ("minus " + renderSpelloutCardinalMasculine(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((renderSpelloutCardinalMasculine(n.floor) + " zarez ") + renderSpelloutCardinalMasculine(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 5000000000000000) then
              return ((renderSpelloutCardinalFeminine((n / 5.0e+15).floor) + " bilijardi") + (if (n == 5000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 1000000000000000)))
              end))
            end
            if (n >= 2000000000000000) then
              return ((renderSpelloutCardinalFeminine((n / 2.0e+15).floor) + " bilijarde") + (if (n == 2000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ((renderSpelloutCardinalFeminine((n / 1.0e+15).floor) + " bilijarda") + (if (n == 1000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 100000000000000)))
              end))
            end
            if (n >= 5000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 5000000000000.0).floor) + " bilijuna") + (if (n == 5000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 1000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000000.0).floor) + " bilijuna") + (if (n == 2000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000000000.0).floor) + " bilijun") + (if (n == 1000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 100000000000)))
              end))
            end
            if (n >= 5000000000) then
              return ((renderSpelloutCardinalFeminine((n / 5000000000.0).floor) + " milijardi") + (if (n == 5000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 1000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((renderSpelloutCardinalFeminine((n / 2000000000.0).floor) + " milijarde") + (if (n == 2000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((renderSpelloutCardinalFeminine((n / 1000000000.0).floor) + " milijarda") + (if (n == 1000000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 100000000)))
              end))
            end
            if (n >= 5000000) then
              return ((renderSpelloutCardinalMasculine((n / 5000000.0).floor) + " milijuna") + (if (n == 5000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 1000000)))
              end))
            end
            if (n >= 2000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000.0).floor) + " milijuna") + (if (n == 2000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000.0).floor) + " milijun") + (if (n == 1000000) then
                ""
              else
                (" " + renderSpelloutCardinalMasculine((n % 100000)))
              end))
            end
            if (n >= 5000) then
              return ((renderSpelloutCardinalFeminine((n / 5000.0).floor) + " tisuća") + ((n == 5000) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 1000))))))
            end
            if (n >= 2000) then
              return ((renderSpelloutCardinalFeminine((n / 2000.0).floor) + " tisuće") + ((n == 2000) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 1000))))))
            end
            if (n >= 1000) then
              return ("tisuću" + ((n == 1000) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 900) then
              return ("devetsto" + ((n == 900) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 800) then
              return ("osamsto" + ((n == 800) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 700) then
              return ("sedamsto" + ((n == 700) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 600) then
              return ("šeststo" + ((n == 600) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 500) then
              return ("petsto" + ((n == 500) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 400) then
              return ("četiristo" + ((n == 400) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 300) then
              return ("tristo" + ((n == 300) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 200) then
              return ("dvjesto" + ((n == 200) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 100) then
              return ("sto" + ((n == 100) ? ("") : ((" " + renderSpelloutCardinalMasculine((n % 100))))))
            end
            if (n >= 90) then
              return ("devedeset" + ((n == 90) ? ("") : ((" i " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 80) then
              return ("osamdeset" + ((n == 80) ? ("") : ((" i " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 70) then
              return ("sedamdeset" + ((n == 70) ? ("") : ((" i " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 60) then
              return ("šezdeset" + ((n == 60) ? ("") : ((" i " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 50) then
              return ("pedeset" + ((n == 50) ? ("") : ((" i " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 40) then
              return ("četrdeset" + ((n == 40) ? ("") : ((" i " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 30) then
              return ("trideset" + ((n == 30) ? ("") : ((" i " + renderSpelloutCardinalMasculine((n % 10))))))
            end
            if (n >= 20) then
              return ("dvadeset" + ((n == 20) ? ("") : ((" i " + renderSpelloutCardinalMasculine((n % 10))))))
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
          def renderSpelloutCardinalNeuter(n)
            is_fractional = (n != n.floor)
            return ("minus " + renderSpelloutCardinalNeuter(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((renderSpelloutCardinalNeuter(n.floor) + " zarez ") + renderSpelloutCardinalNeuter(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 5000000000000000) then
              return ((renderSpelloutCardinalFeminine((n / 5.0e+15).floor) + " bilijardi") + (if (n == 5000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 1000000000000000)))
              end))
            end
            if (n >= 2000000000000000) then
              return ((renderSpelloutCardinalFeminine((n / 2.0e+15).floor) + " bilijarde") + (if (n == 2000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ((renderSpelloutCardinalFeminine((n / 1.0e+15).floor) + " bilijarda") + (if (n == 1000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 100000000000000)))
              end))
            end
            if (n >= 5000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 5000000000000.0).floor) + " bilijuna") + (if (n == 5000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 1000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000000.0).floor) + " bilijuna") + (if (n == 2000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000000000.0).floor) + " bilijun") + (if (n == 1000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 100000000000)))
              end))
            end
            if (n >= 5000000000) then
              return ((renderSpelloutCardinalFeminine((n / 5000000000.0).floor) + " milijardi") + (if (n == 5000000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 1000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((renderSpelloutCardinalFeminine((n / 2000000000.0).floor) + " milijarde") + (if (n == 2000000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((renderSpelloutCardinalFeminine((n / 1000000000.0).floor) + " milijarda") + (if (n == 1000000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 100000000)))
              end))
            end
            if (n >= 5000000) then
              return ((renderSpelloutCardinalMasculine((n / 5000000.0).floor) + " milijuna") + (if (n == 5000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 1000000)))
              end))
            end
            if (n >= 2000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000.0).floor) + " milijuna") + (if (n == 2000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000.0).floor) + " milijun") + (if (n == 1000000) then
                ""
              else
                (" " + renderSpelloutCardinalNeuter((n % 100000)))
              end))
            end
            if (n >= 5000) then
              return ((renderSpelloutCardinalFeminine((n / 5000.0).floor) + " tisuća") + ((n == 5000) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 1000))))))
            end
            if (n >= 2000) then
              return ((renderSpelloutCardinalFeminine((n / 2000.0).floor) + " tisuće") + ((n == 2000) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 1000))))))
            end
            if (n >= 1000) then
              return ("tisuću" + ((n == 1000) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 100))))))
            end
            if (n >= 900) then
              return ("devetsto" + ((n == 900) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 100))))))
            end
            if (n >= 800) then
              return ("osamsto" + ((n == 800) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 100))))))
            end
            if (n >= 700) then
              return ("sedamsto" + ((n == 700) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 100))))))
            end
            if (n >= 600) then
              return ("šeststo" + ((n == 600) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 100))))))
            end
            if (n >= 500) then
              return ("petsto" + ((n == 500) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 100))))))
            end
            if (n >= 400) then
              return ("četiristo" + ((n == 400) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 100))))))
            end
            if (n >= 300) then
              return ("tristo" + ((n == 300) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 100))))))
            end
            if (n >= 200) then
              return ("dvjesto" + ((n == 200) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 100))))))
            end
            if (n >= 100) then
              return ("sto" + ((n == 100) ? ("") : ((" " + renderSpelloutCardinalNeuter((n % 100))))))
            end
            if (n >= 90) then
              return ("devedeset" + ((n == 90) ? ("") : ((" i " + renderSpelloutCardinalNeuter((n % 10))))))
            end
            if (n >= 80) then
              return ("osamdeset" + ((n == 80) ? ("") : ((" i " + renderSpelloutCardinalNeuter((n % 10))))))
            end
            if (n >= 70) then
              return ("sedamdeset" + ((n == 70) ? ("") : ((" i " + renderSpelloutCardinalNeuter((n % 10))))))
            end
            if (n >= 60) then
              return ("šezdeset" + ((n == 60) ? ("") : ((" i " + renderSpelloutCardinalNeuter((n % 10))))))
            end
            if (n >= 50) then
              return ("pedeset" + ((n == 50) ? ("") : ((" i " + renderSpelloutCardinalNeuter((n % 10))))))
            end
            if (n >= 40) then
              return ("četrdeset" + ((n == 40) ? ("") : ((" i " + renderSpelloutCardinalNeuter((n % 10))))))
            end
            if (n >= 30) then
              return ("trideset" + ((n == 30) ? ("") : ((" i " + renderSpelloutCardinalNeuter((n % 10))))))
            end
            if (n >= 20) then
              return ("dvadeset" + ((n == 20) ? ("") : ((" i " + renderSpelloutCardinalNeuter((n % 10))))))
            end
            return renderSpelloutCardinalMasculine(n) if (n >= 3)
            return "dva" if (n >= 2)
            return "jedno" if (n >= 1)
            return "nula" if (n >= 0)
          end
          def renderSpelloutCardinalFeminine(n)
            is_fractional = (n != n.floor)
            return ("minus " + renderSpelloutCardinalFeminine(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((renderSpelloutCardinalFeminine(n.floor) + " zarez ") + renderSpelloutCardinalFeminine(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 5000000000000000) then
              return ((renderSpelloutCardinalFeminine((n / 5.0e+15).floor) + " bilijardi") + (if (n == 5000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 1000000000000000)))
              end))
            end
            if (n >= 2000000000000000) then
              return ((renderSpelloutCardinalFeminine((n / 2.0e+15).floor) + " bilijarde") + (if (n == 2000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ((renderSpelloutCardinalFeminine((n / 1.0e+15).floor) + " bilijarda") + (if (n == 1000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 100000000000000)))
              end))
            end
            if (n >= 5000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 5000000000000.0).floor) + " bilijuna") + (if (n == 5000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 1000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000000.0).floor) + " bilijuna") + (if (n == 2000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000000000.0).floor) + " bilijun") + (if (n == 1000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 100000000000)))
              end))
            end
            if (n >= 5000000000) then
              return ((renderSpelloutCardinalFeminine((n / 5000000000.0).floor) + " milijardi") + (if (n == 5000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 1000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((renderSpelloutCardinalFeminine((n / 2000000000.0).floor) + " milijarde") + (if (n == 2000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((renderSpelloutCardinalFeminine((n / 1000000000.0).floor) + " milijarda") + (if (n == 1000000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 100000000)))
              end))
            end
            if (n >= 5000000) then
              return ((renderSpelloutCardinalMasculine((n / 5000000.0).floor) + " milijuna") + (if (n == 5000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 1000000)))
              end))
            end
            if (n >= 2000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000.0).floor) + " milijuna") + (if (n == 2000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000.0).floor) + " milijun") + (if (n == 1000000) then
                ""
              else
                (" " + renderSpelloutCardinalFeminine((n % 100000)))
              end))
            end
            if (n >= 5000) then
              return ((renderSpelloutCardinalFeminine((n / 5000.0).floor) + " tisuća") + ((n == 5000) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 1000))))))
            end
            if (n >= 2000) then
              return ((renderSpelloutCardinalFeminine((n / 2000.0).floor) + " tisuće") + ((n == 2000) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 1000))))))
            end
            if (n >= 1000) then
              return ("tisuću" + ((n == 1000) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 900) then
              return ("devetsto" + ((n == 900) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 800) then
              return ("osamsto" + ((n == 800) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 700) then
              return ("sedamsto" + ((n == 700) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 600) then
              return ("šeststo" + ((n == 600) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 500) then
              return ("petsto" + ((n == 500) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 400) then
              return ("četiristo" + ((n == 400) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 300) then
              return ("tristo" + ((n == 300) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 200) then
              return ("dvjesto" + ((n == 200) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 100) then
              return ("sto" + ((n == 100) ? ("") : ((" " + renderSpelloutCardinalFeminine((n % 100))))))
            end
            if (n >= 90) then
              return ("devedeset" + ((n == 90) ? ("") : ((" i " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 80) then
              return ("osamdeset" + ((n == 80) ? ("") : ((" i " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 70) then
              return ("sedamdeset" + ((n == 70) ? ("") : ((" i " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 60) then
              return ("šezdeset" + ((n == 60) ? ("") : ((" i " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 50) then
              return ("pedeset" + ((n == 50) ? ("") : ((" i " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 40) then
              return ("četrdeset" + ((n == 40) ? ("") : ((" i " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 30) then
              return ("trideset" + ((n == 30) ? ("") : ((" i " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            if (n >= 20) then
              return ("dvadeset" + ((n == 20) ? ("") : ((" i " + renderSpelloutCardinalFeminine((n % 10))))))
            end
            return renderSpelloutCardinalMasculine(n) if (n >= 3)
            return "dvije" if (n >= 2)
            return "jedna" if (n >= 1)
            return "nula" if (n >= 0)
          end
          def renderSpelloutOrdinalBase(n)
            is_fractional = (n != n.floor)
            return ("minus " + renderSpelloutOrdinalBase(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 5000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 5.0e+15).floor) + " biliarda") + (if (n == 5000000000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalBase((n % 1000000000000000)))
              end))
            end
            if (n >= 2000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2.0e+15).floor) + " biliardy") + (if (n == 2000000000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalBase((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 1.0e+15).floor) + " biliarda") + (if (n == 1000000000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalBase((n % 100000000000000)))
              end))
            end
            if (n >= 5000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 5000000000000.0).floor) + " bilijun") + (if (n == 5000000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalBase((n % 1000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000000.0).floor) + " bilijuny") + (if (n == 2000000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalBase((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000000000.0).floor) + " bilijun") + (if (n == 1000000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalBase((n % 100000000000)))
              end))
            end
            if (n >= 5000000000) then
              return ((renderSpelloutCardinalMasculine((n / 5000000000.0).floor) + " miliarda") + (if (n == 5000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalBase((n % 1000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000000.0).floor) + " miliardy") + (if (n == 2000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalBase((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000000.0).floor) + " miliarda") + (if (n == 1000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalBase((n % 100000000)))
              end))
            end
            if (n >= 5000000) then
              return ((renderSpelloutCardinalMasculine((n / 5000000.0).floor) + " milijun") + ((n == 5000000) ? ("") : ((" " + renderSpelloutOrdinalBase((n % 1000000))))))
            end
            if (n >= 2000000) then
              return ((renderSpelloutCardinalMasculine((n / 2000000.0).floor) + " milijuny") + ((n == 2000000) ? ("") : ((" " + renderSpelloutOrdinalBase((n % 1000000))))))
            end
            if (n >= 1000000) then
              return ((renderSpelloutCardinalMasculine((n / 1000000.0).floor) + " milijun") + ((n == 1000000) ? ("") : ((" " + renderSpelloutOrdinalBase((n % 100000))))))
            end
            if (n >= 5000) then
              return ((renderSpelloutCardinalFeminine((n / 5000.0).floor) + " tisuću") + ((n == 5000) ? ("") : ((" " + renderSpelloutOrdinalBase((n % 1000))))))
            end
            if (n >= 2000) then
              return ((renderSpelloutCardinalFeminine((n / 2000.0).floor) + " tisuće") + ((n == 2000) ? ("") : ((" " + renderSpelloutOrdinalBase((n % 1000))))))
            end
            if (n >= 1000) then
              return ("tisuću" + ((n == 1000) ? ("") : ((" " + renderSpelloutOrdinalBase((n % 100))))))
            end
            if (n >= 900) then
              return ("devetst" + ((n == 900) ? ("") : ((" " + renderSpelloutOrdinalBase((n % 100))))))
            end
            if (n >= 800) then
              return ("osamst" + ((n == 800) ? ("") : ((" " + renderSpelloutOrdinalBase((n % 100))))))
            end
            if (n >= 700) then
              return ("sedamst" + ((n == 700) ? ("") : ((" " + renderSpelloutOrdinalBase((n % 100))))))
            end
            if (n >= 600) then
              return ("šest" + ((n == 600) ? ("") : ((" " + renderSpelloutOrdinalBase((n % 100))))))
            end
            if (n >= 500) then
              return ("petst" + ((n == 500) ? ("") : ((" " + renderSpelloutOrdinalBase((n % 100))))))
            end
            if (n >= 400) then
              return ("četrist" + ((n == 400) ? ("") : ((" " + renderSpelloutOrdinalBase((n % 100))))))
            end
            if (n >= 300) then
              return ("trist" + ((n == 300) ? ("") : ((" " + renderSpelloutOrdinalBase((n % 100))))))
            end
            if (n >= 200) then
              return ("dvest" + ((n == 200) ? ("") : ((" " + renderSpelloutOrdinalBase((n % 100))))))
            end
            if (n >= 100) then
              return ("st" + ((n == 100) ? ("") : ((" " + renderSpelloutOrdinalBase((n % 100))))))
            end
            if (n >= 90) then
              return ("devedeset" + ((n == 90) ? ("") : ((" " + renderSpelloutOrdinalBase((n % 10))))))
            end
            if (n >= 80) then
              return ("osamdeset" + ((n == 80) ? ("") : ((" " + renderSpelloutOrdinalBase((n % 10))))))
            end
            if (n >= 70) then
              return ("sedamdeset" + ((n == 70) ? ("") : ((" " + renderSpelloutOrdinalBase((n % 10))))))
            end
            if (n >= 60) then
              return ("šezdeset" + ((n == 60) ? ("") : ((" " + renderSpelloutOrdinalBase((n % 10))))))
            end
            if (n >= 50) then
              return ("pedeset" + ((n == 50) ? ("") : ((" " + renderSpelloutOrdinalBase((n % 10))))))
            end
            if (n >= 40) then
              return ("četrdeset" + ((n == 40) ? ("") : ((" " + renderSpelloutOrdinalBase((n % 10))))))
            end
            if (n >= 30) then
              return ("trideset" + ((n == 30) ? ("") : ((" " + renderSpelloutOrdinalBase((n % 10))))))
            end
            if (n >= 20) then
              return ("dvadeset" + ((n == 20) ? ("") : ((" " + renderSpelloutOrdinalBase((n % 10))))))
            end
            return renderSpelloutNumbering(n) if (n >= 11)
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
          private(:renderSpelloutOrdinalBase)
          def renderSpelloutOrdinalMasculine(n)
            return (renderSpelloutOrdinalBase(n) + "i") if (n >= 0)
          end
          def renderSpelloutOrdinalNeuter(n)
            return (renderSpelloutOrdinalBase(n) + "o") if (n >= 4)
            return (renderSpelloutOrdinalBase(n) + "e") if (n >= 3)
            return (renderSpelloutOrdinalBase(n) + "o") if (n >= 0)
          end
          def renderSpelloutOrdinalFeminine(n)
            return (renderSpelloutOrdinalBase(n) + "a") if (n >= 0)
          end)
        end
      end
    end
  end
end