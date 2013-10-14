# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter
      @formatters[:ta] = Tamil = Module.new { }
      
      class Tamil::Spellout
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
            return ("எதிர்ம " + format_spellout_cardinal(-n)) if (n < 0)
            if is_fractional and (n > 1) then
              return ((format_spellout_cardinal(n.floor) + " புள்ளி ") + format_spellout_cardinal(n.to_s.gsub(/d*./, "").to_f))
            end
            return n.to_s if (n >= 1000000000000000000)
            if (n >= 10000000) then
              return ((format_spellout_cardinal((n / 10000000.0).floor) + " கோடி") + ((n == 10000000) ? ("") : ((" " + format_spellout_cardinal((n % 10000000))))))
            end
            if (n >= 100000) then
              return ((format_spellout_cardinal((n / 100000.0).floor) + " லட்சம்") + ((n == 100000) ? ("") : ((" " + format_spellout_cardinal((n % 100000))))))
            end
            if (n >= 1000) then
              return ((format_spellout_cardinal((n / 1000.0).floor) + " ஆயிரம்") + ((n == 1000) ? ("") : ((" " + format_spellout_cardinal((n % 100))))))
            end
            if (n >= 900) then
              return ("தொள்ளாயிரம்" + ((n == 900) ? ("") : ((" " + format_spellout_cardinal((n % 100))))))
            end
            if (n >= 800) then
              return ("எண்நூறு" + ((n == 800) ? ("") : ((" " + format_spellout_cardinal((n % 100))))))
            end
            if (n >= 700) then
              return ("எழுநூறு" + ((n == 700) ? ("") : ((" " + format_spellout_cardinal((n % 100))))))
            end
            if (n >= 600) then
              return ("அறுநூறு" + ((n == 600) ? ("") : ((" " + format_spellout_cardinal((n % 100))))))
            end
            if (n >= 500) then
              return ("ஐநூறு" + ((n == 500) ? ("") : ((" " + format_spellout_cardinal((n % 100))))))
            end
            if (n >= 400) then
              return ("நாநூறூ" + ((n == 400) ? ("") : ((" " + format_spellout_cardinal((n % 100))))))
            end
            if (n >= 300) then
              return ("முந்நூறு" + ((n == 300) ? ("") : ((" " + format_spellout_cardinal((n % 100))))))
            end
            if (n >= 200) then
              return ("இருநூறு" + ((n == 200) ? ("") : ((" " + format_spellout_cardinal((n % 100))))))
            end
            if (n >= 100) then
              return ("நூறு" + ((n == 100) ? ("") : ((" " + format_spellout_cardinal((n % 100))))))
            end
            if (n >= 90) then
              return ("தொண்ணூறு" + ((n == 90) ? ("") : ((" " + format_spellout_cardinal((n % 10))))))
            end
            if (n >= 80) then
              return ("எண்பது" + ((n == 80) ? ("") : ((" " + format_spellout_cardinal((n % 10))))))
            end
            if (n >= 70) then
              return ("எழுபது" + ((n == 70) ? ("") : ((" " + format_spellout_cardinal((n % 10))))))
            end
            if (n >= 60) then
              return ("அறுபது" + ((n == 60) ? ("") : ((" " + format_spellout_cardinal((n % 10))))))
            end
            if (n >= 50) then
              return ("ஐம்பது" + ((n == 50) ? ("") : ((" " + format_spellout_cardinal((n % 10))))))
            end
            if (n >= 40) then
              return ("நாற்பது" + ((n == 40) ? ("") : ((" " + format_spellout_cardinal((n % 10))))))
            end
            if (n >= 30) then
              return ("முப்பது" + ((n == 30) ? ("") : ((" " + format_spellout_cardinal((n % 10))))))
            end
            if (n >= 20) then
              return ("இருபது" + ((n == 20) ? ("") : ((" " + format_spellout_cardinal((n % 10))))))
            end
            return "பத்தொன்பது" if (n >= 19)
            return "பதினெட்டு" if (n >= 18)
            return "பதினேழு" if (n >= 17)
            return "பதினாறு" if (n >= 16)
            return "பதினைந்து" if (n >= 15)
            return "பதினான்கு" if (n >= 14)
            return "பதின்மூன்று" if (n >= 13)
            return "பன்னிரண்டு" if (n >= 12)
            return "பதினொன்று" if (n >= 11)
            return "பத்து" if (n >= 10)
            return "ஒன்பது" if (n >= 9)
            return "எட்டு" if (n >= 8)
            return "ஏழு" if (n >= 7)
            return "ஆறு" if (n >= 6)
            return "ஐந்து" if (n >= 5)
            return "நான்கு" if (n >= 4)
            return "மூன்று" if (n >= 3)
            return "இரண்டு" if (n >= 2)
            return "ஒன்று" if (n >= 1)
            return "பூஜ்யம்" if (n >= 0)
          end
          def format_spellout_ordinal(n)
            is_fractional = (n != n.floor)
            return ("எதிர்ம " + format_spellout_ordinal(-n)) if (n < 0)
            return n.to_s if is_fractional and (n > 1)
            return (n.to_s + "ாவது") if (n >= 21)
            return "இருபதாவது" if (n >= 20)
            return "பத்தொன்பதாவது" if (n >= 19)
            return "பதினெட்டாவது" if (n >= 18)
            return "பதினேழாவது" if (n >= 17)
            return "பதினாறாவது" if (n >= 16)
            return "பதினைந்தாவது" if (n >= 15)
            return "பதிநான்காவது" if (n >= 14)
            return "பதிமூன்றாவது" if (n >= 13)
            return "பன்னிரண்டாவது" if (n >= 12)
            return "பதினொன்றாவது" if (n >= 11)
            return "பத்தாவது" if (n >= 10)
            return "ஒன்பதாவது" if (n >= 9)
            return "எட்டாவது" if (n >= 8)
            return "ஏழாவது" if (n >= 7)
            return "ஆறாவது" if (n >= 6)
            return "ஐந்தாவது" if (n >= 5)
            return "நான்காவது" if (n >= 4)
            return "மூன்றாவது" if (n >= 3)
            return "இரண்டாவது" if (n >= 2)
            return "முதலாவது" if (n >= 1)
            return "பூஜ்யம்" if (n >= 0)
          end
        end
      end
      
      class Tamil::Ordinal
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