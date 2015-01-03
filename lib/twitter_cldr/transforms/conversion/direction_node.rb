# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Transforms
    class Conversion < Rule

      class DirectionNode
        include Resolvable
        attr_reader :operator, :left, :right

        def initialize(operator, left, right)
          @operator = operator
          @left = left
          @right = right
        end

        def resolve(symbol_table)
          l = join(resolve_child(left, symbol_table))
          r = join(resolve_child(right, symbol_table))
          ResolvedDirectionNode.new(operator, l, r)
        end

        protected

        def join(arr)
          if arr.is_a?(Array)
            "(#{arr.join})"
          else
            arr
          end
        end
      end

      class ResolvedDirectionNode
        attr_reader :operator, :left, :right

        def initialize(operator, left, right)
          @operator = operator
          @left = left
          @right = right
        end

        def match(cursor)

        end
      end

    end
  end
end
