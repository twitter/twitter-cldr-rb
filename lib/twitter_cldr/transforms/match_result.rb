# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Transforms

    class MatchResult
      attr_reader :rule, :start, :finish, :cursor_offset

      def initialize(rule, start, finish, cursor_offset)
        @rule = rule
        @start = start
        @finish = finish
        @cursor_offset = cursor_offset
      end
    end

  end
end
