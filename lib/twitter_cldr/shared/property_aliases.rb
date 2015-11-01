# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Shared

    class PropertyAliases
      class << self

        def abbreviated_alias_for(property_name, long_name)
          (long_index_for(property_name) || {})
            .fetch(long_name, {})
            .fetch(:abbreviated_name, nil)
        end

        def long_alias_for(property_name, abbreviated_name)
          (abbreviated_index_for(property_name) || {})
            .fetch(abbreviated_name, {})
            .fetch(:long_name, nil)
        end

        def aliases_for(property_name)
          resource[property_name.to_sym]
        end

        private

        def abbreviated_index_for(property_name)
          abbreviated_indices[property_name] ||=
            create_index(property_name, :abbreviated_name)
        end

        def long_index_for(property_name)
          long_indices[property_name] ||=
            create_index(property_name, :long_name)
        end

        def create_index(property_name, field)
          aliases_for(property_name).each_with_object({}) do |fields, ret|
            ret[fields[field]] = fields
          end
        end

        def abbreviated_indices
          @abbreviated_indices ||= {}
        end

        def long_indices
          @long_indices ||= {}
        end

        def resource
          @resource ||=
            TwitterCldr.get_resource('unicode_data', 'property_value_aliases')
        end

      end
    end

  end
end
