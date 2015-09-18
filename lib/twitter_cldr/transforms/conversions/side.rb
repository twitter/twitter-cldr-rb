# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Transforms
    module Conversions

      class Side
        attr_reader :before_context, :key
        attr_reader :after_context, :cursor_offset

        def initialize(before_context, key, after_context, cursor_offset)
          @before_context = before_context
          @key = key
          @after_context = after_context
          @cursor_offset = cursor_offset
        end

        def match?(cursor)
          idx = cursor.text.index(to_regexp, cursor.position)
          idx == cursor.position
        end

        def index_value
          # index value is int value of first byte
          @index_value ||= key.getbyte(0)
        end

        protected

        def to_regexp
          @regexp ||= begin
            str = TwitterCldr::Shared::UnicodeRegex.compile(
              "#{before_context}#{key}#{after_context}"
            ).to_regexp_str
            /#{str}/
          end
        end
      end

    end
  end
end
