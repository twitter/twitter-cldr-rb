# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Shared

    # TODO: update README (here and in twitter-cldr-js)
    module TerritoriesContainment

      class << self

        # Returns true if the first territory contains the second one. Returns false otherwise.
        # Raises an ArgumentError exception if one of the territories is invalid.
        def contains(parent_code, child_code)
          validate_territory(parent_code)
          validate_territory(child_code)

          while child_code
            immediate_parent = parent(child_code)

            if immediate_parent != parent_code
              child_code = immediate_parent
            else
              return true
            end
          end

          false
        end

        # Returns the immediate parent of the territory with the given code.
        # Raises an ArgumentError exception if the territory code is invalid.
        def parent(territory_code)
          validate_territory(territory_code)

          parents_map[territory_code]
        end

        # Returns the immediate parent of the territory with the given code.
        # Raises an ArgumentError exception if the territory code is invalid.
        def children(territory_code)
          validate_territory(territory_code)

          containment_map[territory_code]
        end

        protected

        def validate_territory(territory_code)
          raise unknown_territory_exception(territory_code) unless parents_map.include?(territory_code)
        end

        def unknown_territory_exception(territory_code)
          ArgumentError.new("unknown territory code #{territory_code.inspect}")
        end

        def parents_map
          @parents_map ||= containment_map.inject({}) do |memo, (territory, children)|
            # make sure even the top-level territories are present in the map (with 'nil' as their parent)
            memo[territory] = nil unless memo.include?(territory)

            children.each do |child|
              memo[child] = territory
            end

            memo
          end
        end

        def containment_map
          @containment_map ||= get_resource.inject(Hash.new { |h, k| h[k] = [] }) do |memo, (territory, children)|
            memo[territory.to_s] = children[:contains].map(&:to_s)
            memo
          end
        end

        def get_resource
          TwitterCldr.get_resource(:shared, :territories_containment)[:territories]
        end

      end

    end
  end
end

