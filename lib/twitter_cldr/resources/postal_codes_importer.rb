# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'rest-client'
require 'json'
require 'yaml'

module TwitterCldr
  module Resources

    class PostalCodesImporter

      BASE_URL = 'http://i18napis.appspot.com/address/data/'

      # Arguments:
      #
      #   output_path - output directory for generated YAML file
      #
      def initialize(output_path)
        @output_path = output_path
      end

      def import
        File.open(File.join(@output_path, 'postal_codes.yml'), 'w') do |output|
          output.write(YAML.dump(load))
        end
      end

      private

      def load
        each_territory.each_with_object({}) do |territory, ret|
          next unless regex = get_regex_for(territory)

          ret[territory] = {
            regex: Regexp.compile(regex),
            ast: TwitterCldr::Utils::RegexpAst.dump(
              RegexpAstGenerator.generate(regex)
            )
          }
        end
      end

      def get_regex_for(territory)
        result = RestClient.get("#{BASE_URL}#{territory.to_s.upcase}")
        data = JSON.parse(result.body)
        data['zip']
      end

      def each_territory
        if block_given?
          TwitterCldr::Shared::Territories.all.each_pair do |territory, _|
            yield territory
          end
        else
          to_enum(__method__)
        end
      end

    end

  end
end
