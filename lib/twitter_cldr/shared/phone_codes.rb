# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Shared
    module PhoneCodes

      class << self

        def territories
          resource.keys
        end

        def code_for_territory(territory)
          resource[territory.to_s.downcase.to_sym]
        end

        private

        def resource
          @resource ||= TwitterCldr.get_resource(:shared, :phone_codes)
        end

      end

    end
  end
end