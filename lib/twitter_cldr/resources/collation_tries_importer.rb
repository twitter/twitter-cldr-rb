# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'fileutils'

module TwitterCldr
  module Resources
    class CollationTriesImporter < Importer

      UCA_ZIP_FILE = 'CollationAuxiliary.zip'.freeze

      requirement :cldr, '21'
      requirement :uca, '6.1.0', [UCA_ZIP_FILE]
      requirement :dependency, [TailoringImporter]
      locales TwitterCldr.supported_locales
      ruby_engine :jruby

      private

      def execute
        # copy_fractional_uca
        update_default_trie_dump

        params.fetch(:locales).each do |locale|
          update_tailoring_trie_dump(locale)
        end
      end

      private

      def copy_fractional_uca
        zip_path = requirements[:uca].source_path_for(UCA_ZIP_FILE)
        output_path = File.join('resources', 'collation', 'FractionalUCA.txt')
        FileUtils.mkdir_p(File.dirname(output_path))

        Zip::File.open(zip_path) do |zip|
          File.open(output_path, 'w') do |file|
            file.write(zip.read('CollationAuxiliary/FractionalUCA.txt'))
          end
        end
      end

      def update_default_trie_dump
        save_trie_dump(TwitterCldr::Collation::TrieLoader::DEFAULT_TRIE_LOCALE, default_trie)
      end

      def update_tailoring_trie_dump(locale)
        save_trie_dump(locale, TwitterCldr::Collation::TrieBuilder.load_tailored_trie(locale, default_trie))
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
