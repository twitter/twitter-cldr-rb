# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:vi] = Vietnamese = Module.new { }
      
      class Vietnamese::Spellout
        class << self
          def format_spellout_numbering_year(n)
            is_fractional = (n != n.floor)
            return n.to_s if is_fractional and (n > 1)
            return format_spellout_numbering(n) if (n >= 0)
          end
          def format_spellout_numbering(n)
            return format_spellout_cardinal(n) if (n >= 0)
          end
          def format_teen(n)
            return format_spellout_cardinal(n) if (n >= 6)
            return "lăm" if (n >= 5)
            return format_spellout_cardinal(n) if (n >= 0)
          end
          private(:format_teen)
          def format_x_ty(n)
            return format_teen(n) if (n >= 2)
            return "mốt" if (n >= 1)
            return format_spellout_cardinal(n) if (n >= 0)
          end
          private(:format_x_ty)
          def format_after_hundred(n)
            return format_spellout_cardinal(n) if (n >= 10)
            return ("lẻ " + format_spellout_cardinal(n)) if (n >= 0)
          end
          private(:format_after_hundred)
          def format_after_thousand_or_more(n)
            return format_spellout_cardinal(n) if (n >= 100)
            return ("không trăm " + format_after_hundred(n)) if (n >= 0)
          end
          private(:format_after_thousand_or_more)
          def format_spellout_cardinal(n)
            is_fractional = (n != n.floor)
            return ("âm " + format_spellout_cardinal(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_cardinal(n.floor) + " phẩy ") + format_spellout_cardinal((n % 10)))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 1000000000) then
              return ((format_spellout_cardinal((n / 1000000000).floor) + " tỷ") + (if ((n == 1000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_after_thousand_or_more((n % 1000000000)))
              end))
            end
            if (n >= 1000000) then
              return ((format_spellout_cardinal((n / 1000000).floor) + " triệu") + (if ((n == 1000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_after_thousand_or_more((n % 1000000)))
              end))
            end
            if (n >= 1000) then
              return ((format_spellout_cardinal((n / 1000).floor) + " nghìn") + (if ((n == 1000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_after_thousand_or_more((n % 1000)))
              end))
            end
            if (n >= 100) then
              return ((format_spellout_cardinal((n / 100).floor) + " trăm") + (if ((n == 100) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_after_hundred((n % 100)))
              end))
            end
            if (n >= 20) then
              return ((format_spellout_cardinal((n / 100).floor) + " mươi") + (((n == 20) or ((n % 10) == 0)) ? ("") : ((" " + format_x_ty((n % 100))))))
            end
            if (n >= 10) then
              return ("mười" + (((n == 10) or ((n % 10) == 0)) ? ("") : ((" " + format_teen((n % 10))))))
            end
            return "chín" if (n >= 9)
            return "tám" if (n >= 8)
            return "bảy" if (n >= 7)
            return "sáu" if (n >= 6)
            return "năm" if (n >= 5)
            return "bốn" if (n >= 4)
            return "ba" if (n >= 3)
            return "hai" if (n >= 2)
            return "một" if (n >= 1)
            return "không" if (n >= 0)
          end
          def format_spellout_ordinal(n)
            is_fractional = (n != n.floor)
            return n.to_s if is_fractional and (n > 1)
            return ("thứ " + format_spellout_cardinal(n)) if (n >= 5)
            return "thứ tư" if (n >= 4)
            return ("thứ " + format_spellout_cardinal(n)) if (n >= 3)
            return "thứ nhì" if (n >= 2)
            return "thứ nhất" if (n >= 1)
            return ("thứ " + format_spellout_cardinal(n)) if (n >= 0)
          end
        end
      end
      
      class Vietnamese::Ordinal
        class << self
          def format_digits_ordinal(n)
            return ("−" + format_digits_ordinal(-n)) if (n < 0)
            return ("thứ " + n.to_s) if (n >= 0)
          end
        end
      end
    end
  end
end