# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Segmentation
    class Cursor
      attr_reader :text, :position, :match_cache

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

      def eof?
        position >= text.size
      end

      def eos?
        position >= text.size - 1
      end
    end
  end
end
