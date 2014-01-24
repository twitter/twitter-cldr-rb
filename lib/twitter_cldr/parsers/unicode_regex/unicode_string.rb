# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Parsers
    class UnicodeRegexParser

      # unicode_char, escaped_char, string, multichar_string
      # Can exist inside and outside of character classes
      class UnicodeString

        attr_reader :codepoints

        def initialize(codepoints)
          @codepoints = codepoints
        end

        def to_set
          # If the number of codepoints is greater than 1,
          # treat them as a group (eg. multichar string)
          if codepoints.size > 1
            RangeSet.new([codepoints..codepoints])
          else
            RangeSet.new([codepoints.first..codepoints.first])
          end
        end

        def to_regexp_str
          cps = codepoints.is_a?(Array) ? codepoints : [codepoints]
          cps.map { |cp| "(?:#{to_utf8(cp)})" }.join
        end

      end
    end
  end
end