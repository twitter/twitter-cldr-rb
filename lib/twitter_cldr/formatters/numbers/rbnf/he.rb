# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:he] = Hebrew = Module.new { }
      
      class Hebrew::Spellout
        class << self
          def format_spellout_numbering_year(n)
            is_fractional = (n != n.floor)
            return n.to_s if is_fractional and (n > 1)
            return format_spellout_numbering(n) if (n >= 0)
          end
          def format_spellout_numbering(n)
            is_fractional = (n != n.floor)
            return ("מינוס " + format_spellout_numbering(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_numbering(n.floor) + " נקודה ") + format_spellout_numbering((n % 10)))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 3000000000000000) then
              return ((format_spellout_numbering_m((n / 10000000000000000).floor) + " טריליון") + (if ((n == 3000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 10000000000000000)))
              end))
            end
            if (n >= 2000000000000000) then
              return ("שני טריליון" + (if ((n == 2000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 10000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("טריליון" + (if ((n == 1000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 1000000000000000)))
              end))
            end
            if (n >= 3000000000000) then
              return ((format_spellout_numbering_m((n / 10000000000000).floor) + " ביליון") + (if ((n == 3000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 10000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ("שני ביליון" + (if ((n == 2000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 10000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("ביליון" + (if ((n == 1000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 1000000000000)))
              end))
            end
            if (n >= 3000000000) then
              return ((format_spellout_numbering_m((n / 10000000000).floor) + " מיליארד") + (if ((n == 3000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 10000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ("שני מיליארד" + (if ((n == 2000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 10000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("מיליארד" + (if ((n == 1000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 1000000000)))
              end))
            end
            if (n >= 3000000) then
              return ((format_spellout_numbering_m((n / 10000000).floor) + " מיליון") + (if ((n == 3000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 10000000)))
              end))
            end
            if (n >= 2000000) then
              return ("שני מיליון" + (if ((n == 2000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 10000000)))
              end))
            end
            if (n >= 1000000) then
              return ("מיליון" + (if ((n == 1000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 1000000)))
              end))
            end
            if (n >= 11000) then
              return ((format_spellout_numbering_m((n / 1000000).floor) + " אלף") + (if ((n == 11000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 1000000)))
              end))
            end
            if (n >= 3000) then
              return ((format_thousands((n / 10000).floor) + " אלפים") + (if ((n == 3000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 10000)))
              end))
            end
            if (n >= 2000) then
              return ("אלפיים" + (if ((n == 2000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 10000)))
              end))
            end
            if (n >= 1000) then
              return ("אלף" + (if ((n == 1000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 1000)))
              end))
            end
            if (n >= 300) then
              return ((format_spellout_numbering((n / 1000).floor) + " מאות") + (if ((n == 300) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 1000)))
              end))
            end
            if (n >= 200) then
              return ("מאתיים" + (if ((n == 200) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 1000)))
              end))
            end
            if (n >= 100) then
              return ("מאה" + (if ((n == 100) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 100)))
              end))
            end
            if (n >= 90) then
              return ("תשעים" + (if ((n == 90) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 100)))
              end))
            end
            if (n >= 80) then
              return ("שמונים" + (if ((n == 80) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 100)))
              end))
            end
            if (n >= 70) then
              return ("שבעים" + (if ((n == 70) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 100)))
              end))
            end
            if (n >= 60) then
              return ("שישים" + (if ((n == 60) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 100)))
              end))
            end
            if (n >= 50) then
              return ("חמישים" + (if ((n == 50) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 100)))
              end))
            end
            if (n >= 40) then
              return ("ארבעים" + (if ((n == 40) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 100)))
              end))
            end
            if (n >= 30) then
              return ("שלושים" + (if ((n == 30) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 100)))
              end))
            end
            if (n >= 20) then
              return ("עשרים" + (if ((n == 20) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 100)))
              end))
            end
            return (format_spellout_numbering((n % 100)) + " עשרה") if (n >= 13)
            return "שתים עשרה" if (n >= 12)
            return "אחת עשרה" if (n >= 11)
            return "עשר" if (n >= 10)
            return "תשע" if (n >= 9)
            return "שמונה" if (n >= 8)
            return "שבע" if (n >= 7)
            return "שש" if (n >= 6)
            return "חמש" if (n >= 5)
            return "ארבע" if (n >= 4)
            return "שלוש" if (n >= 3)
            return "שתיים" if (n >= 2)
            return "אחת" if (n >= 1)
            return "אפס" if (n >= 0)
          end
          def format_spellout_cardinal_feminine(n)
            is_fractional = (n != n.floor)
            return ("מינוס " + format_spellout_cardinal_feminine(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return (((format_spellout_numbering(n.floor) + " נקודה ") + format_spellout_cardinal_feminine((n % 10))) + " ")
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 3000000000000000) then
              return ((format_spellout_numbering_m((n / 10000000000000000).floor) + " טריליון") + (if ((n == 3000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 10000000000000000)))
              end))
            end
            if (n >= 2000000000000000) then
              return ("שני טריליון" + (if ((n == 2000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 10000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("טריליון" + (if ((n == 1000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 1000000000000000)))
              end))
            end
            if (n >= 3000000000000) then
              return ((format_spellout_numbering_m((n / 10000000000000).floor) + " ביליון") + (if ((n == 3000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 10000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ("שני ביליון" + (if ((n == 2000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 10000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("ביליון" + (if ((n == 1000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 1000000000000)))
              end))
            end
            if (n >= 3000000000) then
              return ((format_spellout_numbering_m((n / 10000000000).floor) + " מיליארד") + (if ((n == 3000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 10000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ("שני מיליארד" + (if ((n == 2000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 10000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("מיליארד" + (if ((n == 1000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 1000000000)))
              end))
            end
            if (n >= 3000000) then
              return ((format_spellout_numbering_m((n / 10000000).floor) + " מיליון") + (if ((n == 3000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 10000000)))
              end))
            end
            if (n >= 2000000) then
              return ("שני מיליון" + (if ((n == 2000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 10000000)))
              end))
            end
            if (n >= 1000000) then
              return ("מיליון" + (if ((n == 1000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 1000000)))
              end))
            end
            if (n >= 11000) then
              return ((format_spellout_numbering_m((n / 1000000).floor) + " אלף") + (if ((n == 11000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 1000000)))
              end))
            end
            if (n >= 3000) then
              return ((format_thousands((n / 10000).floor) + " אלפים") + (if ((n == 3000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 10000)))
              end))
            end
            if (n >= 2000) then
              return ("אלפיים" + (if ((n == 2000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 10000)))
              end))
            end
            if (n >= 1000) then
              return ("אלף" + (if ((n == 1000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 1000)))
              end))
            end
            if (n >= 300) then
              return ((format_spellout_numbering((n / 1000).floor) + " מאות") + (if ((n == 300) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 1000)))
              end))
            end
            if (n >= 200) then
              return ("מאתיים" + (if ((n == 200) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 1000)))
              end))
            end
            if (n >= 100) then
              return ("מאה" + (if ((n == 100) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 100)))
              end))
            end
            if (n >= 90) then
              return ("תשעים" + (if ((n == 90) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 100)))
              end))
            end
            if (n >= 80) then
              return ("שמונים" + (if ((n == 80) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 100)))
              end))
            end
            if (n >= 70) then
              return ("שבעים" + (if ((n == 70) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 100)))
              end))
            end
            if (n >= 60) then
              return ("שישים" + (if ((n == 60) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 100)))
              end))
            end
            if (n >= 50) then
              return ("חמישים" + (if ((n == 50) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 100)))
              end))
            end
            if (n >= 40) then
              return ("ארבעים" + (if ((n == 40) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 100)))
              end))
            end
            if (n >= 30) then
              return ("שלושים" + (if ((n == 30) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 100)))
              end))
            end
            if (n >= 20) then
              return ("עשרים" + (if ((n == 20) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 100)))
              end))
            end
            if (n >= 13) then
              return (format_spellout_cardinal_feminine((n % 100)) + " עשרה")
            end
            return "שתיים עשרה" if (n >= 12)
            return "אחת עשרה" if (n >= 11)
            return "עשר" if (n >= 10)
            return "תשע" if (n >= 9)
            return "שמונה" if (n >= 8)
            return "שבע" if (n >= 7)
            return "שש" if (n >= 6)
            return "חמש" if (n >= 5)
            return "ארבע" if (n >= 4)
            return "שלוש" if (n >= 3)
            return "שתיים" if (n >= 2)
            return "אחת" if (n >= 1)
            return "אפס" if (n >= 0)
          end
          def format_and_feminine(n)
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 3000000000000) then
              return ((format_and_masculine((n / 10000000000000).floor) + " ביליון") + (if ((n == 3000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 10000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ("שני ביליון" + (if ((n == 2000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 10000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("ביליון" + (if ((n == 1000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 1000000000000)))
              end))
            end
            if (n >= 3000000000) then
              return ((format_and_masculine((n / 10000000000).floor) + " מיליארד") + (if ((n == 3000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 10000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ("שני מיליארד" + (if ((n == 2000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 10000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("מיליארד" + (if ((n == 1000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 1000000000)))
              end))
            end
            if (n >= 3000000) then
              return ((format_and_masculine((n / 10000000).floor) + " מיליון") + (if ((n == 3000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 10000000)))
              end))
            end
            if (n >= 2000000) then
              return ("שני מיליון" + (if ((n == 2000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 10000000)))
              end))
            end
            if (n >= 1000000) then
              return ("מיליון" + (if ((n == 1000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 1000000)))
              end))
            end
            if (n >= 11000) then
              return ((format_and_masculine((n / 1000000).floor) + " אלף") + (if ((n == 11000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 1000000)))
              end))
            end
            if (n >= 3000) then
              return ((format_and_thousands((n / 10000).floor) + " אלפים") + (if ((n == 3000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 10000)))
              end))
            end
            if (n >= 2000) then
              return ("אלפיים" + (if ((n == 2000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 10000)))
              end))
            end
            if (n >= 1000) then
              return ("אלף" + (if ((n == 1000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_feminine((n % 1000)))
              end))
            end
            return ("תשע מאות " + format_and_feminine((n % 1000))) if (n >= 901)
            return "תשע מאות" if (n >= 900)
            return ("שמונה מאות " + format_and_feminine((n % 1000))) if (n >= 801)
            return "שמונה מאות" if (n >= 800)
            return ("שבע מאות " + format_and_feminine((n % 1000))) if (n >= 701)
            return "שבע מאות" if (n >= 700)
            return ("שש מאות " + format_and_feminine((n % 1000))) if (n >= 601)
            return "שש מאות" if (n >= 600)
            return ("חמש מאות " + format_and_feminine((n % 1000))) if (n >= 501)
            return "חמש מאות" if (n >= 500)
            return ("ארבע מאות " + format_and_feminine((n % 1000))) if (n >= 401)
            return "ארבע מאות" if (n >= 400)
            return ("שלוש מאות " + format_and_feminine((n % 1000))) if (n >= 301)
            return "שלוש מאות" if (n >= 300)
            return ("מאתיים " + format_and_feminine((n % 1000))) if (n >= 201)
            return "מאתיים" if (n >= 200)
            return ("מאה " + format_and_feminine((n % 1000))) if (n >= 101)
            return "מאה" if (n >= 100)
            return ("תשעים " + format_and_feminine((n % 100))) if (n >= 91)
            return "תשעים" if (n >= 90)
            return ("שמונים " + format_and_feminine((n % 100))) if (n >= 81)
            return "שמונים" if (n >= 80)
            return ("שבעים " + format_and_feminine((n % 100))) if (n >= 71)
            return "שבעים" if (n >= 70)
            return ("שישים " + format_and_feminine((n % 100))) if (n >= 61)
            return "שישים" if (n >= 60)
            return ("חמישים " + format_and_feminine((n % 100))) if (n >= 51)
            return "חמישים" if (n >= 50)
            return ("ארבעים " + format_and_feminine((n % 100))) if (n >= 41)
            return "ארבעים" if (n >= 40)
            return ("שלושים " + format_and_feminine((n % 100))) if (n >= 31)
            return "שלושים" if (n >= 30)
            return ("עשרים " + format_and_feminine((n % 100))) if (n >= 21)
            return "עשרים" if (n >= 20)
            return ("ו" + format_spellout_numbering(n)) if (n >= 3)
            return "ושתיים" if (n >= 2)
            return ("ו" + format_spellout_numbering(n)) if (n >= 1)
          end
          private(:format_and_feminine)
          def format_spellout_numbering_m(n)
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 3000000000000000) then
              return ((format_spellout_numbering_m((n / 10000000000000000).floor) + " טריליון") + (if ((n == 3000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 10000000000000000)))
              end))
            end
            if (n >= 2000000000000000) then
              return ("שני טריליון" + (if ((n == 2000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 10000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("טריליון" + (if ((n == 1000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 1000000000000000)))
              end))
            end
            if (n >= 3000000000000) then
              return ((format_spellout_numbering_m((n / 10000000000000).floor) + " ביליון") + (if ((n == 3000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 10000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ("שני ביליון" + (if ((n == 2000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 10000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("ביליון" + (if ((n == 1000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 1000000000000)))
              end))
            end
            if (n >= 3000000000) then
              return ((format_spellout_numbering_m((n / 10000000000).floor) + " מיליארד") + (if ((n == 3000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 10000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ("שני מיליארד" + (if ((n == 2000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 10000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("מיליארד" + (if ((n == 1000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 1000000000)))
              end))
            end
            if (n >= 3000000) then
              return ((format_spellout_numbering_m((n / 10000000).floor) + " מיליון") + (if ((n == 3000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 10000000)))
              end))
            end
            if (n >= 2000000) then
              return ("שני מיליון" + (if ((n == 2000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 10000000)))
              end))
            end
            if (n >= 1000000) then
              return ("מיליון" + (if ((n == 1000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 1000000)))
              end))
            end
            if (n >= 11000) then
              return ((format_spellout_numbering_m((n / 1000000).floor) + " אלף") + (if ((n == 11000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 1000000)))
              end))
            end
            if (n >= 3000) then
              return ((format_thousands((n / 10000).floor) + " אלפים") + (if ((n == 3000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 10000)))
              end))
            end
            if (n >= 2000) then
              return ("אלפיים" + (if ((n == 2000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 10000)))
              end))
            end
            if (n >= 1000) then
              return ("אלף" + (if ((n == 1000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 1000)))
              end))
            end
            if (n >= 300) then
              return ((format_spellout_numbering((n / 1000).floor) + " מאות") + (if ((n == 300) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 1000)))
              end))
            end
            if (n >= 200) then
              return ("מאתיים" + (if ((n == 200) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 1000)))
              end))
            end
            if (n >= 100) then
              return ("מאה" + (if ((n == 100) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 100)))
              end))
            end
            if (n >= 90) then
              return ("תשעים" + (if ((n == 90) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 100)))
              end))
            end
            if (n >= 80) then
              return ("שמונים" + (if ((n == 80) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 100)))
              end))
            end
            if (n >= 70) then
              return ("שבעים" + (if ((n == 70) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 100)))
              end))
            end
            if (n >= 60) then
              return ("שישים" + (if ((n == 60) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 100)))
              end))
            end
            if (n >= 50) then
              return ("חמישים" + (if ((n == 50) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 100)))
              end))
            end
            if (n >= 40) then
              return ("ארבעים" + (if ((n == 40) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 100)))
              end))
            end
            if (n >= 30) then
              return ("שלושים" + (if ((n == 30) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 100)))
              end))
            end
            if (n >= 20) then
              return ("עשרים" + (if ((n == 20) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 100)))
              end))
            end
            return (format_spellout_numbering_m((n % 100)) + " עשר") if (n >= 13)
            return "שניים עשר" if (n >= 12)
            return "אחד עשר" if (n >= 11)
            return "עשרה" if (n >= 10)
            return "תשעה" if (n >= 9)
            return "שמונה" if (n >= 8)
            return "שבעה" if (n >= 7)
            return "שישה" if (n >= 6)
            return "חמישה" if (n >= 5)
            return "ארבעה" if (n >= 4)
            return "שלושה" if (n >= 3)
            return "שניים" if (n >= 2)
            return "אחד" if (n >= 1)
            return "אפס" if (n >= 0)
          end
          private(:format_spellout_numbering_m)
          def format_spellout_cardinal_masculine(n)
            is_fractional = (n != n.floor)
            return ("מינוס " + format_spellout_cardinal_masculine(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return (((format_spellout_numbering_m(n.floor) + " נקודה ") + format_spellout_cardinal_masculine((n % 10))) + " ")
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 3000000000000000) then
              return ((format_spellout_numbering_m((n / 10000000000000000).floor) + " טריליון") + (if ((n == 3000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 10000000000000000)))
              end))
            end
            if (n >= 2000000000000000) then
              return ("שני טריליון" + (if ((n == 2000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 10000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("טריליון" + (if ((n == 1000000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 1000000000000000)))
              end))
            end
            if (n >= 3000000000000) then
              return ((format_spellout_numbering_m((n / 10000000000000).floor) + " ביליון") + (if ((n == 3000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 10000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ("שני ביליון" + (if ((n == 2000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 10000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("ביליון" + (if ((n == 1000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 1000000000000)))
              end))
            end
            if (n >= 3000000000) then
              return ((format_spellout_numbering_m((n / 10000000000).floor) + " מיליארד") + (if ((n == 3000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 10000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ("שני מיליארד" + (if ((n == 2000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 10000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("מיליארד" + (if ((n == 1000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 1000000000)))
              end))
            end
            if (n >= 3000000) then
              return ((format_spellout_numbering_m((n / 10000000).floor) + " מיליון") + (if ((n == 3000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 10000000)))
              end))
            end
            if (n >= 2000000) then
              return ("שני מיליון" + (if ((n == 2000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 10000000)))
              end))
            end
            if (n >= 1000000) then
              return ("מיליון" + (if ((n == 1000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 1000000)))
              end))
            end
            if (n >= 11000) then
              return ((format_spellout_numbering_m((n / 1000000).floor) + " אלף") + (if ((n == 11000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 1000000)))
              end))
            end
            if (n >= 3000) then
              return ((format_thousands((n / 10000).floor) + " אלפים") + (if ((n == 3000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 10000)))
              end))
            end
            if (n >= 2000) then
              return ("אלפיים" + (if ((n == 2000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 10000)))
              end))
            end
            if (n >= 1000) then
              return ("אלף" + (if ((n == 1000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 1000)))
              end))
            end
            if (n >= 300) then
              return ((format_spellout_numbering((n / 1000).floor) + " מאות") + (if ((n == 300) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 1000)))
              end))
            end
            if (n >= 200) then
              return ("מאתיים" + (if ((n == 200) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 1000)))
              end))
            end
            if (n >= 100) then
              return ("מאה" + (if ((n == 100) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 100)))
              end))
            end
            if (n >= 90) then
              return ("תשעים" + (if ((n == 90) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 100)))
              end))
            end
            if (n >= 80) then
              return ("שמונים" + (if ((n == 80) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 100)))
              end))
            end
            if (n >= 70) then
              return ("שבעים" + (if ((n == 70) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 100)))
              end))
            end
            if (n >= 60) then
              return ("שישים" + (if ((n == 60) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 100)))
              end))
            end
            if (n >= 50) then
              return ("חמישים" + (if ((n == 50) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 100)))
              end))
            end
            if (n >= 40) then
              return ("ארבעים" + (if ((n == 40) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 100)))
              end))
            end
            if (n >= 30) then
              return ("שלושים" + (if ((n == 30) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 100)))
              end))
            end
            if (n >= 20) then
              return ("עשרים" + (if ((n == 20) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 100)))
              end))
            end
            if (n >= 13) then
              return (format_spellout_cardinal_masculine((n % 100)) + " עשר")
            end
            return "שניים עשר" if (n >= 12)
            return "אחד עשר" if (n >= 11)
            return "עשרה" if (n >= 10)
            return "תשעה" if (n >= 9)
            return "שמונה" if (n >= 8)
            return "שבעה" if (n >= 7)
            return "שישה" if (n >= 6)
            return "חמישה" if (n >= 5)
            return "ארבעה" if (n >= 4)
            return "שלושה" if (n >= 3)
            return "שניים" if (n >= 2)
            return "אחד" if (n >= 1)
            return "אפס" if (n >= 0)
          end
          def format_spellout_construct_masculine(n)
            return ("מינוס " + format_spellout_construct_masculine(-n)) if (n < 0)
            return "עשרת" if (n >= 10)
            return "תשעת" if (n >= 9)
            return "שמונת" if (n >= 8)
            return "שבעת" if (n >= 7)
            return "ששת" if (n >= 6)
            return "חמשת" if (n >= 5)
            return "ארבעת" if (n >= 4)
            return "שלושת" if (n >= 3)
            return "שני" if (n >= 2)
            return "אחד" if (n >= 1)
            return (format_spellout_cardinal_masculine(n) + " ") if (n >= 0)
          end
          def format_and_masculine(n)
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 3000000000000) then
              return ((format_and_masculine((n / 10000000000000).floor) + " ביליון") + (if ((n == 3000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 10000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ("שני ביליון" + (if ((n == 2000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 10000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("ביליון" + (if ((n == 1000000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 1000000000000)))
              end))
            end
            if (n >= 3000000000) then
              return ((format_and_masculine((n / 10000000000).floor) + " מיליארד") + (if ((n == 3000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 10000000000)))
              end))
            end
            if (n >= 2000000000) then
              return ("שני מיליארד" + (if ((n == 2000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 10000000000)))
              end))
            end
            if (n >= 1000000000) then
              return ("מיליארד" + (if ((n == 1000000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 1000000000)))
              end))
            end
            if (n >= 3000000) then
              return ((format_and_masculine((n / 10000000).floor) + " מיליון") + (if ((n == 3000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 10000000)))
              end))
            end
            if (n >= 2000000) then
              return ("שני מיליון" + (if ((n == 2000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 10000000)))
              end))
            end
            if (n >= 1000000) then
              return ("מיליון" + (if ((n == 1000000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 1000000)))
              end))
            end
            if (n >= 11000) then
              return ((format_and_masculine((n / 1000000).floor) + " אלף") + (if ((n == 11000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 1000000)))
              end))
            end
            if (n >= 3000) then
              return ((format_and_thousands((n / 10000).floor) + " אלפים") + (if ((n == 3000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 10000)))
              end))
            end
            if (n >= 2000) then
              return ("אלפיים" + (if ((n == 2000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 10000)))
              end))
            end
            if (n >= 1000) then
              return ("אלף" + (if ((n == 1000) or ((n % 10) == 0)) then
                ""
              else
                (" " + format_and_masculine((n % 1000)))
              end))
            end
            return ("תשע מאות " + format_and_masculine((n % 1000))) if (n >= 901)
            return "תשע מאות" if (n >= 900)
            return ("שמונה מאות " + format_and_masculine((n % 1000))) if (n >= 801)
            return "שמונה מאות" if (n >= 800)
            return ("שבע מאות " + format_and_masculine((n % 1000))) if (n >= 701)
            return "שבע מאות" if (n >= 700)
            return ("שש מאות " + format_and_masculine((n % 1000))) if (n >= 601)
            return "שש מאות" if (n >= 600)
            return ("חמש מאות " + format_and_masculine((n % 1000))) if (n >= 501)
            return "חמש מאות" if (n >= 500)
            return ("ארבע מאות " + format_and_masculine((n % 1000))) if (n >= 401)
            return "ארבע מאות" if (n >= 400)
            return ("שלוש מאות " + format_and_masculine((n % 1000))) if (n >= 301)
            return "שלוש מאות" if (n >= 300)
            return ("מאתיים " + format_and_masculine((n % 1000))) if (n >= 201)
            return "מאתיים" if (n >= 200)
            return ("מאה " + format_and_masculine((n % 1000))) if (n >= 101)
            return "מאה" if (n >= 100)
            return ("תשעים " + format_and_masculine((n % 100))) if (n >= 91)
            return "תשעים" if (n >= 90)
            return ("שמונים " + format_and_masculine((n % 100))) if (n >= 81)
            return "שמונים" if (n >= 80)
            return ("שבעים " + format_and_masculine((n % 100))) if (n >= 71)
            return "שבעים" if (n >= 70)
            return ("שישים " + format_and_masculine((n % 100))) if (n >= 61)
            return "שישים" if (n >= 60)
            return ("חמישים " + format_and_masculine((n % 100))) if (n >= 51)
            return "חמישים" if (n >= 50)
            return ("ארבעים " + format_and_masculine((n % 100))) if (n >= 41)
            return "ארבעים" if (n >= 40)
            return ("שלושים " + format_and_masculine((n % 100))) if (n >= 31)
            return "שלושים" if (n >= 30)
            return ("עשרים " + format_and_masculine((n % 100))) if (n >= 21)
            return "עשרים" if (n >= 20)
            return ("ו" + format_spellout_numbering_m(n)) if (n >= 1)
          end
          private(:format_and_masculine)
          def format_thousands(n)
            return ("ERROR-" + n.to_s) if (n >= 11)
            return (format_spellout_numbering(n) + "ת") if (n >= 9)
            return "שמונת" if (n >= 8)
            return (format_spellout_numbering(n) + "ת") if (n >= 3)
            return ("ERROR-" + n.to_s) if (n >= 1)
          end
          private(:format_thousands)
          def format_and_thousands(n)
            return ("ERROR-" + n.to_s) if (n >= 11)
            return ("ו" + format_thousands(n)) if (n >= 3)
            return ("ERROR-" + n.to_s) if (n >= 1)
          end
          private(:format_and_thousands)
          def format_spellout_ordinal_masculine(n)
            is_fractional = (n != n.floor)
            return ("מינוס " + format_spellout_ordinal_masculine(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return format_spellout_numbering_m(n) if (n >= 11)
            return "עשירי" if (n >= 10)
            return "תשיעי" if (n >= 9)
            return "שמיני" if (n >= 8)
            return "שביעי" if (n >= 7)
            return "שישי" if (n >= 6)
            return "חמישי" if (n >= 5)
            return "רביעי" if (n >= 4)
            return "שלישי" if (n >= 3)
            return "שני" if (n >= 2)
            return "ראשון" if (n >= 1)
            return "מספר אפס" if (n >= 0)
          end
          def format_spellout_ordinal_feminine(n)
            is_fractional = (n != n.floor)
            return ("מינוס " + format_spellout_ordinal_feminine(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return format_spellout_numbering(n) if (n >= 11)
            return "עשירית" if (n >= 10)
            return "תשיעית" if (n >= 9)
            return "שמינית" if (n >= 8)
            return "שביעית" if (n >= 7)
            return "שישית" if (n >= 6)
            return "חמישית" if (n >= 5)
            return "רביעית" if (n >= 4)
            return "שלישית" if (n >= 3)
            return "שניה" if (n >= 2)
            return "ראשונה" if (n >= 1)
            return "מספר אפס" if (n >= 0)
          end
        end
      end
    end
  end
end