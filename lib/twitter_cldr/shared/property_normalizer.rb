# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Shared

    class PropertyNormalizer
      attr_reader :database

      def initialize(database)
        @database = database
      end

      def normalize(property_name, property_value = nil)
        candidates = find_property_name_candidates(property_name)

        if property_value
          name, value = resolve_candidates(candidates, property_value)
        else
          name = candidates.find { |c| database.include?(c) }
          value = nil
        end

        [name, value]
      end

      private

      def resolve_candidates(property_name_candidates, property_value)
        value_candidates = find_property_value_candidates(
          property_name_candidates, property_value
        )

        resolve_name_value_candidates(
          property_name_candidates, value_candidates
        )
      end

      def resolve_name_value_candidates(property_name_candidates, value_candidates)
        property_name_candidates.each do |property_name|
          value_candidates.each do |value_candidate|
            if database.include?(property_name, value_candidate)
              return [property_name, value_candidate]
            end
          end
        end

        []
      end

      def find_property_name_candidates(property_name)
        aliases = PropertyNameAliases.aliases_for(property_name)
        aliases << property_name
        aliases.uniq
      end

      def find_property_value_candidates(property_name_candidates, property_value)
        property_name_candidates.flat_map do |property_name|
          PropertyValueAliases.aliases_for(property_name, property_value) + [property_value]
        end.uniq
      end
    end

  end
end
