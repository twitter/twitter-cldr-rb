# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Resources
    module Properties

      class ScriptExtensionsPropertyImporter < PropertyImporter
        DATA_URL = 'ucd/ScriptExtensions.txt'
        PROPERTY_NAME = 'Script_Extensions'

        def initialize(input_path, database)
          super(
            input_path: input_path,
            property_name: PROPERTY_NAME,
            data_url: DATA_URL,
            data_path: File.basename(DATA_URL),
            database: database
          )
        end

        private

        def load
          super do |data, ret|
            code_points = expand_range(data[0])
            property_values = data[1].split(' ')

            property_values.each do |property_value|
              ret[PROPERTY_NAME][property_value] += code_points
            end
          end
        end
      end

    end
  end
end
