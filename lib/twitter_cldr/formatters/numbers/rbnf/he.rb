# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:he] = Hebrew = Class.new do
        class << self
          (def renderSpelloutNumberingYear(n)
            is_fractional = (n != n.floor)
            return n.to_s if is_fractional and (n > 1)
            return renderSpelloutNumbering(n) if (n >= 0)
          end
          def renderSpelloutNumbering(n)
            is_fractional = (n != n.floor)
            return ("מינוס " + renderSpelloutNumbering(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((renderSpelloutNumbering(n.floor) + " נקודה ") + renderSpelloutNumbering(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 3000000000000000) then
              return ((renderSpelloutNumberingM((n / 3.0e+15).floor) + " טריליון") + (if (n == 3000000000000000) then
                ""
              else
                (" " + renderAndFeminine((n % 1000000000000000)))
              end))
            end
            if (n >= 2000000000000000) then
              return ("שני טריליון" + (if (n == 2000000000000000) then
                ""
              else
                (" " + renderAndFeminine((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("טריליון" + (if (n == 1000000000000000) then
                ""
              else
                (" " + renderAndFeminine((n % 100000000000000)))
              end))
            end
            if (n >= 3000000000000) then
              return ((renderSpelloutNumberingM((n / 3000000000000.0).floor) + " ביליון") + (if (n == 3000000000000) then
                ""
              else
                (" " + renderAndFeminine((n % 1000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ("שני ביליון" + (if (n == 2000000000000) then
                ""
              else
                (" " + renderAndFeminine((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("ביליון" + (if (n == 1000000000000) then
                ""
              else
                (" " + renderAndFeminine((n % 100000000000)))
              end))
            end
            if (n >= 3000000000) then
              return ((renderSpelloutNumberingM((n / 3000000000.0).floor) + " מיליארד") + ((n == 3000000000) ? ("") : ((" " + renderAndFeminine((n % 1000000000))))))
            end
            if (n >= 2000000000) then
              return ("שני מיליארד" + ((n == 2000000000) ? ("") : ((" " + renderAndFeminine((n % 1000000000))))))
            end
            if (n >= 1000000000) then
              return ("מיליארד" + ((n == 1000000000) ? ("") : ((" " + renderAndFeminine((n % 100000000))))))
            end
            if (n >= 3000000) then
              return ((renderSpelloutNumberingM((n / 3000000.0).floor) + " מיליון") + ((n == 3000000) ? ("") : ((" " + renderAndFeminine((n % 1000000))))))
            end
            if (n >= 2000000) then
              return ("שני מיליון" + ((n == 2000000) ? ("") : ((" " + renderAndFeminine((n % 1000000))))))
            end
            if (n >= 1000000) then
              return ("מיליון" + ((n == 1000000) ? ("") : ((" " + renderAndFeminine((n % 100000))))))
            end
            if (n >= 11000) then
              return ((renderSpelloutNumberingM((n / 11000.0).floor) + " אלף") + ((n == 11000) ? ("") : ((" " + renderAndFeminine((n % 1000))))))
            end
            if (n >= 3000) then
              return ((renderThousands((n / 3000.0).floor) + " אלפים") + ((n == 3000) ? ("") : ((" " + renderAndFeminine((n % 1000))))))
            end
            if (n >= 2000) then
              return ("אלפיים" + ((n == 2000) ? ("") : ((" " + renderAndFeminine((n % 1000))))))
            end
            if (n >= 1000) then
              return ("אלף" + ((n == 1000) ? ("") : ((" " + renderAndFeminine((n % 100))))))
            end
            if (n >= 300) then
              return ((renderSpelloutNumbering((n / 300.0).floor) + " מאות") + ((n == 300) ? ("") : ((" " + renderAndFeminine((n % 100))))))
            end
            if (n >= 200) then
              return ("מאתיים" + ((n == 200) ? ("") : ((" " + renderAndFeminine((n % 100))))))
            end
            if (n >= 100) then
              return ("מאה" + ((n == 100) ? ("") : ((" " + renderAndFeminine((n % 100))))))
            end
            if (n >= 90) then
              return ("תשעים" + ((n == 90) ? ("") : ((" " + renderAndFeminine((n % 10))))))
            end
            if (n >= 80) then
              return ("שמונים" + ((n == 80) ? ("") : ((" " + renderAndFeminine((n % 10))))))
            end
            if (n >= 70) then
              return ("שבעים" + ((n == 70) ? ("") : ((" " + renderAndFeminine((n % 10))))))
            end
            if (n >= 60) then
              return ("שישים" + ((n == 60) ? ("") : ((" " + renderAndFeminine((n % 10))))))
            end
            if (n >= 50) then
              return ("חמישים" + ((n == 50) ? ("") : ((" " + renderAndFeminine((n % 10))))))
            end
            if (n >= 40) then
              return ("ארבעים" + ((n == 40) ? ("") : ((" " + renderAndFeminine((n % 10))))))
            end
            if (n >= 30) then
              return ("שלושים" + ((n == 30) ? ("") : ((" " + renderAndFeminine((n % 10))))))
            end
            if (n >= 20) then
              return ("עשרים" + ((n == 20) ? ("") : ((" " + renderAndFeminine((n % 10))))))
            end
            return (renderSpelloutNumbering((n % 10)) + " עשרה") if (n >= 13)
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
          def renderSpelloutCardinalFeminine(n)
            is_fractional = (n != n.floor)
            return ("מינוס " + renderSpelloutCardinalFeminine(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return (((renderSpelloutNumbering(n.floor) + " נקודה ") + renderSpelloutCardinalFeminine(n.to_s.gsub(/d*./, "").to_f)) + " ")
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 3000000000000000) then
              return ((renderSpelloutNumberingM((n / 3.0e+15).floor) + " טריליון") + (if (n == 3000000000000000) then
                ""
              else
                (" " + renderAndFeminine((n % 1000000000000000)))
              end))
            end
            if (n >= 2000000000000000) then
              return ("שני טריליון" + (if (n == 2000000000000000) then
                ""
              else
                (" " + renderAndFeminine((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("טריליון" + (if (n == 1000000000000000) then
                ""
              else
                (" " + renderAndFeminine((n % 100000000000000)))
              end))
            end
            if (n >= 3000000000000) then
              return ((renderSpelloutNumberingM((n / 3000000000000.0).floor) + " ביליון") + (if (n == 3000000000000) then
                ""
              else
                (" " + renderAndFeminine((n % 1000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ("שני ביליון" + (if (n == 2000000000000) then
                ""
              else
                (" " + renderAndFeminine((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("ביליון" + (if (n == 1000000000000) then
                ""
              else
                (" " + renderAndFeminine((n % 100000000000)))
              end))
            end
            if (n >= 3000000000) then
              return ((renderSpelloutNumberingM((n / 3000000000.0).floor) + " מיליארד") + ((n == 3000000000) ? ("") : ((" " + renderAndFeminine((n % 1000000000))))))
            end
            if (n >= 2000000000) then
              return ("שני מיליארד" + ((n == 2000000000) ? ("") : ((" " + renderAndFeminine((n % 1000000000))))))
            end
            if (n >= 1000000000) then
              return ("מיליארד" + ((n == 1000000000) ? ("") : ((" " + renderAndFeminine((n % 100000000))))))
            end
            if (n >= 3000000) then
              return ((renderSpelloutNumberingM((n / 3000000.0).floor) + " מיליון") + ((n == 3000000) ? ("") : ((" " + renderAndFeminine((n % 1000000))))))
            end
            if (n >= 2000000) then
              return ("שני מיליון" + ((n == 2000000) ? ("") : ((" " + renderAndFeminine((n % 1000000))))))
            end
            if (n >= 1000000) then
              return ("מיליון" + ((n == 1000000) ? ("") : ((" " + renderAndFeminine((n % 100000))))))
            end
            if (n >= 11000) then
              return ((renderSpelloutNumberingM((n / 11000.0).floor) + " אלף") + ((n == 11000) ? ("") : ((" " + renderAndFeminine((n % 1000))))))
            end
            if (n >= 3000) then
              return ((renderThousands((n / 3000.0).floor) + " אלפים") + ((n == 3000) ? ("") : ((" " + renderAndFeminine((n % 1000))))))
            end
            if (n >= 2000) then
              return ("אלפיים" + ((n == 2000) ? ("") : ((" " + renderAndFeminine((n % 1000))))))
            end
            if (n >= 1000) then
              return ("אלף" + ((n == 1000) ? ("") : ((" " + renderAndFeminine((n % 100))))))
            end
            if (n >= 300) then
              return ((renderSpelloutNumbering((n / 300.0).floor) + " מאות") + ((n == 300) ? ("") : ((" " + renderAndFeminine((n % 100))))))
            end
            if (n >= 200) then
              return ("מאתיים" + ((n == 200) ? ("") : ((" " + renderAndFeminine((n % 100))))))
            end
            if (n >= 100) then
              return ("מאה" + ((n == 100) ? ("") : ((" " + renderAndFeminine((n % 100))))))
            end
            if (n >= 90) then
              return ("תשעים" + ((n == 90) ? ("") : ((" " + renderAndFeminine((n % 10))))))
            end
            if (n >= 80) then
              return ("שמונים" + ((n == 80) ? ("") : ((" " + renderAndFeminine((n % 10))))))
            end
            if (n >= 70) then
              return ("שבעים" + ((n == 70) ? ("") : ((" " + renderAndFeminine((n % 10))))))
            end
            if (n >= 60) then
              return ("שישים" + ((n == 60) ? ("") : ((" " + renderAndFeminine((n % 10))))))
            end
            if (n >= 50) then
              return ("חמישים" + ((n == 50) ? ("") : ((" " + renderAndFeminine((n % 10))))))
            end
            if (n >= 40) then
              return ("ארבעים" + ((n == 40) ? ("") : ((" " + renderAndFeminine((n % 10))))))
            end
            if (n >= 30) then
              return ("שלושים" + ((n == 30) ? ("") : ((" " + renderAndFeminine((n % 10))))))
            end
            if (n >= 20) then
              return ("עשרים" + ((n == 20) ? ("") : ((" " + renderAndFeminine((n % 10))))))
            end
            return (renderSpelloutCardinalFeminine((n % 10)) + " עשרה") if (n >= 13)
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
          def renderAndFeminine(n)
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 3000000000000) then
              return ((renderAndMasculine((n / 3000000000000.0).floor) + " ביליון") + (if (n == 3000000000000) then
                ""
              else
                (" " + renderAndFeminine((n % 1000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ("שני ביליון" + (if (n == 2000000000000) then
                ""
              else
                (" " + renderAndFeminine((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("ביליון" + (if (n == 1000000000000) then
                ""
              else
                (" " + renderAndFeminine((n % 100000000000)))
              end))
            end
            if (n >= 3000000000) then
              return ((renderAndMasculine((n / 3000000000.0).floor) + " מיליארד") + ((n == 3000000000) ? ("") : ((" " + renderAndFeminine((n % 1000000000))))))
            end
            if (n >= 2000000000) then
              return ("שני מיליארד" + ((n == 2000000000) ? ("") : ((" " + renderAndFeminine((n % 1000000000))))))
            end
            if (n >= 1000000000) then
              return ("מיליארד" + ((n == 1000000000) ? ("") : ((" " + renderAndFeminine((n % 100000000))))))
            end
            if (n >= 3000000) then
              return ((renderAndMasculine((n / 3000000.0).floor) + " מיליון") + ((n == 3000000) ? ("") : ((" " + renderAndFeminine((n % 1000000))))))
            end
            if (n >= 2000000) then
              return ("שני מיליון" + ((n == 2000000) ? ("") : ((" " + renderAndFeminine((n % 1000000))))))
            end
            if (n >= 1000000) then
              return ("מיליון" + ((n == 1000000) ? ("") : ((" " + renderAndFeminine((n % 100000))))))
            end
            if (n >= 11000) then
              return ((renderAndMasculine((n / 11000.0).floor) + " אלף") + ((n == 11000) ? ("") : ((" " + renderAndFeminine((n % 1000))))))
            end
            if (n >= 3000) then
              return ((renderAndThousands((n / 3000.0).floor) + " אלפים") + ((n == 3000) ? ("") : ((" " + renderAndFeminine((n % 1000))))))
            end
            if (n >= 2000) then
              return ("אלפיים" + ((n == 2000) ? ("") : ((" " + renderAndFeminine((n % 1000))))))
            end
            if (n >= 1000) then
              return ("אלף" + ((n == 1000) ? ("") : ((" " + renderAndFeminine((n % 100))))))
            end
            return ("תשע מאות " + renderAndFeminine((n % 100))) if (n >= 901)
            return "תשע מאות" if (n >= 900)
            return ("שמונה מאות " + renderAndFeminine((n % 100))) if (n >= 801)
            return "שמונה מאות" if (n >= 800)
            return ("שבע מאות " + renderAndFeminine((n % 100))) if (n >= 701)
            return "שבע מאות" if (n >= 700)
            return ("שש מאות " + renderAndFeminine((n % 100))) if (n >= 601)
            return "שש מאות" if (n >= 600)
            return ("חמש מאות " + renderAndFeminine((n % 100))) if (n >= 501)
            return "חמש מאות" if (n >= 500)
            return ("ארבע מאות " + renderAndFeminine((n % 100))) if (n >= 401)
            return "ארבע מאות" if (n >= 400)
            return ("שלוש מאות " + renderAndFeminine((n % 100))) if (n >= 301)
            return "שלוש מאות" if (n >= 300)
            return ("מאתיים " + renderAndFeminine((n % 100))) if (n >= 201)
            return "מאתיים" if (n >= 200)
            return ("מאה " + renderAndFeminine((n % 100))) if (n >= 101)
            return "מאה" if (n >= 100)
            return ("תשעים " + renderAndFeminine((n % 10))) if (n >= 91)
            return "תשעים" if (n >= 90)
            return ("שמונים " + renderAndFeminine((n % 10))) if (n >= 81)
            return "שמונים" if (n >= 80)
            return ("שבעים " + renderAndFeminine((n % 10))) if (n >= 71)
            return "שבעים" if (n >= 70)
            return ("שישים " + renderAndFeminine((n % 10))) if (n >= 61)
            return "שישים" if (n >= 60)
            return ("חמישים " + renderAndFeminine((n % 10))) if (n >= 51)
            return "חמישים" if (n >= 50)
            return ("ארבעים " + renderAndFeminine((n % 10))) if (n >= 41)
            return "ארבעים" if (n >= 40)
            return ("שלושים " + renderAndFeminine((n % 10))) if (n >= 31)
            return "שלושים" if (n >= 30)
            return ("עשרים " + renderAndFeminine((n % 10))) if (n >= 21)
            return "עשרים" if (n >= 20)
            return ("ו" + renderSpelloutNumbering(n)) if (n >= 3)
            return "ושתיים" if (n >= 2)
            return ("ו" + renderSpelloutNumbering(n)) if (n >= 1)
          end
          private(:renderAndFeminine)
          def renderSpelloutNumberingM(n)
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 3000000000000000) then
              return ((renderSpelloutNumberingM((n / 3.0e+15).floor) + " טריליון") + (if (n == 3000000000000000) then
                ""
              else
                (" " + renderAndMasculine((n % 1000000000000000)))
              end))
            end
            if (n >= 2000000000000000) then
              return ("שני טריליון" + (if (n == 2000000000000000) then
                ""
              else
                (" " + renderAndMasculine((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("טריליון" + (if (n == 1000000000000000) then
                ""
              else
                (" " + renderAndMasculine((n % 100000000000000)))
              end))
            end
            if (n >= 3000000000000) then
              return ((renderSpelloutNumberingM((n / 3000000000000.0).floor) + " ביליון") + (if (n == 3000000000000) then
                ""
              else
                (" " + renderAndMasculine((n % 1000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ("שני ביליון" + (if (n == 2000000000000) then
                ""
              else
                (" " + renderAndMasculine((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("ביליון" + (if (n == 1000000000000) then
                ""
              else
                (" " + renderAndMasculine((n % 100000000000)))
              end))
            end
            if (n >= 3000000000) then
              return ((renderSpelloutNumberingM((n / 3000000000.0).floor) + " מיליארד") + ((n == 3000000000) ? ("") : ((" " + renderAndMasculine((n % 1000000000))))))
            end
            if (n >= 2000000000) then
              return ("שני מיליארד" + ((n == 2000000000) ? ("") : ((" " + renderAndMasculine((n % 1000000000))))))
            end
            if (n >= 1000000000) then
              return ("מיליארד" + ((n == 1000000000) ? ("") : ((" " + renderAndMasculine((n % 100000000))))))
            end
            if (n >= 3000000) then
              return ((renderSpelloutNumberingM((n / 3000000.0).floor) + " מיליון") + ((n == 3000000) ? ("") : ((" " + renderAndMasculine((n % 1000000))))))
            end
            if (n >= 2000000) then
              return ("שני מיליון" + ((n == 2000000) ? ("") : ((" " + renderAndMasculine((n % 1000000))))))
            end
            if (n >= 1000000) then
              return ("מיליון" + ((n == 1000000) ? ("") : ((" " + renderAndMasculine((n % 100000))))))
            end
            if (n >= 11000) then
              return ((renderSpelloutNumberingM((n / 11000.0).floor) + " אלף") + ((n == 11000) ? ("") : ((" " + renderAndMasculine((n % 1000))))))
            end
            if (n >= 3000) then
              return ((renderThousands((n / 3000.0).floor) + " אלפים") + ((n == 3000) ? ("") : ((" " + renderAndMasculine((n % 1000))))))
            end
            if (n >= 2000) then
              return ("אלפיים" + ((n == 2000) ? ("") : ((" " + renderAndMasculine((n % 1000))))))
            end
            if (n >= 1000) then
              return ("אלף" + ((n == 1000) ? ("") : ((" " + renderAndMasculine((n % 100))))))
            end
            if (n >= 300) then
              return ((renderSpelloutNumbering((n / 300.0).floor) + " מאות") + ((n == 300) ? ("") : ((" " + renderAndMasculine((n % 100))))))
            end
            if (n >= 200) then
              return ("מאתיים" + ((n == 200) ? ("") : ((" " + renderAndMasculine((n % 100))))))
            end
            if (n >= 100) then
              return ("מאה" + ((n == 100) ? ("") : ((" " + renderAndMasculine((n % 100))))))
            end
            if (n >= 90) then
              return ("תשעים" + ((n == 90) ? ("") : ((" " + renderAndMasculine((n % 10))))))
            end
            if (n >= 80) then
              return ("שמונים" + ((n == 80) ? ("") : ((" " + renderAndMasculine((n % 10))))))
            end
            if (n >= 70) then
              return ("שבעים" + ((n == 70) ? ("") : ((" " + renderAndMasculine((n % 10))))))
            end
            if (n >= 60) then
              return ("שישים" + ((n == 60) ? ("") : ((" " + renderAndMasculine((n % 10))))))
            end
            if (n >= 50) then
              return ("חמישים" + ((n == 50) ? ("") : ((" " + renderAndMasculine((n % 10))))))
            end
            if (n >= 40) then
              return ("ארבעים" + ((n == 40) ? ("") : ((" " + renderAndMasculine((n % 10))))))
            end
            if (n >= 30) then
              return ("שלושים" + ((n == 30) ? ("") : ((" " + renderAndMasculine((n % 10))))))
            end
            if (n >= 20) then
              return ("עשרים" + ((n == 20) ? ("") : ((" " + renderAndMasculine((n % 10))))))
            end
            return (renderSpelloutNumberingM((n % 10)) + " עשר") if (n >= 13)
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
          private(:renderSpelloutNumberingM)
          def renderSpelloutCardinalMasculine(n)
            is_fractional = (n != n.floor)
            return ("מינוס " + renderSpelloutCardinalMasculine(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return (((renderSpelloutNumberingM(n.floor) + " נקודה ") + renderSpelloutCardinalMasculine(n.to_s.gsub(/d*./, "").to_f)) + " ")
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 3000000000000000) then
              return ((renderSpelloutNumberingM((n / 3.0e+15).floor) + " טריליון") + (if (n == 3000000000000000) then
                ""
              else
                (" " + renderAndMasculine((n % 1000000000000000)))
              end))
            end
            if (n >= 2000000000000000) then
              return ("שני טריליון" + (if (n == 2000000000000000) then
                ""
              else
                (" " + renderAndMasculine((n % 1000000000000000)))
              end))
            end
            if (n >= 1000000000000000) then
              return ("טריליון" + (if (n == 1000000000000000) then
                ""
              else
                (" " + renderAndMasculine((n % 100000000000000)))
              end))
            end
            if (n >= 3000000000000) then
              return ((renderSpelloutNumberingM((n / 3000000000000.0).floor) + " ביליון") + (if (n == 3000000000000) then
                ""
              else
                (" " + renderAndMasculine((n % 1000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ("שני ביליון" + (if (n == 2000000000000) then
                ""
              else
                (" " + renderAndMasculine((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("ביליון" + (if (n == 1000000000000) then
                ""
              else
                (" " + renderAndMasculine((n % 100000000000)))
              end))
            end
            if (n >= 3000000000) then
              return ((renderSpelloutNumberingM((n / 3000000000.0).floor) + " מיליארד") + ((n == 3000000000) ? ("") : ((" " + renderAndMasculine((n % 1000000000))))))
            end
            if (n >= 2000000000) then
              return ("שני מיליארד" + ((n == 2000000000) ? ("") : ((" " + renderAndMasculine((n % 1000000000))))))
            end
            if (n >= 1000000000) then
              return ("מיליארד" + ((n == 1000000000) ? ("") : ((" " + renderAndMasculine((n % 100000000))))))
            end
            if (n >= 3000000) then
              return ((renderSpelloutNumberingM((n / 3000000.0).floor) + " מיליון") + ((n == 3000000) ? ("") : ((" " + renderAndMasculine((n % 1000000))))))
            end
            if (n >= 2000000) then
              return ("שני מיליון" + ((n == 2000000) ? ("") : ((" " + renderAndMasculine((n % 1000000))))))
            end
            if (n >= 1000000) then
              return ("מיליון" + ((n == 1000000) ? ("") : ((" " + renderAndMasculine((n % 100000))))))
            end
            if (n >= 11000) then
              return ((renderSpelloutNumberingM((n / 11000.0).floor) + " אלף") + ((n == 11000) ? ("") : ((" " + renderAndMasculine((n % 1000))))))
            end
            if (n >= 3000) then
              return ((renderThousands((n / 3000.0).floor) + " אלפים") + ((n == 3000) ? ("") : ((" " + renderAndMasculine((n % 1000))))))
            end
            if (n >= 2000) then
              return ("אלפיים" + ((n == 2000) ? ("") : ((" " + renderAndMasculine((n % 1000))))))
            end
            if (n >= 1000) then
              return ("אלף" + ((n == 1000) ? ("") : ((" " + renderAndMasculine((n % 100))))))
            end
            if (n >= 300) then
              return ((renderSpelloutNumbering((n / 300.0).floor) + " מאות") + ((n == 300) ? ("") : ((" " + renderAndMasculine((n % 100))))))
            end
            if (n >= 200) then
              return ("מאתיים" + ((n == 200) ? ("") : ((" " + renderAndMasculine((n % 100))))))
            end
            if (n >= 100) then
              return ("מאה" + ((n == 100) ? ("") : ((" " + renderAndMasculine((n % 100))))))
            end
            if (n >= 90) then
              return ("תשעים" + ((n == 90) ? ("") : ((" " + renderAndMasculine((n % 10))))))
            end
            if (n >= 80) then
              return ("שמונים" + ((n == 80) ? ("") : ((" " + renderAndMasculine((n % 10))))))
            end
            if (n >= 70) then
              return ("שבעים" + ((n == 70) ? ("") : ((" " + renderAndMasculine((n % 10))))))
            end
            if (n >= 60) then
              return ("שישים" + ((n == 60) ? ("") : ((" " + renderAndMasculine((n % 10))))))
            end
            if (n >= 50) then
              return ("חמישים" + ((n == 50) ? ("") : ((" " + renderAndMasculine((n % 10))))))
            end
            if (n >= 40) then
              return ("ארבעים" + ((n == 40) ? ("") : ((" " + renderAndMasculine((n % 10))))))
            end
            if (n >= 30) then
              return ("שלושים" + ((n == 30) ? ("") : ((" " + renderAndMasculine((n % 10))))))
            end
            if (n >= 20) then
              return ("עשרים" + ((n == 20) ? ("") : ((" " + renderAndMasculine((n % 10))))))
            end
            return (renderSpelloutCardinalMasculine((n % 10)) + " עשר") if (n >= 13)
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
          def renderSpelloutConstructMasculine(n)
            return ("מינוס " + renderSpelloutConstructMasculine(-n)) if (n < 0)
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
            return (renderSpelloutCardinalMasculine(n) + " ") if (n >= 0)
          end
          def renderAndMasculine(n)
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 3000000000000) then
              return ((renderAndMasculine((n / 3000000000000.0).floor) + " ביליון") + (if (n == 3000000000000) then
                ""
              else
                (" " + renderAndMasculine((n % 1000000000000)))
              end))
            end
            if (n >= 2000000000000) then
              return ("שני ביליון" + (if (n == 2000000000000) then
                ""
              else
                (" " + renderAndMasculine((n % 1000000000000)))
              end))
            end
            if (n >= 1000000000000) then
              return ("ביליון" + (if (n == 1000000000000) then
                ""
              else
                (" " + renderAndMasculine((n % 100000000000)))
              end))
            end
            if (n >= 3000000000) then
              return ((renderAndMasculine((n / 3000000000.0).floor) + " מיליארד") + ((n == 3000000000) ? ("") : ((" " + renderAndMasculine((n % 1000000000))))))
            end
            if (n >= 2000000000) then
              return ("שני מיליארד" + ((n == 2000000000) ? ("") : ((" " + renderAndMasculine((n % 1000000000))))))
            end
            if (n >= 1000000000) then
              return ("מיליארד" + ((n == 1000000000) ? ("") : ((" " + renderAndMasculine((n % 100000000))))))
            end
            if (n >= 3000000) then
              return ((renderAndMasculine((n / 3000000.0).floor) + " מיליון") + ((n == 3000000) ? ("") : ((" " + renderAndMasculine((n % 1000000))))))
            end
            if (n >= 2000000) then
              return ("שני מיליון" + ((n == 2000000) ? ("") : ((" " + renderAndMasculine((n % 1000000))))))
            end
            if (n >= 1000000) then
              return ("מיליון" + ((n == 1000000) ? ("") : ((" " + renderAndMasculine((n % 100000))))))
            end
            if (n >= 11000) then
              return ((renderAndMasculine((n / 11000.0).floor) + " אלף") + ((n == 11000) ? ("") : ((" " + renderAndMasculine((n % 1000))))))
            end
            if (n >= 3000) then
              return ((renderAndThousands((n / 3000.0).floor) + " אלפים") + ((n == 3000) ? ("") : ((" " + renderAndMasculine((n % 1000))))))
            end
            if (n >= 2000) then
              return ("אלפיים" + ((n == 2000) ? ("") : ((" " + renderAndMasculine((n % 1000))))))
            end
            if (n >= 1000) then
              return ("אלף" + ((n == 1000) ? ("") : ((" " + renderAndMasculine((n % 100))))))
            end
            return ("תשע מאות " + renderAndMasculine((n % 100))) if (n >= 901)
            return "תשע מאות" if (n >= 900)
            return ("שמונה מאות " + renderAndMasculine((n % 100))) if (n >= 801)
            return "שמונה מאות" if (n >= 800)
            return ("שבע מאות " + renderAndMasculine((n % 100))) if (n >= 701)
            return "שבע מאות" if (n >= 700)
            return ("שש מאות " + renderAndMasculine((n % 100))) if (n >= 601)
            return "שש מאות" if (n >= 600)
            return ("חמש מאות " + renderAndMasculine((n % 100))) if (n >= 501)
            return "חמש מאות" if (n >= 500)
            return ("ארבע מאות " + renderAndMasculine((n % 100))) if (n >= 401)
            return "ארבע מאות" if (n >= 400)
            return ("שלוש מאות " + renderAndMasculine((n % 100))) if (n >= 301)
            return "שלוש מאות" if (n >= 300)
            return ("מאתיים " + renderAndMasculine((n % 100))) if (n >= 201)
            return "מאתיים" if (n >= 200)
            return ("מאה " + renderAndMasculine((n % 100))) if (n >= 101)
            return "מאה" if (n >= 100)
            return ("תשעים " + renderAndMasculine((n % 10))) if (n >= 91)
            return "תשעים" if (n >= 90)
            return ("שמונים " + renderAndMasculine((n % 10))) if (n >= 81)
            return "שמונים" if (n >= 80)
            return ("שבעים " + renderAndMasculine((n % 10))) if (n >= 71)
            return "שבעים" if (n >= 70)
            return ("שישים " + renderAndMasculine((n % 10))) if (n >= 61)
            return "שישים" if (n >= 60)
            return ("חמישים " + renderAndMasculine((n % 10))) if (n >= 51)
            return "חמישים" if (n >= 50)
            return ("ארבעים " + renderAndMasculine((n % 10))) if (n >= 41)
            return "ארבעים" if (n >= 40)
            return ("שלושים " + renderAndMasculine((n % 10))) if (n >= 31)
            return "שלושים" if (n >= 30)
            return ("עשרים " + renderAndMasculine((n % 10))) if (n >= 21)
            return "עשרים" if (n >= 20)
            return ("ו" + renderSpelloutNumberingM(n)) if (n >= 1)
          end
          private(:renderAndMasculine)
          def renderThousands(n)
            return ("ERROR-" + n.to_s) if (n >= 11)
            return (renderSpelloutNumbering(n) + "ת") if (n >= 9)
            return "שמונת" if (n >= 8)
            return (renderSpelloutNumbering(n) + "ת") if (n >= 3)
            return ("ERROR-" + n.to_s) if (n >= 1)
          end
          private(:renderThousands)
          def renderAndThousands(n)
            return ("ERROR-" + n.to_s) if (n >= 11)
            return ("ו" + renderThousands(n)) if (n >= 3)
            return ("ERROR-" + n.to_s) if (n >= 1)
          end
          private(:renderAndThousands)
          def renderSpelloutOrdinalMasculine(n)
            is_fractional = (n != n.floor)
            return ("מינוס " + renderSpelloutOrdinalMasculine(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return renderSpelloutNumberingM(n) if (n >= 11)
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
          def renderSpelloutOrdinalFeminine(n)
            is_fractional = (n != n.floor)
            return ("מינוס " + renderSpelloutOrdinalFeminine(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return renderSpelloutNumbering(n) if (n >= 11)
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
          end)
        end
      end
    end
  end
end