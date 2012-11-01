# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'nokogiri'

require 'twitter_cldr/resources/download'

module TwitterCldr
  module Resources

    class CurrencyDigitsAndRoundingImporter

      SUPPLEMENTAL_DATA_PATH = File.join('common', 'supplemental', 'supplementalData.xml')

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

        doc = File.open(File.join(@input_path, SUPPLEMENTAL_DATA_PATH)) { |file| Nokogiri::XML(file) }

        currency_digits_and_rounding = doc.xpath('//currencyData/fractions/info').inject({}) do |memo, node|
          code = node.attr('iso4217')
          digits = node.attr('digits').to_i
          rounding = node.attr('rounding').to_i

          memo[code.upcase.to_sym] = { :digits => digits, :rounding => rounding }
          memo
        end

        currency_digits_and_rounding = Hash[currency_digits_and_rounding.sort_by{|a,b| a.to_s <=> b.to_s}]

        File.open(File.join(@output_path, 'currency_digits_and_rounding.yml'), 'w') { |output| output.write(YAML.dump(currency_digits_and_rounding)) }
      end

    end

  end
end