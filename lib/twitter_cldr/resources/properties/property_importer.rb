# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'twitter_cldr/resources/download'

module TwitterCldr
  module Resources
    module Properties

      class PropertyImporter < UnicodeImporter
        attr_reader :input_path, :property_name
        attr_reader :data_url, :data_path, :database

        def initialize(options)
          @input_path = options.fetch(:input_path)
          @property_name = options.fetch(:property_name)
          @data_url = options.fetch(:data_url)
          @data_path = options.fetch(:data_path)
          @database = options.fetch(:database)
        end

        def import
          load.each_pair do |property_name, property_values|
            property_values.each_pair do |property_value, ranges|
              database.store(property_name, property_value, ranges)
            end
          end
        end

        private

        def load
          results = Hash.new do |h, k|
            h[k] = Hash.new { |h, k| h[k] = [] }
          end

          rangify_hash(
            parse_standard_file(data_file).each_with_object(results) do |data, ret|
              next unless data[0].size > 0

              if block_given?
                yield data, ret
              else
                code_points = expand_range(data[0])
                property_value = format_property_value(data[1])
                ret[property_name][property_value] += code_points
              end
            end
          )
        end

        def rangify_hash(hash)
          hash.each_with_object({}) do |(key, value), ret|
            ret[key] = case value
              when Hash
                rangify_hash(value)
              when Array
                TwitterCldr::Utils::RangeSet.from_array(value)
            end
          end
        end

        def expand_range(str)
          initial, final = str.split("..")
          (initial.to_i(16)..(final || initial).to_i(16)).to_a
        end

        def format_property_value(value)
          value
        end

        def data_file
          TwitterCldr::Resources.download_unicode_data_if_necessary(
            File.join(input_path, data_path), data_url
          )
        end
      end

    end
  end
end
