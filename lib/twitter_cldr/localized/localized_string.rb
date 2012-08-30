# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Localized

    class LocalizedString < LocalizedObject
      include Enumerable

      # Uses wrapped string object as a format specification and returns the result of applying it to +args+ (see
      # +TwitterCldr::Utils.interpolate+ method for interpolation syntax).
      #
      # If +args+ is a Hash than pluralization is performed before interpolation (see +PluralFormatter+ class for
      # pluralization specification).
      #
      def %(args)
        pluralized = args.is_a?(Hash) ? @formatter.format(@base_obj, args) : @base_obj
        TwitterCldr::Utils.interpolate(pluralized, args)
      end

      def formatter_const
        TwitterCldr::Formatters::PluralFormatter
      end

      def normalize(options = {})
        TwitterCldr::Normalization.normalize(@base_obj, options).localize(@locale)
      end

      def code_points
        TwitterCldr::Utils::CodePoints.from_string(@base_obj)
      end

      def to_s
        @base_obj.dup
      end

      def size
        code_points.size
      end

      alias :length :size

      def bytesize
        @base_obj.respond_to?(:bytesize) ? @base_obj.bytesize : @base_obj.size
      end

      def [](index)
        if index.is_a?(Range)
          TwitterCldr::Utils::CodePoints.to_string(code_points[index])
        else
          TwitterCldr::Utils::CodePoints.to_char(code_points[index])
        end
      end

      def each_char
        if block_given?
          code_points.each do |code_point|
            yield TwitterCldr::Utils::CodePoints.to_char(code_point)
          end
          @base_obj
        else
          code_points.map { |code_point| TwitterCldr::Utils::CodePoints.to_char(code_point) }.to_enum
        end
      end

      alias :each :each_char

    end

  end
end