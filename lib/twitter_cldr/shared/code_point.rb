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
      INDICES = [:category, :combining_class, :bidi_class]

      attr_reader :fields

      (CODE_POINT_FIELDS - [:decomposition]).each_with_index do |field, idx|
        define_method field do
          fields[idx]
        end
      end

      def decomposition
        @decomposition ||= begin
          if decomposition =~ DECOMPOSITION_REGEX
            $2 && $2.split.map(&:hex)
          else
            raise ArgumentError, "decomposition #{decomposition.inspect} has invalid format"
          end
        end
      end

      def compatibility_decomposition_tag
        @compat_decomp_tag ||= begin
          if decomposition =~ DECOMPOSITION_REGEX
            $1
          else
            raise ArgumentError, "decomposition #{decomposition.inspect} has invalid format"
          end
        end
      end

      def initialize(fields)
        @fields = fields
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
          code_point_cache[code_point] ||= begin
            target = get_block(code_point)

            return unless target && target.first

            block_data      = TwitterCldr.get_resource(:unicode_data, :blocks, target.first)
            code_point_data = block_data.fetch(code_point) { |cp| get_range_start(cp, block_data) }

            CodePoint.new(code_point_data) if code_point_data
          end
        end

        INDICES.each do |index_name|
          define_method :"codes_for_#{index_name}" do |search_terms|
            index = (index_cache[index_name] ||= TwitterCldr.get_resource(
              :unicode_data, :indices, index_name
            ))

            index[search_terms]
          end
        end

        def for_canonical_decomposition(code_points)
          if canonical_compositions.has_key?(code_points)
            find(canonical_compositions[code_points])
          end
        end

        def canonical_compositions
          @canonical_compositions ||=
            TwitterCldr.get_resource(:unicode_data, :canonical_compositions)
        end

        def hangul_type(code_point)
          hangul_type_cache[code_point] ||= begin
            if code_point
              [:lparts, :vparts, :tparts, :compositions].each do |type|
                hangul_blocks[type].each do |range|
                  return type if range.include?(code_point)
                end
              end
              nil
            else
              nil
            end
          end
        end

        def excluded_from_composition?(code_point)
          composition_exclusion_cache[code_point] ||=
            composition_exclusions.any? { |exclusion| exclusion.include?(code_point) }
        end

        private

        def index_cache
          @index_cache ||= {}
        end

        def hangul_type_cache
          @hangul_type_cache ||= {}
        end

        def code_point_cache
          @code_point_cache ||= {}
        end

        def composition_exclusion_cache
          @composition_exclusion_cache ||= {}
        end

        def hangul_blocks
          @hangul_blocks ||= TwitterCldr.get_resource(:unicode_data, :hangul_blocks)
        end

        def composition_exclusions
          @composition_exclusions ||= TwitterCldr.get_resource(:unicode_data, :composition_exclusions)
        end

        def get_block(code_point)
          block_cache[code_point] ||=
            blocks.detect { |_, range|  range.include?(code_point) }
        end

        def block_cache
          @block_cache ||= {}
        end

        def blocks
          TwitterCldr.get_resource(:unicode_data, :blocks)
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