# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Shared
    class Resources
      def initialize
        @resources_by_locale = Hash.new do |hash, locale|
          hash[locale] = Hash.new { |h, resource| h[resource] = data_for(locale, resource) }
        end
      end

      def resource_for(locale, resource)
        @resources_by_locale[locale.to_sym][resource]
      end

      protected

      def data_for(locale, resource)
        TwitterCldr::Utils.deep_symbolize_keys(YAML.load(File.read(TwitterCldr.get_resource_file(locale, resource))))
      end

    end
  end
end