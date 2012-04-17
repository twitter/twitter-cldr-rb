# encoding: UTF-8

module TwitterCldr
  module Normalizers
    class NFD < Base
      class << self
        def normalize_code_points(code_points)          
          code_points = code_points.map { |code_point| decompose code_point }.flatten
          reorder code_points
          code_points
        end

        #Recursively replace the given code point with the values in its Decomposition_Mapping property
        def decompose(code_point)
          unicode_data = TwitterCldr::Shared::UnicodeData.for_code_point(code_point) || Array.new(size=15, obj="")
          decomposition_mapping = unicode_data[5].split

          #Return the code point if compatibility mapping or if no mapping exists
          if decomposition_mapping.first =~ /<.*>/ || decomposition_mapping.empty?
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
          (TwitterCldr::Shared::UnicodeData.for_code_point(code_point) || Array.new(size=15, obj=""))[3].to_i
        end
      end
    end
  end
end