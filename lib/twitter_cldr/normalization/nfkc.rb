# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Normalization

    # Implements normalization of a Unicode string to Normalization Form KC (NFKC).
    # This normalization form includes compatibility decomposition followed by compatibility composition.
    #
    class NFKC < Base

      class << self

        def normalize_code_points(code_points)
          compose(TwitterCldr::Normalization::NFKD.normalize_code_points(code_points))
        end

        protected

        def compose(code_points)
          final = []
          hangul_code_points = []

          code_points.each_with_index do |code_point, index|
            final << code_point
            hangul_type = TwitterCldr::Shared::CodePoint.hangul_type(code_point)
            next_hangul_type = TwitterCldr::Shared::CodePoint.hangul_type(code_points[index + 1])

            if valid_hangul_sequence?(hangul_code_points.size, hangul_type)
              hangul_code_points << code_point
              unless valid_hangul_sequence?(hangul_code_points.size, next_hangul_type)
                next_hangul_type = nil
              end
            else
              hangul_code_points.clear
            end

            if hangul_code_points.size > 1 && !next_hangul_type
              final.pop(hangul_code_points.size)
              final << compose_hangul(hangul_code_points)
              hangul_code_points.clear
            end
          end

          compose_normal(final)
          final
        end

        def valid_hangul_sequence?(buffer_size, hangul_type)
          [[0, :lparts], [1, :vparts], [2, :tparts]].include?([buffer_size, hangul_type])
        end

        def compose_hangul(code_points)
          TwitterCldr::Normalization::Hangul.compose(code_points)
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
              decomp_data = TwitterCldr::Shared::CodePoint.for_decomposition([code_points[starter_index], code_point])

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