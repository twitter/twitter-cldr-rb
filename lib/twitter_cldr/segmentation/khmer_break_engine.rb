# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'singleton'
require 'forwardable'

module TwitterCldr
  module Segmentation
    class KhmerBreakEngine

      include Singleton
      extend Forwardable

      def_delegators :engine, :each_boundary

      def self.word_set
        @word_set ||= TwitterCldr::Shared::UnicodeSet.new.tap do |set|
          set.apply_pattern('[[:Khmer:]&[:Line_Break=SA:]]')
        end
      end

      private

      def engine
        @engine ||= BrahmicBreakEngine.new(
          lookahead: 3,
          root_combine_threshold: 3,
          prefix_combine_threshold: 3,
          min_word: 4,
          word_set: self.class.word_set,
          mark_set: mark_set,
          end_word_set: end_word_set,
          begin_word_set: begin_word_set,
          dictionary: Dictionary.khmer,
          advance_past_suffix: -> (*) do
            0  # not applicable to Khmer
          end
        )
      end

      def mark_set
        @mark_set ||= TwitterCldr::Shared::UnicodeSet.new.tap do |set|
          set.apply_pattern('[[:Khmer:]&[:Line_Break=SA:]&[:M:]]')
          set.add(0x0020)
        end
      end

      def end_word_set
        @end_word_set ||= TwitterCldr::Shared::UnicodeSet.new.tap do |set|
          set.add_set(self.class.word_set)
          set.subtract(0x17D2) # KHMER SIGN COENG that combines some characters
        end
      end

      def begin_word_set
        @begin_word_set ||= TwitterCldr::Shared::UnicodeSet.new.tap do |set|
          set.add_range(0x1780..0x17B3)
        end
      end

    end
  end
end
