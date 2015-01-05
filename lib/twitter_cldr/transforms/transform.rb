# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Transforms

    # Base class for transforms
    class Transform < Rule
      protected

      def transform_each_range_in(cursor)
        new_text = ''
        new_ranges = []
        last_range = nil
        range_offset = 0

        cursor.each_range do |range|
          if last_range
            new_text << cursor.text[(last_range.last + 1)...range.first]
          end

          new_segment = yield range

          new_text << new_segment
          cur_offset = new_segment.length - (range.last - range.first)
          new_ranges << ((range.first + range_offset)..(range.last + cur_offset + range_offset))

          range_offset += cur_offset
          last_range = range
        end

        [new_text, TwitterCldr::Utils::RangeSet.new(new_ranges)]
      end
    end

  end
end
