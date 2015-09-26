# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'twitter_cldr/resources/download'

module TwitterCldr
  module Resources

    class UnicodeScriptsImporter < UnicodeImporter
      SCRIPTS_URL = 'ftp://ftp.unicode.org/Public/UNIDATA/Scripts.txt'

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
        File.open(@output_path, 'w+') do |f|
          f.write(YAML.dump(parse_scripts))
        end
      end

      protected

      def parse_scripts
        flatten(
          Hash.new { |h, k| h[k] = TwitterCldr::Utils::RangeSet.new([]) }.tap do |ret|
            parse_standard_file(scripts_data_file) do |data|
              range = parse_range(data[0])
              script_name = data[1]
              ret[script_name] << range
            end
          end
        )
      end

      def flatten(script_hash)
        script_hash.each_with_object({}) do |(script_name, range_set), ret|
          ret[script_name] = range_set.to_a(false)
        end
      end

      def parse_range(str)
        if idx = str.index('..')
          first = str[0..idx].to_i(16)
          second = str[(idx + 2)..-1].to_i(16)
          Range.new(first, second)
        else
          num = str.to_i(16)
          (num..num)
        end
      end

      def scripts_data_file
        TwitterCldr::Resources.download_if_necessary(
          File.join(@input_path, 'Scripts.txt'), SCRIPTS_URL
        )
      end
    end

  end
end
