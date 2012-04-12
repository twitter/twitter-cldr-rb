# encoding: UTF-8

module TwitterCldr
  module Shared
    class Resources
      def initialize
        @resources_by_locale = Hash.new { |hash, key| hash[key] = Hash.new { |h, k| h[k] = data_for(key, k) } }
      end

      def resource_for(locale, resource)
        @resources_by_locale[locale.to_sym][resource]
      end

      protected

      def data_for(locale, resource)
        deep_symbolize_keys(YAML.load(File.read(TwitterCldr.get_resource_file(locale, resource))))
      end

      # adapted from: http://snippets.dzone.com/posts/show/11121 (first comment)
      def deep_symbolize_keys(arg)
        case arg
          when Array
            arg.map { |elem| deep_symbolize_keys(elem) }
          when Hash
            Hash[arg.map { |k, v| [k.is_a?(String) ? k.to_sym : k, deep_symbolize_keys(v)] }]
          else
            arg
        end
      end
    end
  end
end