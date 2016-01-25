# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Segmentation
    RuleMatchData = Struct.new(
      :rule, :boundary_offset, :boundary_position
    )

    class Rule

      attr_reader :left, :right
      attr_accessor :string, :id

      def initialize(left, right)
        @left = left
        @right = right
      end

      def match(cursor)
        left_match = match_side(left, cursor.text, cursor.position)
        return nil unless left_match
        left_match_offset = offset(left_match, cursor.position)

        right_match = match_side(right, cursor.text, left_match_offset.last)
        return nil unless right_match
        right_match_offset = offset(right_match, left_match_offset.last)

        offset = [left_match_offset.first, right_match_offset.last]
        position = left_match_offset.last

        RuleMatchData.new(self, offset, position)
      end

      private

      def offset(match, default)
        if match
          match.offset(0)
        else
          [default, default]
        end
      end

      def match_side(side, text, position)
        if side
          side_match = side.match(text, position)

          if side_match && side_match.begin(0) == position
            side_match
          end
        end
      end
    end

    class BreakRule < Rule
      def boundary_symbol
        :break
      end

      def break?
        true
      end
    end

    class NoBreakRule < Rule
      def boundary_symbol
        :no_break
      end

      def break?
        false
      end
    end

  end
end
