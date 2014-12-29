# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'twitter_cldr/resources/download'

module TwitterCldr
  module Resources

    class UnicodePropertiesImporter < UnicodeImporter

      PROPERTIES_BASE_URL = 'ftp://ftp.unicode.org/Public/UCD/latest/ucd'
      PROPERTIES = [
        "auxiliary/SentenceBreakProperty",
        "auxiliary/WordBreakProperty",
        "LineBreak"
      ]

      # Arguments:
      #
      #   input_path  - path to a directory containing the various property files
      #   output_path - output directory for imported YAML files
      #
      def initialize(input_path, output_path)
        @input_path  = input_path
        @output_path = output_path
      end

      def import
        FileUtils.mkdir_p(@output_path)

        PROPERTIES.each do |property|
          input_file = property_data_file("#{property}.txt")
          output_file = File.join(@output_path, "#{fix_name(property)}.yml")

          File.open(output_file, "w+") do |f|
            f.write(
              YAML.dump(
                parse_standard_file(input_file).inject({}) do |ret, data|
                  name = data[1].strip.to_sym
                  ret[name] ||= []
                  ret[name] += expand_range(data[0])
                  ret
                end.inject({}) do |ret, (key, data)|
                  ret[key] = TwitterCldr::Utils::RangeSet.rangify(data)
                  ret
                end
              )
            )
          end
        end
      end

      private

      def fix_name(str)
        underscore(File.basename(str.gsub("Property", "")))
      end

      def underscore(str)
        str.gsub(/([a-z])([A-Z])/, '\1_\2').downcase
      end

      def expand_range(str)
        initial, final = str.split("..")
        (initial.to_i(16)..(final || initial).to_i(16)).to_a
      end

      def property_data_file(file)
        TwitterCldr::Resources.download_if_necessary(
          File.join(@input_path, File.basename(file)), File.join(PROPERTIES_BASE_URL, file)
        )
      end

    end

  end
end