# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Transforms
    class Conversion < Rule

      class Node
        include Resolvable
        attr_reader :operator, :left, :right

        def initialize(operator, left, right)
          @operator = operator
          @left = left
          @right = right
        end

        def resolve(symbol_table)
          l = resolve_child(left, symbol_table)
          r = resolve_child(right, symbol_table)

          if operator == :cursor
            "(#{l.join})()(#{r.join})"
          else
            "(#{l.join})(#{r.join})"
          end
        end
      end

    end
  end
end
