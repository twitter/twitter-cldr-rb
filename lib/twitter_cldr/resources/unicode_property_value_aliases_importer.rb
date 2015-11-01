# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'twitter_cldr/resources/download'

module TwitterCldr
  module Resources

    class UnicodePropertyValueAliasesImporter < UnicodeImporter
      SCRIPTS_URL = 'ftp://ftp.unicode.org/Public/UNIDATA/PropertyValueAliases.txt'

      # Arguments:
      #
      #   input_path  - path to a directory containing Scripts.txt
      #   output_path - output directory for imported YAML files
      #
      def initialize(input_path, output_path)
        @input_path  = input_path
        @output_path = output_path
      end

      def import
        File.write(@output_path, YAML.dump(parse_property_value_aliases))
      end

      private

      def parse_property_value_aliases
        Hash.new { |h, k| h[k] = [] }.tap do |result|
          parse_standard_file(scripts_data_file) do |data|
            property = data[0]
            result[property.to_sym] << if property == 'ccc'
              parse_ccc_alias(data)
            else
              parse_alias(data)
            end
          end
        end
      end

      def parse_alias(data)
        {
          abbreviated_name: data[1],
          long_name: data[2]
        }
      end

      def parse_ccc_alias(data)
        {
          numeric: data[1],  # don't know what this means
          abbreviated_name: data[2],
          long_name: data[3]
        }
      end

      def scripts_data_file
        TwitterCldr::Resources.download_if_necessary(
          File.join(@input_path, 'PropertyValueAliases.txt'), SCRIPTS_URL
        )
      end
    end

  end
end
