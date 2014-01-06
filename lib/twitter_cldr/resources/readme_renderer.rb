require 'erb'
require 'twitter_cldr'
require 'pry-nav'

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
        if obj.is_a?(Array)
          "[#{obj.map(&:inspect).join(", ")}, ... ]"
        end
      end

    end
  end
end

contents = File.read("/Users/legrandfromage/workspace/twitter-cldr-rb/README.md.erb")
rr = ReadmeRenderer.new(contents)
puts rr.render
puts rr.failed_assertions.inspect
