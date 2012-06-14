# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Shared
    module UnicodeData

      autoload :Attributes, "twitter_cldr/shared/unicode_data/attributes"

      class << self

        DECOMPOSITION_DATA_INDEX = 5

        def for_code_point(code_point)
          target = get_block(code_point)

          if target && target.first
            block_data = TwitterCldr.get_resource(:unicode_data, target.first)
            code_point_data = block_data.fetch(code_point.to_sym) { |code_point_sym| get_range_start(code_point_sym, block_data) }
            Attributes.new(*code_point_data) if code_point_data
          else
            nil
          end
        end

        def for_decomposition(code_points)
          @decomposition_map ||= TwitterCldr.get_resource(:unicode_data, :decomposition_map)
          key = code_points.join(" ").to_sym

          if @decomposition_map.include?(key)
            for_code_point(@decomposition_map[key])
          else
            nil
          end
        end

        private

        def get_block(code_point)
          blocks = TwitterCldr.get_resource(:unicode_data, :blocks)
          code_point_int = code_point.to_i(16)

          # Find the target block
          result = blocks.find do |block_name, range|
            range.include?(code_point_int)
          end

          # If the block can't be found, search for it in the array of missing blocks
          unless result
            result = missing_blocks.find do |block_name, range|
              range.include?(code_point_int)
            end
          end

          result
        end

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

        def missing_blocks
          @missing_blocks ||= []
          if @missing_blocks.empty?
            blocks = TwitterCldr.get_resource(:unicode_data, :blocks)
            (range_array = blocks.inject([]) { |ret, entry| ret += [entry.last.first, entry.last.last]; ret }.sort).shift
            range_array.each_slice(2) do |slice|
              unless slice.last == slice.first + 1
                @missing_blocks << [nil, (slice.first + 1)..slice.last]
              end
            end
          end
          @missing_blocks
        end

      end

    end
  end
end