# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'twitter_cldr/resources/download'

module TwitterCldr
  module Resources

    class UnicodeDataImporter < UnicodeImporter

      BLOCKS_URL           = 'ftp://ftp.unicode.org/Public/UNIDATA/Blocks.txt'
      UNICODE_DATA_URL     = 'ftp://ftp.unicode.org/Public/UNIDATA/UnicodeData.txt'
      CASEFOLDING_DATA_URL = 'ftp://ftp.unicode.org/Public/UNIDATA/CaseFolding.txt'

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
        blocks           = import_blocks
        unicode_data     = import_unicode_data(blocks)
        casefolding_data = import_casefolding_data
        index_data       = build_indices(
          TwitterCldr::Shared::CodePoint::INDICES, unicode_data
        )

        File.open(File.join(@output_path, 'blocks.yml'), 'w') do |output|
          YAML.dump(blocks, output)
        end

        FileUtils.mkdir_p(File.join(@output_path, 'blocks'))

        unicode_data.each do |block_name, code_points|
          File.open(File.join(@output_path, 'blocks', "#{block_name}.yml"), 'w') do |output|
            YAML.dump(code_points, output)
          end
        end

        File.open(File.join(@output_path, 'casefolding.yml'), 'w') do |output|
          YAML.dump(casefolding_data, output)
        end

        FileUtils.mkdir_p(File.join(@output_path, 'indices'))

        indices = index_data

        indices.each_pair do |index_name, data|
          File.open(File.join(@output_path, "indices", "#{index_name}.yml"), 'w') do |output|
            YAML.dump(data, output)
          end
        end

        File.open(File.join(@output_path, "indices", "keys.yml"), 'w') do |output|
          YAML.dump(
            indices.inject({}) do |ret, (index_name, data)|
              data.keys.each do |prop|
                ret[prop] ||= []
                ret[prop] << index_name
              end
              ret
            end, output
          )
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

        parse_standard_file(unicode_data_file) do |data|
          data[0] = data[0].hex
          unicode_data[find_block(blocks, data[0]).first][data[0]] = data
        end

        unicode_data
      end

      def import_casefolding_data
        parse_standard_file(casefold_data_file).map do |data|
          {
            :source => data[0].hex,
            :target => data[2].split(" ").map(&:hex),
            :status => data[1]
          }
        end
      end

      def build_indices(indices, unicode_data)
        indices.inject({}) do |index_ret, index_name|
          field_index = TwitterCldr::Shared::CODE_POINT_FIELDS.find_index do |field|
            field == index_name
          end

          index_ret[index_name] = Hash.new { |hash, key| hash[key] = [] }

          unicode_data.each_pair do |block_name, block_data|
            block_data.each_pair do |code_point, data|
              index_ret[index_name][data[field_index].to_sym] << code_point
            end
          end

          index_ret
        end.inject({}) do |index_ret, (index_key, index_data)|
          index_ret[index_key] = index_data.inject({}) do |field_ret, (field_key, field_data)|
            field_ret[field_key] = TwitterCldr::Utils::RangeSet.rangify(field_data)
            field_ret
          end
          index_ret
        end
      end

      def casefold_data_file
        TwitterCldr::Resources.download_if_necessary(File.join(@input_path, 'CaseFolding.txt'), CASEFOLDING_DATA_URL)
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