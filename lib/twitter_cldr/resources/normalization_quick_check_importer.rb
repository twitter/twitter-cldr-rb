# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'twitter_cldr/resources/download'

module TwitterCldr
  module Resources

    class NormalizationQuickCheckImporter

      PROPS_FILE_URL = "ftp://ftp.unicode.org/Public/UNIDATA/DerivedNormalizationProps.txt"

      # Arguments:
      #
      #   input_path  - path to a directory containing DerivedNormalizationProps.txt
      #   output_path - output directory for imported YAML files
      #
      def initialize(input_path, output_path)
        @input_path  = input_path
        @output_path = output_path
      end

      def import
        parse_props_file.each_pair do |algorithm, code_point_list|
          File.open(File.join(@output_path, "#{algorithm.downcase}_quick_check.yml"), "w+") do |f|
            f.write(YAML.dump(TwitterCldr::Utils::RangeSet.rangify(code_point_list)))
          end
        end
      end

      private

      def parse_props_file
        check_table = {}
        cur_type = nil

        File.open(props_file) do |input|
          input.each_line do |line|
            cur_type = nil if line =~ /=Maybe/
            type = line.scan(/#\s*Property:\s*(NF[KDC]+)_Quick_Check/).flatten

            if type.size > 0
              cur_type = type.first
              check_table[cur_type] = []
            end

            if check_table.size > 0 && line[0...1] != "#" && !line.strip.empty? && cur_type
              start, finish = line.scan(/(\h+(\.\.\h+)?)/).first.first.split("..").map { |num| num.to_i(16) }

              if finish
                check_table[cur_type] += (start..finish).to_a
              else
                check_table[cur_type] << start
              end
            end

            break if line =~ /={5,}/ && check_table.size >= 4 && check_table.all? { |key, val| val.size > 0 }
          end
        end

        check_table
      end

      def props_file
        TwitterCldr::Resources.download_if_necessary(File.join(@input_path, 'DerivedNormalizationProps.txt'), PROPS_FILE_URL)
      end

    end

  end
end