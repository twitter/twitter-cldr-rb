# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'nokogiri'

require 'twitter_cldr/resources/download'

module TwitterCldr
  module Resources

    class PhoneCodesImporter

      PHONE_CODES_PATH = File.join('common', 'supplemental', 'telephoneCodeData.xml')

      TERRITORY_REGEXP = /^[A-Z]{2}$/

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

        doc = File.open(File.join(@input_path, PHONE_CODES_PATH)) { |file| Nokogiri::XML(file) }

        phone_codes = doc.xpath('//codesByTerritory').inject({}) do |memo, node|
          territory = node.attr('territory')
          memo[territory.downcase.to_sym] = node.at_xpath('telephoneCountryCode').attr('code') if territory =~ TERRITORY_REGEXP
          memo
        end

        phone_codes = Hash[phone_codes.sort_by(&:first)]

        File.open(File.join(@output_path, 'phone_codes.yml'), 'w') { |output| output.write(YAML.dump(phone_codes)) }
      end

    end

  end
end