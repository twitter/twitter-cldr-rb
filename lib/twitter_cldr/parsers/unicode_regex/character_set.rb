# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

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
          set_to_regex(to_set)
        end

        def to_set
          codepoints.subtract(
            TwitterCldr::Shared::UnicodeRegex.invalid_regexp_chars
          )
        end

        private

        def codepoints
          if property
            method = :"code_points_for_#{property}"

            if TwitterCldr::Shared::CodePoint.respond_to?(method)
              ranges = TwitterCldr::Shared::CodePoint.send(method, property_value)

              if ranges
                TwitterCldr::Utils::RangeSet.new(ranges)
              else
                raise UnicodeRegexParserError.new(
                  "Couldn't find property '#{property}' containing property value '#{property_value}'"
                )
              end
            else
              raise UnicodeRegexParserError.new(
                "Couldn't find property '#{property}"
              )
            end
          else
            TwitterCldr::Utils::RangeSet.new(
              TwitterCldr::Shared::CodePoint.code_points_for_property_value(property_value)
            )
          end
        end

      end
    end
  end
end
