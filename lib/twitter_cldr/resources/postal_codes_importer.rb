# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'nokogiri'

require 'twitter_cldr/resources/download'

module TwitterCldr
  module Resources

    class PostalCodesImporter

      POSTAL_CODES_PATH = File.join('common', 'supplemental', 'postalCodeData.xml')

      # Arguments:
      #
      #   input_path  - path to a directory containing CLDR data
      #   output_path - output directory for generated YAML file
      #
      def initialize(input_path, output_path)
        @input_path  = input_path
        @output_path = output_path
      end

      def import
        TwitterCldr::Resources.download_cldr_if_necessary(@input_path)

        doc = File.open(File.join(@input_path, POSTAL_CODES_PATH)) { |file| Nokogiri::XML(file) }

        postal_codes = doc.xpath('//postCodeRegex').inject({}) do |memo, node|
          memo[node.attr('territoryId').downcase.to_sym] = Regexp.new(node.text); memo
        end

        postal_codes = Hash[postal_codes.sort_by(&:first)]

        postal_codes = postal_codes.each_with_object({}) do |(territory, regex), memo|
          memo[territory] = {
            :regex => regex,
            :ast => TwitterCldr::Utils::RegexpAst.dump(
              RegexpAstGenerator.generate(regex.source)
            )
          }
        end

        File.open(File.join(@output_path, 'postal_codes.yml'), 'w') do |output|
          output.write(YAML.dump(postal_codes))
        end
      end

    end

  end
end