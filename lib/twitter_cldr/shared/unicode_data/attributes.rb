# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Shared
    module UnicodeData

      Attributes = Struct.new(
        :code_point,
        :name,
        :category,
        :combining_class,
        :bidi_class,
        :decomposition,
        :digit_value,
        :non_decimal_digit_value,
        :numeric_value,
        :bidi_mirrored,
        :unicode1_name,
        :iso_comment,
        :simple_uppercase_map,
        :simple_lowercase_map,
        :simple_titlecase_map
      )

      class Attributes
        def hangul_type
          Attributes.hangul_type(code_point)
        end

        def excluded_from_composition?
          Attributes.excluded_from_composition?(code_point)
        end

        class << self

          def hangul_type(code_point)
            return nil unless code_point
            code_point_int = code_point.to_i(16)
            result = nil
            [:compositions, :decompositions, :lparts, :vparts, :tparts].each do |type|
              hangul_blocks[type].each do |range|
                result = type.to_sym and break if range.include?(code_point_int)
              end
            end
            result
          end

          def excluded_from_composition?(code_point)
            code_point_int = code_point.hex
            composition_exclusions.any? { |excl| excl.include?(code_point_int) }
          end

          protected

          def hangul_blocks
            @hangul_blocks ||= TwitterCldr.get_resource(:unicode_data, :blocks_hangul)
          end

          def composition_exclusions
            @composition_exclusions ||= TwitterCldr.get_resource(:unicode_data, :composition_exclusions)
          end

        end

      end
    end
  end
end