# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'cgi'
require 'java'
require 'nokogiri'
require 'twitter_cldr/resources/download'

module TwitterCldr
  module Resources

    # This class should be used with JRuby 1.7 in 1.9 mode, ICU4J version >= 49.1
    class TailoringTestsImporter < IcuBasedImporter
      CLDR_URL = "http://unicode.org/cldr/trac/export/12161/tags/release-21-d02/test"

      # Arguments:
      #
      #   input_path  - path to a directory containing CLDR data
      #   output_path - output directory for imported YAML files
      #   icu4j_path  - path to ICU4J jar file
      #
      def initialize(input_path, output_path, icu4j_path)
        require_icu4j(icu4j_path)

        @input_path  = input_path
        @output_path = output_path
      end

      def import(locales)
        locales.each { |locale| import_locale(locale) }
      end

      private

      def import_locale(locale)
        download_test_for_locale_if_necessary(locale)

        if tailoring_test_present?(locale)
          doc = Nokogiri::XML(File.read(input_file_path(locale)))
          results = doc.xpath('//collation/result').flat_map do |result|
            CGI.unescapeHTML(result.text).split("\n")
          end

          results = results.uniq.reject(&:empty?)
          results = sort_results(locale, results)

          File.open(output_file_path(locale), 'w+') do |f|
            f.write(results.join("\n"))
          end
        end
      end

      def sort_results(locale, results)
        collator = Java::ComIbmIcuText::Collator.get_instance(
          Java::JavaUtil::Locale.new(locale.to_s)
        )

        results.sort { |a, b| collator.compare(a, b) }
      end

      def download_test_for_locale_if_necessary(locale)
        TwitterCldr::Resources.download_if_necessary(
          input_file_path(locale), "#{CLDR_URL}/#{locale}.xml"
        )
      end

      def tailoring_test_present?(locale)
        File.file?(input_file_path(locale))
      end

      def input_file_path(locale)
        File.join(@input_path, "#{locale}.xml")
      end

      def output_file_path(locale)
        File.join(@output_path, "#{locale}.txt")
      end

    end

  end
end
