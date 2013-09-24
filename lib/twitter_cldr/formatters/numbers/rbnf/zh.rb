# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:zh] = Chinese = Class.new do
        class << self
          (def renderSpelloutNumberingYear(n)
            is_fractional = (n != n.floor)
            return n.to_s if is_fractional and (n > 1)
            return renderSpelloutNumbering(n) if (n >= 10000)
            return renderSpelloutNumberingYearDigits(n) if (n >= 1000)
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
            is_fractional = (n != n.floor)
            return ("负" + renderSpelloutNumbering(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((renderSpelloutNumbering(n.floor) + "点") + renderSpelloutNumbering(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 10000000000000000) then
              return ((renderSpelloutNumbering((n / 1.0e+16).floor) + "京") + ((n == 10000000000000000) ? ("") : (renderNumber13((n % 10000000000000000)))))
            end
            if (n >= 1000000000000) then
              return ((renderSpelloutNumbering((n / 1000000000000.0).floor) + "兆") + ((n == 1000000000000) ? ("") : (renderNumber8((n % 100000000000)))))
            end
            if (n >= 100000000) then
              return ((renderSpelloutNumbering((n / 100000000.0).floor) + "亿") + ((n == 100000000) ? ("") : (renderNumber5((n % 100000000)))))
            end
            if (n >= 10000) then
              return ((renderSpelloutNumbering((n / 10000.0).floor) + "万") + ((n == 10000) ? ("") : (renderNumber4((n % 10000)))))
            end
            if (n >= 1000) then
              return ((renderSpelloutNumbering((n / 1000.0).floor) + "千") + ((n == 1000) ? ("") : (renderNumber3((n % 100)))))
            end
            if (n >= 100) then
              return ((renderSpelloutNumbering((n / 100.0).floor) + "百") + ((n == 100) ? ("") : (renderNumber2((n % 100)))))
            end
            if (n >= 20) then
              return ((renderSpelloutNumbering((n / 20.0).floor) + "十") + ((n == 20) ? ("") : (renderSpelloutNumbering((n % 10)))))
            end
            if (n >= 10) then
              return ("十" + ((n == 10) ? ("") : (renderSpelloutNumbering((n % 10)))))
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
          def renderNumber2(n)
            return renderSpelloutNumbering(n) if (n >= 20)
            return ("一" + renderSpelloutNumbering(n)) if (n >= 10)
            return ("〇" + renderSpelloutNumbering(n)) if (n >= 1)
          end
          private(:renderNumber2)
          def renderNumber3(n)
            return renderSpelloutNumbering(n) if (n >= 100)
            return ("〇" + renderSpelloutNumbering(n)) if (n >= 20)
            return ("〇一" + renderSpelloutNumbering(n)) if (n >= 10)
            return ("〇" + renderSpelloutNumbering(n)) if (n >= 1)
          end
          private(:renderNumber3)
          def renderNumber4(n)
            return renderSpelloutNumbering(n) if (n >= 1000)
            return ("〇" + renderSpelloutNumbering(n)) if (n >= 20)
            return ("〇一" + renderSpelloutNumbering(n)) if (n >= 10)
            return ("〇" + renderSpelloutNumbering(n)) if (n >= 1)
          end
          private(:renderNumber4)
          def renderNumber5(n)
            return renderSpelloutNumbering(n) if (n >= 10000)
            return ("〇" + renderSpelloutNumbering(n)) if (n >= 20)
            return ("〇一" + renderSpelloutNumbering(n)) if (n >= 10)
            return ("〇" + renderSpelloutNumbering(n)) if (n >= 1)
          end
          private(:renderNumber5)
          def renderNumber8(n)
            return renderSpelloutNumbering(n) if (n >= 10000000)
            return ("〇" + renderSpelloutNumbering(n)) if (n >= 20)
            return ("〇一" + renderSpelloutNumbering(n)) if (n >= 10)
            return ("〇" + renderSpelloutNumbering(n)) if (n >= 1)
          end
          private(:renderNumber8)
          def renderNumber13(n)
            return renderSpelloutNumbering(n) if (n >= 1000000000000)
            return ("〇" + renderSpelloutNumbering(n)) if (n >= 20)
            return ("〇一" + renderSpelloutNumbering(n)) if (n >= 10)
            return ("〇" + renderSpelloutNumbering(n)) if (n >= 1)
          end
          private(:renderNumber13)
          def renderSpelloutCardinalFinancial(n)
            is_fractional = (n != n.floor)
            return ("负" + renderSpelloutCardinalFinancial(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((renderSpelloutCardinalFinancial(n.floor) + "点") + renderSpelloutCardinalFinancial(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 10000000000000000) then
              return ((renderSpelloutCardinalFinancial((n / 1.0e+16).floor) + "京") + (if (n == 10000000000000000) then
                ""
              else
                renderFinancialnumber13((n % 10000000000000000))
              end))
            end
            if (n >= 1000000000000) then
              return ((renderSpelloutCardinalFinancial((n / 1000000000000.0).floor) + "兆") + ((n == 1000000000000) ? ("") : (renderFinancialnumber8((n % 100000000000)))))
            end
            if (n >= 100000000) then
              return ((renderSpelloutCardinalFinancial((n / 100000000.0).floor) + "亿") + ((n == 100000000) ? ("") : (renderFinancialnumber5((n % 100000000)))))
            end
            if (n >= 10000) then
              return ((renderSpelloutCardinalFinancial((n / 10000.0).floor) + "万") + ((n == 10000) ? ("") : (renderFinancialnumber4((n % 10000)))))
            end
            if (n >= 1000) then
              return ((renderSpelloutCardinalFinancial((n / 1000.0).floor) + "仟") + ((n == 1000) ? ("") : (renderFinancialnumber3((n % 100)))))
            end
            if (n >= 100) then
              return ((renderSpelloutCardinalFinancial((n / 100.0).floor) + "佰") + ((n == 100) ? ("") : (renderFinancialnumber2((n % 100)))))
            end
            if (n >= 20) then
              return ((renderSpelloutCardinalFinancial((n / 20.0).floor) + "拾") + ((n == 20) ? ("") : (renderSpelloutCardinalFinancial((n % 10)))))
            end
            if (n >= 10) then
              return ("拾" + ((n == 10) ? ("") : (renderSpelloutCardinalFinancial((n % 10)))))
            end
            return "玖" if (n >= 9)
            return "捌" if (n >= 8)
            return "柒" if (n >= 7)
            return "陆" if (n >= 6)
            return "伍" if (n >= 5)
            return "肆" if (n >= 4)
            return "叁" if (n >= 3)
            return "贰" if (n >= 2)
            return "壹" if (n >= 1)
            return "零" if (n >= 0)
          end
          def renderFinancialnumber2(n)
            return renderSpelloutCardinalFinancial(n) if (n >= 20)
            return ("壹" + renderSpelloutCardinalFinancial(n)) if (n >= 10)
            return ("零" + renderSpelloutCardinalFinancial(n)) if (n >= 1)
          end
          private(:renderFinancialnumber2)
          def renderFinancialnumber3(n)
            return renderSpelloutCardinalFinancial(n) if (n >= 100)
            return ("零" + renderSpelloutCardinalFinancial(n)) if (n >= 20)
            return ("零壹" + renderSpelloutCardinalFinancial(n)) if (n >= 10)
            return ("零" + renderSpelloutCardinalFinancial(n)) if (n >= 1)
          end
          private(:renderFinancialnumber3)
          def renderFinancialnumber4(n)
            return renderSpelloutCardinalFinancial(n) if (n >= 1000)
            return ("零" + renderSpelloutCardinalFinancial(n)) if (n >= 20)
            return ("零壹" + renderSpelloutCardinalFinancial(n)) if (n >= 10)
            return ("零" + renderSpelloutCardinalFinancial(n)) if (n >= 1)
          end
          private(:renderFinancialnumber4)
          def renderFinancialnumber5(n)
            return renderSpelloutCardinalFinancial(n) if (n >= 10000)
            return ("零" + renderSpelloutCardinalFinancial(n)) if (n >= 20)
            return ("零壹" + renderSpelloutCardinalFinancial(n)) if (n >= 10)
            return ("零" + renderSpelloutCardinalFinancial(n)) if (n >= 1)
          end
          private(:renderFinancialnumber5)
          def renderFinancialnumber8(n)
            return renderSpelloutCardinalFinancial(n) if (n >= 10000000)
            return ("零" + renderSpelloutCardinalFinancial(n)) if (n >= 20)
            return ("零壹" + renderSpelloutCardinalFinancial(n)) if (n >= 10)
            return ("零" + renderSpelloutCardinalFinancial(n)) if (n >= 1)
          end
          private(:renderFinancialnumber8)
          def renderFinancialnumber13(n)
            return renderSpelloutCardinalFinancial(n) if (n >= 1000000000000)
            return ("零" + renderSpelloutCardinalFinancial(n)) if (n >= 20)
            return ("零壹" + renderSpelloutCardinalFinancial(n)) if (n >= 10)
            return ("零" + renderSpelloutCardinalFinancial(n)) if (n >= 1)
          end
          private(:renderFinancialnumber13)
          def renderSpelloutCardinal(n)
            is_fractional = (n != n.floor)
            return ("负" + renderSpelloutCardinal(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((renderSpelloutCardinal(n.floor) + "点") + renderSpelloutCardinal(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 10000000000000000) then
              return ((renderSpelloutCardinal((n / 1.0e+16).floor) + "京") + (if (n == 10000000000000000) then
                ""
              else
                renderCardinal13((n % 10000000000000000))
              end))
            end
            if (n >= 1000000000000) then
              return ((renderSpelloutCardinal((n / 1000000000000.0).floor) + "兆") + ((n == 1000000000000) ? ("") : (renderCardinal8((n % 100000000000)))))
            end
            if (n >= 100000000) then
              return ((renderSpelloutCardinal((n / 100000000.0).floor) + "亿") + ((n == 100000000) ? ("") : (renderCardinal5((n % 100000000)))))
            end
            if (n >= 10000) then
              return ((renderSpelloutCardinal((n / 10000.0).floor) + "万") + ((n == 10000) ? ("") : (renderCardinal4((n % 10000)))))
            end
            if (n >= 1000) then
              return ((renderSpelloutCardinal((n / 1000.0).floor) + "千") + ((n == 1000) ? ("") : (renderCardinal3((n % 100)))))
            end
            if (n >= 100) then
              return ((renderSpelloutCardinal((n / 100.0).floor) + "百") + ((n == 100) ? ("") : (renderCardinal2((n % 100)))))
            end
            return renderSpelloutNumbering(n) if (n >= 10)
            return "九" if (n >= 9)
            return "八" if (n >= 8)
            return "七" if (n >= 7)
            return "六" if (n >= 6)
            return "五" if (n >= 5)
            return "四" if (n >= 4)
            return "三" if (n >= 3)
            return "二" if (n >= 2)
            return "一" if (n >= 1)
            return "零" if (n >= 0)
          end
          def renderCardinal2(n)
            return renderSpelloutNumbering(n) if (n >= 20)
            return ("一" + renderSpelloutNumbering(n)) if (n >= 10)
            return ("零" + renderSpelloutNumbering(n)) if (n >= 1)
          end
          private(:renderCardinal2)
          def renderCardinal3(n)
            return renderSpelloutCardinal(n) if (n >= 100)
            return ("零" + renderSpelloutCardinal(n)) if (n >= 20)
            return ("零一" + renderSpelloutCardinal(n)) if (n >= 10)
            return ("零" + renderSpelloutNumbering(n)) if (n >= 1)
          end
          private(:renderCardinal3)
          def renderCardinal4(n)
            return renderSpelloutCardinal(n) if (n >= 1000)
            return ("零" + renderSpelloutCardinal(n)) if (n >= 20)
            return ("零一" + renderSpelloutCardinal(n)) if (n >= 10)
            return ("零" + renderSpelloutNumbering(n)) if (n >= 1)
          end
          private(:renderCardinal4)
          def renderCardinal5(n)
            return renderSpelloutCardinal(n) if (n >= 10000)
            return ("零" + renderSpelloutCardinal(n)) if (n >= 20)
            return ("零一" + renderSpelloutCardinal(n)) if (n >= 10)
            return ("零" + renderSpelloutNumbering(n)) if (n >= 1)
          end
          private(:renderCardinal5)
          def renderCardinal8(n)
            return renderSpelloutCardinal(n) if (n >= 10000000)
            return ("零" + renderSpelloutCardinal(n)) if (n >= 20)
            return ("零一" + renderSpelloutCardinal(n)) if (n >= 10)
            return ("零" + renderSpelloutNumbering(n)) if (n >= 1)
          end
          private(:renderCardinal8)
          def renderCardinal13(n)
            return renderSpelloutCardinal(n) if (n >= 1000000000000)
            return ("零" + renderSpelloutCardinal(n)) if (n >= 20)
            return ("零一" + renderSpelloutCardinal(n)) if (n >= 10)
            return ("零" + renderSpelloutNumbering(n)) if (n >= 1)
          end
          private(:renderCardinal13)
          def renderSpelloutCardinalAlternate2(n)
            is_fractional = (n != n.floor)
            return ("负" + renderSpelloutCardinalAlternate2(-n)) if (n < 0)
            return renderSpelloutCardinal(n) if is_fractional and (n > 1)
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 10000000000000000) then
              return ((renderSpelloutCardinalAlternate2((n / 1.0e+16).floor) + "京") + (if (n == 10000000000000000) then
                ""
              else
                renderCardinalAlternate213((n % 10000000000000000))
              end))
            end
            if (n >= 1000000000000) then
              return ((renderSpelloutCardinalAlternate2((n / 1000000000000.0).floor) + "兆") + (if (n == 1000000000000) then
                ""
              else
                renderCardinalAlternate28((n % 100000000000))
              end))
            end
            if (n >= 100000000) then
              return ((renderSpelloutCardinalAlternate2((n / 100000000.0).floor) + "亿") + ((n == 100000000) ? ("") : (renderCardinalAlternate25((n % 100000000)))))
            end
            if (n >= 10000) then
              return ((renderSpelloutCardinalAlternate2((n / 10000.0).floor) + "万") + ((n == 10000) ? ("") : (renderCardinalAlternate24((n % 10000)))))
            end
            if (n >= 1000) then
              return ((renderSpelloutCardinalAlternate2((n / 1000.0).floor) + "千") + ((n == 1000) ? ("") : (renderCardinalAlternate23((n % 100)))))
            end
            if (n >= 100) then
              return ((renderSpelloutCardinalAlternate2((n / 100.0).floor) + "百") + ((n == 100) ? ("") : (renderCardinalAlternate22((n % 100)))))
            end
            return renderSpelloutNumbering(n) if (n >= 10)
            return "九" if (n >= 9)
            return "八" if (n >= 8)
            return "七" if (n >= 7)
            return "六" if (n >= 6)
            return "五" if (n >= 5)
            return "四" if (n >= 4)
            return "三" if (n >= 3)
            return "两" if (n >= 2)
            return "一" if (n >= 1)
            return "零" if (n >= 0)
          end
          def renderCardinalAlternate22(n)
            return renderSpelloutNumbering(n) if (n >= 20)
            return ("一" + renderSpelloutNumbering(n)) if (n >= 10)
            return ("零" + renderSpelloutNumbering(n)) if (n >= 1)
          end
          private(:renderCardinalAlternate22)
          def renderCardinalAlternate23(n)
            return renderSpelloutCardinalAlternate2(n) if (n >= 100)
            return ("零" + renderSpelloutCardinalAlternate2(n)) if (n >= 20)
            return ("零一" + renderSpelloutCardinalAlternate2(n)) if (n >= 10)
            return ("零" + renderSpelloutNumbering(n)) if (n >= 1)
          end
          private(:renderCardinalAlternate23)
          def renderCardinalAlternate24(n)
            return renderSpelloutCardinalAlternate2(n) if (n >= 1000)
            return ("零" + renderSpelloutCardinalAlternate2(n)) if (n >= 20)
            return ("零一" + renderSpelloutCardinalAlternate2(n)) if (n >= 10)
            return ("零" + renderSpelloutNumbering(n)) if (n >= 1)
          end
          private(:renderCardinalAlternate24)
          def renderCardinalAlternate25(n)
            return renderSpelloutCardinalAlternate2(n) if (n >= 10000)
            return ("零" + renderSpelloutCardinalAlternate2(n)) if (n >= 20)
            return ("零一" + renderSpelloutCardinalAlternate2(n)) if (n >= 10)
            return ("零" + renderSpelloutNumbering(n)) if (n >= 1)
          end
          private(:renderCardinalAlternate25)
          def renderCardinalAlternate28(n)
            return renderSpelloutCardinalAlternate2(n) if (n >= 10000000)
            return ("零" + renderSpelloutCardinalAlternate2(n)) if (n >= 20)
            return ("零一" + renderSpelloutCardinalAlternate2(n)) if (n >= 10)
            return ("零" + renderSpelloutNumbering(n)) if (n >= 1)
          end
          private(:renderCardinalAlternate28)
          def renderCardinalAlternate213(n)
            return renderSpelloutCardinalAlternate2(n) if (n >= 1000000000000)
            return ("零" + renderSpelloutCardinalAlternate2(n)) if (n >= 20)
            return ("零一" + renderSpelloutCardinalAlternate2(n)) if (n >= 10)
            return ("零" + renderSpelloutNumbering(n)) if (n >= 1)
          end
          private(:renderCardinalAlternate213)
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