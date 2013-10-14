# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:hi] = Hindi = Module.new { }
      
      class Hindi::Spellout
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
            return ("ऋण " + format_spellout_cardinal(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_cardinal(n.floor) + " दशमलव ") + format_spellout_cardinal(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 100000000000) then
              return ((format_spellout_cardinal((n / 100000000000.0).floor) + " खरब") + (if (n == 100000000000) then
                ""
              else
                (" " + format_spellout_cardinal((n % 100000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ((format_spellout_cardinal((n / 1000000000.0).floor) + " अरब") + (if (n == 1000000000) then
                ""
              else
                (" " + format_spellout_cardinal((n % 100000000)))
              end))
            end
            if (n >= 10000000) then
              return ((format_spellout_cardinal((n / 10000000.0).floor) + " करोड़") + ((n == 10000000) ? ("") : ((" " + format_spellout_cardinal((n % 10000000))))))
            end
            if (n >= 100000) then
              return ((format_spellout_cardinal((n / 100000.0).floor) + " लाख") + ((n == 100000) ? ("") : ((" " + format_spellout_cardinal((n % 100000))))))
            end
            if (n >= 1000) then
              return ((format_spellout_cardinal((n / 1000.0).floor) + " हज़ार") + ((n == 1000) ? ("") : ((" " + format_spellout_cardinal((n % 100))))))
            end
            if (n >= 100) then
              return ((format_spellout_cardinal((n / 100.0).floor) + " सौ") + ((n == 100) ? ("") : ((" " + format_spellout_cardinal((n % 100))))))
            end
            return "निन्यानबे" if (n >= 99)
            return "अट्ठानबे" if (n >= 98)
            return "सत्तानबे" if (n >= 97)
            return "छियानबे" if (n >= 96)
            return "पंचानबे" if (n >= 95)
            return "चौरानबे" if (n >= 94)
            return "तिरानबे" if (n >= 93)
            return "बानबे" if (n >= 92)
            return "इक्यानबे" if (n >= 91)
            return "नब्बे" if (n >= 90)
            return "नवासी" if (n >= 89)
            return "अट्ठासी" if (n >= 88)
            return "सत्तासी" if (n >= 87)
            return "छियासी" if (n >= 86)
            return "पचासी" if (n >= 85)
            return "चौरासी" if (n >= 84)
            return "तिरासी" if (n >= 83)
            return "बयासी" if (n >= 82)
            return "इक्यासी" if (n >= 81)
            return "अस्सी" if (n >= 80)
            return "उनासी" if (n >= 79)
            return "अठहत्तर" if (n >= 78)
            return "सतहत्तर" if (n >= 77)
            return "छिहत्तर" if (n >= 76)
            return "पचहत्तर" if (n >= 75)
            return "चौहत्तर" if (n >= 74)
            return "तिहत्तर" if (n >= 73)
            return "बहत्तर" if (n >= 72)
            return "इकहत्तर" if (n >= 71)
            return "सत्तर" if (n >= 70)
            return "उनहत्तर" if (n >= 69)
            return "अड़सठ" if (n >= 68)
            return "सड़सठ" if (n >= 67)
            return "छियासठ" if (n >= 66)
            return "पैंसठ" if (n >= 65)
            return "चौंसठ" if (n >= 64)
            return "तिरेसठ" if (n >= 63)
            return "बासठ" if (n >= 62)
            return "इकसठ" if (n >= 61)
            return "साठ" if (n >= 60)
            return "उनसठ" if (n >= 59)
            return "अट्ठावन" if (n >= 58)
            return "सत्तावन" if (n >= 57)
            return "छप्पन" if (n >= 56)
            return "पचपन" if (n >= 55)
            return "चौवन" if (n >= 54)
            return "तिरेपन" if (n >= 53)
            return "बावन" if (n >= 52)
            return "इक्यावन" if (n >= 51)
            return "पचास" if (n >= 50)
            return "उनचास" if (n >= 49)
            return "अड़तालीस" if (n >= 48)
            return "सैंतालीस" if (n >= 47)
            return "छियालीस" if (n >= 46)
            return "पैंतालीस" if (n >= 45)
            return "चौवालीस" if (n >= 44)
            return "तैंतालीस" if (n >= 43)
            return "बयालीस" if (n >= 42)
            return "इकतालीस" if (n >= 41)
            return "चालीस" if (n >= 40)
            return "उनतालीस" if (n >= 39)
            return "अड़तीस" if (n >= 38)
            return "सैंतीस" if (n >= 37)
            return "छत्तीस" if (n >= 36)
            return "पैंतीस" if (n >= 35)
            return "चौंतीस" if (n >= 34)
            return "तैंतीस" if (n >= 33)
            return "बत्तीस" if (n >= 32)
            return "इकतीस" if (n >= 31)
            return "तीस" if (n >= 30)
            return "उनतीस" if (n >= 29)
            return "अट्ठाईस" if (n >= 28)
            return "सत्ताईस" if (n >= 27)
            return "छब्बीस" if (n >= 26)
            return "पच्चीस" if (n >= 25)
            return "चौबीस" if (n >= 24)
            return "तेईस" if (n >= 23)
            return "बाईस" if (n >= 22)
            return "इक्कीस" if (n >= 21)
            return "बीस" if (n >= 20)
            return "उन्नीस" if (n >= 19)
            return "अठारह" if (n >= 18)
            return "सत्रह" if (n >= 17)
            return "सोलह" if (n >= 16)
            return "पन्द्रह" if (n >= 15)
            return "चौदह" if (n >= 14)
            return "तेरह" if (n >= 13)
            return "बारह" if (n >= 12)
            return "ग्यारह" if (n >= 11)
            return "दस" if (n >= 10)
            return "नौ" if (n >= 9)
            return "आठ" if (n >= 8)
            return "सात" if (n >= 7)
            return "छह" if (n >= 6)
            return "पाँच" if (n >= 5)
            return "चार" if (n >= 4)
            return "तीन" if (n >= 3)
            return "दो" if (n >= 2)
            return "एक" if (n >= 1)
            return "शून्य" if (n >= 0)
          end
          def format_spellout_ordinal_masculine(n)
            is_fractional = (n != n.floor)
            return ("ऋण " + format_spellout_ordinal_masculine(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return (format_spellout_cardinal(n) + "वाँ") if (n >= 7)
            return "छठा" if (n >= 6)
            return "पाँचवाँ" if (n >= 5)
            return "चौथा" if (n >= 4)
            return "तीसरा" if (n >= 3)
            return "दूसरा" if (n >= 2)
            return "पहला" if (n >= 1)
            return "शून्यवाँ" if (n >= 0)
          end
          def format_spellout_ordinal_feminine(n)
            is_fractional = (n != n.floor)
            return ("ऋण " + format_spellout_ordinal_feminine(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return (format_spellout_cardinal(n) + "वी") if (n >= 7)
            return "छठी" if (n >= 6)
            return "पाँचवी" if (n >= 5)
            return "चौथी" if (n >= 4)
            return "तीसरी" if (n >= 3)
            return "दूसरी" if (n >= 2)
            return "पहली" if (n >= 1)
            return "शून्यवी" if (n >= 0)
          end
        end
      end
      
      class Hindi::Ordinal
        class << self
          def format_digits_ordinal(n)
            return ("−" + format_digits_ordinal(-n)) if (n < 0)
            return (n.to_s + ".") if (n >= 0)
          end
        end
      end
    end
  end
end