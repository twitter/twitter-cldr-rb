# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Parsers
    class UnicodeRegexParser

      # Can exist inside and outside of character classes
      class CharacterSet < Component

        include TwitterCldr::Shared

        attr_reader :property_name, :property_value

        def initialize(text)
          if (name_parts = text.split("=")).size == 2
            @property_name, @property_value = name_parts
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
          code_points = CodePoint.code_points_for_property(
            property_name, property_value
          )

          %w(General_Category Script).each do |name|
            if code_points.empty?
              code_points = CodePoint.code_points_for_property(
                name, property_value
              )
            else
              break
            end
          end

          if code_points.empty?
            raise UnicodeRegexParserError,
              "Couldn't find property '#{property_name}' containing "\
              "property value '#{property_value}'"
          end

          code_points
        end

      end
    end
  end
end
