# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'nokogiri'

module TwitterCldr
  module Resources

    class PhoneCodesImporter < Importer
      TERRITORY_REGEXP = /^[A-Z]{2}$/

      requirement :cldr, Versions.cldr_version
      output_path 'shared'
      ruby_engine :mri

      private

      def execute
        doc = File.open(File.join(source_path)) do |file|
          Nokogiri::XML(file)
        end

        phone_codes = doc.xpath('//codesByTerritory').each_with_object({}) do |node, memo|
          territory = node.attr('territory')

          if territory =~ TERRITORY_REGEXP
            memo[territory.downcase.to_sym] = node.at_xpath('telephoneCountryCode').attr('code')
          end
        end

        phone_codes = Hash[phone_codes.sort_by(&:first)]
        File.write(output_path, YAML.dump(phone_codes))
      end

      def output_path
        File.join(params.fetch(:output_path), 'phone_codes.yml')
      end

      def source_path
        @source_path ||= File.join(
          requirements[:cldr].common_path, 'supplemental', 'telephoneCodeData.xml'
        )
      end
    end

  end
end
