# encoding: UTF-8

module TwitterCldr
  module Normalizers
    class NFD < Base
      class << self
        def normalize_code_points(code_points)          
          code_points = code_points.map { |code_point| decompose_code_point(code_point) }.flatten
          reorder(code_points)        
          code_points
        end

        #Recursively replace the given code point with the values in its Decomposition_Mapping property
        def decompose_code_point(code_point)
          unicode_data = TwitterCldr::Shared::UnicodeData.for_code_point(code_point) || Array.new(size=15, obj="")
          decomposition_mapping = unicode_data[5].split

          #Return the code point if compatibility mapping or if no mapping exists
          if decomposition_mapping.first =~ /<.*>/ or decomposition_mapping.empty?
            code_point
          else
            decomposition_mapping.map do |decomposition_code_point|
              decompose_code_point(decomposition_code_point)
            end.flatten
          end
        end

        #Swap any two adjacent code points A & B if ccc(A) > ccc(B) > 0
        def reorder(code_point_sequence)
          combining_classes = code_point_sequence.map do |code_point| 
            unicode_data = TwitterCldr::Shared::UnicodeData.for_code_point(code_point) || Array.new(size=15, obj="")
            unicode_data[3].to_i
          end

          (code_point_sequence.size).times do
            code_point_sequence.each_index do |i|
              if code_point_sequence[i+1]
                if (combining_classes[i] > combining_classes[i+1]) and (combining_classes[i+1] > 0)
                  code_point_sequence[i], code_point_sequence[i+1] = code_point_sequence[i+1], code_point_sequence[i]
                  combining_classes[i], combining_classes[i+1] = combining_classes[i+1], combining_classes[i]
                end
              end
            end
          end
        end
      end
    end
  end
end