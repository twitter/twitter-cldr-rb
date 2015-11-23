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

    class CodePoint
      DECOMPOSITION_DATA_INDEX = 5
      DECOMPOSITION_REGEX = /^(?:<(.+)>\s+)?(.+)?$/

      attr_reader :fields

      CODE_POINT_FIELDS.each_with_index do |field, idx|
        unless field == :decomposition
          define_method field do
            fields[idx]
          end
        end
      end

      def decomposition
        @decomposition ||= begin
          decomp = fields[DECOMPOSITION_DATA_INDEX]
          if decomp =~ DECOMPOSITION_REGEX
            $2 && $2.split.map(&:hex)
          else
            raise ArgumentError,
              "decomposition #{decomp.inspect} has invalid format"
          end
        end
      end

      def compatibility_decomposition_tag
        @compat_decomp_tag ||= begin
          decomp = fields[DECOMPOSITION_DATA_INDEX]
          if decomp =~ DECOMPOSITION_REGEX
            $1
          else
            raise ArgumentError,
              "decomposition #{decomp.inspect} has invalid format"
          end
        end
      end

      def initialize(fields)
        @fields = fields
      end

      def properties
        self.class.properties.properties_for_code_point(code_point)
      end

      class << self

        def find(code_point)
          code_point_cache[code_point] ||= begin
            target = get_block(code_point)

            return unless target && target.first

            block_data      = TwitterCldr.get_resource(:unicode_data, :blocks, target.first)
            code_point_data = block_data.fetch(code_point) { |cp| get_range_start(cp, block_data) }

            CodePoint.new(code_point_data) if code_point_data
          end
        end

        def properties
          @properties ||= TwitterCldr::Shared::PropertiesDatabase.new
        end

        def code_points_for_property(property_name, property_value = nil)
          properties.code_points_for_property(
            property_name, property_value
          )
        end

        def properties_for_code_point(code_point)
          properties.properties_for_code_point(code_point)
        end

        private

        def code_point_cache
          @code_point_cache ||= {}
        end

        def get_block(code_point)
          block_cache[code_point] ||= blocks.detect do |_, range|
            range.include?(code_point)
          end
        end

        def block_cache
          @block_cache ||= {}
        end

        def blocks
          @blocks ||= TwitterCldr.get_resource(
            :unicode_data, :blocks
          )
        end

        # Check if block constitutes a range. The code point beginning a range will have a name enclosed in <>, ending with 'First'
        # eg: <CJK Ideograph Extension A, First>
        # http://unicode.org/reports/tr44/#Code_Point_Ranges
        def get_range_start(code_point, block_data)
          start_data = block_data[block_data.keys.min]

          if start_data[1] =~ /<.*, First>/
            start_data = start_data.clone
            start_data[0] = code_point
            start_data[1] = start_data[1].sub(', First', '')
            start_data
          end
        end

      end
    end
  end
end
