
# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Resources
    module Properties

      class PropertiesImporter

        IMPORTERS = [
          AgePropertyImporter,
          # ArabicShapingPropertyImporter,  # added in later version of unicode (we're not there yet)
          # BidiBracketsPropertyImporter,   # added in later version of unicode (we're not there yet)
          BlocksPropertyImporter,
          DerivedCorePropertiesImporter,
          EastAsianWidthPropertyImporter,
          GraphemeBreakPropertyImporter,
          HangulSyllableTypePropertyImporter,
          IndicPositionalCategoryPropertyImporter,
          IndicSyllabicCategoryPropertyImporter,
          JamoPropertyImporter,
          LineBreakPropertyImporter,
          PropListImporter,
          ScriptExtensionsPropertyImporter,
          ScriptPropertyImporter,
          SentenceBreakPropertyImporter,
          UnicodeDataPropertiesImporter,
          WordBreakPropertyImporter
        ]

        attr_reader :input_path, :output_path, :database

        # Arguments:
        #
        #   input_path  - path to a directory containing the various property files
        #   output_path - output directory for imported YAML directory structure
        #
        def initialize(input_path, output_path)
          @input_path  = input_path
          @output_path = output_path
          @database = TwitterCldr::Shared::PropertiesDatabase.new(
            output_path
          )
        end

        def import
          IMPORTERS.each do |importer|
            importer.new(input_path, database).import
          end
        end

      end

    end
  end
end
