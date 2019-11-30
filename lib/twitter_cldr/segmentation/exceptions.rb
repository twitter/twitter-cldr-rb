# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'singleton'

module TwitterCldr
  module Segmentation
    class Exceptions
      include Singleton

      class << self
        def instance(locale)
          return NullExceptions.instance unless exists?(locale)

          cache[locale] ||= begin
            rsrc = TwitterCldr.get_resource('uli', 'segments', locale)

            new(
              Marshal.load(rsrc[:forwards_trie]),
              Marshal.load(rsrc[:backwards_trie])
            )
          end
        end

        private

        def exists?(locale)
          TwitterCldr.resource_exists?('uli', 'segments', locale)
        end

        def cache
          @cache ||= {}
        end
      end

      attr_reader :forward_trie, :backward_trie

      def initialize(forward_trie, backward_trie)
        @forward_trie = forward_trie
        @backward_trie = backward_trie
      end

      def should_break?(cursor)
        idx = cursor.position

        # consider case when a space follows the '.' (so we handle i.e. "Mr. Brown")
        idx -= 2 if cursor.codepoint(idx - 1) == 32
        node = backward_trie.root

        found = loop do
          break false if idx < 0 || idx >= cursor.length
          node = node.child(cursor.codepoint(idx)) rescue binding.pry
          break false unless node
          break true if node.value
          idx -= 1
        end

        return true unless found

        node = forward_trie.root

        loop do
          return true if idx >= cursor.length
          node = node.child(cursor.codepoint(idx))
          return true unless node
          return false if node.value
          idx += 1
        end
      end
    end
  end
end
