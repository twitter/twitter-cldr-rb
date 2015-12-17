# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Transforms

    class TransformId
      class << self
        def parse(str)
          new(*str.split(/[\-\/]/))
        end

        def join(source, target, variant = nil)
          base = "#{source}-#{target}"
          variant ? "#{base}/#{variant}" : base
        end

        def split_file_name(file_name)
          file_name.split('-')
        end
      end

      attr_reader :source, :target, :variant

      def initialize(source, target, variant = nil)
        @source = source
        @target = target
        @variant = variant
      end

      def has_variant?
        !!variant
      end

      def reverse
        self.class.new(target, source, variant)
      end

      def file_name
        [source, target, variant].compact.join('-')
      end

      def to_s
        self.class.join(source, target, variant)
      end
    end

  end
end
