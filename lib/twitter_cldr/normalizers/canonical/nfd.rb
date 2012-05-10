# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Normalizers
    class NFD < Base

      HANGUL_CONSTANTS = {
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

      class << self

        def normalize(string)
          # Convert string to code points
          code_points = string.split('').map { |char| char_to_code_point(char) }

          # Normalize code points
          normalized_code_points = normalize_code_points(code_points)

          # Convert normalized code points back to string
          normalized_code_points.map { |code_point| code_point_to_char(code_point) }.join
        end

        def normalize_code_points(code_points)
          code_points = code_points.map { |code_point| decompose code_point }.flatten
          reorder(code_points)
        end

        # Recursively replace the given code point with the values in its Decomposition_Mapping property.
        def decompose(code_point)
          unicode_data = TwitterCldr::Shared::UnicodeData.for_code_point(code_point)
          return code_point unless unicode_data

          decomposition_mapping = unicode_data.decomposition.split

          if unicode_data.name.include?('Hangul')
            decompose_hangul(code_point)
          # Return the code point if compatibility mapping or if no mapping exists
          elsif decomposition_mapping.first =~ /<.*>/ || decomposition_mapping.empty?
            code_point
          else
            decomposition_mapping.map do |decomposition_code_point|
              decompose(decomposition_code_point)
            end.flatten
          end
        end

        private

        # Special decomposition for Hangul syllables.
        # Documented in Section 3.12 at http://www.unicode.org/versions/Unicode6.1.0/ch03.pdf
        def decompose_hangul(code_point)
          s_index = code_point.hex - HANGUL_CONSTANTS[:SBase]

          l_index = s_index / HANGUL_CONSTANTS[:NCount]
          v_index = (s_index % HANGUL_CONSTANTS[:NCount]) / HANGUL_CONSTANTS[:TCount]
          t_index = s_index % HANGUL_CONSTANTS[:TCount]

          result = []

          result << (HANGUL_CONSTANTS[:LBase] + l_index).to_s(16).upcase
          result << (HANGUL_CONSTANTS[:VBase] + v_index).to_s(16).upcase
          result << (HANGUL_CONSTANTS[:TBase] + t_index).to_s(16).upcase if t_index > 0

          result
        end

        # Swap any two adjacent code points A & B if ccc(A) > ccc(B) > 0.
        def reorder(code_points)
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

    end
  end
end