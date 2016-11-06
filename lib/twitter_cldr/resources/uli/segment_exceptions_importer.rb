# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'fileutils'
require 'open-uri'
require 'json'

module TwitterCldr
  module Resources
    module Uli
      class SegmentExceptionsImporter < Resources::Importer

        URL = "http://unicode.org/uli/trac/export/58/trunk/abbrs/json/%{locale}.json"
        LOCALES = [:de, :en, :es, :fr, :it, :pt, :ru]   # these are the only locales ULI supports at the moment

        output_path 'uli/segments'
        ruby_engine :mri

        def execute
          FileUtils.mkdir_p(input_path)
          FileUtils.mkdir_p(output_path)
          LOCALES.each { |locale| import_locale(locale) }
        end

        private

        def output_path
          params.fetch(:output_path)
        end

        def import_locale(locale)
          if input_file = download_resource_for(locale)
            output_file = File.join(output_path, "#{locale}.yml")
            exceptions = JSON.parse(File.read(input_file))

            File.open(output_file, 'w+') do |f|
              YAML.dump({
                locale => {
                  exceptions: exceptions['data']['abbrs']
                }
              }, f)
            end
          end
        end

        def download_resource_for(locale)
          input_file = input_file_for(locale)
          url = URL % { locale: locale }

          unless File.file?(input_file)
            STDOUT.write("Downloading #{url}... ")
            open(input_file, 'wb') { |file| file << open(url).read }
            puts 'done'
          end

          input_file
        end

        def input_path
          @input_path ||= File.join(
            TwitterCldr::VENDOR_DIR, 'uli', 'segments'
          )
        end

        def input_file_for(locale)
          File.join(input_path, "#{locale}.json")
        end

      end
    end
  end
end
