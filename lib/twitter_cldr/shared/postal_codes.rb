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
            territory_cache[key] ||= new(
              territory,
              res[:regex],
              TwitterCldr::Utils::RegexpAst.load(res[:ast])
            )
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

      attr_reader :territory, :regexp, :single_regexp, :multi_regexp, :ast

      def initialize(territory, regexp, ast)
        @territory = territory
        @regexp = regexp
        if @regexp
          @single_regexp = build_regexp "\\A#{regexp.source}\\z"
          @multi_regexp = build_regexp "\\b#{regexp.source}\\b"
        end
        @ast = ast
      end

      def valid?(postal_code)
        !!(single_regexp && single_regexp =~ postal_code)
      end

      def find_all(postal_codes)
        # we cannot use String#scan here as some of the CLDR regular
        # expressions have capture groups while others don't making
        # it completely unpredictable what that method might return
        offset = 0; matches = []
        while match = multi_regexp.match(postal_codes, offset)
          matches << match[0]
          offset += match.offset(0)[1]
        end
        matches
      end

      def sample(sample_size = 1)
        generator.sample(sample_size)
      end

      private

      def build_regexp(regexp_str, modifiers = '')
        Regexp.new(regexp_str, modifiers)
      end

      def generator
        generator_cache[territory] ||= PostalCodeGenerator.new(ast)
      end

      def generator_cache
        @@generator_cache ||= {}
      end

    end
  end
end
