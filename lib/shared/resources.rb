module TwitterCldr
  module Shared
    class Resources
      def initialize
        @resources_by_locale = {}
      end

      def resource_for(locale, resource)
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
        YAML.load(File.read(TwitterCldr.get_resource_file(locale, resource))).deep_symbolize_keys!
      end
    end
  end
end