# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:ja] = Japanese = Module.new { }
      
      class Japanese::Spellout
        class << self
          def format_spellout_numbering_year(n)
            is_fractional = (n != n.floor)
            return n.to_s if is_fractional and (n > 1)
            return format_spellout_numbering(n) if (n >= 10000)
            return format_spellout_numbering_year_digits(n) if (n >= 1000)
            return format_spellout_numbering(n) if (n >= 2)
            return "元" if (n >= 1)
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
            return format_spellout_cardinal(n) if (n >= 0)
          end
          def format_spellout_cardinal_financial(n)
            is_fractional = (n != n.floor)
            return ("マイナス" + format_spellout_cardinal_financial(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_cardinal_financial(n.floor) + "点") + format_spellout_cardinal_financial((n % 10)))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 10000000000000000) then
              return ((format_spellout_cardinal_financial((n / 10000000000000000).floor) + "京") + (if ((n == 10000000000000000) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_cardinal_financial((n % 10000000000000000))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal_financial((n / 1000000000000).floor) + "兆") + (if ((n == 1000000000000) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_cardinal_financial((n % 1000000000000))
              end))
            end
            if (n >= 100000000) then
              return ((format_spellout_cardinal_financial((n / 100000000).floor) + "億") + (if ((n == 100000000) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_cardinal_financial((n % 100000000))
              end))
            end
            if (n >= 10000) then
              return ((format_spellout_cardinal_financial((n / 10000).floor) + "萬") + (if ((n == 10000) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_cardinal_financial((n % 10000))
              end))
            end
            if (n >= 1000) then
              return ((format_spellout_cardinal_financial((n / 1000).floor) + "千") + (if ((n == 1000) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_cardinal_financial((n % 1000))
              end))
            end
            if (n >= 100) then
              return ((format_spellout_cardinal_financial((n / 100).floor) + "百") + (if ((n == 100) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_cardinal_financial((n % 100))
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
          def format_spellout_cardinal(n)
            is_fractional = (n != n.floor)
            return ("マイナス" + format_spellout_cardinal(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_cardinal(n.floor) + "・") + format_spellout_cardinal((n % 10)))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 10000000000000000) then
              return ((format_spellout_cardinal((n / 10000000000000000).floor) + "京") + (if ((n == 10000000000000000) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_cardinal((n % 10000000000000000))
              end))
            end
            if (n >= 1000000000000) then
              return ((format_spellout_cardinal((n / 1000000000000).floor) + "兆") + (if ((n == 1000000000000) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_cardinal((n % 1000000000000))
              end))
            end
            if (n >= 100000000) then
              return ((format_spellout_cardinal((n / 100000000).floor) + "億") + (if ((n == 100000000) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_cardinal((n % 100000000))
              end))
            end
            if (n >= 10000) then
              return ((format_spellout_cardinal((n / 10000).floor) + "万") + (if ((n == 10000) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_cardinal((n % 10000))
              end))
            end
            if (n >= 2000) then
              return ((format_spellout_cardinal((n / 10000).floor) + "千") + (if ((n == 2000) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_cardinal((n % 10000))
              end))
            end
            if (n >= 1000) then
              return ("千" + (if ((n == 1000) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_cardinal((n % 1000))
              end))
            end
            if (n >= 200) then
              return ((format_spellout_cardinal((n / 1000).floor) + "百") + (if ((n == 200) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_cardinal((n % 1000))
              end))
            end
            if (n >= 100) then
              return ("百" + (if ((n == 100) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_cardinal((n % 100))
              end))
            end
            if (n >= 20) then
              return ((format_spellout_cardinal((n / 100).floor) + "十") + (if ((n == 20) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_cardinal((n % 100))
              end))
            end
            if (n >= 10) then
              return ("十" + (if ((n == 10) or ((n % 10) == 0)) then
                ""
              else
                format_spellout_cardinal((n % 10))
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
          def format_spellout_ordinal(n)
            is_fractional = (n != n.floor)
            return n.to_s if is_fractional and (n > 1)
            return ("第" + format_spellout_numbering(n)) if (n >= 0)
          end
        end
      end
      
      class Japanese::Ordinal
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