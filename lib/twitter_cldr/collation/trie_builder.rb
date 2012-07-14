# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Collation

    # Builds a fractional collation elements Trie from the file containing a fractional collation elements table.
    #
    module TrieBuilder

      # Fractional collation element regexp
      FCE_REGEXP = /^((?:[0-9A-F]+)(?:\s[0-9A-F]+)*);\s((?:\[.*?\])(?:\[.*?\])*)/

      class << self

        def load_trie(resource)
          parse_trie(load_resource(resource))
        end

        def load_tailored_trie(locale, fallback)
          build_tailored_trie(TwitterCldr.get_resource(:collation, :tailoring, locale), fallback)
        end

        def parse_trie(table, trie = TwitterCldr::Collation::Trie.new)
          table.lines.each do |line|
            trie.set(parse_code_points($1), parse_collation_element($2)) if FCE_REGEXP =~ line
          end

          trie
        end

        private

        def load_resource(resource)
          open(File.join(TwitterCldr::RESOURCES_DIR, resource), 'r')
        end

        def parse_code_points(string)
          string.split.map { |cp| cp.to_i(16) }
        end

        def parse_collation_element(string)
          string.scan(/\[.*?\]/).map do |match|
            match[1..-2].gsub(/\s/, '').split(',', -1).map { |bytes| bytes.to_i(16) }
          end
        end

        def build_tailored_trie(tailoring_data, fallback)
          trie = TwitterCldr::Collation::TrieWithFallback.new(fallback)

          parse_trie(tailoring_data[:tailored_table], trie)
          copy_expansions(trie, fallback, parse_suppressed_starters(tailoring_data[:suppressed_contractions]))

          trie
        end

        def copy_expansions(trie, source_trie, suppressed_starters)
          suppressed_starters.each do |starter|
            trie.add([starter], source_trie.get([starter]))
          end

          (trie.starters - suppressed_starters).each do |starter|
            source_trie.each_starting_with(starter) do |key, value|
              trie.add(key, value)
            end
          end
        end

        def parse_suppressed_starters(suppressed_contractions)
          suppressed_contractions.chars.map do |starter|
            starter_code_points = TwitterCldr::Utils::CodePoints.from_string(starter)
            raise Runtime, 'Suppressed contraction starter should be a single code point' if starter_code_points.size > 1
            starter_code_points.first.to_i(16)
          end
        end

      end

    end

  end
end