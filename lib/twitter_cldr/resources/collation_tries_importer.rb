# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Resources
    class CollationTriesImporter < Importer
      requirement :dependency, [TailoringImporter]
      locales TwitterCldr.supported_locales
      ruby_engine :jruby

      private

      def execute
        update_default_trie_dump

        params.fetch(:locales).each do |locale|
          update_tailoring_trie_dump(locale)
        end
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
        File.write(path, Marshal.dump(trie))
      end

      def default_trie
        @default_trie ||= TwitterCldr::Collation::TrieBuilder.load_default_trie
      end
    end
  end
end
