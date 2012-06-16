# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Collation

    class Collator

      FRACTIONAL_UCA_SHORT_RESOURCE = 'collation/FractionalUCA_SHORT.txt'

      UNMARKED = 3

      def sort_key(string_or_code_points)
        sort_key_for_code_points(get_integer_code_points(string_or_code_points))
      end

      def trie
        @trie ||= self.class.trie
      end

      def self.trie
        @trie ||= TwitterCldr::Collation::TrieBuilder.load_trie(FRACTIONAL_UCA_SHORT_RESOURCE)
      end

      private

      def sort_key_for_code_points(integer_code_points)
        TwitterCldr::Collation::SortKey.build(get_collation_elements(integer_code_points))
      end

      def get_integer_code_points(str_or_code_points)
        code_points = str_or_code_points.is_a?(String) ? TwitterCldr::Utils::CodePoints.from_string(str_or_code_points) : str_or_code_points

        # Normalization makes the collation process significantly slower (like seven times slower on the UCA
        # non-ignorable test from CollationTest_NON_IGNORABLE.txt). ICU uses some optimizations to apply normalization
        # only in special, rare cases. We need to investigate possible solutions and do normalization cleverly too.
        code_points = TwitterCldr::Normalizers::NFD.normalize_code_points(code_points)

        code_points.map { |cp| cp.to_i(16) }
      end

      def get_collation_elements(integer_code_points)
        result = []
        result.concat(code_point_collation_elements(integer_code_points)) until integer_code_points.empty?
        result
      end

      # Returns the first sequence of fractional collation elements for an array of integer code points. Returned value
      # is an array of well formed (including weights for all significant levels) integer arrays.
      #
      # All used code points are removed from the beginning of the input array.
      #
      def code_point_collation_elements(integer_code_points)
        explicit_collation_elements(integer_code_points) || [implicit_collation_element(integer_code_points.shift)]
      end

      # Tries to build explicit collation elements array for the longest code points prefix in the given sequence. When
      # possible, combines last code point of this sequence with non-subsequent non-starters. That's necessary because
      # canonical ordering (that is performed during normalization) can break contractions that existed in the original,
      # de-normalized string.
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

        # mark 0 combining class (assigned to starters) as used to exit the loop when it's encountered
        used_combining_classes = { 0 => true }

        while non_starter_pos < integer_code_points.size && !suffixes.empty?
          # create a trie from a hash of suffixes available for the chosen prefix
          subtrie = TwitterCldr::Collation::Trie.new(suffixes)

          # get next code point (possibly non-starter)
          non_starter_code_point = integer_code_points[non_starter_pos]
          combining_class        = TwitterCldr::Normalizers::Base.combining_class_for(non_starter_code_point.to_s(16))

          # combining class has been already used, so this non-starter is 'blocked' from our prefix
          break if used_combining_classes[combining_class]

          used_combining_classes[combining_class] = true

          # try to find collation elements for [prefix + non-starter] code points sequence
          # as the subtrie contains suffixes (without prefix) we pass only non-starter itself
          new_collation_elements, new_suffixes = subtrie.find_prefix([non_starter_code_point]).first(2)

          if new_collation_elements
            # non-starter with a collation elements sequence corresponding to [prefix + non-starter] accepted
            collation_elements = new_collation_elements
            suffixes           = new_suffixes

            # remove non-starter from its position in the code points sequence
            # after that we can move further from the same position
            integer_code_points.delete_at(non_starter_pos)
          else
            # move to the next code point
            non_starter_pos += 1
          end
        end

        collation_elements
      end

      def implicit_collation_element(integer_code_point)
        # illegal values xxFFFE and xxFFFF are ignored ([] is equivalent to [0, 0, 0])
        return [] if (integer_code_point & 0xFFFE) == 0xFFFE

        implicit_ce_generator.get_collation_element(integer_code_point)
      end

      def implicit_ce_generator
        @implicit_ce_generator ||= TwitterCldr::Collation::ImplicitCEGenerator.new
      end

    end

  end
end