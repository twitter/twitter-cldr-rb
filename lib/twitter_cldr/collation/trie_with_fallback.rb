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
        value, prefix_size, suffixes = super

        if prefix_size > 0
          [value, prefix_size, suffixes]
        else
          @fallback.find_prefix(key)
        end
      end

    end

  end
end