# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Collation

    class Trie

      def initialize(suffixes = {})
        @root = [nil, suffixes]
      end

      def add(key, value)
        final = key.inject(@root) do |node, key_element|
          node[1][key_element] ||= [nil, {}]
        end

        final[0] = value
      end

      def get(key)
        final = key.inject(@root) do |node, key_element|
          subtree = node[1][key_element]
          return unless subtree
          subtree
        end

        final[0]
      end

      def find_prefix(key)
        prefix_size = 0
        node = @root

        key.each do |key_element|
          subtree = node[1][key_element]

          if subtree
            prefix_size += 1
            node = subtree
          else
            break
          end
        end

        node + [prefix_size]
      end

    end

  end
end