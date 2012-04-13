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

          TwitterCldr.get_resource("unicode_data", target.first)[code_point.to_sym] if target
        end   
      end
    end
  end
end