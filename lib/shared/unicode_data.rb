# encoding: UTF-8

module TwitterCldr
  module Shared
    class UnicodeData
      @@unicode_data_attrs = Struct.new(:code_point, :name, :category, :combining_class, :bidi_class, :decomposition, :digit_value, :non_decimal_digit_value, :numeric_value, :bidi_mirrored, :unicode1_name, :iso_comment, :simple_uppercase_map, :simple_lowercase_map, :simple_titlecase_map)
      class << self
        def for_code_point(code_point)
          blocks = TwitterCldr.get_resource("unicode_data", "blocks")
          
          #Find the target block
          target = blocks.find do |block_name, range|
            range.include? code_point.to_i(16)
          end 

          unicode_data = TwitterCldr.get_resource("unicode_data", target.first)[code_point.to_sym] if target
          @@unicode_data_attrs.new(*unicode_data) if unicode_data
        end   
      end
    end
  end
end