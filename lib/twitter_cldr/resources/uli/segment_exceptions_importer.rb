# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'twitter_cldr/resources/download'
require 'fileutils'
require 'json'

module TwitterCldr
  module Resources
    module Uli
      class SegmentExceptionsImporter

        URL = "http://unicode.org/uli/trac/export/58/trunk/abbrs/json/%{locale}.json"

        attr_reader :input_path, :output_path

        def initialize(input_path, output_path)
          @input_path  = input_path
          @output_path = output_path
        end

        def import(locales)
          FileUtils.mkdir_p(input_path)
          FileUtils.mkdir_p(output_path)
          locales.each { |locale| import_locale(locale) }
        end

        private

        def import_locale(locale)
          if input_file = download_resource_for(locale)
            output_file = File.join(output_path, "#{locale}.yml")
            exceptions = JSON.parse(File.read(input_file))

            File.open(output_file, "w+") do |f|
              YAML.dump({
                locale => {
                  exceptions: exceptions["data"]["abbrs"]
                }
              }, f)
            end
          end
        end

        def download_resource_for(locale)
          input_file = input_path_for(locale)
          TwitterCldr::Resources.download_if_necessary(
            input_file, URL.gsub("%{locale}", locale.to_s)
          )
          input_file
        end

        def input_path_for(locale)
          File.join(input_path, "#{locale}.json")
        end

      end
    end
  end
end
