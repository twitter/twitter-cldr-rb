# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Transforms
    class Conversion < Rule

      class Side
        attr_reader :before_context, :key
        attr_reader :after_context, :cursor_offset

        def initialize(before_context, key, after_context, cursor_offset)
          @before_context = before_context
          @key = key
          @after_context = after_context
          @cursor_offset = cursor_offset
        end

        def to_regexp
          @regexp ||= begin
            str = TwitterCldr::Shared::UnicodeRegex.compile(key).to_regexp_str
            /#{str}/n
          end
        end

        def match?(cursor)
          idx = cursor.text.index(to_regexp, cursor.position)
          idx == cursor.position
        end

        def index_value
          # index value is int value of first byte
          key.unpack('C').first
        end
      end

    end
  end
end
