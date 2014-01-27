# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

include TwitterCldr::Utils

module TwitterCldr
  module Parsers
    class UnicodeRegexParser
      class Literal < Component

        attr_reader :text

        # ord is good enough (don't need unpack) because ASCII chars
        # have the same numbers as their unicode equivalents
        SPECIAL_CHARACTERS = {
          "s" => [32],  # space
          "t" => [9],   # tab
          "r" => [13],  # carriage return
          "n" => [10],  # newline
          "f" => [12],  # form feed
          "d" => ("0".."9").to_a.map { |c| c[0] },
          "w" => (("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a + ["_"]).map { |c| c[0] }
        }

        def initialize(text)
          @text = text
        end

        def to_regexp_str
          text
        end

        def to_set
          if text =~ /^\\/
            special_char = text[1..-1]

            if SPECIAL_CHARACTERS.include?(special_char.downcase)
              set_for_special_char(special_char)
            else
              RangeSet.from_array([special_char.ord])
            end
          else
            RangeSet.from_array([text.ord])
          end
        end

        private

        def set_for_special_char(char)
          special_char_set_cache[char] ||= begin
            chars = RangeSet.from_array(SPECIAL_CHARACTERS[char.downcase])

            if char.upcase == char
              UnicodeRegex.valid_regexp_chars.subtract(chars)
            else
              chars
            end
          end
        end

        def special_char_set_cache
          @@special_char_set_cache ||= {}
        end

      end

    end
  end
end
