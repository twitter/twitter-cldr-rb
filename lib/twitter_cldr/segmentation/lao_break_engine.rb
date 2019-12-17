# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'singleton'
require 'forwardable'

module TwitterCldr
  module Segmentation
    class LaoBreakEngine

      include Singleton
      extend Forwardable

      def_delegators :engine, :each_boundary

      def self.word_set
        @word_set ||= TwitterCldr::Shared::UnicodeSet.new.tap do |set|
          set.apply_pattern('[[:Laoo:]&[:Line_Break=SA:]]')
        end
      end

      private

      def engine
        @engine ||= BrahmicBreakEngine.new(
          lookahead: 3,
          root_combine_threshold: 3,
          prefix_combine_threshold: 3,
          min_word: 2,
          word_set: self.class.word_set,
          mark_set: mark_set,
          end_word_set: end_word_set,
          begin_word_set: begin_word_set,
          dictionary: Dictionary.lao,
          advance_past_suffix: -> (*) do
            0  # not applicable to Lao
          end
        )
      end

      def mark_set
        @mark_set ||= TwitterCldr::Shared::UnicodeSet.new.tap do |set|
          set.apply_pattern('[[:Laoo:]&[:Line_Break=SA:]&[:M:]]')
          set.add(0x0020)
        end
      end

      def end_word_set
        @end_word_set ||= TwitterCldr::Shared::UnicodeSet.new.tap do |set|
          set.add_set(self.class.word_set)
          set.subtract_range(0x0EC0..0x0EC4) # prefix vowels
        end
      end

      def begin_word_set
        @begin_word_set ||= TwitterCldr::Shared::UnicodeSet.new.tap do |set|
          set.add_range(0x0E81..0x0EAE)  # basic consonants (including holes for corresponding Thai characters)
          set.add_range(0x0EDC..0x0EDD)  # digraph consonants (no Thai equivalent)
          set.add_range(0x0EC0..0x0EC4)  # prefix vowels
        end
      end

    end
  end
end
