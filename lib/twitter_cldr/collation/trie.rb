# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Collation

    # This class represents a trie - a tree data structure, also known as a prefix tree.
    #
    # Every node corresponds to a single character of the key. To find the value by key one goes down the trie
    # starting from the root and descending one character at a time. If at some level current node doesn't have a
    # child corresponding to the next character of the key, then the trie doesn't contain a value with the given key.
    # Otherwise, the final node, corresponding to the last character of the key, should contain the value. If it's
    # nil, then the trie doesn't contain a value with the given key (or the value itself is nil).
    #
    class Trie

      # Initializes a new trie. If `trie_hash` value is passed it's used as the initial data for the trie. Usually,
      # `trie_hash` is extracted from other trie and represents its sub-trie.
      #
      def initialize(trie_hash = {})
        @root = [nil, trie_hash]
      end

      def starters
        @root[1].keys
      end

      def each_starting_with(starter, &block)
        starting_node = @root[1][starter]
        each_pair(starting_node, [starter], &block) if starting_node
      end

      def add(key, value, override = true)
        final = key.inject(@root) do |node, key_element|
          node[1] ||= {}
          node[1][key_element] ||= [nil, nil]
        end

        final[0] = value unless final[0] && !override
      end

      def get(key)
        final = key.inject(@root) do |node, key_element|
          subtrie = node[1] && node[1][key_element]
          return unless subtrie
          subtrie
        end

        final[0]
      end

      # Finds the longest substring of the `key` that matches, as a key, a node in the trie.
      #
      # Returns a three elements array:
      #
      #   1. value in the last node that was visited
      #   2. sub-trie of this node (as a hash)
      #   3. size of the `key` prefix that matches this node
      #
      def find_prefix(key)
        prefix_size = 0
        node = @root

        key.each do |key_element|
          subtrie = node[1] && node[1][key_element]

          if subtrie
            prefix_size += 1
            node = subtrie
          else
            break
          end
        end

        node + [prefix_size]
      end

      private

      def each_pair(node, key, &block)
        yield [key, node[0]] if node[0]

        return unless node[1]

        node[1].each do |key_element, child|
          each_pair(child, key + [key_element], &block)
        end
      end

    end

  end
end