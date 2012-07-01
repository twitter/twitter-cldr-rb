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

        def parse_trie(table, trie = TwitterCldr::Collation::Trie.new)
          table.lines.each do |line|
            trie.add(parse_code_points($1), parse_collation_element($2)) if FCE_REGEXP =~ line
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

      end

    end

  end
end