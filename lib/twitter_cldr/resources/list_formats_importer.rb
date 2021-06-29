# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'nokogiri'
require 'parallel'
require 'etc'
require 'set'

module TwitterCldr
  module Resources

    class ListFormatsImporter < Importer

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
      end

      def import_locale(locale)
        data = requirements[:cldr].merge_each_ancestor(locale) do |ancestor_locale|
          ListFormats.new(ancestor_locale, requirements[:cldr]).to_h
        end

        output_file = File.join(output_path, locale.to_s, 'lists.yml')

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

    end


    class ListFormats

      attr_reader :locale, :cldr_req

      def initialize(locale, cldr_req)
        @locale = locale
        @cldr_req = cldr_req
      end

      def to_h
        { lists: lists }
      end

      def lists
        doc.xpath('//ldml/listPatterns/listPattern').each_with_object({}) do |pattern_node, pattern_result|
          pattern_type = if attribute = pattern_node.attribute('type')
            attribute.value.to_sym
          else
            :default
          end

          if aliased = pattern_node.xpath('alias').first
            alias_type = aliased.attribute('path').value[/@type='([\w-]+)'/, 1]
            pattern_result[pattern_type] = :"lists.#{alias_type || 'default'}"
            next
          end

          pattern_result[pattern_type] = pattern_node.xpath('listPatternPart').each_with_object({}) do |type_node, type_result|
            type_result[type_node.attribute('type').value.to_sym] = type_node.content
          end
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
