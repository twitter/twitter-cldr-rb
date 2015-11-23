# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Resources
    module Properties

      class PropListImporter < PropertyImporter
        DATA_URL = 'ucd/PropList.txt'

        def initialize(input_path, database)
          super(
            input_path: input_path,
            property_name: nil,
            data_url: DATA_URL,
            data_path: File.basename(DATA_URL),
            database: database
          )
        end

        private

        def load
          super do |data, ret|
            code_points = expand_range(data[0])
            property_name = format_property_value(data[1])
            ret[property_name][nil] += code_points
          end
        end
      end

    end
  end
end
