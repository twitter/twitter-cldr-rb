 # encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Segmentation
    class Cursor
      attr_reader :text, :match_cache
      attr_accessor :position

      def initialize(text)
        @text = text
        reset
      end

      def advance(amount = 1)
        @position += amount
      end

      def reset
        @position = 0
        @match_cache = {}
      end

      def eos?
        position >= text.size
      end

      def codepoint
        text[position].codepoints.first
      end
    end
  end
end
