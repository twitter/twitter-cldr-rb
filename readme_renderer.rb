# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'erb'

module TwitterCldr
  module Resources
    class ReadmeRenderer

      attr_reader :text, :failed_assertions

      def initialize(text)
        @text = text
        @failed_assertions = []
      end

      def render
        ERB.new(text).result(binding)
      end

      def datetime
        @datetime ||= DateTime.new(2014, 2, 14, 12, 20, 5, 0)
      end

      def time
        @time ||= Time.new(2014, 2, 14, 12, 20, 5, 0)
      end

      private

      def assert(got, expected)
        if got.is_a?(String) && expected.is_a?(String)
          got = got.localize.normalize(:using => :NFKC).to_s
          expected = expected.localize.normalize(:using => :NFKC).to_s
        end

        failed_assertions << [got, expected] unless got == expected
        got  # for now...
      end

      def assert_true(got)
        assert(got, true)
      end

      def assert_false(got)
        assert(got, false)
      end

      def ellipsize(obj)
        case obj
          when Array
            "[#{obj.map(&:inspect).join(", ")}, ... ]"
          when Hash
            "{ ... #{obj.map { |key, val| key.inspect + " => " val.inspect }.join(", ") } ... }"
        end
      end

      def slice_hash(hash, keys)
        hash.inject({}) do |ret, (key, val)|
          ret[key] = val if keys.include?(key)
          ret
        end
      end

    end
  end
end
