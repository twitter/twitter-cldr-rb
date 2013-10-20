# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:th] = Thai = Module.new { }
      
      class Thai::Spellout
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
            return ("ลบ​" + format_spellout_cardinal(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_cardinal(n.floor) + "​จุด​") + format_spellout_cardinal((n % 10)))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 1000000) then
              return ((format_spellout_cardinal((n / 1000000).floor) + "​ล้าน") + (if ((n == 1000000) or ((n % 10) == 0)) then
                ""
              else
                ("​" + format_spellout_cardinal((n % 1000000)))
              end))
            end
            if (n >= 100000) then
              return ((format_spellout_cardinal((n / 100000).floor) + "​แสน") + (if ((n == 100000) or ((n % 10) == 0)) then
                ""
              else
                ("​" + format_spellout_cardinal((n % 100000)))
              end))
            end
            if (n >= 10000) then
              return ((format_spellout_cardinal((n / 10000).floor) + "​หมื่น") + (if ((n == 10000) or ((n % 10) == 0)) then
                ""
              else
                ("​" + format_spellout_cardinal((n % 10000)))
              end))
            end
            if (n >= 1000) then
              return ((format_spellout_cardinal((n / 1000).floor) + "​พัน") + (if ((n == 1000) or ((n % 10) == 0)) then
                ""
              else
                ("​" + format_spellout_cardinal((n % 1000)))
              end))
            end
            if (n >= 100) then
              return ((format_spellout_cardinal((n / 100).floor) + "​ร้อย") + (if ((n == 100) or ((n % 10) == 0)) then
                ""
              else
                ("​" + format_spellout_cardinal((n % 100)))
              end))
            end
            if (n >= 30) then
              return ((format_spellout_cardinal((n / 100).floor) + "​สิบ") + (if ((n == 30) or ((n % 10) == 0)) then
                ""
              else
                ("​" + format_alt_ones((n % 100)))
              end))
            end
            if (n >= 20) then
              return ("ยี่​สิบ" + (if ((n == 20) or ((n % 10) == 0)) then
                ""
              else
                ("​" + format_alt_ones((n % 100)))
              end))
            end
            if (n >= 10) then
              return ("สิบ" + (((n == 10) or ((n % 10) == 0)) ? ("") : (("​" + format_alt_ones((n % 10))))))
            end
            return "เก้า" if (n >= 9)
            return "แปด" if (n >= 8)
            return "เจ็ด" if (n >= 7)
            return "หก" if (n >= 6)
            return "ห้า" if (n >= 5)
            return "สี่" if (n >= 4)
            return "สาม" if (n >= 3)
            return "สอง" if (n >= 2)
            return "หนึ่ง" if (n >= 1)
            return "ศูนย์" if (n >= 0)
          end
          def format_alt_ones(n)
            return format_spellout_cardinal(n) if (n >= 2)
            return "เอ็ด" if (n >= 1)
          end
          private(:format_alt_ones)
          def format_spellout_ordinal(n)
            is_fractional = (n != n.floor)
            return n.to_s if is_fractional and (n > 1)
            return ("ที่​" + format_spellout_cardinal(n)) if (n >= 0)
          end
        end
      end
      
      class Thai::Ordinal
        class << self
          def format_digits_ordinal(n)
            return ("ที่−" + -n.to_s) if (n < 0)
            return ("ที่​" + n.to_s) if (n >= 0)
          end
        end
      end
    end
  end
end