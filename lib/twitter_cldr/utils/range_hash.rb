# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Utils

    class OverlappingRangeError < StandardError; end

    class RangeHash
      include Enumerable

      attr_reader :keys_array, :values_hash

      def initialize
        @keys_array = []
        @values_hash = {}
      end

      def [](num)
        if num.is_a?(Range)
          raise ArgumentError, 'Index argument must not be a range'
        else
          if key = find_key(num)
            values_hash[key]
          end
        end
      end

      def []=(new_key, new_val)
        closest_key_idx = find_closest_key_index(new_key.first)

        if key = keys_array[closest_key_idx]
          if exact_overlap?(key, new_key)
            values_hash[key] = new_val
            return
          elsif overlap?(new_key, key)
            raise OverlappingRangeError,
              "#{new_key} partially overlaps existing range in the hash"
          end
        end

        insert(key, closest_key_idx, new_key, new_val)
      end

      def keys
        keys_array.flat_map(&:to_a)
      end

      def values
        values_hash.values
      end

      def each
        if block_given?
          keys_array.each do |key|
            key.each do |i|
              yield i, values_hash[key]
            end
          end
        else
          to_enum(__method__)
        end
      end

      alias_method :each_pair, :each

      protected

      include RangeHelpers

      def insert(key, closest_idx, new_key, new_val)
        if !key || (new_key.first < key.first)
          keys_array.insert(closest_idx, new_key)
        else
          keys_array.insert(closest_idx + 1, new_key)
        end

        values_hash[new_key] = new_val
      end

      def find_key(num)
        if key = find_closest_key(num)
          key if key.include?(num)
        end
      end

      def find_closest_key(num)
        if key_index = find_closest_key_index(num)
          keys_array[key_index]
        end
      end

      def find_closest_key_index(num)
        low = 0
        mid = 0
        high = keys_array.length - 1

        while low <= high
          mid = (low + high) >> 1

          if num >= keys_array[mid].first && num <= keys_array[mid].last
            return mid
          elsif num < keys_array[mid].first
            high = mid - 1
          else
            low = mid + 1
          end
        end

        mid
      end
    end

  end
end
