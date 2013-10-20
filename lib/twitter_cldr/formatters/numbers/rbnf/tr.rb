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
              return ((format_spellout_cardinal(n.floor) + " virgül ") + format_spellout_cardinal((n % 10)))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 1000000000000000) then
              return ((format_spellout_cardinal((n / 1000000000000000).floor) + " katrilyon") + (if ((n == 1000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal((n / 1000000000000).floor) + " trilyon") + (if ((n == 1000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((format_spellout_cardinal((n / 1000000000).floor) + " milyar") + (if ((n == 1000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal((n % 1000000000)))
              end))
            end
            if (n >= 1000000) then
              return ((format_spellout_cardinal((n / 1000000).floor) + " milyon") + (if ((n == 1000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal((n % 1000000)))
              end))
            end
            if (n >= 2000) then
              return ((format_spellout_cardinal((n / 10000).floor) + " bin") + (if ((n == 2000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal((n % 10000)))
              end))
            end
            if (n >= 1000) then
              return ("bin" + (if ((n == 1000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal((n % 1000)))
              end))
            end
            if (n >= 200) then
              return ((format_spellout_cardinal((n / 1000).floor) + " yüz") + (if ((n == 200) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal((n % 1000)))
              end))
            end
            if (n >= 100) then
              return ("yüz" + (if ((n == 100) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal((n % 100)))
              end))
            end
            if (n >= 90) then
              return ("doksan" + (if ((n == 90) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal((n % 100)))
              end))
            end
            if (n >= 80) then
              return ("seksen" + (if ((n == 80) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal((n % 100)))
              end))
            end
            if (n >= 70) then
              return ("yetmiş" + (if ((n == 70) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal((n % 100)))
              end))
            end
            if (n >= 60) then
              return ("altmış" + (if ((n == 60) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal((n % 100)))
              end))
            end
            if (n >= 50) then
              return ("elli" + (if ((n == 50) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal((n % 100)))
              end))
            end
            if (n >= 40) then
              return ("kırk" + (if ((n == 40) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal((n % 100)))
              end))
            end
            if (n >= 30) then
              return ("otuz" + (if ((n == 30) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal((n % 100)))
              end))
            end
            if (n >= 20) then
              return ("yirmi" + (if ((n == 20) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal((n % 100)))
              end))
            end
            if (n >= 10) then
              return ("on" + (if ((n == 10) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal((n % 10)))
              end))
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
              return ((format_spellout_numbering((n / 1000000000000000).floor) + " katrilyon") + format_uncu((n % 1000000000000000)))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_numbering((n / 1000000000000).floor) + " trilyon") + format_uncu((n % 1000000000000)))
            end
            if (n >= 1000000000) then
              return ((format_spellout_numbering((n / 1000000000).floor) + " milyar") + "ıncı")
            end
            if (n >= 1000000) then
              return ((format_spellout_numbering((n / 1000000).floor) + " milyon") + format_uncu((n % 1000000)))
            end
            if (n >= 2000) then
              return ((format_spellout_numbering((n / 10000).floor) + " bin") + format_inci((n % 10000)))
            end
            return ("bin" + format_inci((n % 1000))) if (n >= 1000)
            if (n >= 200) then
              return ((format_spellout_numbering((n / 1000).floor) + " yüz") + "üncü")
            end
            return ("yüz" + "üncü") if (n >= 100)
            return ("doksan" + "ıncı") if (n >= 90)
            return ("seksen" + format_inci((n % 100))) if (n >= 80)
            return ("yetmiş" + format_inci((n % 100))) if (n >= 70)
            return ("altmış" + "ıncı") if (n >= 60)
            return ("elli" + format_nci((n % 100))) if (n >= 50)
            return ("kırk" + "ıncı") if (n >= 40)
            return ("otuz" + format_uncu((n % 100))) if (n >= 30)
            return ("yirmi" + format_nci((n % 100))) if (n >= 20)
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