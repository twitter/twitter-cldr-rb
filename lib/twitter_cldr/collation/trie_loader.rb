# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Collation

    # Builds a fractional collation elements Trie from the file containing a fractional collation elements table.
    #
    module TrieLoader

      class << self

        def load_default_trie
          load_trie
        end

        def load_tailored_trie(locale, fallback)
          trie = load_trie(locale)
          trie.fallback = fallback
          trie
        end

        private

        def load_trie(locale = :default)
          load_dump(locale) do |dump|
            Marshal.load(dump)
          end
        end

        def load_dump(locale)
          open(File.join(TwitterCldr::RESOURCES_DIR, 'collation', 'tries', "#{locale}.dump"), 'r') do |dump|
            yield dump
          end
        end

      end

    end

  end
end