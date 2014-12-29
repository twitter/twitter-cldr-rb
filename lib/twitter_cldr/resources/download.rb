# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Resources

    CLDR_URL = 'http://unicode.org/Public/cldr/26/core.zip'
    ICU4J_URL = 'http://download.icu-project.org/files/icu4j/54.1/icu4j-54_1.jar'

    # Use these instead to update collation and tailoring data
    # CLDR_URL = 'http://unicode.org/Public/cldr/23.1/core.zip'
    # ICU4J_URL = 'http://download.icu-project.org/files/icu4j/51.2/icu4j-51_2.jar'

    class << self

      def download_if_necessary(path, url)
        if File.file?(path)
          puts "Using '#{path}'."
        else
          puts "Downloading '#{url}' to '#{path}'."
          FileUtils.mkdir_p(File.dirname(path))
          system("curl #{url} -o #{path}")
        end

        path
      end

      def download_cldr_if_necessary(path, url = CLDR_URL)
        if File.directory?(path)
          puts "Using CLDR data from '#{path}'."
        else
          begin
            require 'zip'
          rescue LoadError
            raise StandardError.new("Unable to require 'zip'. Please switch to at least Ruby 1.9, then rebundle and try again.")
          end

          require 'cldr/download'

          puts "Downloading CLDR data from '#{url}' to '#{path}'."
          Cldr.download(url, path)
        end

        path
      end

      def download_icu4j_if_necessary(path, url = ICU4J_URL)
        download_if_necessary(path, url)
        path
      end

    end

  end
end
