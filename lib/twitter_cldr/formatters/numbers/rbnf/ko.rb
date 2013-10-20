# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:ko] = Korean = Module.new { }
      
      class Korean::Spellout
        class << self
          def format_spellout_numbering_year(n)
            is_fractional = (n != n.floor)
            return n.to_s if is_fractional and (n > 1)
            return format_spellout_numbering(n) if (n >= 0)
          end
          def format_spellout_numbering(n)
            is_fractional = (n != n.floor)
            if is_fractional and (n > 1) then
              return ((format_spellout_numbering(n.floor) + "점") + format_spellout_numbering((n % 10)))
            end
            if (n > 0) and (n < 1) then
              return ((format_spellout_cardinal_sinokorean(n.floor) + "점") + format_spellout_numbering((n % 10)))
            end
            return format_spellout_cardinal_sinokorean(n) if (n >= 1)
            return "공" if (n >= 0)
          end
          def format_spellout_cardinal_sinokorean(n)
            is_fractional = (n != n.floor)
            return ("마이너스 " + format_spellout_cardinal_sinokorean(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_cardinal_sinokorean(n.floor) + "점") + format_spellout_cardinal_sinokorean((n % 10)))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 10000000000000000) then
              return ((format_spellout_cardinal_sinokorean((n / 10000000000000000).floor) + "경") + (if ((n == 10000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_sinokorean((n % 10000000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal_sinokorean((n / 1000000000000).floor) + "조") + (if ((n == 1000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_sinokorean((n % 1000000000000)))
              end))
            end
            if (n >= 100000000) then
              return ((format_spellout_cardinal_sinokorean((n / 100000000).floor) + "억") + (if ((n == 100000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_sinokorean((n % 100000000)))
              end))
            end
            if (n >= 20000) then
              return ((format_spellout_cardinal_sinokorean((n / 100000).floor) + "만") + (if ((n == 20000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_sinokorean((n % 100000)))
              end))
            end
            if (n >= 10000) then
              return ("만" + (if ((n == 10000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_sinokorean((n % 10000)))
              end))
            end
            if (n >= 2000) then
              return ((format_spellout_cardinal_sinokorean((n / 10000).floor) + "천") + (if ((n == 2000) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_cardinal_sinokorean((n % 10000))
              end))
            end
            if (n >= 1000) then
              return ("천" + (if ((n == 1000) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_cardinal_sinokorean((n % 1000))
              end))
            end
            if (n >= 200) then
              return ((format_spellout_cardinal_sinokorean((n / 1000).floor) + "백") + (if ((n == 200) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_cardinal_sinokorean((n % 1000))
              end))
            end
            if (n >= 100) then
              return ("백" + (if ((n == 100) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_cardinal_sinokorean((n % 100))
              end))
            end
            if (n >= 20) then
              return ((format_spellout_cardinal_sinokorean((n / 100).floor) + "십") + (if ((n == 20) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_cardinal_sinokorean((n % 100))
              end))
            end
            if (n >= 10) then
              return ("십" + (if ((n == 10) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_cardinal_sinokorean((n % 10))
              end))
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
          def format_spellout_cardinal_native_attributive(n)
            is_fractional = (n != n.floor)
            if (n < 0) then
              return ("마이너스 " + format_spellout_cardinal_native_attributive(-n))
            end
            return format_spellout_cardinal_sinokorean(n) if is_fractional and (n > 1)
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 10000000000000000) then
              return ((format_spellout_cardinal_sinokorean((n / 10000000000000000).floor) + "경") + (if ((n == 10000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_native_attributive((n % 10000000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal_sinokorean((n / 1000000000000).floor) + "조") + (if ((n == 1000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_native_attributive((n % 1000000000000)))
              end))
            end
            if (n >= 100000000) then
              return ((format_spellout_cardinal_sinokorean((n / 100000000).floor) + "억") + (if ((n == 100000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_native_attributive((n % 100000000)))
              end))
            end
            if (n >= 20000) then
              return ((format_spellout_cardinal_sinokorean((n / 100000).floor) + "만") + (if ((n == 20000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_native_attributive((n % 100000)))
              end))
            end
            if (n >= 10000) then
              return ("만" + (if ((n == 10000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_native_attributive((n % 10000)))
              end))
            end
            if (n >= 2000) then
              return ((format_spellout_cardinal_sinokorean((n / 10000).floor) + "천") + (if ((n == 2000) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_cardinal_native_attributive((n % 10000))
              end))
            end
            if (n >= 1000) then
              return ("천" + (if ((n == 1000) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_cardinal_native_attributive((n % 1000))
              end))
            end
            if (n >= 200) then
              return ((format_spellout_cardinal_sinokorean((n / 1000).floor) + "백") + (if ((n == 200) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_cardinal_native_attributive((n % 1000))
              end))
            end
            if (n >= 100) then
              return ("백" + (if ((n == 100) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_cardinal_native_attributive((n % 100))
              end))
            end
            if (n >= 90) then
              return ("아흔" + (if ((n == 90) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_cardinal_native_attributive((n % 100))
              end))
            end
            if (n >= 80) then
              return ("여든" + (if ((n == 80) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_cardinal_native_attributive((n % 100))
              end))
            end
            if (n >= 70) then
              return ("일흔" + (if ((n == 70) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_cardinal_native_attributive((n % 100))
              end))
            end
            if (n >= 60) then
              return ("예순" + (if ((n == 60) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_cardinal_native_attributive((n % 100))
              end))
            end
            if (n >= 50) then
              return ("쉰" + (if ((n == 50) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_cardinal_native_attributive((n % 100))
              end))
            end
            if (n >= 40) then
              return ("마흔" + (if ((n == 40) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_cardinal_native_attributive((n % 100))
              end))
            end
            if (n >= 30) then
              return ("서른" + (if ((n == 30) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_cardinal_native_attributive((n % 100))
              end))
            end
            if (n >= 21) then
              return ("스물" + (if ((n == 21) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_cardinal_native_attributive((n % 100))
              end))
            end
            return "스무" if (n >= 20)
            if (n >= 10) then
              return ("열" + (if ((n == 10) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_cardinal_native_attributive((n % 10))
              end))
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
          def format_spellout_cardinal_native(n)
            is_fractional = (n != n.floor)
            return ("마이너스 " + format_spellout_cardinal_native(-n)) if (n < 0)
            return format_spellout_cardinal_sinokorean(n) if is_fractional and (n > 1)
            return format_spellout_cardinal_sinokorean(n) if (n >= 100)
            if (n >= 90) then
              return ("아흔" + (if ((n == 90) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_cardinal_native((n % 100))
              end))
            end
            if (n >= 80) then
              return ("여든" + (if ((n == 80) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_cardinal_native((n % 100))
              end))
            end
            if (n >= 70) then
              return ("일흔" + (if ((n == 70) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_cardinal_native((n % 100))
              end))
            end
            if (n >= 60) then
              return ("예순" + (if ((n == 60) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_cardinal_native((n % 100))
              end))
            end
            if (n >= 50) then
              return ("쉰" + (if ((n == 50) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_cardinal_native((n % 100))
              end))
            end
            if (n >= 40) then
              return ("마흔" + (if ((n == 40) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_cardinal_native((n % 100))
              end))
            end
            if (n >= 30) then
              return ("서른" + (if ((n == 30) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_cardinal_native((n % 100))
              end))
            end
            if (n >= 20) then
              return ("스물" + (if ((n == 20) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_cardinal_native((n % 100))
              end))
            end
            if (n >= 10) then
              return ("열" + (if ((n == 10) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_cardinal_native((n % 10)))
              end))
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
          def format_spellout_cardinal_financial(n)
            is_fractional = (n != n.floor)
            return ("마이너스 " + format_spellout_cardinal_financial(-n)) if (n < 0)
            return format_spellout_cardinal_sinokorean(n) if is_fractional and (n > 1)
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 10000000000000000) then
              return ((format_spellout_cardinal_financial((n / 10000000000000000).floor) + "경") + (if ((n == 10000000000000000) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_cardinal_financial((n % 10000000000000000))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal_financial((n / 1000000000000).floor) + "조") + (if ((n == 1000000000000) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_cardinal_financial((n % 1000000000000))
              end))
            end
            if (n >= 100000000) then
              return ((format_spellout_cardinal_financial((n / 100000000).floor) + "억") + (if ((n == 100000000) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_cardinal_financial((n % 100000000))
              end))
            end
            if (n >= 10000) then
              return ((format_spellout_cardinal_financial((n / 10000).floor) + "만") + (if ((n == 10000) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_cardinal_financial((n % 10000))
              end))
            end
            if (n >= 1000) then
              return ((format_spellout_cardinal_financial((n / 1000).floor) + "천") + (if ((n == 1000) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_cardinal_financial((n % 1000))
              end))
            end
            if (n >= 100) then
              return ((format_spellout_cardinal_financial((n / 100).floor) + "백") + (if ((n == 100) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_cardinal_financial((n % 100))
              end))
            end
            if (n >= 10) then
              return ((format_spellout_cardinal_financial((n / 10).floor) + "십") + (if ((n == 10) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_cardinal_financial((n % 10))
              end))
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
          def format_spellout_ordinal_sinokorean_count(n)
            is_fractional = (n != n.floor)
            return ("마이너스 " + format_spellout_ordinal_sinokorean_count(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            if (n >= 10) then
              return (format_spellout_ordinal_sinokorean_count_smaller(n) + " 번째")
            end
            if (n >= 0) then
              return (format_spellout_ordinal_native_count_smaller(n) + " 번째")
            end
          end
          def format_spellout_ordinal_sinokorean_count_smaller(n)
            return format_spellout_ordinal_sinokorean_count_larger(n) if (n >= 50)
            if (n >= 40) then
              return ("마흔" + (if ((n == 40) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_ordinal_sinokorean_count_smaller((n % 100))
              end))
            end
            if (n >= 30) then
              return ("서른" + (if ((n == 30) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_ordinal_sinokorean_count_smaller((n % 100))
              end))
            end
            if (n >= 21) then
              return ("스물" + (if ((n == 21) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_ordinal_sinokorean_count_smaller((n % 100))
              end))
            end
            return "스무" if (n >= 20)
            if (n >= 10) then
              return ("열" + (if ((n == 10) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_ordinal_sinokorean_count_smaller((n % 10))
              end))
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
          private(:format_spellout_ordinal_sinokorean_count_smaller)
          def format_spellout_ordinal_sinokorean_count_larger(n)
            if (n >= 10000000000000000) then
              return ((format_spellout_ordinal_sinokorean_count_larger((n / 10000000000000000).floor) + "경") + (if ((n == 10000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_sinokorean_count_larger((n % 10000000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_ordinal_sinokorean_count_larger((n / 1000000000000).floor) + "조") + (if ((n == 1000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_sinokorean_count_larger((n % 1000000000000)))
              end))
            end
            if (n >= 100000000) then
              return ((format_spellout_ordinal_sinokorean_count_larger((n / 100000000).floor) + "억") + (if ((n == 100000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_sinokorean_count_larger((n % 100000000)))
              end))
            end
            if (n >= 20000) then
              return ((format_spellout_ordinal_sinokorean_count_larger((n / 100000).floor) + "만") + (if ((n == 20000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_sinokorean_count_larger((n % 100000)))
              end))
            end
            if (n >= 10000) then
              return ("만" + (if ((n == 10000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_sinokorean_count_larger((n % 10000)))
              end))
            end
            if (n >= 2000) then
              return ((format_spellout_ordinal_sinokorean_count_larger((n / 10000).floor) + "천") + (if ((n == 2000) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_ordinal_sinokorean_count_larger((n % 10000))
              end))
            end
            if (n >= 1000) then
              return ("천" + (if ((n == 1000) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_ordinal_sinokorean_count_larger((n % 1000))
              end))
            end
            if (n >= 200) then
              return ((format_spellout_ordinal_sinokorean_count_larger((n / 1000).floor) + "백") + (if ((n == 200) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_ordinal_sinokorean_count_larger((n % 1000))
              end))
            end
            if (n >= 100) then
              return ("백" + (if ((n == 100) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_ordinal_sinokorean_count_larger((n % 100))
              end))
            end
            if (n >= 90) then
              return ("구십" + (if ((n == 90) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_ordinal_sinokorean_count_larger((n % 100))
              end))
            end
            if (n >= 80) then
              return ("팔십" + (if ((n == 80) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_ordinal_sinokorean_count_larger((n % 100))
              end))
            end
            if (n >= 70) then
              return ("칠십" + (if ((n == 70) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_ordinal_sinokorean_count_larger((n % 100))
              end))
            end
            if (n >= 60) then
              return ("육십" + (if ((n == 60) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_ordinal_sinokorean_count_larger((n % 100))
              end))
            end
            if (n >= 50) then
              return ("오십" + (if ((n == 50) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_ordinal_sinokorean_count_larger((n % 100))
              end))
            end
            if (n >= 20) then
              return ((format_spellout_ordinal_sinokorean_count_larger((n / 100).floor) + "십") + (if ((n == 20) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_ordinal_sinokorean_count_larger((n % 100))
              end))
            end
            if (n >= 10) then
              return ("십" + (if ((n == 10) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_ordinal_sinokorean_count_larger((n % 10))
              end))
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
          private(:format_spellout_ordinal_sinokorean_count_larger)
          def format_spellout_ordinal_native_count(n)
            is_fractional = (n != n.floor)
            return ("마이너스 " + format_spellout_ordinal_native_count(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            if (n >= 0) then
              return (format_spellout_ordinal_native_count_smaller(n) + " 번째")
            end
          end
          def format_spellout_ordinal_native_count_smaller(n)
            return format_spellout_ordinal_native_count_larger(n) if (n >= 50)
            return format_spellout_cardinal_native_attributive(n) if (n >= 2)
            return "첫" if (n >= 1)
            return "영" if (n >= 0)
          end
          private(:format_spellout_ordinal_native_count_smaller)
          def format_spellout_ordinal_native_count_larger(n)
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 10000000000000000) then
              return ((format_spellout_cardinal_sinokorean((n / 10000000000000000).floor) + "경") + (if ((n == 10000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_native_count_larger((n % 10000000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal_sinokorean((n / 1000000000000).floor) + "조") + (if ((n == 1000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_native_count_larger((n % 1000000000000)))
              end))
            end
            if (n >= 100000000) then
              return ((format_spellout_cardinal_sinokorean((n / 100000000).floor) + "억") + (if ((n == 100000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_native_count_larger((n % 100000000)))
              end))
            end
            if (n >= 20000) then
              return ((format_spellout_cardinal_sinokorean((n / 100000).floor) + "만") + (if ((n == 20000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_native_count_larger((n % 100000)))
              end))
            end
            if (n >= 10000) then
              return ("만" + (if ((n == 10000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_native_count_larger((n % 10000)))
              end))
            end
            if (n >= 2000) then
              return ((format_spellout_cardinal_sinokorean((n / 10000).floor) + "천") + (if ((n == 2000) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_ordinal_native_count_larger((n % 10000))
              end))
            end
            if (n >= 1000) then
              return ("천" + (if ((n == 1000) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_ordinal_native_count_larger((n % 1000))
              end))
            end
            if (n >= 200) then
              return ((format_spellout_cardinal_sinokorean((n / 1000).floor) + "백") + (if ((n == 200) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_ordinal_native_count_larger((n % 1000))
              end))
            end
            if (n >= 100) then
              return ("백" + (if ((n == 100) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_ordinal_native_count_larger((n % 100))
              end))
            end
            if (n >= 90) then
              return ("아흔" + (if ((n == 90) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_cardinal_native_attributive((n % 100))
              end))
            end
            if (n >= 80) then
              return ("여든" + (if ((n == 80) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_cardinal_native_attributive((n % 100))
              end))
            end
            if (n >= 70) then
              return ("일흔" + (if ((n == 70) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_cardinal_native_attributive((n % 100))
              end))
            end
            if (n >= 60) then
              return ("예순" + (if ((n == 60) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_cardinal_native_attributive((n % 100))
              end))
            end
            if (n >= 50) then
              return ("쉰" + (if ((n == 50) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_cardinal_native_attributive((n % 100))
              end))
            end
            if (n >= 40) then
              return ("마흔" + (if ((n == 40) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_ordinal_native_count_larger((n % 100))
              end))
            end
            if (n >= 30) then
              return ("서른" + (if ((n == 30) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_ordinal_native_count_larger((n % 100))
              end))
            end
            return format_spellout_cardinal_native_attributive(n) if (n >= 2)
            return "한" if (n >= 1)
            return "영" if (n >= 0)
          end
          private(:format_spellout_ordinal_native_count_larger)
          def format_spellout_ordinal_sinokorean(n)
            if (n >= 100) then
              return (format_spellout_ordinal_sinokorean_count_larger(n) + "째")
            end
            return (format_spellout_cardinal_sinokorean(n) + "째") if (n >= 50)
            return format_spellout_ordinal_native(n) if (n >= 0)
          end
          def format_spellout_ordinal_native(n)
            is_fractional = (n != n.floor)
            return ("마이너스 " + format_spellout_ordinal_native(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return (format_spellout_ordinal_native_priv(n) + "째") if (n >= 0)
          end
          def format_spellout_ordinal_native_priv(n)
            return format_spellout_ordinal_native_smaller(n) if (n >= 3)
            return "둘" if (n >= 2)
            return "첫" if (n >= 1)
            return "영" if (n >= 0)
          end
          private(:format_spellout_ordinal_native_priv)
          def format_spellout_ordinal_native_smaller(n)
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 10000000000000000) then
              return ((format_spellout_cardinal_sinokorean((n / 10000000000000000).floor) + "경") + (if ((n == 10000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_native_smaller_x02((n % 10000000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal_sinokorean((n / 1000000000000).floor) + "조") + (if ((n == 1000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_native_smaller_x02((n % 1000000000000)))
              end))
            end
            if (n >= 100000000) then
              return ((format_spellout_cardinal_sinokorean((n / 100000000).floor) + "억") + (if ((n == 100000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_native_smaller_x02((n % 100000000)))
              end))
            end
            if (n >= 20000) then
              return ((format_spellout_cardinal_sinokorean((n / 100000).floor) + "만") + (if ((n == 20000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_native_smaller_x02((n % 100000)))
              end))
            end
            if (n >= 10000) then
              return ("만" + (if ((n == 10000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_spellout_ordinal_native_smaller_x02((n % 10000)))
              end))
            end
            if (n >= 2000) then
              return ((format_spellout_cardinal_sinokorean((n / 10000).floor) + "천") + (if ((n == 2000) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_ordinal_native_smaller_x02((n % 10000))
              end))
            end
            if (n >= 1000) then
              return ("천" + (if ((n == 1000) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_ordinal_native_smaller_x02((n % 1000))
              end))
            end
            if (n >= 200) then
              return ((format_spellout_cardinal_sinokorean((n / 1000).floor) + "백") + (if ((n == 200) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_ordinal_native_smaller_x02((n % 1000))
              end))
            end
            if (n >= 100) then
              return ("백" + (if ((n == 100) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_ordinal_native_smaller_x02((n % 100))
              end))
            end
            if (n >= 90) then
              return ("아흔" + (if ((n == 90) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_ordinal_native_smaller((n % 100))
              end))
            end
            if (n >= 80) then
              return ("여든" + (if ((n == 80) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_ordinal_native_smaller((n % 100))
              end))
            end
            if (n >= 70) then
              return ("일흔" + (if ((n == 70) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_ordinal_native_smaller((n % 100))
              end))
            end
            if (n >= 60) then
              return ("예순" + (if ((n == 60) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_ordinal_native_smaller((n % 100))
              end))
            end
            if (n >= 50) then
              return ("쉰" + (if ((n == 50) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_ordinal_native_smaller((n % 100))
              end))
            end
            if (n >= 40) then
              return ("마흔" + (if ((n == 40) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_ordinal_native_smaller((n % 100))
              end))
            end
            if (n >= 30) then
              return ("서른" + (if ((n == 30) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_ordinal_native_smaller((n % 100))
              end))
            end
            if (n >= 21) then
              return ("스물" + (if ((n == 21) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_ordinal_native_smaller((n % 100))
              end))
            end
            return "스무" if (n >= 20)
            if (n >= 10) then
              return ("열" + (if ((n == 10) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_ordinal_native_smaller((n % 10))
              end))
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
          private(:format_spellout_ordinal_native_smaller)
          def format_spellout_ordinal_native_smaller_x02(n)
            return format_spellout_ordinal_native_smaller(n) if (n >= 3)
            return "둘" if (n >= 2)
            return format_spellout_ordinal_native_smaller(n) if (n >= 0)
          end
          private(:format_spellout_ordinal_native_smaller_x02)
        end
      end
    end
  end
end