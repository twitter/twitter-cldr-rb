# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'uri'
require 'open-uri'
require 'zip'

module TwitterCldr
  module Resources
    module Requirements

      class CldrRequirement
        CLDR_URL = "http://unicode.org/Public/cldr/%{version}/core.zip"

        attr_reader :version

        def initialize(version)
          @version = version
        end

        def prepare
          # download and unzip if source directory doesn't exist
          unless File.directory?(source_path)
            STDOUT.write("Downloading cldr v#{version}... ")
            download
            puts 'done'
          end

          puts "Using cldr v#{version} from #{source_path}"
        end

        def source_path
          @source_path ||= File.join(TwitterCldr::VENDOR_DIR, "cldr_v#{version}")
        end

        def common_path
          File.join(source_path, 'common')
        end

        private

        def cldr_url
          CLDR_URL % { version: version }
        end

        def download
          URI.parse(cldr_url).open do |tempfile|
            FileUtils.mkdir_p(source_path)
            Zip.on_exists_proc = true

            Zip::File.open(tempfile.path) do |file|
              file.each do |entry|
                path = File.join(source_path, entry.name)
                FileUtils.mkdir_p(File.dirname(path))
                file.extract(entry, path)
              end
            end
          end
        end
      end

    end
  end
end
