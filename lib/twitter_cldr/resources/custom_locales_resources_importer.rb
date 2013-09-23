# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'json'
require 'open-uri'

module TwitterCldr
  module Resources

    class CustomLocalesResourcesImporter

      API_ENDPOINT = "http://translate.twitter.com/api/2/twitter/phrase/%s/translations.json"

      TIME_PERIODS = {
        :day    => 19636,
        :hour   => 19638,
        :minute => 19634,
        :second => 19639
      }

      # Arguments:
      #
      #   output_path - output directory for imported YAML files
      #
      def initialize(output_path)
        @output_path = output_path
      end

      def import
        total = TwitterCldr.supported_locales.size
        TwitterCldr.supported_locales.each.with_index do |locale, idx|
          import_units(locale)
          yield idx, total, locale if block_given?
        end
      end

      private

      def import_units(locale)
        fetch_units_data(locale).each do |data|
          dir_path = File.join(@output_path, locale.to_s)

          FileUtils.mkpath(dir_path)

          File.open(File.join(dir_path, 'units.yml'), 'w:utf-8') do |output|
            output.write(YAML.dump({ locale => data }))
          end
        end
      end

      def fetch_units_data(locale)
        TIME_PERIODS.inject({}) do |result, (label, id)|
          api_response = JSON.parse(open(API_ENDPOINT % id).read)
          twitter_locale = TwitterCldr.twitter_locale(locale).to_s

          if api_response[twitter_locale]
            if patterns = TwitterCldr::Formatters::Plurals::Rules.all_for(locale)
              patterns = patterns.inject({}) do |memo, rule|
                memo[rule] = api_response[twitter_locale].gsub("%{number}", "{0}"); memo
              end

              set_value(result, patterns, locale, :units, label, :abbreviated)
            end
          end

          result
        end
      end

      def set_value(hash, value, *path)
        last = path[0..-2].inject(hash) do |current, level|
          current[level] ||= {}
        end

        last[path.last] = value
      end

    end

  end
end