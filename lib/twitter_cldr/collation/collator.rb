# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Collation

    class Collator

      FRACTIONAL_UCA_SHORT_RESOURCE = 'collation/FractionalUCA_SHORT.txt'

      def sort_key(string_or_code_points)
        sort_key_for_code_points(get_code_points(string_or_code_points))
      end

      def sort(strings)
        strings.map{ |s| [s, comparison_key(s)] }.sort{ |a, b| compare_keys(a[1], b[1]) }.map(&:first)
      end

      def compare(string_a, string_b)
        string_a == string_b ? 0 : compare_keys(comparison_key(string_a), comparison_key(string_b))
      end

      def trie
        @trie ||= self.class.trie
      end

      def self.trie
        @trie ||= TwitterCldr::Collation::TrieBuilder.load_trie(FRACTIONAL_UCA_SHORT_RESOURCE)
      end

      private

      def comparison_key(string)
        code_points = TwitterCldr::Utils::CodePoints.from_string(string)
        { :code_points => code_points, :sort_key => sort_key(code_points) }
      end

      def compare_keys(a, b)
        (a[:sort_key] <=> b[:sort_key]).nonzero? || get_integer_code_points(a[:code_points]) <=> get_integer_code_points(b[:code_points])
      end

      def sort_key_for_code_points(integer_code_points)
        TwitterCldr::Collation::SortKey.build(get_collation_elements(integer_code_points))
      end

      def get_integer_code_points(code_points)
        code_points.map { |code_point| code_point.to_i(16) }
      end

      def get_collation_elements(integer_code_points)
        result = []
        result.concat(code_point_collation_elements(integer_code_points)) until integer_code_points.empty?
        result
      end

      def get_code_points(str_or_code_points)
        code_points = str_or_code_points.is_a?(String) ? TwitterCldr::Utils::CodePoints.from_string(str_or_code_points) : str_or_code_points

        # Normalization makes the collation process significantly slower (like seven times slower on the UCA
        # non-ignorable test from CollationTest_NON_IGNORABLE.txt). ICU uses some optimizations to apply normalization
        # only in special, rare cases. We need to investigate possible solutions and do normalization cleverly too.
        code_points = TwitterCldr::Normalization::NFD.normalize_code_points(code_points)

        get_integer_code_points(code_points)
      end

      # Returns the first sequence of fractional collation elements for an array of integer code points. Returned value
      # is an array of well formed (including weights for all significant levels) integer arrays.
      #
      # NOTE (side-effect): all used code points are removed from the input array.
      #
      def code_point_collation_elements(integer_code_points)
        explicit_collation_elements(integer_code_points) || implicit_collation_elements(integer_code_points)
      end

      # Tries to build explicit collation elements array for the longest code points prefix in the given sequence. When
      # possible, combines this prefix with (not necessarily subsequent) non-starters that follow it in the sequence.
      # That's necessary because canonical ordering (that is performed during normalization) can break contractions
      # that existed in the original, de-normalized string.
      #
      # NOTE (side-effect): all used code points are removed from the input array.
      #
      # For more information see section '4.2 Produce Array' of the main algorithm at http://www.unicode.org/reports/tr10/#Main_Algorithm
      #
      def explicit_collation_elements(integer_code_points)
        # find the longest prefix in the trie
        collation_elements, suffixes, prefix_size = trie.find_prefix(integer_code_points)

        return unless collation_elements

        # remove prefix from the code points sequence
        integer_code_points.shift(prefix_size)

        non_starter_pos = 0

        used_combining_classes = {}

        while non_starter_pos < integer_code_points.size && !suffixes.empty?
          # create a trie from a hash of suffixes available for the chosen prefix
          subtrie = TwitterCldr::Collation::Trie.new(suffixes)

          # get next code point (possibly non-starter)
          non_starter_code_point = integer_code_points[non_starter_pos]
          combining_class        = TwitterCldr::Normalization::Base.combining_class_for(non_starter_code_point.to_s(16))

          # code point is a starter or combining class has been already used (non-starter is 'blocked' from the prefix)
          break if combining_class == 0 || used_combining_classes[combining_class]

          used_combining_classes[combining_class] = true

          # Try to find collation elements for [prefix + non-starter] code points sequence. As the subtrie contains
          # suffixes (without prefix) we pass only non-starter itself.
          new_collation_elements, new_suffixes = subtrie.find_prefix([non_starter_code_point]).first(2)

          if new_collation_elements
            # non-starter with a collation elements sequence corresponding to [prefix + non-starter] accepted
            collation_elements = new_collation_elements
            suffixes           = new_suffixes

            # Remove non-starter from its position in the sequence. Then we can move further from the same position.
            integer_code_points.delete_at(non_starter_pos)
          else
            # move to the next code point
            non_starter_pos += 1
          end
        end

        collation_elements
      end

      def implicit_collation_elements(integer_code_points)
        TwitterCldr::Collation::ImplicitCollationElements.for_code_point(integer_code_points.shift)
      end

    end

  end
end
