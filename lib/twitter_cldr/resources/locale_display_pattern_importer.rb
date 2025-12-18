# encoding: UTF-8

require 'nokogiri'

module TwitterCldr
  module Resources
    class LocaleDisplayPatternImporter < Importer
      requirement :cldr, Versions.cldr_version
      output_path 'locales'
      locales TwitterCldr.supported_locales
      ruby_engine :mri

      private

      def execute
        params[:locales].each do |locale|
          import_locale(locale)
        end
      end

      def import_locale(locale)
        data = requirements[:cldr].build_data(locale) do |ancestor_locale|
          LocaleDisplayPattern.new(ancestor_locale, requirements[:cldr]).to_h
        end

        output_file = File.join(output_path, locale.to_s, 'locale_display_pattern.yml')
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

      class LocaleDisplayPattern
        attr_reader :locale, :cldr_req

        def initialize(locale, cldr_req)
          @locale = locale
          @cldr_req = cldr_req
        end

        def to_h
          { locale_display_pattern: locale_display_pattern }
        end

        private

        def locale_display_pattern
          doc.xpath('//ldml/localeDisplayNames/localeDisplayPattern').each_with_object({}) do |node, result|
            %w[localePattern localeSeparator localeKeyTypePattern].each do |key|
              elem = node.xpath(key).first
              next unless elem
              result[underscore(key).to_sym] = elem.content
            end
          end
        end

        def underscore(str)
          str.gsub(/(.)([A-Z])/, '\1_\2').downcase
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
