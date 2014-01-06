# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'erb'

module TwitterCldr
  module Resources
    class ReadmeRenderer

      attr_reader :text, :assertion_failures

      def initialize(text)
        @text = text
        @assertion_failures = []
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

        assertion_failures << [got, expected] unless got == expected
        got  # for now...
      end

      def assert_true(got)
        assert(got, true)
      end

      def assert_false(got)
        assert(got, false)
      end

      def assert_no_error(proc)
        error = nil
        begin
          proc.call
        rescue => e
          assertion_failures << [e, nil]
        end
      end

      def ellipsize(obj)
        case obj
          when Array
            "[#{obj.map(&:inspect).join(", ")}, ... ]"
          when Hash
            hash_text = obj.map { |key, val| "#{key.inspect} => #{val.inspect}" }.join(", ")
            "{ ... #{hash_text} ... }"
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
