# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'rest-client'
require 'json'
require 'set'
require 'yaml'

module TwitterCldr
  module Resources

    class PostalCodesImporter < Importer

      BASE_URL = 'https://i18napis.appspot.com/address/data/'

      output_path 'shared'
      ruby_engine :mri

      private

      def execute
        File.open(File.join(output_path, 'postal_codes.yml'), 'w') do |output|
          output.write(YAML.dump(load))
        end
      end

      def output_path
        params.fetch(:output_path)
      end

      def load
        territories = Set.new

        each_territory.each_with_object({}) do |territory, ret|
          next unless regex = get_regex_for(territory)

          ret[territory] = {
            regex: Regexp.compile(regex),
            ast: TwitterCldr::Utils::RegexpAst.dump(
              RegexpAstGenerator.generate(regex)
            )
          }

          territories.add(territory)
          STDOUT.write("\rImported postal codes for #{territory}, #{territories.size} of #{territory_count} total")
        end

        puts
      end

      def get_regex_for(territory)
        result = RestClient.get("#{BASE_URL}#{territory.to_s.upcase}")
        data = JSON.parse(result.body)
        data['zip']
      end

      def territory_count
        TwitterCldr::Shared::Territories.all.size
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
