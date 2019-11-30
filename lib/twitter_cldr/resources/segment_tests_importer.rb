# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'fileutils'

module TwitterCldr
  module Resources
    class SegmentTestsImporter < Importer

      TEST_FILES = [
        'ucd/auxiliary/WordBreakTest.txt',
        'ucd/auxiliary/SentenceBreakTest.txt',
        'ucd/auxiliary/GraphemeBreakTest.txt',
        'ucd/auxiliary/LineBreakTest.txt'
      ]

      requirement :unicode, Versions.unicode_version, TEST_FILES
      output_path 'shared/segments/tests'
      ruby_engine :mri

      def execute
        TEST_FILES.each do |test_file|
          import_test_file(test_file)
        end
      end

      private

      def import_test_file(test_file)
        source_file = source_path_for(test_file)
        FileUtils.mkdir_p(File.dirname(source_file))
        result = UnicodeFileParser.parse_standard_file(source_file).map(&:first)
        output_file = output_path_for(test_file)
        FileUtils.mkdir_p(File.dirname(output_file))
        File.write(output_file, YAML.dump(result))
      end

      def source_path_for(test_file)
        requirements[:unicode].source_path_for(test_file)
      end

      def output_path_for(test_file)
        file = underscore(File.basename(test_file).chomp(File.extname(test_file)))
        File.join(params.fetch(:output_path), "#{file}.yml")
      end

      def underscore(str)
        str.gsub(/(.)([A-Z])/, '\1_\2').downcase
      end

    end
  end
end
