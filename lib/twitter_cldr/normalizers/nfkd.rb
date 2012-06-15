# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  # Normalizers module includes algorithm for Unicode normalization. Basic information on this topic can be found in the
  # Unicode Standard Annex #15 "Unicode Normalization Forms" at http://www.unicode.org/reports/tr15/. More detailed
  # description is given in the section "3.11 Normalization Forms" of the Unicode Standard core specification. The
  # latest version at the moment (for Unicode 6.1) is available at http://www.unicode.org/versions/Unicode6.1.0/ch03.pdf.
  #
  module Normalizers

    # Implements normalization of a Unicode string to Normalization Form KD (NFKD).
    # This normalization form includes only compatibility decomposition.
    #
    class NFKD < Base

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
          code_points.map { |code_point| decompose_recursively(code_point) }.flatten
        end

        # Recursively decomposes a given code point with the values in its Decomposition Mapping property.
        #
        def decompose_recursively(code_point)
          unicode_data = TwitterCldr::Shared::UnicodeData::CodePoint.for_hex(code_point)
          return code_point unless unicode_data

          if unicode_data.hangul_type == :compositions
            decompose_hangul(code_point)
          else
            decompose_regular(code_point, decomposition_mapping(unicode_data))
          end
        end

        # Decomposes regular (non-Hangul) code point.
        #
        def decompose_regular(code_point, mapping)
          if mapping && !mapping.empty?
            mapping.map{ |cp| decompose_recursively(cp) }.flatten
          else
            code_point
          end
        end

        # Returns code point's Decomposition Mapping based on its Unicode data.
        #
        def decomposition_mapping(unicode_data)
          mapping = parse_decomposition_mapping(unicode_data)
          mapping.shift if compatibility_decomposition?(mapping) # remove compatibility formatting tag
          mapping
        end

        def compatibility_decomposition?(mapping)
          !!(COMPATIBILITY_FORMATTING_TAG_REGEXP =~ mapping.first)
        end

        def parse_decomposition_mapping(unicode_data)
          unicode_data.decomposition.split
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

        # Performs stable sorting of a sequence of [code_point, combining_class] pairs. For sorting a regular bubble
        # sort is used (with a small optimization that stops the algorithm if none of the elements were swapped during
        # the iteration).
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
          TwitterCldr::Shared::UnicodeData::CodePoint.for_hex(code_point).combining_class.to_i
        rescue NoMethodError
          0
        end

      end

      COMPATIBILITY_FORMATTING_TAG_REGEXP = /^<.*>$/

    end
  end
end
