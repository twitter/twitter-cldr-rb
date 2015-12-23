# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Resources
    module Properties

      class BidiBracketsPropertyImporter < PropertyImporter
        DATA_URL = 'ucd/BidiBrackets.txt'
        PROPERTY_NAME = 'Bidi_Paired_Bracket_Type'

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
            paired_bracket_type = infer_paired_bracket_type(data[2])
            ret[PROPERTY_NAME][paired_bracket_type] += code_points
          end
        end

        def infer_paired_bracket_type(str)
          TwitterCldr::Shared::Properties::BidiBrackets.bracket_types[str.upcase]
        end
      end

    end
  end
end
