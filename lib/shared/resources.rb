module TwitterCldr
  module Shared
    class Resources
      def initialize
        @resources_by_locale = {}
      end

      def resource_for(locale, resource)
        locale = locale.to_sym
        unless @resources_by_locale.include?(locale)
          @resources_by_locale[locale] = {}
        end

        unless @resources_by_locale[locale].include?(resource)
          @resources_by_locale[locale][resource] = data_for(locale, resource)
        end

        @resources_by_locale[locale][resource]
      end

      protected

      def data_for(locale, resource)
        deep_symbolize_keys(YAML.load(File.read(TwitterCldr.get_resource_file(locale, resource))))
      end

      # adapted from: http://snippets.dzone.com/posts/show/11121 (first comment)
      def deep_symbolize_keys(arg)
        case arg
          when Array then
            arg.map { |elem| deep_symbolize_keys(elem) }
          when Hash then
            Hash[
              arg.map do |key, value|
                k = key.is_a?(String) ? key.to_sym : key
                v = deep_symbolize_keys(value)
                [k, v]
              end]
          else
            arg
        end
      end
    end
  end
end