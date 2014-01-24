# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

include TwitterCldr::Utils
include TwitterCldr::Shared

module TwitterCldr
  module Parsers
    class UnicodeRegexParser

      # Can only exist in character classes
      class CharacterSet < Component

        attr_reader :name, :negated

        def initialize(name, negated)
          @name = name
          @negated = negated
        end

        def to_set
          range_set = RangeSet.from_array(
            TwitterCldr::Shared::CodePoint.code_points_for_property(name)
          )

          range_set = range_set.subtract(UnicodeRegex.invalid_regexp_chars)

          if negated
            UnicodeRegex.valid_regexp_chars.subtract(range_set)
          else
            range_set
          end
        end

      end
    end
  end
end