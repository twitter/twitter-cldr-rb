# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Parsers
    class UnicodeRegexParser
      class Component

        protected

        def to_utf8(codepoints)
          codepoints = codepoints.is_a?(Array) ? codepoints : [codepoints]
          codepoints.pack("U*").bytes.to_a.map { |s| "\\" + s.to_s(8) }.join
        end

      end
    end
  end
end
