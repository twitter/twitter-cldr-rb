# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'twitter_cldr/resources/download'

module TwitterCldr
  module Resources

    class UnicodePropertyAliasesImporter < UnicodeImporter
      PROPERTY_ALIASES_URL = 'ucd/PropertyAliases.txt'
      PROPERTY_VALUE_ALIASES_URL = 'ucd/PropertyValueAliases.txt'

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
        File.write(
          File.join(@output_path, 'property_value_aliases.yml'),
          YAML.dump(parse_property_value_aliases)
        )

        File.write(
          File.join(@output_path, 'property_aliases.yml'),
          YAML.dump(parse_property_aliases)
        )
      end

      private

      def parse_property_aliases
        Hash.new { |h, k| h[k] = [] }.tap do |result|
          parse_standard_file(property_aliases_data_file) do |data|
            property = data[0]
            result[property] = parse_alias(data)
          end
        end
      end

      def parse_property_value_aliases
        Hash.new { |h, k| h[k] = [] }.tap do |result|
          parse_standard_file(property_value_aliases_data_file) do |data|
            property_value = data[0]
            result[property_value] << if property_value == 'ccc'
              parse_ccc_value_alias(data)
            else
              parse_value_alias(data)
            end
          end
        end
      end

      def parse_alias(data)
        {
          long_name: data[1],
          additional: data[2..-1]
        }
      end

      def parse_value_alias(data)
        {
          abbreviated_name: data[1],
          long_name: data[2]
        }
      end

      def parse_ccc_value_alias(data)
        {
          numeric: data[1],  # don't know what this means
          abbreviated_name: data[2],
          long_name: data[3]
        }
      end

      def property_aliases_data_file
        TwitterCldr::Resources.download_unicode_data_if_necessary(
          File.join(@input_path, 'PropertyAliases.txt'), PROPERTY_ALIASES_URL
        )
      end

      def property_value_aliases_data_file
        TwitterCldr::Resources.download_unicode_data_if_necessary(
          File.join(@input_path, 'PropertyValueAliases.txt'), PROPERTY_VALUE_ALIASES_URL
        )
      end
    end

  end
end
