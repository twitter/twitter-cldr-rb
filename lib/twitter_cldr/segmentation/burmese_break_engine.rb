# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'singleton'
require 'forwardable'

module TwitterCldr
  module Segmentation
    class BurmeseBreakEngine

      include Singleton
      extend Forwardable

      def_delegators :engine, :each_boundary

      def self.word_set
        @word_set ||= begin
          uset = TwitterCldr::Shared::UnicodeSet.new
          uset.apply_pattern('[[:Mymr:]&[:Line_Break=SA:]]')
          uset.to_set
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
          dictionary: Dictionary.burmese,
          advance_past_suffix: -> (*) do
            0  # not applicable to Burmese
          end
        )
      end

      def mark_set
        @mark_set ||= TwitterCldr::Shared::UnicodeSet.new.tap do |set|
          set.apply_pattern('[[:Mymr:]&[:Line_Break=SA:]&[:M:]]')
          set.add(0x0020)
        end
      end

      def end_word_set
        @end_word_set ||= TwitterCldr::Shared::UnicodeSet.new.tap do |set|
          set.add_list(self.class.word_set)
        end
      end

      def begin_word_set
        @begin_word_set ||= TwitterCldr::Shared::UnicodeSet.new.tap do |set|
          # basic consonants and independent vowels
          set.add_range(0x1000..0x102A)
        end
      end

    end
  end
end
