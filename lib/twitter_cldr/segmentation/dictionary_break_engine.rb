# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Segmentation
    class DictionaryBreakEngine

      def each_boundary(cursor, &block)
        return to_enum(__method__, cursor) unless block_given?

        last_boundary = cursor.position
        stop = cursor.position

        while !cursor.eos? && word_set.include?(cursor.codepoints[stop])
          stop += 1
        end

        divide_up_dictionary_range(cursor, stop).each do |boundary|
          last_boundary = boundary
          yield boundary
        end
      end

      def word_set(*args)
        raise NotImplementedError, "#{__method__} must be defined in derived classes"
      end

      private

      def divide_up_dictionary_range(*args)
        raise NotImplementedError, "#{__method__} must be defined in derived classes"
      end

    end
  end
end
