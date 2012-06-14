# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Collation

    class TrieBuilder

      FRACTIONAL_UCA_REGEXP = /^((?:[0-9A-F]+)(?:\s[0-9A-F]+)*);\s((?:\[.*?\])(?:\[.*?\])*)/

      def self.load_trie(file_path)
        new(file_path).build
      end

      def initialize(resource)
        @file_path = File.join(TwitterCldr::RESOURCES_DIR, resource)
      end

      def build
        parse_trie(load_collation_elements_table)
      end

      private

      def parse_trie(table)
        trie = TwitterCldr::Collation::Trie.new

        table.lines.each do |line|
          trie.add(parse_code_points($1), parse_collation_element($2)) if FRACTIONAL_UCA_REGEXP =~ line
        end

        trie
      end

      def load_collation_elements_table
        open(@file_path, 'r')
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