# encoding: UTF-8

module TwitterCldr
  module Shared
    class UnicodeData
      class << self
        def for_code_point(code_point)
          blocks = TwitterCldr.get_resource("unicode_data", "blocks")
          
          #Find the target block
          target = blocks.find do |block_name, range|
            range.include? code_point.to_i(16)
          end 

          if target
            block_data = TwitterCldr.get_resource("unicode_data", target.first)          
            block_data.fetch(code_point.to_sym) { |code_point_sym| get_range_start(code_point_sym, block_data) }
          end
        end

        private
        # Check if block constitutes a range. The code point beginning a range will have a name enclosed in <>, ending with 'First'
        # eg: <CJK Ideograph Extension A, First>
        # http://unicode.org/reports/tr44/#Code_Point_Ranges
        def get_range_start(code_point, block_data)
          start_code_point = block_data.keys.sort_by { |key| key.to_s.to_i(16) }.first
          start_data = block_data[start_code_point].clone
          if start_data[1] =~ /<.*, First>/
            start_data[0] = code_point.to_s
            start_data[1] = start_data[1].sub(', First', '')
            start_data
          end
        end
      end
    end
  end
end