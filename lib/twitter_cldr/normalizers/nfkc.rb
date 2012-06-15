# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Normalizers

    # Implements normalization of a Unicode string to Normalization Form KC (NFKC).
    # This normalization form includes compatibility decomposition followed by compatibility composition.
    #
    class NFKC < Base

      class << self

        def normalize(string)
          code_points = TwitterCldr::Utils::CodePoints.from_string(string)
          normalized_code_points = normalize_code_points(code_points)
          TwitterCldr::Utils::CodePoints.to_string(normalized_code_points)
        end

        def normalize_code_points(code_points)
          compose(TwitterCldr::Normalizers::NFKD.normalize_code_points(code_points))
        end

        protected

        def compose(code_points)
          final = []
          hangul_code_points = []

          code_points.each_with_index do |code_point, index|
            final << code_point
            hangul_type = TwitterCldr::Shared::UnicodeData::CodePoint.hangul_type(code_point)
            next_hangul_type = TwitterCldr::Shared::UnicodeData::CodePoint.hangul_type(code_points[index + 1])

            if valid_hangul_sequence?(hangul_code_points.size, hangul_type)
              hangul_code_points << code_point
              unless valid_hangul_sequence?(hangul_code_points.size, next_hangul_type)
                next_hangul_type = nil
              end
            else
              hangul_code_points.clear
            end

            if hangul_code_points.size > 1 && !next_hangul_type
              hangul_code_points.size.times { final.pop }
              final << compose_hangul(hangul_code_points)
              hangul_code_points.clear
            end
          end

          compose_normal(final)
          final
        end

        def valid_hangul_sequence?(buffer_size, hangul_type)
          case [buffer_size, hangul_type]
            when [0, :lparts], [1, :vparts], [2, :tparts]
              true
            else
              false
          end
        end

        # Special composition for Hangul syllables. Documented in Section 3.12 at
        # http://www.unicode.org/versions/Unicode6.1.0/ch03.pdf
        #
        def compose_hangul(code_points)
          l_index = code_points.first.hex - HANGUL_DECOMPOSITION_CONSTANTS[:LBase]
          v_index = code_points[1].hex - HANGUL_DECOMPOSITION_CONSTANTS[:VBase]
          t_index = code_points[2] ? code_points[2].hex - HANGUL_DECOMPOSITION_CONSTANTS[:TBase] : 0  # tpart may be missing, that's ok
          lv_index = (l_index * HANGUL_DECOMPOSITION_CONSTANTS[:NCount]) + (v_index * HANGUL_DECOMPOSITION_CONSTANTS[:TCount])
          (HANGUL_DECOMPOSITION_CONSTANTS[:SBase] + lv_index + t_index).to_s(16).upcase.rjust(4, "0")
        end

        # Implements composition of Unicode code points following the guidelines here:
        # http://www.unicode.org/versions/Unicode6.1.0/ch03.pdf - Section 3.12
        # Combining code points are combined with their base characters.  For example, "ñ"
        # can be decomposed into 006E 0303, one code point for the "n" and the "˜" respectively.
        # Composition reverses this process, turning 006E 0303 into a single 00F1 code point.
        #
        def compose_normal(code_points)
          index = 1

          while index < code_points.size
            code_point = code_points[index]
            combining_class = combining_class_for(code_point)
            starter_index = find_starter_index(index, code_points)

            # is this character blocked from combining with the last starter?
            if starter_index < index - 1
              previous_combining_class = combining_class_for(code_points[index - 1])
              blocked = (previous_combining_class == 0) || (previous_combining_class >= combining_class)
            else
              blocked = false
            end

            unless blocked
              # do a reverse-lookup for the decomposed code points
              decomp_data = TwitterCldr::Shared::UnicodeData::CodePoint.for_decomposition([code_points[starter_index], code_point])

              # check if two code points are canonically equivalent
              if decomp_data && !decomp_data.excluded_from_composition?
                # combine the characters
                code_points[starter_index] = decomp_data.code_point
                code_points.delete_at(index)
                index -= 1
              end
            end

            index += 1
          end
        end

        def find_starter_index(start_pos, code_points)
          start_pos.times do |i|
            return start_pos - i - 1 if combining_class_for(code_points[start_pos - i - 1]) == 0
          end
        end

      end

    end
  end
end