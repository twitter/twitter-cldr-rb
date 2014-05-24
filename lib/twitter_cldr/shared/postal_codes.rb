# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Shared

    class InvalidTerritoryError < StandardError; end

    class PostalCodes

      class << self

        def territories
          resource.keys
        end

        def for_territory(territory)
          key = territory.to_s.downcase.to_sym
          if res = resource[key]
            territory_cache[key] ||= begin
              new(
                territory,
                res[:regex],
                TwitterCldr::Utils::RegexpAst.load(res[:ast])
              )
            end
          else
            raise InvalidTerritoryError, "invalid territory"
          end
        end

        private

        def territory_cache
          @territory_cache ||= {}
        end

        def resource
          @resource ||= TwitterCldr.get_resource(:shared, :postal_codes)
        end

      end

      attr_reader :territory, :regexp, :ast

      def initialize(territory, regexp, ast)
        @territory = territory
        @regexp = regexp
        @ast = ast
      end

      def valid?(postal_code)
        !!(regexp && regexp =~ postal_code)
      end

      def sample(sample_size = 1)
        generator.sample(sample_size)
      end

      private

      def generator
        generator_cache[territory] ||= PostalCodeGenerator.new(ast)
      end

      def generator_cache
        @@generator_cache ||= {}
      end

    end
  end
end
