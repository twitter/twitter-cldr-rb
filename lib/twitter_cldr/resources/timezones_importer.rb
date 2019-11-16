# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'nokogiri'
require 'fileutils'
require 'parallel'
require 'etc'
require 'set'

module TwitterCldr
  module Resources

    class TimezonesImporter < Importer

      requirement :cldr, Versions.cldr_version
      output_path 'locales'
      locales TwitterCldr.supported_locales
      ruby_engine :mri

      private

      def execute
        locales = Set.new

        finish = -> (locale, *) do
          locales.add(locale)
          STDOUT.write "\rImported #{locale}, #{locales.size} of #{params[:locales].size} total"
        end

        Parallel.each(params[:locales], in_processes: Etc.nprocessors, finish: finish) do |locale|
          import_locale(locale)
          locales << locale
        end

        puts ''
      end

      def import_locale(locale)
        data = requirements[:cldr].merge_each_ancestor(locale) do |ancestor_locale|
          TimezoneData.new(ancestor_locale, requirements[:cldr]).to_h
        end

        output_file = File.join(output_path, locale.to_s, 'timezones.yml')

        File.open(output_file, 'w:utf-8') do |output|
          output.write(
            TwitterCldr::Utils::YAML.dump(
              TwitterCldr::Utils.deep_symbolize_keys(locale => data),
              use_natural_symbols: true
            )
          )
        end
      end

      def output_path
        params.fetch(:output_path)
      end


      class TimezoneData
        attr_reader :locale, :cldr_req

        def initialize(locale, cldr_req)
          @locale = locale
          @cldr_req = cldr_req
        end

        def to_h
          {
            formats: formats,
            timezones: timezones,
            metazones: metazones
          }
        end

        private

        def formats
          @formats ||= doc.xpath('ldml/dates/timeZoneNames/*').inject({}) do |result, format|
            if format.name.end_with?('Format')
              underscored_name = format.name.gsub(/([a-z])([A-Z])/, '\1_\2').downcase + 's'
              result[underscored_name] ||= {}

              type = if (type_attr = format.attribute('type'))
                type_attr.value
              else
                :generic
              end

              result[underscored_name][type] = format.text
            end

            result
          end
        end

        def timezones
          @timezones ||= doc.xpath('ldml/dates/timeZoneNames/zone').inject({}) do |result, zone|
            type = zone.attr('type').to_sym
            result[type] = {}
            long = nodes_to_hash(zone.xpath('long/*'))
            result[type][:long] = long unless long.empty?
            short = nodes_to_hash(zone.xpath('short/*'))
            result[type][:short] = short unless short.empty?
            city = zone.xpath('exemplarCity').first
            result[type][:city] = city.content if city
            result
          end
        end

        def metazones
          @metazones ||= doc.xpath('ldml/dates/timeZoneNames/metazone').inject({}) do |result, zone|
            type = zone.attr('type').to_sym
            result[type] = {}
            long = nodes_to_hash(zone.xpath('long/*'))
            result[type][:long] = long unless long.empty?
            short = nodes_to_hash(zone.xpath('short/*'))
            result[type][:short] = short unless short.empty?
            result
          end
        end

        def nodes_to_hash(nodes)
          nodes.inject({}) do |result, node|
            result[node.name.to_sym] = node.content
            result
          end
        end

        def doc
          @doc ||= begin
            locale_fs = locale.to_s.gsub('-', '_')
            Nokogiri.XML(File.read(File.join(cldr_main_path, "#{locale_fs}.xml")))
          end
        end

        def cldr_main_path
          @cldr_main_path ||= File.join(cldr_req.common_path, 'main')
        end
      end

    end
  end
end
