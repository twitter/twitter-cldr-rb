# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Transforms
    class Conversion < Rule

      class Context
        include Resolvable
        attr_reader :before, :replacement, :after

        def initialize(*args)
          @before, @replacement, @after = args
        end

        def push(tokens)
          if !replacement
            @replacement = tokens
          elsif !after
            @after = tokens
          elsif !before
            @before = tokens
          end
        end

        def full?
          before && replacement && after
        end

        def resolve(symbol_table)
          b = resolve_child(before, symbol_table)
          r = resolve_child(replacement, symbol_table)
          a = resolve_child(after, symbol_table)
          "#{b.join}(#{r.join})#{a.join}"
        end
      end

    end
  end
end
