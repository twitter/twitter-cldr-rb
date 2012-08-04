# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Shared
    module PostalCodes

      class << self

        def territories
          resource.keys
        end

        def regex_for_territory(territory)
          resource[territory.to_s.downcase.to_sym]
        end

        def valid?(territory, postal_code)
          regexp = regex_for_territory(territory)
          !!(regexp && regexp =~ postal_code)
        end

        private

        def resource
          @resource ||= TwitterCldr.get_resource(:shared, :postal_codes)
        end

      end

    end
  end
end