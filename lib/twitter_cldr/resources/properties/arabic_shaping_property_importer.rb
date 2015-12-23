# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Resources
    module Properties

      class ArabicShapingPropertyImporter < PropertyImporter
        DATA_URL = 'ucd/ArabicShaping.txt'

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
            joining_type = joining_types[data[2].strip.upcase]
            joining_group = format_property_value(data[3])
            ret['Joining_Type'][joining_type] += code_points
            ret['Joining_Group'][joining_group] += code_points
          end
        end

        def joining_types
          TwitterCldr::Shared::Properties::ArabicShaping.joining_types
        end
      end

    end
  end
end
