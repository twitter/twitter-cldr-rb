module TwitterCldr
  module Utils
    class TrieSerializer
      def self.serialize(trie)
        new(trie).serialize
      end

      attr_reader :trie

      def initialize(trie)
        @trie = trie
      end

      def serialize
        ''.b.tap do |result|
          all_keys = each_key.to_a
          all_values = each_value.to_a
          min_key = all_keys.min
          max_key = all_keys.max
          max_value = all_values.max || 0
          keyspace = max_key - min_key
          keyspace_width = width_of(keyspace)
          value_width = width_of(max_value)

          puts "    Min key: #{min_key}"
          puts "    Max key: #{max_key}"
          puts "  Max value: #{max_value} (#{value_width})"
          puts "   Keyspace: #{keyspace} (#{keyspace_width})"
          puts "Child count: #{max_child_count} (#{child_count_width})"

          result << [
            keyspace_width,
            child_count_width,
            *int_to_bytes(min_key, keyspace_width),
            *int_to_bytes(max_key, keyspace_width)
          ].pack('C*')

          each_node do |key, node|
            result << [
              *int_to_bytes(key - min_key, keyspace_width),
              *int_to_bytes(node.child_count, child_count_width),
              *int_to_bytes(node.has_value? ? node.value : 0, value_width)
            ].pack('C*')
          end
        end
      end

      private

      def each_node(root = trie.root, &block)
        return to_enum(__method__, root) unless block

        root.each_key_and_child do |key, child|
          yield key, child
          each_node(child, &block)
        end
      end

      def each_key(root = trie.root, &block)
        return to_enum(__method__, root) unless block

        root.each_key_and_child do |key, child|
          yield key
          each_key(child, &block)
        end
      end

      def each_value(root = trie.root, &block)
        return to_enum(__method__, root) unless block

        root.each_key_and_child do |_, child|
          if child.has_value?
            yield child.value
          end

          each_value(child)
        end
      end

      def max_child_count
        @max_child_count ||= begin
          max_count = 0

          each_node do |_, node|
            if node.child_count > max_count
              max_count = node.child_count
            end
          end

          max_count
        end
      end

      def child_count_width
        @child_count_width ||= width_of(max_child_count)
      end

      def width_of(int)
        i = 1
        i += 1 until int < 2 ** (i * 8)
        i
      end

      def int_to_bytes(int, width)
        Array.new(width) do |i|
          (int >> (width - i - 1) * 8) & 255
        end
      end
    end
  end
end
