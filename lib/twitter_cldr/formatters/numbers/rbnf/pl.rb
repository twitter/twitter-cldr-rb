# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:pl] = Polish = Module.new { }
      
      class Polish::Spellout
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
              return ((format_spellout_cardinal_masculine(n.floor) + " przecinek ") + format_spellout_cardinal_masculine(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 5000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 5.0e+15).floor) + " biliardów") + (if (n == 5000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000000000000)))
              end))
            end
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 2.0e+15).floor) + " biliardy") + (if (n == 2000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 1.0e+15).floor) + " biliard") + (if (n == 1000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100000000000000)))
              end))
            end
            if (n >= 5000000000000) then
              return ((format_spellout_cardinal_masculine((n / 5000000000000.0).floor) + " bilionów") + (if (n == 5000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000000000.0).floor) + " biliony") + (if (n == 2000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000000.0).floor) + " bilion") + (if (n == 1000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100000000000)))
              end))
            end
            if (n >= 5000000000) then
              return ((format_spellout_cardinal_masculine((n / 5000000000.0).floor) + " miliardów") + (if (n == 5000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000000.0).floor) + " miliardy") + (if (n == 2000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000.0).floor) + " miliard") + (if (n == 1000000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100000000)))
              end))
            end
            if (n >= 5000000) then
              return ((format_spellout_cardinal_masculine((n / 5000000.0).floor) + " milionów") + (if (n == 5000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000.0).floor) + " miliony") + (if (n == 2000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000.0).floor) + " milion") + (if (n == 1000000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100000)))
              end))
            end
            if (n >= 5000) then
              return ((format_spellout_cardinal_masculine((n / 5000.0).floor) + " tysięcy") + (if (n == 5000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000)))
              end))
            end
            if (n >= 2000) then
              return ((format_spellout_cardinal_masculine((n / 2000.0).floor) + " tysiące") + (if (n == 2000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 1000)))
              end))
            end
            if (n >= 1000) then
              return ((format_spellout_cardinal_masculine((n / 1000.0).floor) + " tysiąc") + (if (n == 1000) then
                ""
              else
                (" " + format_spellout_cardinal_masculine((n % 100)))
              end))
            end
            if (n >= 500) then
              return ((format_spellout_cardinal_feminine((n / 500.0).floor) + "set") + ((n == 500) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 100))))))
            end
            if (n >= 300) then
              return ((format_spellout_cardinal_feminine((n / 300.0).floor) + "sta") + ((n == 300) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 100))))))
            end
            if (n >= 200) then
              return ((format_spellout_cardinal_feminine((n / 200.0).floor) + "ście") + ((n == 200) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 100))))))
            end
            if (n >= 100) then
              return ("sto" + ((n == 100) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 100))))))
            end
            if (n >= 50) then
              return ((format_spellout_cardinal_masculine((n / 50.0).floor) + "dziesiąt") + ((n == 50) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 10))))))
            end
            if (n >= 40) then
              return ("czterdzieści" + ((n == 40) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 10))))))
            end
            if (n >= 30) then
              return ("trzydzieści" + ((n == 30) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 10))))))
            end
            if (n >= 20) then
              return ("dwadzieścia" + ((n == 20) ? ("") : ((" " + format_spellout_cardinal_masculine((n % 10))))))
            end
            return "dziewiętnaście" if (n >= 19)
            return "osiemnaście" if (n >= 18)
            return "siedemnaście" if (n >= 17)
            return "szesnaście" if (n >= 16)
            return "piętnaście" if (n >= 15)
            return "czternaście" if (n >= 14)
            return "trzynaście" if (n >= 13)
            return "dwanaście" if (n >= 12)
            return "jedenaście" if (n >= 11)
            return "dziesięć" if (n >= 10)
            return "dziewięć" if (n >= 9)
            return "osiem" if (n >= 8)
            return "siedem" if (n >= 7)
            return "sześć" if (n >= 6)
            return "pięć" if (n >= 5)
            return "cztery" if (n >= 4)
            return "trzy" if (n >= 3)
            return "dwa" if (n >= 2)
            return "jeden" if (n >= 1)
            return "zero" if (n >= 0)
          end
          def format_spellout_cardinal_neuter(n)
            is_fractional = (n != n.floor)
            return ("minus " + format_spellout_cardinal_neuter(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_cardinal_neuter(n.floor) + " przecinek ") + format_spellout_fraction(n.to_s.gsub(/d*./, "").to_f))
            end
            return format_spellout_cardinal_neuter_priv(n) if (n >= 2)
            return "jedno" if (n >= 1)
            return "zero" if (n >= 0)
          end
          def format_spellout_cardinal_neuter_priv(n)
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 5000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 5.0e+15).floor) + " biliardów") + (if (n == 5000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter_priv((n % 1000000000000000)))
              end))
            end
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 2.0e+15).floor) + " biliardy") + (if (n == 2000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter_priv((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 1.0e+15).floor) + " biliard") + (if (n == 1000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter_priv((n % 100000000000000)))
              end))
            end
            if (n >= 5000000000000) then
              return ((format_spellout_cardinal_masculine((n / 5000000000000.0).floor) + " bilionów") + (if (n == 5000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter_priv((n % 1000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000000000.0).floor) + " biliony") + (if (n == 2000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter_priv((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000000.0).floor) + " bilion") + (if (n == 1000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter_priv((n % 100000000000)))
              end))
            end
            if (n >= 5000000000) then
              return ((format_spellout_cardinal_masculine((n / 5000000000.0).floor) + " miliardów") + (if (n == 5000000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter_priv((n % 1000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000000.0).floor) + " miliardy") + (if (n == 2000000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter_priv((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000.0).floor) + " miliard") + (if (n == 1000000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter_priv((n % 100000000)))
              end))
            end
            if (n >= 5000000) then
              return ((format_spellout_cardinal_masculine((n / 5000000.0).floor) + " milionów") + (if (n == 5000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter_priv((n % 1000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000.0).floor) + " miliony") + (if (n == 2000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter_priv((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000.0).floor) + " milion") + (if (n == 1000000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter_priv((n % 100000)))
              end))
            end
            if (n >= 5000) then
              return ((format_spellout_cardinal_masculine((n / 5000.0).floor) + " tysięcy") + (if (n == 5000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter_priv((n % 1000)))
              end))
            end
            if (n >= 2000) then
              return ((format_spellout_cardinal_masculine((n / 2000.0).floor) + " tysiące") + (if (n == 2000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter_priv((n % 1000)))
              end))
            end
            if (n >= 1000) then
              return ((format_spellout_cardinal_masculine((n / 1000.0).floor) + " tysiąc") + (if (n == 1000) then
                ""
              else
                (" " + format_spellout_cardinal_neuter_priv((n % 100)))
              end))
            end
            if (n >= 500) then
              return ((format_spellout_cardinal_feminine((n / 500.0).floor) + "set") + (if (n == 500) then
                ""
              else
                (" " + format_spellout_cardinal_neuter_priv((n % 100)))
              end))
            end
            if (n >= 300) then
              return ((format_spellout_cardinal_feminine((n / 300.0).floor) + "sta") + (if (n == 300) then
                ""
              else
                (" " + format_spellout_cardinal_neuter_priv((n % 100)))
              end))
            end
            if (n >= 200) then
              return ((format_spellout_cardinal_feminine((n / 200.0).floor) + "ście") + (if (n == 200) then
                ""
              else
                (" " + format_spellout_cardinal_neuter_priv((n % 100)))
              end))
            end
            if (n >= 100) then
              return ("sto" + (if (n == 100) then
                ""
              else
                (" " + format_spellout_cardinal_neuter_priv((n % 100)))
              end))
            end
            if (n >= 50) then
              return ((format_spellout_cardinal_neuter_priv((n / 50.0).floor) + "dziesiąt") + ((n == 50) ? ("") : ((" " + format_spellout_cardinal_neuter_priv((n % 10))))))
            end
            if (n >= 40) then
              return ("czterdzieści" + ((n == 40) ? ("") : ((" " + format_spellout_cardinal_neuter_priv((n % 10))))))
            end
            if (n >= 30) then
              return ("trzydzieści" + ((n == 30) ? ("") : ((" " + format_spellout_cardinal_neuter_priv((n % 10))))))
            end
            if (n >= 20) then
              return ("dwadzieścia" + ((n == 20) ? ("") : ((" " + format_spellout_cardinal_neuter_priv((n % 10))))))
            end
            return format_spellout_cardinal_masculine(n) if (n >= 2)
            return "jeden" if (n >= 1)
          end
          private(:format_spellout_cardinal_neuter_priv)
          def format_spellout_cardinal_feminine(n)
            is_fractional = (n != n.floor)
            return ("minus " + format_spellout_cardinal_feminine(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_cardinal_feminine(n.floor) + " przecinek ") + format_spellout_fraction(n.to_s.gsub(/d*./, "").to_f))
            end
            return format_spellout_cardinal_feminine_priv(n) if (n >= 2)
            return "jedna" if (n >= 1)
            return "zero" if (n >= 0)
          end
          def format_spellout_cardinal_feminine_priv(n)
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 5000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 5.0e+15).floor) + " biliardów") + (if (n == 5000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine_priv((n % 1000000000000000)))
              end))
            end
            if (n >= 2000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 2.0e+15).floor) + " biliardy") + (if (n == 2000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine_priv((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ((format_spellout_cardinal_masculine((n / 1.0e+15).floor) + " biliard") + (if (n == 1000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine_priv((n % 100000000000000)))
              end))
            end
            if (n >= 5000000000000) then
              return ((format_spellout_cardinal_masculine((n / 5000000000000.0).floor) + " bilionów") + (if (n == 5000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine_priv((n % 1000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000000000.0).floor) + " biliony") + (if (n == 2000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine_priv((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000000.0).floor) + " bilion") + (if (n == 1000000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine_priv((n % 100000000000)))
              end))
            end
            if (n >= 5000000000) then
              return ((format_spellout_cardinal_masculine((n / 5000000000.0).floor) + " miliardów") + (if (n == 5000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine_priv((n % 1000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000000.0).floor) + " miliardy") + (if (n == 2000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine_priv((n % 1000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000000.0).floor) + " miliard") + (if (n == 1000000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine_priv((n % 100000000)))
              end))
            end
            if (n >= 5000000) then
              return ((format_spellout_cardinal_masculine((n / 5000000.0).floor) + " milionów") + (if (n == 5000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine_priv((n % 1000000)))
              end))
            end
            if (n >= 2000000) then
              return ((format_spellout_cardinal_masculine((n / 2000000.0).floor) + " miliony") + (if (n == 2000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine_priv((n % 1000000)))
              end))
            end
            if (n >= 1000000) then
              return ((format_spellout_cardinal_masculine((n / 1000000.0).floor) + " milion") + (if (n == 1000000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine_priv((n % 100000)))
              end))
            end
            if (n >= 5000) then
              return ((format_spellout_cardinal_masculine((n / 5000.0).floor) + " tysięcy") + (if (n == 5000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine_priv((n % 1000)))
              end))
            end
            if (n >= 2000) then
              return ((format_spellout_cardinal_masculine((n / 2000.0).floor) + " tysiące") + (if (n == 2000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine_priv((n % 1000)))
              end))
            end
            if (n >= 1000) then
              return ((format_spellout_cardinal_masculine((n / 1000.0).floor) + " tysiąc") + (if (n == 1000) then
                ""
              else
                (" " + format_spellout_cardinal_feminine_priv((n % 100)))
              end))
            end
            if (n >= 500) then
              return ((format_spellout_cardinal_feminine((n / 500.0).floor) + "set") + (if (n == 500) then
                ""
              else
                (" " + format_spellout_cardinal_feminine_priv((n % 100)))
              end))
            end
            if (n >= 300) then
              return ((format_spellout_cardinal_feminine((n / 300.0).floor) + "sta") + (if (n == 300) then
                ""
              else
                (" " + format_spellout_cardinal_feminine_priv((n % 100)))
              end))
            end
            if (n >= 200) then
              return ((format_spellout_cardinal_feminine((n / 200.0).floor) + "ście") + (if (n == 200) then
                ""
              else
                (" " + format_spellout_cardinal_feminine_priv((n % 100)))
              end))
            end
            if (n >= 100) then
              return ("sto" + (if (n == 100) then
                ""
              else
                (" " + format_spellout_cardinal_feminine_priv((n % 100)))
              end))
            end
            if (n >= 50) then
              return ((format_spellout_cardinal_feminine_priv((n / 50.0).floor) + "dziesiąt") + (if (n == 50) then
                ""
              else
                (" " + format_spellout_cardinal_feminine_priv((n % 10)))
              end))
            end
            if (n >= 40) then
              return ("czterdzieści" + (if (n == 40) then
                ""
              else
                (" " + format_spellout_cardinal_feminine_priv((n % 10)))
              end))
            end
            if (n >= 30) then
              return ("trzydzieści" + (if (n == 30) then
                ""
              else
                (" " + format_spellout_cardinal_feminine_priv((n % 10)))
              end))
            end
            if (n >= 20) then
              return ("dwadzieścia" + (if (n == 20) then
                ""
              else
                (" " + format_spellout_cardinal_feminine_priv((n % 10)))
              end))
            end
            return format_spellout_cardinal_masculine(n) if (n >= 3)
            return "dwie" if (n >= 2)
            return "jeden" if (n >= 1)
          end
          private(:format_spellout_cardinal_feminine_priv)
          def format_spellout_fraction(n)
            return (n / 10000000000.0).floor.to_s if (n >= 10000000000)
            if (n >= 1000000000) then
              return format_spellout_fraction_digits((n / 1000000000.0).floor)
            end
            if (n >= 100000000) then
              return format_spellout_fraction_digits((n / 100000000.0).floor)
            end
            if (n >= 10000000) then
              return format_spellout_fraction_digits((n / 10000000.0).floor)
            end
            if (n >= 1000000) then
              return format_spellout_fraction_digits((n / 1000000.0).floor)
            end
            if (n >= 100000) then
              return format_spellout_fraction_digits((n / 100000.0).floor)
            end
            return format_spellout_fraction_digits((n / 10000.0).floor) if (n >= 10000)
            return format_spellout_fraction_digits((n / 1000.0).floor) if (n >= 1000)
            return format_spellout_fraction_digits((n / 100.0).floor) if (n >= 100)
            return format_spellout_fraction_digits((n / 10.0).floor) if (n >= 10)
          end
          private(:format_spellout_fraction)
          def format_spellout_fraction_digits(n)
            if (n >= 10) then
              return ((format_spellout_fraction_digits((n / 10.0).floor) + " ") + format_spellout_fraction_digits((n % 10)))
            end
            return format_spellout_cardinal_masculine(n) if (n >= 0)
          end
          private(:format_spellout_fraction_digits)
        end
      end
    end
  end
end