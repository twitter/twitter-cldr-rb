# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:"zh-Hant"] = TraditionalChinese = Module.new { }
      
      class TraditionalChinese::Spellout
        class << self
          def format_spellout_numbering_year(n)
            is_fractional = (n != n.floor)
            return n.to_s if is_fractional and (n > 1)
            return format_spellout_numbering(n) if (n >= 10000)
            return format_spellout_numbering_year_digits(n) if (n >= 9001)
            return format_spellout_numbering(n) if (n >= 9000)
            return format_spellout_numbering_year_digits(n) if (n >= 8001)
            return format_spellout_numbering(n) if (n >= 8000)
            return format_spellout_numbering_year_digits(n) if (n >= 7001)
            return format_spellout_numbering(n) if (n >= 7000)
            return format_spellout_numbering_year_digits(n) if (n >= 6001)
            return format_spellout_numbering(n) if (n >= 6000)
            return format_spellout_numbering_year_digits(n) if (n >= 5001)
            return format_spellout_numbering(n) if (n >= 5000)
            return format_spellout_numbering_year_digits(n) if (n >= 4001)
            return format_spellout_numbering(n) if (n >= 4000)
            return format_spellout_numbering_year_digits(n) if (n >= 3001)
            return format_spellout_numbering(n) if (n >= 3000)
            return format_spellout_numbering_year_digits(n) if (n >= 2001)
            return format_spellout_numbering(n) if (n >= 2000)
            return format_spellout_numbering_year_digits(n) if (n >= 1001)
            return format_spellout_numbering(n) if (n >= 1000)
            return format_spellout_numbering(n) if (n >= 0)
          end
          def format_spellout_numbering_year_digits(n)
            if (n >= 1000) then
              return (format_spellout_numbering_year_digits((n / 1000).floor) + format_spellout_numbering_year_digits((n % 1000)))
            end
            if (n >= 100) then
              return (format_spellout_numbering_year_digits((n / 100).floor) + format_spellout_numbering_year_digits((n % 100)))
            end
            if (n >= 10) then
              return (format_spellout_numbering_year_digits((n / 10).floor) + format_spellout_numbering_year_digits((n % 10)))
            end
            return format_spellout_numbering(n) if (n >= 0)
          end
          private(:format_spellout_numbering_year_digits)
          def format_spellout_numbering(n)
            is_fractional = (n != n.floor)
            return ("負" + format_spellout_numbering(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_cardinal(n.floor) + "點") + format_spellout_numbering((n % 10)))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 10000000000000000) then
              return ((format_spellout_cardinal((n / 10000000000000000).floor) + "京") + (if ((n == 10000000000000000) or ((n % 10) == 0)) then
                ""
              else
                format_cardinal13((n % 10000000000000000))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal((n / 1000000000000).floor) + "兆") + (if ((n == 1000000000000) or ((n % 10) == 0)) then
                ""
              else
                format_cardinal8((n % 1000000000000))
              end))
            end
            if (n >= 100000000) then
              return ((format_spellout_cardinal((n / 100000000).floor) + "億") + (if ((n == 100000000) or ((n % 10) == 0)) then
                ""
              else
                format_cardinal5((n % 100000000))
              end))
            end
            if (n >= 10000) then
              return ((format_spellout_cardinal((n / 10000).floor) + "萬") + (((n == 10000) or ((n % 10) == 0)) ? ("") : (format_cardinal4((n % 10000)))))
            end
            if (n >= 1000) then
              return ((format_spellout_cardinal((n / 1000).floor) + "千") + (((n == 1000) or ((n % 10) == 0)) ? ("") : (format_cardinal3((n % 1000)))))
            end
            if (n >= 100) then
              return ((format_spellout_cardinal((n / 100).floor) + "百") + (((n == 100) or ((n % 10) == 0)) ? ("") : (format_cardinal2((n % 100)))))
            end
            if (n >= 20) then
              return ((format_spellout_numbering((n / 100).floor) + "十") + (if ((n == 20) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_numbering((n % 100))
              end))
            end
            if (n >= 10) then
              return ("十" + (if ((n == 10) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_numbering((n % 10))
              end))
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
          def format_spellout_cardinal_financial(n)
            is_fractional = (n != n.floor)
            return ("負" + format_spellout_cardinal_financial(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_cardinal_financial(n.floor) + "點") + format_spellout_cardinal_financial((n % 10)))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 10000000000000000) then
              return ((format_spellout_cardinal_financial((n / 10000000000000000).floor) + "京") + (if ((n == 10000000000000000) or ((n % 10) == 0)) then
                ""
              else
                format_financialnumber13((n % 10000000000000000))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal_financial((n / 1000000000000).floor) + "兆") + (if ((n == 1000000000000) or ((n % 10) == 0)) then
                ""
              else
                format_financialnumber8((n % 1000000000000))
              end))
            end
            if (n >= 100000000) then
              return ((format_spellout_cardinal_financial((n / 100000000).floor) + "億") + (if ((n == 100000000) or ((n % 10) == 0)) then
                ""
              else
                format_financialnumber5((n % 100000000))
              end))
            end
            if (n >= 10000) then
              return ((format_spellout_cardinal_financial((n / 10000).floor) + "萬") + (if ((n == 10000) or ((n % 10) == 0)) then
                ""
              else
                format_financialnumber4((n % 10000))
              end))
            end
            if (n >= 1000) then
              return ((format_spellout_cardinal_financial((n / 1000).floor) + "仟") + (if ((n == 1000) or ((n % 10) == 0)) then
                ""
              else
                format_financialnumber3((n % 1000))
              end))
            end
            if (n >= 100) then
              return ((format_spellout_cardinal_financial((n / 100).floor) + "佰") + (if ((n == 100) or ((n % 10) == 0)) then
                ""
              else
                format_financialnumber2((n % 100))
              end))
            end
            if (n >= 20) then
              return ((format_spellout_cardinal_financial((n / 100).floor) + "拾") + (if ((n == 20) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_cardinal_financial((n % 100))
              end))
            end
            if (n >= 10) then
              return ("拾" + (if ((n == 10) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_cardinal_financial((n % 10))
              end))
            end
            return "玖" if (n >= 9)
            return "捌" if (n >= 8)
            return "柒" if (n >= 7)
            return "陸" if (n >= 6)
            return "伍" if (n >= 5)
            return "肆" if (n >= 4)
            return "參" if (n >= 3)
            return "貳" if (n >= 2)
            return "壹" if (n >= 1)
            return "零" if (n >= 0)
          end
          def format_financialnumber2(n)
            return format_spellout_cardinal_financial(n) if (n >= 20)
            return ("壹" + format_spellout_cardinal_financial(n)) if (n >= 10)
            return ("零" + format_spellout_cardinal_financial(n)) if (n >= 1)
          end
          private(:format_financialnumber2)
          def format_financialnumber3(n)
            return format_spellout_cardinal_financial(n) if (n >= 100)
            return ("零" + format_spellout_cardinal_financial(n)) if (n >= 20)
            return ("零壹" + format_spellout_cardinal_financial(n)) if (n >= 10)
            return ("零" + format_spellout_cardinal_financial(n)) if (n >= 1)
          end
          private(:format_financialnumber3)
          def format_financialnumber4(n)
            return format_spellout_cardinal_financial(n) if (n >= 1000)
            return ("零" + format_spellout_cardinal_financial(n)) if (n >= 20)
            return ("零壹" + format_spellout_cardinal_financial(n)) if (n >= 10)
            return ("零" + format_spellout_cardinal_financial(n)) if (n >= 1)
          end
          private(:format_financialnumber4)
          def format_financialnumber5(n)
            return format_spellout_cardinal_financial(n) if (n >= 10000)
            return ("零" + format_spellout_cardinal_financial(n)) if (n >= 20)
            return ("零壹" + format_spellout_cardinal_financial(n)) if (n >= 10)
            return ("零" + format_spellout_cardinal_financial(n)) if (n >= 1)
          end
          private(:format_financialnumber5)
          def format_financialnumber8(n)
            return format_spellout_cardinal_financial(n) if (n >= 10000000)
            return ("零" + format_spellout_cardinal_financial(n)) if (n >= 20)
            return ("零壹" + format_spellout_cardinal_financial(n)) if (n >= 10)
            return ("零" + format_spellout_cardinal_financial(n)) if (n >= 1)
          end
          private(:format_financialnumber8)
          def format_financialnumber13(n)
            return format_spellout_cardinal_financial(n) if (n >= 1000000000000)
            return ("零" + format_spellout_cardinal_financial(n)) if (n >= 20)
            return ("零壹" + format_spellout_cardinal_financial(n)) if (n >= 10)
            return ("零" + format_spellout_cardinal_financial(n)) if (n >= 1)
          end
          private(:format_financialnumber13)
          def format_spellout_cardinal(n)
            is_fractional = (n != n.floor)
            return ("負" + format_spellout_cardinal(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_cardinal(n.floor) + "點") + format_spellout_cardinal((n % 10)))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 10000000000000000) then
              return ((format_spellout_cardinal((n / 10000000000000000).floor) + "京") + (if ((n == 10000000000000000) or ((n % 10) == 0)) then
                ""
              else
                format_cardinal13((n % 10000000000000000))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal((n / 1000000000000).floor) + "兆") + (if ((n == 1000000000000) or ((n % 10) == 0)) then
                ""
              else
                format_cardinal8((n % 1000000000000))
              end))
            end
            if (n >= 100000000) then
              return ((format_spellout_cardinal((n / 100000000).floor) + "億") + (if ((n == 100000000) or ((n % 10) == 0)) then
                ""
              else
                format_cardinal5((n % 100000000))
              end))
            end
            if (n >= 10000) then
              return ((format_spellout_cardinal((n / 10000).floor) + "萬") + (((n == 10000) or ((n % 10) == 0)) ? ("") : (format_cardinal4((n % 10000)))))
            end
            if (n >= 1000) then
              return ((format_spellout_cardinal((n / 1000).floor) + "千") + (((n == 1000) or ((n % 10) == 0)) ? ("") : (format_cardinal3((n % 1000)))))
            end
            if (n >= 100) then
              return ((format_spellout_cardinal((n / 100).floor) + "百") + (((n == 100) or ((n % 10) == 0)) ? ("") : (format_cardinal2((n % 100)))))
            end
            return format_spellout_numbering(n) if (n >= 10)
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
          def format_cardinal2(n)
            return format_spellout_numbering(n) if (n >= 20)
            return ("一" + format_spellout_numbering(n)) if (n >= 10)
            return ("零" + format_spellout_numbering(n)) if (n >= 1)
          end
          private(:format_cardinal2)
          def format_cardinal3(n)
            return format_spellout_cardinal(n) if (n >= 100)
            return ("零" + format_spellout_cardinal(n)) if (n >= 20)
            return ("零一" + format_spellout_cardinal(n)) if (n >= 10)
            return ("零" + format_spellout_numbering(n)) if (n >= 1)
          end
          private(:format_cardinal3)
          def format_cardinal4(n)
            return format_spellout_cardinal(n) if (n >= 1000)
            return ("零" + format_spellout_cardinal(n)) if (n >= 20)
            return ("零一" + format_spellout_cardinal(n)) if (n >= 10)
            return ("零" + format_spellout_numbering(n)) if (n >= 1)
          end
          private(:format_cardinal4)
          def format_cardinal5(n)
            return format_spellout_cardinal(n) if (n >= 10000)
            return ("零" + format_spellout_cardinal(n)) if (n >= 20)
            return ("零一" + format_spellout_cardinal(n)) if (n >= 10)
            return ("零" + format_spellout_numbering(n)) if (n >= 1)
          end
          private(:format_cardinal5)
          def format_cardinal8(n)
            return format_spellout_cardinal(n) if (n >= 10000000)
            return ("零" + format_spellout_cardinal(n)) if (n >= 20)
            return ("零一" + format_spellout_cardinal(n)) if (n >= 10)
            return ("零" + format_spellout_numbering(n)) if (n >= 1)
          end
          private(:format_cardinal8)
          def format_cardinal13(n)
            return format_spellout_cardinal(n) if (n >= 1000000000000)
            return ("零" + format_spellout_cardinal(n)) if (n >= 20)
            return ("零一" + format_spellout_cardinal(n)) if (n >= 10)
            return ("零" + format_spellout_numbering(n)) if (n >= 1)
          end
          private(:format_cardinal13)
          def format_spellout_cardinal_alternate2(n)
            is_fractional = (n != n.floor)
            return ("負" + format_spellout_cardinal_alternate2(-n)) if (n < 0)
            return format_spellout_cardinal(n) if is_fractional and (n > 1)
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 10000000000000000) then
              return ((format_spellout_cardinal_alternate2((n / 10000000000000000).floor) + "京") + (if ((n == 10000000000000000) or ((n % 10) == 0)) then
                ""
              else
                format_cardinal_alternate2_13((n % 10000000000000000))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal_alternate2((n / 1000000000000).floor) + "兆") + (if ((n == 1000000000000) or ((n % 10) == 0)) then
                ""
              else
                format_cardinal_alternate2_8((n % 1000000000000))
              end))
            end
            if (n >= 100000000) then
              return ((format_spellout_cardinal_alternate2((n / 100000000).floor) + "億") + (if ((n == 100000000) or ((n % 10) == 0)) then
                ""
              else
                format_cardinal_alternate2_5((n % 100000000))
              end))
            end
            if (n >= 10000) then
              return ((format_spellout_cardinal_alternate2((n / 10000).floor) + "萬") + (if ((n == 10000) or ((n % 10) == 0)) then
                ""
              else
                format_cardinal_alternate2_4((n % 10000))
              end))
            end
            if (n >= 1000) then
              return ((format_spellout_cardinal_alternate2((n / 1000).floor) + "千") + (if ((n == 1000) or ((n % 10) == 0)) then
                ""
              else
                format_cardinal_alternate2_3((n % 1000))
              end))
            end
            if (n >= 100) then
              return ((format_spellout_cardinal_alternate2((n / 100).floor) + "百") + (if ((n == 100) or ((n % 10) == 0)) then
                ""
              else
                format_cardinal_alternate2_2((n % 100))
              end))
            end
            return format_spellout_numbering(n) if (n >= 10)
            return "九" if (n >= 9)
            return "八" if (n >= 8)
            return "七" if (n >= 7)
            return "六" if (n >= 6)
            return "五" if (n >= 5)
            return "四" if (n >= 4)
            return "三" if (n >= 3)
            return "兩" if (n >= 2)
            return "一" if (n >= 1)
            return "零" if (n >= 0)
          end
          def format_cardinal_alternate2_2(n)
            return format_spellout_numbering(n) if (n >= 20)
            return ("一" + format_spellout_numbering(n)) if (n >= 10)
            return ("零" + format_spellout_numbering(n)) if (n >= 1)
          end
          private(:format_cardinal_alternate2_2)
          def format_cardinal_alternate2_3(n)
            return format_spellout_cardinal_alternate2(n) if (n >= 100)
            return ("零" + format_spellout_cardinal_alternate2(n)) if (n >= 20)
            return ("零一" + format_spellout_cardinal_alternate2(n)) if (n >= 10)
            return ("零" + format_spellout_numbering(n)) if (n >= 1)
          end
          private(:format_cardinal_alternate2_3)
          def format_cardinal_alternate2_4(n)
            return format_spellout_cardinal_alternate2(n) if (n >= 1000)
            return ("零" + format_spellout_cardinal_alternate2(n)) if (n >= 20)
            return ("零一" + format_spellout_cardinal_alternate2(n)) if (n >= 10)
            return ("零" + format_spellout_numbering(n)) if (n >= 1)
          end
          private(:format_cardinal_alternate2_4)
          def format_cardinal_alternate2_5(n)
            return format_spellout_cardinal_alternate2(n) if (n >= 10000)
            return ("零" + format_spellout_cardinal_alternate2(n)) if (n >= 20)
            return ("零一" + format_spellout_cardinal_alternate2(n)) if (n >= 10)
            return ("零" + format_spellout_numbering(n)) if (n >= 1)
          end
          private(:format_cardinal_alternate2_5)
          def format_cardinal_alternate2_8(n)
            return format_spellout_cardinal_alternate2(n) if (n >= 10000000)
            return ("零" + format_spellout_cardinal_alternate2(n)) if (n >= 20)
            return ("零一" + format_spellout_cardinal_alternate2(n)) if (n >= 10)
            return ("零" + format_spellout_numbering(n)) if (n >= 1)
          end
          private(:format_cardinal_alternate2_8)
          def format_cardinal_alternate2_13(n)
            return format_spellout_cardinal_alternate2(n) if (n >= 1000000000000)
            return ("零" + format_spellout_cardinal_alternate2(n)) if (n >= 20)
            return ("零一" + format_spellout_cardinal_alternate2(n)) if (n >= 10)
            return ("零" + format_spellout_numbering(n)) if (n >= 1)
          end
          private(:format_cardinal_alternate2_13)
          def format_spellout_ordinal(n)
            is_fractional = (n != n.floor)
            return n.to_s if is_fractional and (n > 1)
            return ("第" + format_spellout_numbering(n)) if (n >= 0)
          end
        end
      end
      
      class TraditionalChinese::Ordinal
        class << self
          def format_digits_ordinal(n)
            return ("第−" + -n.to_s) if (n < 0)
            return ("第" + n.to_s) if (n >= 0)
          end
        end
      end
    end
  end
end