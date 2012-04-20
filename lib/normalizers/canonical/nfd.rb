# encoding: UTF-8

module TwitterCldr
  module Normalizers
    class NFD < Base
      @@hangul_constants = {:SBase => "AC00".hex, :LBase => "1100".hex, :VBase => "1161".hex, :TBase => "11A7".hex,
                            :Scount => 11172, :LCount => 19, :VCount => 21, :TCount => 28, :NCount => 588, :Scount => 1172}
      class << self
        def normalize(string)       
          #Convert string to code points
          code_points = string.split('').map { |char| char_to_code_point(char) }

          #Normalize code points
          normalized_code_points = normalize_code_points(code_points)

          #Convert normalized code points back to string
          normalized_code_points.map { |code_point| code_point_to_char(code_point) }.join
        end

        def normalize_code_points(code_points)          
          code_points = code_points.map { |code_point| decompose code_point }.flatten
          reorder code_points
          code_points
        end

        #Recursively replace the given code point with the values in its Decomposition_Mapping property
        def decompose(code_point)
          unicode_data = TwitterCldr::Shared::UnicodeData.for_code_point(code_point)
          return code_point unless unicode_data
          decomposition_mapping = unicode_data[5].split

          # Special decomposition for Hangul syllables.
          # Documented in Section 3.12 at http://www.unicode.org/versions/Unicode6.1.0/ch03.pdf
          if unicode_data[1].include? 'Hangul'
            sIndex = code_point.hex - @@hangul_constants[:SBase]

            lIndex = sIndex / @@hangul_constants[:NCount]
            vIndex = (sIndex % @@hangul_constants[:NCount]) / @@hangul_constants[:TCount]
            tIndex = sIndex % @@hangul_constants[:TCount]

            lPart = (@@hangul_constants[:LBase] + lIndex).to_s(16).upcase
            vPart = (@@hangul_constants[:VBase] + vIndex).to_s(16).upcase
            tPart = (@@hangul_constants[:TBase] + tIndex).to_s(16).upcase if tIndex > 0

            [lPart, vPart, tPart].compact

          #Return the code point if compatibility mapping or if no mapping exists
          elsif decomposition_mapping.first =~ /<.*>/ || decomposition_mapping.empty?
            code_point
          else
            decomposition_mapping.map do |decomposition_code_point|
              decompose(decomposition_code_point)
            end.flatten
          end
        end

        #Swap any two adjacent code points A & B if ccc(A) > ccc(B) > 0
        def reorder(code_points)
          (code_points.size).times do
            code_points.each_with_index do |cp, i|
              unless cp == code_points.last
                ccc_a, ccc_b = combining_class_for(cp), combining_class_for(code_points[i+1])
                if (ccc_a > ccc_b) && (ccc_b > 0)
                  code_points[i], code_points[i+1] = code_points[i+1], code_points[i]
                end
              end
            end
          end
        end

        def combining_class_for(code_point)
          begin
            unicode_data = TwitterCldr::Shared::UnicodeData.for_code_point(code_point)[3].to_i
          rescue NoMethodError
            0
          end          
        end
      end
    end
  end
end