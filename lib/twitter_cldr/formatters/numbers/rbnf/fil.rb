# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:fil] = Filipino = Module.new { }
      
      class Filipino::Spellout
        class << self
          def format_spellout_numbering_year(n)
            is_fractional = (n != n.floor)
            return n.to_s if is_fractional and (n > 1)
            return format_spellout_numbering(n) if (n >= 0)
          end
          def format_spellout_numbering(n)
            return format_spellout_cardinal(n) if (n >= 0)
          end
          def format_number_times(n)
            if (n >= 1000) then
              return ((format_number_times((n / 1000).floor) + " libó") + (if ((n == 1000) or ((n % 10) == 0)) then
                ""
              else
                ("’t " + format_number_times((n % 1000)))
              end))
            end
            if (n >= 100) then
              return ((format_number_times((n / 100).floor) + " daán") + (if ((n == 100) or ((n % 10) == 0)) then
                ""
              else
                (" at " + format_number_times((n % 100)))
              end))
            end
            if (n >= 20) then
              return ((format_number_times((n / 100).floor) + " pû") + (if ((n == 20) or ((n % 10) == 0)) then
                ""
              else
                ("’t " + format_number_times((n % 100)))
              end))
            end
            return ("labíng-" + format_number_times((n % 100))) if (n >= 11)
            return "sampûng" if (n >= 10)
            return "siyám na" if (n >= 9)
            return "walóng" if (n >= 8)
            return "pitóng" if (n >= 7)
            return "anim na" if (n >= 6)
            return "limáng" if (n >= 5)
            return "ápat na" if (n >= 4)
            return "tatlóng" if (n >= 3)
            return "dalawáng" if (n >= 2)
            return "isáng" if (n >= 1)
          end
          private(:format_number_times)
          def format_spellout_cardinal(n)
            is_fractional = (n != n.floor)
            return ("minus " + format_spellout_cardinal(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_cardinal(n.floor) + " tuldok ") + format_spellout_cardinal((n % 10)))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 1000000000000000) then
              return ((format_number_times((n / 1000000000000000).floor) + " katrilyón") + (if ((n == 1000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" at " + format_spellout_cardinal((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_number_times((n / 1000000000000).floor) + " trilyón") + (if ((n == 1000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" at " + format_spellout_cardinal((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((format_number_times((n / 1000000000).floor) + " bilyón") + (if ((n == 1000000000) or ((n % 10) == 0)) then
                ""
              else
                (" at " + format_spellout_cardinal((n % 1000000000)))
              end))
            end
            if (n >= 1000000) then
              return ((format_number_times((n / 1000000).floor) + " milyón") + (if ((n == 1000000) or ((n % 10) == 0)) then
                ""
              else
                (" at " + format_spellout_cardinal((n % 1000000)))
              end))
            end
            if (n >= 1000) then
              return ((format_number_times((n / 1000).floor) + " libó") + (if ((n == 1000) or ((n % 10) == 0)) then
                ""
              else
                ("’t " + format_spellout_cardinal((n % 1000)))
              end))
            end
            if (n >= 100) then
              return ((format_number_times((n / 100).floor) + " daán") + (if ((n == 100) or ((n % 10) == 0)) then
                ""
              else
                (" at " + format_spellout_cardinal((n % 100)))
              end))
            end
            if (n >= 20) then
              return ((format_number_times((n / 100).floor) + " pû") + (if ((n == 20) or ((n % 10) == 0)) then
                ""
              else
                ("’t " + format_spellout_cardinal((n % 100)))
              end))
            end
            return ("labíng-" + format_spellout_cardinal((n % 100))) if (n >= 11)
            return "sampû" if (n >= 10)
            return "siyám" if (n >= 9)
            return "waló" if (n >= 8)
            return "pitó" if (n >= 7)
            return "anim" if (n >= 6)
            return "limá" if (n >= 5)
            return "ápat" if (n >= 4)
            return "tatló" if (n >= 3)
            return "dalawá" if (n >= 2)
            return "isá" if (n >= 1)
            return "walâ" if (n >= 0)
          end
          def format_spellout_ordinal(n)
            is_fractional = (n != n.floor)
            return n.to_s if is_fractional and (n > 1)
            return ("ika " + format_spellout_cardinal(n)) if (n >= 0)
          end
        end
      end
      
      class Filipino::Ordinal
        class << self
          def format_digits_ordinal(n)
            return ("−" + format_digits_ordinal(-n)) if (n < 0)
            return ("ika" + n.to_s) if (n >= 0)
          end
        end
      end
    end
  end
end