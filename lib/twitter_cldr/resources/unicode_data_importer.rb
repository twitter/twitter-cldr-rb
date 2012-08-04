# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'lib/twitter_cldr/resources/download'

module TwitterCldr
  module Resources

    class UnicodeDataImporter

      BLOCKS_URL       = 'ftp://ftp.unicode.org/Public/UNIDATA/Blocks.txt'
      UNICODE_DATA_URL = 'ftp://ftp.unicode.org/Public/UNIDATA/UnicodeData.txt'

      # Arguments:
      #
      #   input_path  - path to a directory containing Blocks.txt and UnicodeData.txt
      #   output_path - output directory for imported YAML files
      #
      def initialize(input_path, output_path)
        @input_path  = input_path
        @output_path = output_path
      end

      def import
        blocks       = import_blocks
        unicode_data = import_unicode_data(blocks)

        File.open(File.join(@output_path, 'blocks.yml'), 'w') { |output| YAML.dump(blocks, output) }

        unicode_data.each do |block_name, code_points|
          File.open(File.join(@output_path, 'blocks', "#{block_name}.yml"), 'w') { |output| YAML.dump(code_points, output) }
        end
      end

      private

      def import_blocks
        blocks = {}

        File.open(blocks_file) do |input|
          input.each_line do |line|
            next unless line =~ /^([0-9A-F]+)\.\.([0-9A-F]+);(.+)$/

            range = ($1.hex..$2.hex)
            name  = block_name($3)

            blocks[name.to_sym] = range
          end
        end

        blocks
      end

      def import_unicode_data(blocks)
        unicode_data = Hash.new { |hash, key| hash[key] = Hash.new { |h, k| h[k] = {} } }

        File.open(unicode_data_file) do |input|
          input.each_line do |line|
            data = line.chomp.split(';', -1)
            data[0] = data[0].hex

            unicode_data[find_block(blocks, data[0]).first][data[0]] = data
          end
        end

        unicode_data
      end

      def unicode_data_file
        TwitterCldr::Resources.download_if_necessary(File.join(@input_path, 'UnicodeData.txt'), UNICODE_DATA_URL)
      end

      def blocks_file
        TwitterCldr::Resources.download_if_necessary(File.join(@input_path, 'Blocks.txt'), BLOCKS_URL)
      end

      def find_block(blocks, code_point)
        blocks.detect { |_, range| range.include?(code_point) }
      end

      def block_name(string)
        string.strip.downcase.gsub(/[\s-]/, '_')
      end

    end

  end
end