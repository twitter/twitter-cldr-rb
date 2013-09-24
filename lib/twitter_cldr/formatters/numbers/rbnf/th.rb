# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:th] = Thai = Class.new do
        class << self
          (def renderSpelloutNumberingYear(n)
            is_fractional = (n != n.floor)
            return n.to_s if is_fractional and (n > 1)
            return renderSpelloutNumbering(n) if (n >= 0)
          end
          def renderSpelloutNumbering(n)
            return renderSpelloutCardinal(n) if (n >= 0)
          end
          def renderSpelloutCardinal(n)
            is_fractional = (n != n.floor)
            return ("ลบ​" + renderSpelloutCardinal(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((renderSpelloutCardinal(n.floor) + "​จุด​") + renderSpelloutCardinal(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 1000000) then
              return ((renderSpelloutCardinal((n / 1000000.0).floor) + "​ล้าน") + ((n == 1000000) ? ("") : (("​" + renderSpelloutCardinal((n % 100000))))))
            end
            if (n >= 100000) then
              return ((renderSpelloutCardinal((n / 100000.0).floor) + "​แสน") + ((n == 100000) ? ("") : (("​" + renderSpelloutCardinal((n % 100000))))))
            end
            if (n >= 10000) then
              return ((renderSpelloutCardinal((n / 10000.0).floor) + "​หมื่น") + ((n == 10000) ? ("") : (("​" + renderSpelloutCardinal((n % 10000))))))
            end
            if (n >= 1000) then
              return ((renderSpelloutCardinal((n / 1000.0).floor) + "​พัน") + ((n == 1000) ? ("") : (("​" + renderSpelloutCardinal((n % 100))))))
            end
            if (n >= 100) then
              return ((renderSpelloutCardinal((n / 100.0).floor) + "​ร้อย") + ((n == 100) ? ("") : (("​" + renderSpelloutCardinal((n % 100))))))
            end
            if (n >= 30) then
              return ((renderSpelloutCardinal((n / 30.0).floor) + "​สิบ") + ((n == 30) ? ("") : (("​" + renderAltOnes((n % 10))))))
            end
            if (n >= 20) then
              return ("ยี่​สิบ" + ((n == 20) ? ("") : (("​" + renderAltOnes((n % 10))))))
            end
            if (n >= 10) then
              return ("สิบ" + ((n == 10) ? ("") : (("​" + renderAltOnes((n % 10))))))
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
          def renderAltOnes(n)
            return renderSpelloutCardinal(n) if (n >= 2)
            return "เอ็ด" if (n >= 1)
          end
          private(:renderAltOnes)
          def renderSpelloutOrdinal(n)
            is_fractional = (n != n.floor)
            return n.to_s if is_fractional and (n > 1)
            return ("ที่​" + renderSpelloutCardinal(n)) if (n >= 0)
          end
          def renderDigitsOrdinal(n)
            return ("ที่−" + -n.to_s) if (n < 0)
            return ("ที่​" + n.to_s) if (n >= 0)
          end)
        end
      end
    end
  end
end