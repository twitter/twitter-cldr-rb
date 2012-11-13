# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'cldr/download'

module TwitterCldr
  module Resources

    CLDR_URL = 'http://unicode.org/Public/cldr/22.1/core.zip'

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
          puts "Downloading CLDR data from '#{url}' to '#{path}'."
          Cldr.download(url, path)
        end

        path
      end

    end

  end
end