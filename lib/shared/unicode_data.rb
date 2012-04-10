# encoding: UTF-8

module TwitterCldr
  module Shared
    class UnicodeData
      @@blocks = TwitterCldr.resources.resource_for("unicode_data", "blocks")
      @@cache = { :data => {} }

      class << self
        def for_code_point(code_point)
          #Find the target block
          target = @@blocks.find do |block_name, range|
            range.cover? code_point.to_i(16)
          end 

          if target
            target_name = target.first
            @@cache[:data][target_name.to_sym] ||= TwitterCldr.resources.resource_for("unicode_data", target_name)
            @@cache[:data][target_name.to_sym][code_point.to_sym]
          end
        end   
      end
    end
  end
end