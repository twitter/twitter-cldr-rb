# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Transforms

    # Note: position is byte position
    class Cursor
      attr_reader :text, :direction, :position

      def initialize(text, direction = :forward)
        set_text(text)
        @direction = direction
        reset_position
      end

      def set_text(new_text)
        @text = new_text
      end

      def reset_position
        @position = 0
      end

      def eos?
        position >= (bytesize - 1)
      end

      def bytesize
        text.respond_to?(:bytesize) ? text.bytesize : text.size
      end
    end

  end
end
