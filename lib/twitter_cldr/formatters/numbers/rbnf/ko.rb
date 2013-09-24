# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:ko] = Korean = Class.new do
        class << self
          (def renderSpelloutNumberingYear(n)
            is_fractional = (n != n.floor)
            return n.to_s if is_fractional and (n > 1)
            return renderSpelloutNumbering(n) if (n >= 0)
          end
          def renderSpelloutNumbering(n)
            is_fractional = (n != n.floor)
            if is_fractional and (n > 1) then
              return ((renderSpelloutNumbering(n.floor) + "점") + renderSpelloutNumbering(n.to_s.gsub(/d*./, "").to_f))
            end
            if (n > 0) and (n < 1) then
              return ((renderSpelloutCardinalSinokorean(n.floor) + "점") + renderSpelloutNumbering(n.to_s.gsub(/d*./, "").to_f))
            end
            return renderSpelloutCardinalSinokorean(n) if (n >= 1)
            return "공" if (n >= 0)
          end
          def renderSpelloutCardinalSinokorean(n)
            is_fractional = (n != n.floor)
            return ("마이너스 " + renderSpelloutCardinalSinokorean(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((renderSpelloutCardinalSinokorean(n.floor) + "점") + renderSpelloutCardinalSinokorean(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 10000000000000000) then
              return ((renderSpelloutCardinalSinokorean((n / 1.0e+16).floor) + "경") + (if (n == 10000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalSinokorean((n % 10000000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((renderSpelloutCardinalSinokorean((n / 1000000000000.0).floor) + "조") + (if (n == 1000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalSinokorean((n % 100000000000)))
              end))
            end
            if (n >= 100000000) then
              return ((renderSpelloutCardinalSinokorean((n / 100000000.0).floor) + "억") + (if (n == 100000000) then
                ""
              else
                (" " + renderSpelloutCardinalSinokorean((n % 100000000)))
              end))
            end
            if (n >= 20000) then
              return ((renderSpelloutCardinalSinokorean((n / 20000.0).floor) + "만") + (if (n == 20000) then
                ""
              else
                (" " + renderSpelloutCardinalSinokorean((n % 10000)))
              end))
            end
            if (n >= 10000) then
              return ("만" + (if (n == 10000) then
                ""
              else
                (" " + renderSpelloutCardinalSinokorean((n % 10000)))
              end))
            end
            if (n >= 2000) then
              return ((renderSpelloutCardinalSinokorean((n / 2000.0).floor) + "천") + ((n == 2000) ? ("") : (renderSpelloutCardinalSinokorean((n % 1000)))))
            end
            if (n >= 1000) then
              return ("천" + ((n == 1000) ? ("") : (renderSpelloutCardinalSinokorean((n % 100)))))
            end
            if (n >= 200) then
              return ((renderSpelloutCardinalSinokorean((n / 200.0).floor) + "백") + ((n == 200) ? ("") : (renderSpelloutCardinalSinokorean((n % 100)))))
            end
            if (n >= 100) then
              return ("백" + ((n == 100) ? ("") : (renderSpelloutCardinalSinokorean((n % 100)))))
            end
            if (n >= 20) then
              return ((renderSpelloutCardinalSinokorean((n / 20.0).floor) + "십") + ((n == 20) ? ("") : (renderSpelloutCardinalSinokorean((n % 10)))))
            end
            if (n >= 10) then
              return ("십" + ((n == 10) ? ("") : (renderSpelloutCardinalSinokorean((n % 10)))))
            end
            return "구" if (n >= 9)
            return "팔" if (n >= 8)
            return "칠" if (n >= 7)
            return "육" if (n >= 6)
            return "오" if (n >= 5)
            return "사" if (n >= 4)
            return "삼" if (n >= 3)
            return "이" if (n >= 2)
            return "일" if (n >= 1)
            return "영" if (n >= 0)
          end
          def renderSpelloutCardinalNativeAttributive(n)
            is_fractional = (n != n.floor)
            return ("마이너스 " + renderSpelloutCardinalNativeAttributive(-n)) if (n < 0)
            return renderSpelloutCardinalSinokorean(n) if is_fractional and (n > 1)
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 10000000000000000) then
              return ((renderSpelloutCardinalSinokorean((n / 1.0e+16).floor) + "경") + (if (n == 10000000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalNativeAttributive((n % 10000000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((renderSpelloutCardinalSinokorean((n / 1000000000000.0).floor) + "조") + (if (n == 1000000000000) then
                ""
              else
                (" " + renderSpelloutCardinalNativeAttributive((n % 100000000000)))
              end))
            end
            if (n >= 100000000) then
              return ((renderSpelloutCardinalSinokorean((n / 100000000.0).floor) + "억") + (if (n == 100000000) then
                ""
              else
                (" " + renderSpelloutCardinalNativeAttributive((n % 100000000)))
              end))
            end
            if (n >= 20000) then
              return ((renderSpelloutCardinalSinokorean((n / 20000.0).floor) + "만") + (if (n == 20000) then
                ""
              else
                (" " + renderSpelloutCardinalNativeAttributive((n % 10000)))
              end))
            end
            if (n >= 10000) then
              return ("만" + (if (n == 10000) then
                ""
              else
                (" " + renderSpelloutCardinalNativeAttributive((n % 10000)))
              end))
            end
            if (n >= 2000) then
              return ((renderSpelloutCardinalSinokorean((n / 2000.0).floor) + "천") + ((n == 2000) ? ("") : (renderSpelloutCardinalNativeAttributive((n % 1000)))))
            end
            if (n >= 1000) then
              return ("천" + ((n == 1000) ? ("") : (renderSpelloutCardinalNativeAttributive((n % 100)))))
            end
            if (n >= 200) then
              return ((renderSpelloutCardinalSinokorean((n / 200.0).floor) + "백") + ((n == 200) ? ("") : (renderSpelloutCardinalNativeAttributive((n % 100)))))
            end
            if (n >= 100) then
              return ("백" + ((n == 100) ? ("") : (renderSpelloutCardinalNativeAttributive((n % 100)))))
            end
            if (n >= 90) then
              return ("아흔" + ((n == 90) ? ("") : (renderSpelloutCardinalNativeAttributive((n % 10)))))
            end
            if (n >= 80) then
              return ("여든" + ((n == 80) ? ("") : (renderSpelloutCardinalNativeAttributive((n % 10)))))
            end
            if (n >= 70) then
              return ("일흔" + ((n == 70) ? ("") : (renderSpelloutCardinalNativeAttributive((n % 10)))))
            end
            if (n >= 60) then
              return ("예순" + ((n == 60) ? ("") : (renderSpelloutCardinalNativeAttributive((n % 10)))))
            end
            if (n >= 50) then
              return ("쉰" + ((n == 50) ? ("") : (renderSpelloutCardinalNativeAttributive((n % 10)))))
            end
            if (n >= 40) then
              return ("마흔" + ((n == 40) ? ("") : (renderSpelloutCardinalNativeAttributive((n % 10)))))
            end
            if (n >= 30) then
              return ("서른" + ((n == 30) ? ("") : (renderSpelloutCardinalNativeAttributive((n % 10)))))
            end
            if (n >= 21) then
              return ("스물" + ((n == 21) ? ("") : (renderSpelloutCardinalNativeAttributive((n % 10)))))
            end
            return "스무" if (n >= 20)
            if (n >= 10) then
              return ("열" + ((n == 10) ? ("") : (renderSpelloutCardinalNativeAttributive((n % 10)))))
            end
            return "아홉" if (n >= 9)
            return "여덟" if (n >= 8)
            return "일곱" if (n >= 7)
            return "여섯" if (n >= 6)
            return "다섯" if (n >= 5)
            return "네" if (n >= 4)
            return "세" if (n >= 3)
            return "두" if (n >= 2)
            return "한" if (n >= 1)
            return "영" if (n >= 0)
          end
          def renderSpelloutCardinalNative(n)
            is_fractional = (n != n.floor)
            return ("마이너스 " + renderSpelloutCardinalNative(-n)) if (n < 0)
            return renderSpelloutCardinalSinokorean(n) if is_fractional and (n > 1)
            return renderSpelloutCardinalSinokorean(n) if (n >= 100)
            if (n >= 90) then
              return ("아흔" + ((n == 90) ? ("") : (renderSpelloutCardinalNative((n % 10)))))
            end
            if (n >= 80) then
              return ("여든" + ((n == 80) ? ("") : (renderSpelloutCardinalNative((n % 10)))))
            end
            if (n >= 70) then
              return ("일흔" + ((n == 70) ? ("") : (renderSpelloutCardinalNative((n % 10)))))
            end
            if (n >= 60) then
              return ("예순" + ((n == 60) ? ("") : (renderSpelloutCardinalNative((n % 10)))))
            end
            if (n >= 50) then
              return ("쉰" + ((n == 50) ? ("") : (renderSpelloutCardinalNative((n % 10)))))
            end
            if (n >= 40) then
              return ("마흔" + ((n == 40) ? ("") : (renderSpelloutCardinalNative((n % 10)))))
            end
            if (n >= 30) then
              return ("서른" + ((n == 30) ? ("") : (renderSpelloutCardinalNative((n % 10)))))
            end
            if (n >= 20) then
              return ("스물" + ((n == 20) ? ("") : (renderSpelloutCardinalNative((n % 10)))))
            end
            if (n >= 10) then
              return ("열" + ((n == 10) ? ("") : ((" " + renderSpelloutCardinalNative((n % 10))))))
            end
            return "아홉" if (n >= 9)
            return "여덟" if (n >= 8)
            return "일곱" if (n >= 7)
            return "여섯" if (n >= 6)
            return "다섯" if (n >= 5)
            return "넷" if (n >= 4)
            return "셋" if (n >= 3)
            return "둘" if (n >= 2)
            return "하나" if (n >= 1)
            return "영" if (n >= 0)
          end
          def renderSpelloutCardinalFinancial(n)
            is_fractional = (n != n.floor)
            return ("마이너스 " + renderSpelloutCardinalFinancial(-n)) if (n < 0)
            return renderSpelloutCardinalSinokorean(n) if is_fractional and (n > 1)
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 10000000000000000) then
              return ((renderSpelloutCardinalFinancial((n / 1.0e+16).floor) + "경") + (if (n == 10000000000000000) then
                ""
              else
                renderSpelloutCardinalFinancial((n % 10000000000000000))
              end))
            end
            if (n >= 1000000000000) then
              return ((renderSpelloutCardinalFinancial((n / 1000000000000.0).floor) + "조") + (if (n == 1000000000000) then
                ""
              else
                renderSpelloutCardinalFinancial((n % 100000000000))
              end))
            end
            if (n >= 100000000) then
              return ((renderSpelloutCardinalFinancial((n / 100000000.0).floor) + "억") + (if (n == 100000000) then
                ""
              else
                renderSpelloutCardinalFinancial((n % 100000000))
              end))
            end
            if (n >= 10000) then
              return ((renderSpelloutCardinalFinancial((n / 10000.0).floor) + "만") + ((n == 10000) ? ("") : (renderSpelloutCardinalFinancial((n % 10000)))))
            end
            if (n >= 1000) then
              return ((renderSpelloutCardinalFinancial((n / 1000.0).floor) + "천") + ((n == 1000) ? ("") : (renderSpelloutCardinalFinancial((n % 100)))))
            end
            if (n >= 100) then
              return ((renderSpelloutCardinalFinancial((n / 100.0).floor) + "백") + ((n == 100) ? ("") : (renderSpelloutCardinalFinancial((n % 100)))))
            end
            if (n >= 10) then
              return ((renderSpelloutCardinalFinancial((n / 10.0).floor) + "십") + ((n == 10) ? ("") : (renderSpelloutCardinalFinancial((n % 10)))))
            end
            return "구" if (n >= 9)
            return "팔" if (n >= 8)
            return "칠" if (n >= 7)
            return "육" if (n >= 6)
            return "오" if (n >= 5)
            return "사" if (n >= 4)
            return "삼" if (n >= 3)
            return "이" if (n >= 2)
            return "일" if (n >= 1)
            return "영" if (n >= 0)
          end
          def renderSpelloutOrdinalSinokoreanCount(n)
            is_fractional = (n != n.floor)
            return ("마이너스 " + renderSpelloutOrdinalSinokoreanCount(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            if (n >= 10) then
              return (renderSpelloutOrdinalSinokoreanCountSmaller(n) + " 번째")
            end
            return (renderSpelloutOrdinalNativeCountSmaller(n) + " 번째") if (n >= 0)
          end
          def renderSpelloutOrdinalSinokoreanCountSmaller(n)
            return renderSpelloutOrdinalSinokoreanCountLarger(n) if (n >= 50)
            if (n >= 40) then
              return ("마흔" + ((n == 40) ? ("") : (renderSpelloutOrdinalSinokoreanCountSmaller((n % 10)))))
            end
            if (n >= 30) then
              return ("서른" + ((n == 30) ? ("") : (renderSpelloutOrdinalSinokoreanCountSmaller((n % 10)))))
            end
            if (n >= 21) then
              return ("스물" + ((n == 21) ? ("") : (renderSpelloutOrdinalSinokoreanCountSmaller((n % 10)))))
            end
            return "스무" if (n >= 20)
            if (n >= 10) then
              return ("열" + ((n == 10) ? ("") : (renderSpelloutOrdinalSinokoreanCountSmaller((n % 10)))))
            end
            return "아홉" if (n >= 9)
            return "여덟" if (n >= 8)
            return "일곱" if (n >= 7)
            return "여섯" if (n >= 6)
            return "다섯" if (n >= 5)
            return "네" if (n >= 4)
            return "세" if (n >= 3)
            return "두" if (n >= 2)
            return "한" if (n >= 1)
            return "영" if (n >= 0)
          end
          private(:renderSpelloutOrdinalSinokoreanCountSmaller)
          def renderSpelloutOrdinalSinokoreanCountLarger(n)
            if (n >= 10000000000000000) then
              return ((renderSpelloutOrdinalSinokoreanCountLarger((n / 1.0e+16).floor) + "경") + (if (n == 10000000000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalSinokoreanCountLarger((n % 10000000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((renderSpelloutOrdinalSinokoreanCountLarger((n / 1000000000000.0).floor) + "조") + (if (n == 1000000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalSinokoreanCountLarger((n % 100000000000)))
              end))
            end
            if (n >= 100000000) then
              return ((renderSpelloutOrdinalSinokoreanCountLarger((n / 100000000.0).floor) + "억") + (if (n == 100000000) then
                ""
              else
                (" " + renderSpelloutOrdinalSinokoreanCountLarger((n % 100000000)))
              end))
            end
            if (n >= 20000) then
              return ((renderSpelloutOrdinalSinokoreanCountLarger((n / 20000.0).floor) + "만") + (if (n == 20000) then
                ""
              else
                (" " + renderSpelloutOrdinalSinokoreanCountLarger((n % 10000)))
              end))
            end
            if (n >= 10000) then
              return ("만" + (if (n == 10000) then
                ""
              else
                (" " + renderSpelloutOrdinalSinokoreanCountLarger((n % 10000)))
              end))
            end
            if (n >= 2000) then
              return ((renderSpelloutOrdinalSinokoreanCountLarger((n / 2000.0).floor) + "천") + (if (n == 2000) then
                ""
              else
                renderSpelloutOrdinalSinokoreanCountLarger((n % 1000))
              end))
            end
            if (n >= 1000) then
              return ("천" + (if (n == 1000) then
                ""
              else
                renderSpelloutOrdinalSinokoreanCountLarger((n % 100))
              end))
            end
            if (n >= 200) then
              return ((renderSpelloutOrdinalSinokoreanCountLarger((n / 200.0).floor) + "백") + ((n == 200) ? ("") : (renderSpelloutOrdinalSinokoreanCountLarger((n % 100)))))
            end
            if (n >= 100) then
              return ("백" + ((n == 100) ? ("") : (renderSpelloutOrdinalSinokoreanCountLarger((n % 100)))))
            end
            if (n >= 90) then
              return ("구십" + ((n == 90) ? ("") : (renderSpelloutOrdinalSinokoreanCountLarger((n % 10)))))
            end
            if (n >= 80) then
              return ("팔십" + ((n == 80) ? ("") : (renderSpelloutOrdinalSinokoreanCountLarger((n % 10)))))
            end
            if (n >= 70) then
              return ("칠십" + ((n == 70) ? ("") : (renderSpelloutOrdinalSinokoreanCountLarger((n % 10)))))
            end
            if (n >= 60) then
              return ("육십" + ((n == 60) ? ("") : (renderSpelloutOrdinalSinokoreanCountLarger((n % 10)))))
            end
            if (n >= 50) then
              return ("오십" + ((n == 50) ? ("") : (renderSpelloutOrdinalSinokoreanCountLarger((n % 10)))))
            end
            if (n >= 20) then
              return ((renderSpelloutOrdinalSinokoreanCountLarger((n / 20.0).floor) + "십") + ((n == 20) ? ("") : (renderSpelloutOrdinalSinokoreanCountLarger((n % 10)))))
            end
            if (n >= 10) then
              return ("십" + ((n == 10) ? ("") : (renderSpelloutOrdinalSinokoreanCountLarger((n % 10)))))
            end
            return "구" if (n >= 9)
            return "팔" if (n >= 8)
            return "칠" if (n >= 7)
            return "육" if (n >= 6)
            return "오" if (n >= 5)
            return "사" if (n >= 4)
            return "삼" if (n >= 3)
            return "이" if (n >= 2)
            return "일" if (n >= 1)
          end
          private(:renderSpelloutOrdinalSinokoreanCountLarger)
          def renderSpelloutOrdinalNativeCount(n)
            is_fractional = (n != n.floor)
            return ("마이너스 " + renderSpelloutOrdinalNativeCount(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return (renderSpelloutOrdinalNativeCountSmaller(n) + " 번째") if (n >= 0)
          end
          def renderSpelloutOrdinalNativeCountSmaller(n)
            return renderSpelloutOrdinalNativeCountLarger(n) if (n >= 50)
            return renderSpelloutCardinalNativeAttributive(n) if (n >= 2)
            return "첫" if (n >= 1)
            return "영" if (n >= 0)
          end
          private(:renderSpelloutOrdinalNativeCountSmaller)
          def renderSpelloutOrdinalNativeCountLarger(n)
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 10000000000000000) then
              return ((renderSpelloutCardinalSinokorean((n / 1.0e+16).floor) + "경") + (if (n == 10000000000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalNativeCountLarger((n % 10000000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((renderSpelloutCardinalSinokorean((n / 1000000000000.0).floor) + "조") + (if (n == 1000000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalNativeCountLarger((n % 100000000000)))
              end))
            end
            if (n >= 100000000) then
              return ((renderSpelloutCardinalSinokorean((n / 100000000.0).floor) + "억") + (if (n == 100000000) then
                ""
              else
                (" " + renderSpelloutOrdinalNativeCountLarger((n % 100000000)))
              end))
            end
            if (n >= 20000) then
              return ((renderSpelloutCardinalSinokorean((n / 20000.0).floor) + "만") + (if (n == 20000) then
                ""
              else
                (" " + renderSpelloutOrdinalNativeCountLarger((n % 10000)))
              end))
            end
            if (n >= 10000) then
              return ("만" + (if (n == 10000) then
                ""
              else
                (" " + renderSpelloutOrdinalNativeCountLarger((n % 10000)))
              end))
            end
            if (n >= 2000) then
              return ((renderSpelloutCardinalSinokorean((n / 2000.0).floor) + "천") + ((n == 2000) ? ("") : (renderSpelloutOrdinalNativeCountLarger((n % 1000)))))
            end
            if (n >= 1000) then
              return ("천" + ((n == 1000) ? ("") : (renderSpelloutOrdinalNativeCountLarger((n % 100)))))
            end
            if (n >= 200) then
              return ((renderSpelloutCardinalSinokorean((n / 200.0).floor) + "백") + ((n == 200) ? ("") : (renderSpelloutOrdinalNativeCountLarger((n % 100)))))
            end
            if (n >= 100) then
              return ("백" + ((n == 100) ? ("") : (renderSpelloutOrdinalNativeCountLarger((n % 100)))))
            end
            if (n >= 90) then
              return ("아흔" + ((n == 90) ? ("") : (renderSpelloutCardinalNativeAttributive((n % 10)))))
            end
            if (n >= 80) then
              return ("여든" + ((n == 80) ? ("") : (renderSpelloutCardinalNativeAttributive((n % 10)))))
            end
            if (n >= 70) then
              return ("일흔" + ((n == 70) ? ("") : (renderSpelloutCardinalNativeAttributive((n % 10)))))
            end
            if (n >= 60) then
              return ("예순" + ((n == 60) ? ("") : (renderSpelloutCardinalNativeAttributive((n % 10)))))
            end
            if (n >= 50) then
              return ("쉰" + ((n == 50) ? ("") : (renderSpelloutCardinalNativeAttributive((n % 10)))))
            end
            if (n >= 40) then
              return ("마흔" + ((n == 40) ? ("") : (renderSpelloutOrdinalNativeCountLarger((n % 10)))))
            end
            if (n >= 30) then
              return ("서른" + ((n == 30) ? ("") : (renderSpelloutOrdinalNativeCountLarger((n % 10)))))
            end
            return renderSpelloutCardinalNativeAttributive(n) if (n >= 2)
            return "한" if (n >= 1)
            return "영" if (n >= 0)
          end
          private(:renderSpelloutOrdinalNativeCountLarger)
          def renderSpelloutOrdinalSinokorean(n)
            return (renderSpelloutOrdinalSinokoreanCountLarger(n) + "째") if (n >= 100)
            return (renderSpelloutCardinalSinokorean(n) + "째") if (n >= 50)
            return renderSpelloutOrdinalNative(n) if (n >= 0)
          end
          def renderSpelloutOrdinalNative(n)
            is_fractional = (n != n.floor)
            return ("마이너스 " + renderSpelloutOrdinalNative(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return (renderSpelloutOrdinalNativePriv(n) + "째") if (n >= 0)
          end
          def renderSpelloutOrdinalNativePriv(n)
            return renderSpelloutOrdinalNativeSmaller(n) if (n >= 3)
            return "둘" if (n >= 2)
            return "첫" if (n >= 1)
            return "영" if (n >= 0)
          end
          private(:renderSpelloutOrdinalNativePriv)
          def renderSpelloutOrdinalNativeSmaller(n)
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 10000000000000000) then
              return ((renderSpelloutCardinalSinokorean((n / 1.0e+16).floor) + "경") + (if (n == 10000000000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalNativeSmallerX02((n % 10000000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((renderSpelloutCardinalSinokorean((n / 1000000000000.0).floor) + "조") + (if (n == 1000000000000) then
                ""
              else
                (" " + renderSpelloutOrdinalNativeSmallerX02((n % 100000000000)))
              end))
            end
            if (n >= 100000000) then
              return ((renderSpelloutCardinalSinokorean((n / 100000000.0).floor) + "억") + (if (n == 100000000) then
                ""
              else
                (" " + renderSpelloutOrdinalNativeSmallerX02((n % 100000000)))
              end))
            end
            if (n >= 20000) then
              return ((renderSpelloutCardinalSinokorean((n / 20000.0).floor) + "만") + (if (n == 20000) then
                ""
              else
                (" " + renderSpelloutOrdinalNativeSmallerX02((n % 10000)))
              end))
            end
            if (n >= 10000) then
              return ("만" + (if (n == 10000) then
                ""
              else
                (" " + renderSpelloutOrdinalNativeSmallerX02((n % 10000)))
              end))
            end
            if (n >= 2000) then
              return ((renderSpelloutCardinalSinokorean((n / 2000.0).floor) + "천") + ((n == 2000) ? ("") : (renderSpelloutOrdinalNativeSmallerX02((n % 1000)))))
            end
            if (n >= 1000) then
              return ("천" + ((n == 1000) ? ("") : (renderSpelloutOrdinalNativeSmallerX02((n % 100)))))
            end
            if (n >= 200) then
              return ((renderSpelloutCardinalSinokorean((n / 200.0).floor) + "백") + ((n == 200) ? ("") : (renderSpelloutOrdinalNativeSmallerX02((n % 100)))))
            end
            if (n >= 100) then
              return ("백" + ((n == 100) ? ("") : (renderSpelloutOrdinalNativeSmallerX02((n % 100)))))
            end
            if (n >= 90) then
              return ("아흔" + ((n == 90) ? ("") : (renderSpelloutOrdinalNativeSmaller((n % 10)))))
            end
            if (n >= 80) then
              return ("여든" + ((n == 80) ? ("") : (renderSpelloutOrdinalNativeSmaller((n % 10)))))
            end
            if (n >= 70) then
              return ("일흔" + ((n == 70) ? ("") : (renderSpelloutOrdinalNativeSmaller((n % 10)))))
            end
            if (n >= 60) then
              return ("예순" + ((n == 60) ? ("") : (renderSpelloutOrdinalNativeSmaller((n % 10)))))
            end
            if (n >= 50) then
              return ("쉰" + ((n == 50) ? ("") : (renderSpelloutOrdinalNativeSmaller((n % 10)))))
            end
            if (n >= 40) then
              return ("마흔" + ((n == 40) ? ("") : (renderSpelloutOrdinalNativeSmaller((n % 10)))))
            end
            if (n >= 30) then
              return ("서른" + ((n == 30) ? ("") : (renderSpelloutOrdinalNativeSmaller((n % 10)))))
            end
            if (n >= 21) then
              return ("스물" + ((n == 21) ? ("") : (renderSpelloutOrdinalNativeSmaller((n % 10)))))
            end
            return "스무" if (n >= 20)
            if (n >= 10) then
              return ("열" + ((n == 10) ? ("") : (renderSpelloutOrdinalNativeSmaller((n % 10)))))
            end
            return "아홉" if (n >= 9)
            return "여덟" if (n >= 8)
            return "일곱" if (n >= 7)
            return "여섯" if (n >= 6)
            return "다섯" if (n >= 5)
            return "넷" if (n >= 4)
            return "셋" if (n >= 3)
            return "두" if (n >= 2)
            return "한" if (n >= 1)
            return "" if (n >= 0)
          end
          private(:renderSpelloutOrdinalNativeSmaller)
          def renderSpelloutOrdinalNativeSmallerX02(n)
            return renderSpelloutOrdinalNativeSmaller(n) if (n >= 3)
            return "둘" if (n >= 2)
            return renderSpelloutOrdinalNativeSmaller(n) if (n >= 0)
          end
          private(:renderSpelloutOrdinalNativeSmallerX02))
        end
      end
    end
  end
end