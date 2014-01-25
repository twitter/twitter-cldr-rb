# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

include TwitterCldr::Utils
include TwitterCldr::Shared

module TwitterCldr
  module Parsers
    class UnicodeRegexParser

      # This is analogous to ICU's UnicodeSet class.
      class CharacterClass < Component

        GROUPING_PAIRS = {
          :close_bracket => :open_bracket
        }

        # Character classes can include set operations (eg. union, intersection, etc).      
        BinaryOperator = Struct.new(:operator, :left, :right)
        UnaryOperator = Struct.new(:operator, :child)

        class << self

          def opening_types
            @opening_types ||= GROUPING_PAIRS.values
          end

          def closing_types
            @closing_types ||= GROUPING_PAIRS.keys
          end

          def opening_type_for(type)
            GROUPING_PAIRS[type]
          end

        end

        def initialize(root)
          @root = root
        end

        def type
          :character_class
        end

        def to_regexp(modifiers = nil)
          Regexp.new(to_regexp_str, modifiers)
        end

        def to_regexp_str
          range_strs = to_set.to_a(true).map do |range|
            case range
              when Range
                "[#{to_utf8(range.first)}-#{to_utf8(range.last)}]"
              when Array
                range.map { |elem| "(?:#{to_utf8(elem)})" }.join
              else
                to_utf8(range)
            end
          end

          "(?:#{range_strs.join("|")})"
        end

        def to_set
          evaluate(root)
        end

        private

        attr_reader :root

        def evaluate(node)
          case node
            when UnaryOperator
              case node.operator
                when :negate
                  UnicodeRegex.valid_regexp_chars.subtract(
                    evaluate(node.child)
                  )
              end

            when BinaryOperator
              case node.operator
                when :union, :pipe
                  evaluate(node.left).union(
                    evaluate(node.right)
                  )
                when :dash
                  evaluate(node.left).difference(
                    evaluate(node.right)
                  )
                when :ampersand
                  evaluate(node.left).intersection(
                    evaluate(node.right)
                  )
              end

            else
              if node
                node.to_set
              else
                RangeSet.new([])
              end
          end
        end

      end
    end
  end
end
