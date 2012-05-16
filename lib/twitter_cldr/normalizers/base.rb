# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Normalizers
    class Base

      class << self

        def normalize(string)
          code_points = TwitterCldr::Utils::CodePoints.from_string(string)
          normalized_code_points = normalize_code_points(code_points)
          TwitterCldr::Utils::CodePoints.to_string(normalized_code_points)
        end

        def normalize_code_points(code_points)
          canonical_ordering(decomposition(code_points))
        end

        protected

        def decomposition(code_points)
          code_points.map{ |code_point| decompose(code_point) }.flatten
        end

        # Recursively decompose a given code point with the values in its Decomposition Mapping property.
        #
        def decompose(code_point)
          unicode_data = TwitterCldr::Shared::UnicodeData.for_code_point(code_point)
          return code_point unless unicode_data

          if unicode_data.name.include?('Hangul')
            decompose_hangul(code_point)
          else
            decompose_regular(unicode_data)
          end
        end

        # Decomposes regular (non-Hangul) code point.
        #
        def decompose_regular(unicode_data)
          mapping = decomposition_mapping(unicode_data)

          if decomposable?(mapping)
            mapping.map{ |cp| decompose(cp) }.flatten
          else
            unicode_data.code_point
          end
        end

        # Returns code point's Decomposition Mapping based on its Unicode data.
        #
        def decomposition_mapping(unicode_data)
          unicode_data.decomposition.split
        end

        # Returns true if a given mapping is decomposable.
        #
        def decomposable?(mapping)
          !mapping.empty?
        end

        def compatibility_decomposition?(mapping)
          mapping.first =~ COMPATIBILITY_DECOMPOSITION_MAPPING_REGEXP
        end

        # Special decomposition for Hangul syllables. Documented in Section 3.12 at
        # http://www.unicode.org/versions/Unicode6.1.0/ch03.pdf
        #
        def decompose_hangul(code_point)
          s_index = code_point.hex - HANGUL_DECOMPOSITION_CONSTANTS[:SBase]

          l_index = s_index / HANGUL_DECOMPOSITION_CONSTANTS[:NCount]
          v_index = (s_index % HANGUL_DECOMPOSITION_CONSTANTS[:NCount]) / HANGUL_DECOMPOSITION_CONSTANTS[:TCount]
          t_index = s_index % HANGUL_DECOMPOSITION_CONSTANTS[:TCount]

          result = []

          result << (HANGUL_DECOMPOSITION_CONSTANTS[:LBase] + l_index).to_s(16).upcase
          result << (HANGUL_DECOMPOSITION_CONSTANTS[:VBase] + v_index).to_s(16).upcase
          result << (HANGUL_DECOMPOSITION_CONSTANTS[:TBase] + t_index).to_s(16).upcase if t_index > 0

          result
        end

        # Performs the Canonical Ordering Algorithm by stable sorting of every subsequence of combining code points
        # (code points that have combining class greater than zero).
        #
        def canonical_ordering(code_points)
          code_points_with_cc = code_points.map { |cp| [cp, combining_class_for(cp)] }

          result = []
          accum  = []

          code_points_with_cc.each do |cp_with_cc|
            if cp_with_cc[1] == 0
              unless accum.empty?
                result.concat(stable_sort(accum))
                accum = []
              end
              result << cp_with_cc
            else
              accum << cp_with_cc
            end
          end

          result.concat(stable_sort(accum)) unless accum.empty?

          result.map { |cp_with_cc| cp_with_cc[0] }
        end

        # Performs stable sorting of a sequence of [code_point, combining_class] pairs.
        #
        def stable_sort(code_points_with_cc)
          n = code_points_with_cc.size - 2

          code_points_with_cc.size.times do
            swapped = false

            (0..n).each do |j|
              if code_points_with_cc[j][1] > code_points_with_cc[j + 1][1]
                code_points_with_cc[j], code_points_with_cc[j + 1] = code_points_with_cc[j + 1], code_points_with_cc[j]
                swapped = true
              end
            end

            break unless swapped
            n -= 1
          end

          code_points_with_cc
        end

        def combining_class_for(code_point)
          TwitterCldr::Shared::UnicodeData.for_code_point(code_point).combining_class.to_i
        rescue NoMethodError
          0
        end

      end

      COMPATIBILITY_DECOMPOSITION_MAPPING_REGEXP = /^<.*>$/

      HANGUL_DECOMPOSITION_CONSTANTS = {
          :SBase  => 0xAC00,
          :LBase  => 0x1100,
          :VBase  => 0x1161,
          :TBase  => 0x11A7,
          :LCount => 19,
          :VCount => 21,
          :TCount => 28,
          :NCount => 588,  # VCount * TCount
          :Scount => 11172 # LCount * NCount
      }

    end
  end
end