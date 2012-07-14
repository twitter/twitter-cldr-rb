# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Resources

    class Loader

      def get_resource(*path)
        resources_cache[resource_file_path(path)]
      end

      def get_locale_resource(locale, resource_name)
        get_resource(:locales, TwitterCldr.convert_locale(locale), resource_name)
      end

      private

      def resources_cache
        @resources_cache ||= Hash.new { |hash, path| hash[path] = load_resource(path) }
      end

      def resource_file_path(path)
        "#{File.join(*path.map(&:to_s))}.yml"
      end

      def load_resource(path)
        TwitterCldr::Utils.deep_symbolize_keys(YAML.load(read_resource_file(path)))
      end

      def read_resource_file(path)
        file_path = File.join(TwitterCldr::RESOURCES_DIR, path)

        if File.file?(file_path)
          File.read(file_path)
        else
          raise ArgumentError.new("Resource '#{path}' not found.")
        end
      end

    end

  end
end