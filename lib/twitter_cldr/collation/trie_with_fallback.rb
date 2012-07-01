# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Collation

    class TrieWithFallback < TwitterCldr::Collation::Trie

      def initialize(fallback)
        super()
        @fallback = fallback
      end

      def get(key)
        super || @fallback.get(key)
      end

      def find_prefix(key)
        value, suffixes, prefix_size = super

        if prefix_size > 0
          [value, suffixes, prefix_size]
        else
          @fallback.find_prefix(key)
        end
      end

    end

  end
end