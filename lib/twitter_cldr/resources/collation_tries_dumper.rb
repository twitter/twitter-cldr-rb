# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Resources

    module CollationTriesDumper

      class << self

        def update_dumps
          update_default_trie_dump
          TwitterCldr.supported_locales.each { |locale| update_tailoring_trie_dump(locale) }
        end

        private

        def update_default_trie_dump
          save_trie_dump(TwitterCldr::Collation::TrieLoader::DEFAULT_TRIE_LOCALE, default_trie)
        end

        def update_tailoring_trie_dump(locale)
          save_trie_dump(locale, TwitterCldr::Collation::TrieBuilder.load_tailored_trie(locale, @default_trie))
        end

        def save_trie_dump(locale, trie)
          path = TwitterCldr::Collation::TrieLoader.dump_path(locale)
          FileUtils.mkdir_p(File.dirname(path))

          File.open(path, 'w') { |f| f.write(Marshal.dump(trie)) }
        end

        def default_trie
          @default_trie ||= TwitterCldr::Collation::TrieBuilder.load_default_trie
        end
      end

    end

  end
end