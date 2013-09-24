# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:ja] = Japanese = Class.new do
        class << self
          (def renderSpelloutNumberingYear(n)
            is_fractional = (n != n.floor)
            return n.to_s if is_fractional and (n > 1)
            return renderSpelloutNumbering(n) if (n >= 10000)
            return renderSpelloutNumberingYearDigits(n) if (n >= 1000)
            return renderSpelloutNumbering(n) if (n >= 2)
            return "元" if (n >= 1)
            return renderSpelloutNumbering(n) if (n >= 0)
          end
          def renderSpelloutNumberingYearDigits(n)
            if (n >= 1000) then
              return (renderSpelloutNumberingYearDigits((n / 1000.0).floor) + renderSpelloutNumberingYearDigits((n % 100)))
            end
            if (n >= 100) then
              return (renderSpelloutNumberingYearDigits((n / 100.0).floor) + renderSpelloutNumberingYearDigits((n % 100)))
            end
            if (n >= 10) then
              return (renderSpelloutNumberingYearDigits((n / 10.0).floor) + renderSpelloutNumberingYearDigits((n % 10)))
            end
            return renderSpelloutNumbering(n) if (n >= 0)
          end
          private(:renderSpelloutNumberingYearDigits)
          def renderSpelloutNumbering(n)
            return renderSpelloutCardinal(n) if (n >= 0)
          end
          def renderSpelloutCardinalFinancial(n)
            is_fractional = (n != n.floor)
            return ("マイナス" + renderSpelloutCardinalFinancial(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((renderSpelloutCardinalFinancial(n.floor) + "点") + renderSpelloutCardinalFinancial(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 10000000000000000) then
              return ((renderSpelloutCardinalFinancial((n / 1.0e+16).floor) + "京") + (if (n == 10000000000000000) then
                ""
              else
                renderSpelloutCardinalFinancial((n % 10000000000000000))
              end))
            end
            if (n >= 1000000000000) then
              return ((renderSpelloutCardinalFinancial((n / 1000000000000.0).floor) + "兆") + (if (n == 1000000000000) then
                ""
              else
                renderSpelloutCardinalFinancial((n % 100000000000))
              end))
            end
            if (n >= 100000000) then
              return ((renderSpelloutCardinalFinancial((n / 100000000.0).floor) + "億") + (if (n == 100000000) then
                ""
              else
                renderSpelloutCardinalFinancial((n % 100000000))
              end))
            end
            if (n >= 10000) then
              return ((renderSpelloutCardinalFinancial((n / 10000.0).floor) + "萬") + ((n == 10000) ? ("") : (renderSpelloutCardinalFinancial((n % 10000)))))
            end
            if (n >= 1000) then
              return ((renderSpelloutCardinalFinancial((n / 1000.0).floor) + "千") + ((n == 1000) ? ("") : (renderSpelloutCardinalFinancial((n % 100)))))
            end
            if (n >= 100) then
              return ((renderSpelloutCardinalFinancial((n / 100.0).floor) + "百") + ((n == 100) ? ("") : (renderSpelloutCardinalFinancial((n % 100)))))
            end
            if (n >= 20) then
              return ((renderSpelloutCardinalFinancial((n / 20.0).floor) + "拾") + ((n == 20) ? ("") : (renderSpelloutCardinalFinancial((n % 10)))))
            end
            if (n >= 10) then
              return ("拾" + ((n == 10) ? ("") : (renderSpelloutCardinalFinancial((n % 10)))))
            end
            return "九" if (n >= 9)
            return "八" if (n >= 8)
            return "七" if (n >= 7)
            return "六" if (n >= 6)
            return "伍" if (n >= 5)
            return "四" if (n >= 4)
            return "参" if (n >= 3)
            return "弐" if (n >= 2)
            return "壱" if (n >= 1)
            return "零" if (n >= 0)
          end
          def renderSpelloutCardinal(n)
            is_fractional = (n != n.floor)
            return ("マイナス" + renderSpelloutCardinal(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((renderSpelloutCardinal(n.floor) + "・") + renderSpelloutCardinal(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 10000000000000000) then
              return ((renderSpelloutCardinal((n / 1.0e+16).floor) + "京") + (if (n == 10000000000000000) then
                ""
              else
                renderSpelloutCardinal((n % 10000000000000000))
              end))
            end
            if (n >= 1000000000000) then
              return ((renderSpelloutCardinal((n / 1000000000000.0).floor) + "兆") + ((n == 1000000000000) ? ("") : (renderSpelloutCardinal((n % 100000000000)))))
            end
            if (n >= 100000000) then
              return ((renderSpelloutCardinal((n / 100000000.0).floor) + "億") + ((n == 100000000) ? ("") : (renderSpelloutCardinal((n % 100000000)))))
            end
            if (n >= 10000) then
              return ((renderSpelloutCardinal((n / 10000.0).floor) + "万") + ((n == 10000) ? ("") : (renderSpelloutCardinal((n % 10000)))))
            end
            if (n >= 2000) then
              return ((renderSpelloutCardinal((n / 2000.0).floor) + "千") + ((n == 2000) ? ("") : (renderSpelloutCardinal((n % 1000)))))
            end
            if (n >= 1000) then
              return ("千" + ((n == 1000) ? ("") : (renderSpelloutCardinal((n % 100)))))
            end
            if (n >= 200) then
              return ((renderSpelloutCardinal((n / 200.0).floor) + "百") + ((n == 200) ? ("") : (renderSpelloutCardinal((n % 100)))))
            end
            if (n >= 100) then
              return ("百" + ((n == 100) ? ("") : (renderSpelloutCardinal((n % 100)))))
            end
            if (n >= 20) then
              return ((renderSpelloutCardinal((n / 20.0).floor) + "十") + ((n == 20) ? ("") : (renderSpelloutCardinal((n % 10)))))
            end
            if (n >= 10) then
              return ("十" + ((n == 10) ? ("") : (renderSpelloutCardinal((n % 10)))))
            end
            return "九" if (n >= 9)
            return "八" if (n >= 8)
            return "七" if (n >= 7)
            return "六" if (n >= 6)
            return "五" if (n >= 5)
            return "四" if (n >= 4)
            return "三" if (n >= 3)
            return "二" if (n >= 2)
            return "一" if (n >= 1)
            return "〇" if (n >= 0)
          end
          def renderSpelloutOrdinal(n)
            is_fractional = (n != n.floor)
            return n.to_s if is_fractional and (n > 1)
            return ("第" + renderSpelloutNumbering(n)) if (n >= 0)
          end
          def renderDigitsOrdinal(n)
            return ("第−" + -n.to_s) if (n < 0)
            return ("第" + n.to_s) if (n >= 0)
          end)
        end
      end
    end
  end
end