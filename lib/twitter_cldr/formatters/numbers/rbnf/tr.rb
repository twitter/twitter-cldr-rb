# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:tr] = Turkish = Module.new { }
      
      class Turkish::Spellout
        class << self
          def format_spellout_numbering_year(n)
            is_fractional = (n != n.floor)
            return n.to_s if is_fractional and (n > 1)
            return format_spellout_numbering(n) if (n >= 0)
          end
          def format_spellout_numbering(n)
            return format_spellout_cardinal(n) if (n >= 0)
          end
          def format_spellout_cardinal(n)
            is_fractional = (n != n.floor)
            return ("eksi " + format_spellout_cardinal(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_cardinal(n.floor) + " virgül ") + format_spellout_cardinal(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 1000000000000000) then
              return ((format_spellout_cardinal((n / 1.0e+15).floor) + " katrilyon") + (if (n == 1000000000000000) then
                ""
              else
                (" " + format_spellout_cardinal((n % 100000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal((n / 1000000000000.0).floor) + " trilyon") + (if (n == 1000000000000) then
                ""
              else
                (" " + format_spellout_cardinal((n % 100000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((format_spellout_cardinal((n / 1000000000.0).floor) + " milyar") + (if (n == 1000000000) then
                ""
              else
                (" " + format_spellout_cardinal((n % 100000000)))
              end))
            end
            if (n >= 1000000) then
              return ((format_spellout_cardinal((n / 1000000.0).floor) + " milyon") + ((n == 1000000) ? ("") : ((" " + format_spellout_cardinal((n % 100000))))))
            end
            if (n >= 2000) then
              return ((format_spellout_cardinal((n / 2000.0).floor) + " bin") + ((n == 2000) ? ("") : ((" " + format_spellout_cardinal((n % 1000))))))
            end
            if (n >= 1000) then
              return ("bin" + ((n == 1000) ? ("") : ((" " + format_spellout_cardinal((n % 100))))))
            end
            if (n >= 200) then
              return ((format_spellout_cardinal((n / 200.0).floor) + " yüz") + ((n == 200) ? ("") : ((" " + format_spellout_cardinal((n % 100))))))
            end
            if (n >= 100) then
              return ("yüz" + ((n == 100) ? ("") : ((" " + format_spellout_cardinal((n % 100))))))
            end
            if (n >= 90) then
              return ("doksan" + ((n == 90) ? ("") : ((" " + format_spellout_cardinal((n % 10))))))
            end
            if (n >= 80) then
              return ("seksen" + ((n == 80) ? ("") : ((" " + format_spellout_cardinal((n % 10))))))
            end
            if (n >= 70) then
              return ("yetmiş" + ((n == 70) ? ("") : ((" " + format_spellout_cardinal((n % 10))))))
            end
            if (n >= 60) then
              return ("altmış" + ((n == 60) ? ("") : ((" " + format_spellout_cardinal((n % 10))))))
            end
            if (n >= 50) then
              return ("elli" + ((n == 50) ? ("") : ((" " + format_spellout_cardinal((n % 10))))))
            end
            if (n >= 40) then
              return ("kırk" + ((n == 40) ? ("") : ((" " + format_spellout_cardinal((n % 10))))))
            end
            if (n >= 30) then
              return ("otuz" + ((n == 30) ? ("") : ((" " + format_spellout_cardinal((n % 10))))))
            end
            if (n >= 20) then
              return ("yirmi" + ((n == 20) ? ("") : ((" " + format_spellout_cardinal((n % 10))))))
            end
            if (n >= 10) then
              return ("on" + ((n == 10) ? ("") : ((" " + format_spellout_cardinal((n % 10))))))
            end
            return "dokuz" if (n >= 9)
            return "sekiz" if (n >= 8)
            return "yedi" if (n >= 7)
            return "altı" if (n >= 6)
            return "beş" if (n >= 5)
            return "dört" if (n >= 4)
            return "üç" if (n >= 3)
            return "iki" if (n >= 2)
            return "bir" if (n >= 1)
            return "sıfır" if (n >= 0)
          end
          def format_inci(n)
            return (" " + format_spellout_ordinal(n)) if (n >= 1)
            return "inci" if (n >= 0)
          end
          private(:format_inci)
          def format_nci(n)
            return (" " + format_spellout_ordinal(n)) if (n >= 1)
            return "nci" if (n >= 0)
          end
          private(:format_nci)
          def format_nc_(n)
            return (" " + format_spellout_ordinal(n)) if (n >= 1)
            return "üncü" if (n >= 0)
          end
          private(:format_nc_)
          def format_uncu(n)
            return (" " + format_spellout_ordinal(n)) if (n >= 1)
            return "uncu" if (n >= 0)
          end
          private(:format_uncu)
          def format_spellout_ordinal(n)
            is_fractional = (n != n.floor)
            return ("eksi " + format_spellout_ordinal(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return (n.to_s + "'inci") if (n >= 1000000000000000000)
            if (n >= 1000000000000000) then
              return ((format_spellout_numbering((n / 1.0e+15).floor) + " katrilyon") + format_uncu((n % 100000000000000)))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_numbering((n / 1000000000000.0).floor) + " trilyon") + format_uncu((n % 100000000000)))
            end
            if (n >= 1000000000) then
              return ((format_spellout_numbering((n / 1000000000.0).floor) + " milyar") + "ıncı")
            end
            if (n >= 1000000) then
              return ((format_spellout_numbering((n / 1000000.0).floor) + " milyon") + format_uncu((n % 100000)))
            end
            if (n >= 2000) then
              return ((format_spellout_numbering((n / 2000.0).floor) + " bin") + format_inci((n % 1000)))
            end
            return ("bin" + format_inci((n % 100))) if (n >= 1000)
            if (n >= 200) then
              return ((format_spellout_numbering((n / 200.0).floor) + " yüz") + "üncü")
            end
            return ("yüz" + "üncü") if (n >= 100)
            return ("doksan" + "ıncı") if (n >= 90)
            return ("seksen" + format_inci((n % 10))) if (n >= 80)
            return ("yetmiş" + format_inci((n % 10))) if (n >= 70)
            return ("altmış" + "ıncı") if (n >= 60)
            return ("elli" + format_nci((n % 10))) if (n >= 50)
            return ("kırk" + "ıncı") if (n >= 40)
            return ("otuz" + format_uncu((n % 10))) if (n >= 30)
            return ("yirmi" + format_nci((n % 10))) if (n >= 20)
            return ("on" + format_uncu((n % 10))) if (n >= 10)
            return "dokuzuncu" if (n >= 9)
            return "sekizinci" if (n >= 8)
            return "yedinci" if (n >= 7)
            return "altıncı" if (n >= 6)
            return "beşinci" if (n >= 5)
            return "dörtüncü" if (n >= 4)
            return "üçüncü" if (n >= 3)
            return "ikinci" if (n >= 2)
            return "birinci" if (n >= 1)
            return "sıfırıncı" if (n >= 0)
          end
        end
      end
      
      class Turkish::Ordinal
        class << self
          def format_digits_ordinal_indicator(n)
            return "inci" if (n >= 0)
          end
          private(:format_digits_ordinal_indicator)
          def format_digits_ordinal(n)
            return ("−" + format_digits_ordinal(-n)) if (n < 0)
            return (n.to_s + format_digits_ordinal_indicator(n)) if (n >= 0)
          end
        end
      end
    end
  end
end