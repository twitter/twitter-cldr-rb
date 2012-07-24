# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Shared

    CODE_POINT_FIELDS = [
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
    ]

    CodePoint = Struct.new(*CODE_POINT_FIELDS) do
      DECOMPOSITION_DATA_INDEX = 5

      DECOMPOSITION_REGEX = /^(?:<(.+)>\s+)?(.+)?$/

      attr_accessor :compatibility_decomposition_tag

      def initialize(*)
        super

        if decomposition =~ DECOMPOSITION_REGEX
          self.compatibility_decomposition_tag = $1
          self.decomposition = $2 && $2.split.map(&:hex)
        else
          raise ArgumentError, "decomposition #{decomposition.inspect} has invalid format"
        end
      end

      def compatibility_decomposition?
        !!compatibility_decomposition_tag
      end

      def hangul_type
        CodePoint.hangul_type(code_point)
      end

      def excluded_from_composition?
        CodePoint.excluded_from_composition?(code_point)
      end

      class << self

        def find(code_point)
          target = get_block(code_point)

          return unless target && target.first

          block_data      = TwitterCldr.get_resource(:unicode_data, target.first)
          code_point_data = block_data.fetch(code_point_to_string(code_point).to_sym) { |cp| get_range_start(cp, block_data) }

          CodePoint.new(code_point_data[0].hex, *code_point_data[1..-1]) if code_point_data
        end

        def for_decomposition(code_points)
          @decomposition_map ||= TwitterCldr.get_resource(:unicode_data, :decomposition_map)
          key = code_points.map(&method(:code_point_to_string)).join(' ').to_sym

          find(@decomposition_map[key].hex) if @decomposition_map.include?(key)
        end

        def hangul_type(code_point)
          return unless code_point

          [:lparts, :vparts, :tparts, :compositions].each do |type|
            hangul_blocks[type].each do |range|
              return type if range.include?(code_point)
            end
          end

          nil
        end

        def excluded_from_composition?(code_point)
          composition_exclusions.any? { |exclusion| exclusion.include?(code_point) }
        end

        private

        def hangul_blocks
          @hangul_blocks ||= TwitterCldr.get_resource(:unicode_data, :hangul_blocks)
        end

        def composition_exclusions
          @composition_exclusions ||= TwitterCldr.get_resource(:unicode_data, :composition_exclusions)
        end

        def get_block(code_point)
          blocks.detect { |_, range|  range.include?(code_point) }
        end

        def blocks
          TwitterCldr.get_resource(:unicode_data, :blocks)
        end

        # Check if block constitutes a range. The code point beginning a range will have a name enclosed in <>, ending with 'First'
        # eg: <CJK Ideograph Extension A, First>
        # http://unicode.org/reports/tr44/#Code_Point_Ranges
        def get_range_start(code_point, block_data)
          start_code_point = block_data.keys.sort_by { |key| key.to_s.hex }.first
          start_data = block_data[start_code_point].clone

          if start_data[1] =~ /<.*, First>/
            start_data[0] = code_point.to_s
            start_data[1] = start_data[1].sub(', First', '')
            start_data
          end
        end

        def code_point_to_string(code_point)
          code_point.to_s(16).rjust(4, '0').upcase
        end

      end
    end
  end
end