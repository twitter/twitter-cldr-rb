# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Transforms

    class InvalidTransformIdError < StandardError; end

    class TransformId
      class << self
        def parse(str)
          if normalized = normalize(str)
            new(*split(normalized))
          else
            raise InvalidTransformIdError,
              "'#{str}' is not a valid transform id"
          end
        end

        def split(str)
          str.split(/[\-\/]/)
        end

        def join(source, target, variant = nil)
          base = "#{source}-#{target}"
          variant ? "#{base}/#{variant}" : base
        end

        def join_file_name(parts)
          parts.compact.join('-')
        end

        private

        def normalize(str)
          normalization_index[str.downcase]
        end

        def normalization_index
          @index ||=
            Transformer.each_transform.each_with_object({}) do |key, ret|
              source, target, variant = split(key)
              reverse_key = join_file_name([target, source, variant])
              ret[key.downcase] = key
              ret[reverse_key.downcase] = reverse_key
          end
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
        self.class.join_file_name([source, target, variant])
      end

      def to_s
        self.class.join(source, target, variant)
      end
    end

  end
end
