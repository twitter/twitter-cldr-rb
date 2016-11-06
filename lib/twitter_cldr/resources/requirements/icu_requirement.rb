# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'open-uri'

module TwitterCldr
  module Resources
    module Requirements

      class IcuRequirement
        ICU_URL = "http://download.icu-project.org/files/icu4j/%{version}/icu4j-%{underscored_version}.jar"

        attr_reader :version

        def initialize(version)
          @version = version
        end

        def prepare
          unless File.file?(source_path)
            STDOUT.write("Downloading icu v#{version}... ")
            download
            puts 'done'
          end

          require 'java'
          require source_path

          puts "Using icu v#{version} from #{source_path}"
        end

        def source_path
          @source_path ||= File.join(
            TwitterCldr::VENDOR_DIR, "icu_v#{version}.jar"
          )
        end

        private

        def download
          open(source_path, 'wb') do |file|
            file << open(icu_url).read
          end
        end

        def icu_url
          ICU_URL % {
            version: version,
            underscored_version: underscored_version
          }
        end

        def underscored_version
          @underscored_version ||= version.gsub('.', '_')
        end
      end

    end
  end
end
