# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Resources

    class ResourceLoadError < StandardError; end

    class Loader

      def get_resource(*path)
        resources_cache[resource_file_path(path)]
      end

      def get_locale_resource(locale, resource_name)
        get_resource(*locale_resource_path(locale, resource_name))
      end

      def resource_loaded?(*path)
        resources_cache.include?(resource_file_path(path))
      end

      def locale_resource_loaded?(locale, resource_name)
        resource_loaded?(*locale_resource_path(locale, resource_name))
      end

      def resource_types
        @resource_types ||= Dir.glob(File.join(RESOURCES_DIR, 'locales/en', '*')).map do |file|
          File.basename(file).chomp(File.extname(file)).to_sym
        end
      end

      def preload_resources_for_locale(locale, *resources)
        if resources.size > 0
          resources = resource_types if resources.first == :all
          resources.each { |res| get_locale_resource(locale, res) }
        end
        nil
      end

      def preload_resource_for_locales(resource, *locales)
        locales.each do |locale|
          preload_resources_for_locale(locale, resource)
        end
        nil
      end

      def preload_resources_for_all_locales(*resources)
        TwitterCldr.supported_locales.each do |locale|
          preload_resources_for_locale(locale, *resources)
        end
        nil
      end

      def preload_all_resources
        TwitterCldr.supported_locales.each do |locale|
          preload_resources_for_locale(locale, :all)
        end
        nil
      end

      private

      def locale_resource_path(locale, resource_name)
        [:locales, TwitterCldr.convert_locale(locale), resource_name]
      end

      def resources_cache
        @resources_cache ||= Hash.new { |hash, path| hash[path] = load_resource(path) }
      end

      def resource_file_path(path)
        "#{File.join(*path.map(&:to_s))}.yml"
      end

      def load_resource(path, merge_custom = true)
        base = YAML.load(read_resource_file(path))
        custom_path = File.join("custom", path)

        if merge_custom && resource_exists?(custom_path) && !TwitterCldr.disable_custom_locale_resources
          TwitterCldr::Utils.deep_merge!(base, load_resource(custom_path, false))
        end

        base
      end

      def resource_exists?(path)
        File.exist?(File.join(TwitterCldr::RESOURCES_DIR, path))
      end

      def read_resource_file(path)
        file_path = File.join(TwitterCldr::RESOURCES_DIR, path)

        if File.file?(file_path)
          File.read(file_path)
        else
          raise ResourceLoadError,
            "Resource '#{path}' not found."
        end
      end

    end

  end
end
