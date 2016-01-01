# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'twitter_cldr/resources/download'
require 'fileutils'

module TwitterCldr
  module Resources
    class SegmentTestsImporter < UnicodeImporter

      URL_ROOT = "ucd/auxiliary"
      TEST_FILES = [
        'WordBreakTest.txt', 'SentenceBreakTest.txt'
      ]

      attr_reader :input_path, :output_path

      def initialize(input_path, output_path)
        @input_path  = input_path
        @output_path = output_path
      end

      def import
        FileUtils.mkdir_p(input_path)
        FileUtils.mkdir_p(output_path)

        TEST_FILES.each do |test_file|
          import_test_file(test_file)
        end
      end

      private

      def import_test_file(test_file)
        url = "#{URL_ROOT}/#{test_file}"
        input_file = input_file_for(test_file)
        output_file = output_path_for(test_file)
        download(input_file, url)
        result = parse_standard_file(input_file).map(&:first)
        File.write(output_file, YAML.dump(result))
      end

      def input_file_for(test_file)
        File.join(input_path, test_file)
      end

      def output_path_for(test_file)
        base = underscore(test_file.chomp(File.extname(test_file)))
        File.join(output_path, "#{base}.yml")
      end

      def download(input_file, url)
        TwitterCldr::Resources.download_unicode_data_if_necessary(
          input_file, url
        )
      end

      def underscore(str)
        str.gsub(/(.)([A-Z])/, '\1_\2').downcase
      end

    end
  end
end
