# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:vi] = Vietnamese = Class.new do
        class << self
          (def renderSpelloutNumberingYear(n)
            is_fractional = (n != n.floor)
            return n.to_s if is_fractional and (n > 1)
            return renderSpelloutNumbering(n) if (n >= 0)
          end
          def renderSpelloutNumbering(n)
            return renderSpelloutCardinal(n) if (n >= 0)
          end
          def renderTeen(n)
            return renderSpelloutCardinal(n) if (n >= 6)
            return "lăm" if (n >= 5)
            return renderSpelloutCardinal(n) if (n >= 0)
          end
          private(:renderTeen)
          def renderXTy(n)
            return renderTeen(n) if (n >= 2)
            return "mốt" if (n >= 1)
            return renderSpelloutCardinal(n) if (n >= 0)
          end
          private(:renderXTy)
          def renderAfterHundred(n)
            return renderSpelloutCardinal(n) if (n >= 10)
            return ("lẻ " + renderSpelloutCardinal(n)) if (n >= 0)
          end
          private(:renderAfterHundred)
          def renderAfterThousandOrMore(n)
            return renderSpelloutCardinal(n) if (n >= 100)
            return ("không trăm " + renderAfterHundred(n)) if (n >= 0)
          end
          private(:renderAfterThousandOrMore)
          def renderSpelloutCardinal(n)
            is_fractional = (n != n.floor)
            return ("âm " + renderSpelloutCardinal(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((renderSpelloutCardinal(n.floor) + " phẩy ") + renderSpelloutCardinal(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 1000000000) then
              return ((renderSpelloutCardinal((n / 1000000000.0).floor) + " tỷ") + (if (n == 1000000000) then
                ""
              else
                (" " + renderAfterThousandOrMore((n % 100000000)))
              end))
            end
            if (n >= 1000000) then
              return ((renderSpelloutCardinal((n / 1000000.0).floor) + " triệu") + ((n == 1000000) ? ("") : ((" " + renderAfterThousandOrMore((n % 100000))))))
            end
            if (n >= 1000) then
              return ((renderSpelloutCardinal((n / 1000.0).floor) + " nghìn") + ((n == 1000) ? ("") : ((" " + renderAfterThousandOrMore((n % 100))))))
            end
            if (n >= 100) then
              return ((renderSpelloutCardinal((n / 100.0).floor) + " trăm") + ((n == 100) ? ("") : ((" " + renderAfterHundred((n % 100))))))
            end
            if (n >= 20) then
              return ((renderSpelloutCardinal((n / 20.0).floor) + " mươi") + ((n == 20) ? ("") : ((" " + renderXTy((n % 10))))))
            end
            if (n >= 10) then
              return ("mười" + ((n == 10) ? ("") : ((" " + renderTeen((n % 10))))))
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
          def renderSpelloutOrdinal(n)
            is_fractional = (n != n.floor)
            return n.to_s if is_fractional and (n > 1)
            return ("thứ " + renderSpelloutCardinal(n)) if (n >= 5)
            return "thứ tư" if (n >= 4)
            return ("thứ " + renderSpelloutCardinal(n)) if (n >= 3)
            return "thứ nhì" if (n >= 2)
            return "thứ nhất" if (n >= 1)
            return ("thứ " + renderSpelloutCardinal(n)) if (n >= 0)
          end
          def renderDigitsOrdinal(n)
            return ("−" + renderDigitsOrdinal(-n)) if (n < 0)
            return ("thứ " + n.to_s) if (n >= 0)
          end)
        end
      end
    end
  end
end