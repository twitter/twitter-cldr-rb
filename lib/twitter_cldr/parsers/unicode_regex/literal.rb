# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Parsers
    class UnicodeRegex
      class Literal

        attr_reader :text

        def initialize(text)
          @text = text
        end

        def to_regexp_str
          text
        end

      end

    end
  end
end