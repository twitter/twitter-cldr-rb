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

        if left_match.size > 1
          left_match_offsets = 1.upto(left_match.size - 1).map do |n|
            left_match.offset(n)
          end
          .select { |o| o.all? }
          .sort_by { |a, b| b - a }

          left_match_offsets.each do |left_match_offset|
            next unless left_match_offset.all?

            right_match = match_side(right, cursor.text, left_match_offset.last)
            next unless right_match
            right_match_offset = offset(right_match, left_match_offset.last)

            offset = [left_match_offset.first, right_match_offset.last]
            position = left_match_offset.last

            return RuleMatchData.new(self, offset, position)
          end

          nil
        else
          left_match_offset = offset(left_match, cursor.position)

          right_match = match_side(right, cursor.text, left_match_offset.last)
          return nil unless right_match
          right_match_offset = offset(right_match, left_match_offset.last)

          offset = [left_match_offset.first, right_match_offset.last]
          position = left_match_offset.last

          RuleMatchData.new(self, offset, position)
        end
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
