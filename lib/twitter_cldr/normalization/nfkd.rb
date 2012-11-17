# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  # Normalization module includes algorithm for Unicode normalization. Basic information on this topic can be found in the
  # Unicode Standard Annex #15 "Unicode Normalization Forms" at http://www.unicode.org/reports/tr15/. More detailed
  # description is given in the section "3.11 Normalization Forms" of the Unicode Standard core specification. The
  # latest version at the moment (for Unicode 6.1) is available at http://www.unicode.org/versions/Unicode6.1.0/ch03.pdf.
  #
  module Normalization

    # Implements normalization of a Unicode string to Normalization Form KD (NFKD).
    # This normalization form includes only compatibility decomposition.
    #
    class NFKD < Base


      class << self

        def normalize_code_points(code_points)
          canonical_ordering(decompose(code_points))
        end

        protected

        def decompose(code_points)
          code_points.inject([]) do |ret, code_point|
            if requires_normalization?(code_point)
              ret += decompose_recursively(code_point)
            else
              ret << code_point
            end
            ret
          end
        end

        # Recursively decomposes a given code point with the values in its Decomposition Mapping property.
        #
        def decompose_recursively(code_point)
          unicode_data = TwitterCldr::Shared::CodePoint.find(code_point)
          return code_point unless unicode_data

          if unicode_data.hangul_type == :compositions
            decompose_hangul(code_point)
          else
            decompose_regular(unicode_data)
          end
        end

        # Decomposes regular (non-Hangul) code point.
        #
        def decompose_regular(unicode_data)
          if decompose?(unicode_data)
            unicode_data.decomposition.map { |code_point| decompose_recursively(code_point) }.flatten
          else
            unicode_data.code_point
          end
        end

        def decompose?(unicode_data)
          !!unicode_data.decomposition
        end

        def decompose_hangul(code_point)
          TwitterCldr::Normalization::Hangul.decompose(code_point)
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

      end

    end
  end
end
