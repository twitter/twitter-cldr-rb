# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

include TwitterCldr::Utils
include TwitterCldr::Shared

module TwitterCldr
  module Parsers
    class UnicodeRegexParser

      # Can exist inside and outside of character classes
      class CharacterSet < Component

        attr_reader :property, :property_value

        def initialize(text)
          if (name_parts = text.split("=")).size == 2
            @property = name_parts[0].downcase
            @property_value = name_parts[1].to_sym
          else
            @property_value = text
          end
        end

        def to_regexp_str
          parts = to_set.to_a(true).map do |element|
            case element
              when Range
                "[#{to_utf8(element.first)}-#{to_utf8(element.last)}]"
              else
                to_utf8(element)
            end
          end

          "(?:#{parts.join("|")})"
        end

        def to_set
          codepoints.subtract(UnicodeRegex.invalid_regexp_chars)
        end

        private

        def codepoints
          if property
            ranges = CodePoint.send(:"code_points_for_#{property}", property_value)

            if ranges
              RangeSet.new(ranges)
            else
              raise UnicodeRegexParserError.new(
                "Couldn't find property '#{property}' containing property value '#{property_value}'"
              )
            end
          else
            RangeSet.new(
              CodePoint.code_points_for_property_value(property_value)
            )
          end
        end

      end
    end
  end
end