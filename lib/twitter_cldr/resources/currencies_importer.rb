# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0
$KCODE = 'UTF8' unless RUBY_VERSION >= '1.9'

require 'nokogiri'
require 'fileutils'
require 'ya2yaml'

require 'twitter_cldr/resources/download'

module TwitterCldr
  module Resources
    class CurrenciesImporter

      LOCALES_PATH = File.join('common', 'main')
      CURRENCY_TYPES_PATH = File.join('common', 'bcp47', 'currency.xml')
      SUPPLEMENTAL_DATA_PATH = File.join('common', 'supplemental', 'supplementalData.xml')

      # Arguments:
      #
      #   input_path  - path to a directory containing CLDR data
      #   output_path - output directory for generated YAML file
      #
      def initialize(input_path, output_path)
        @input_path  = input_path
        @output_path = output_path
      end

      def import
        TwitterCldr::Resources.download_cldr_if_necessary(@input_path)

        @currencies = {:root => {}}

        # Get all types
        currency_types_doc = File.open(File.join(@input_path, CURRENCY_TYPES_PATH)) { |file| Nokogiri::XML(file) }
        currency_types_doc.xpath('//ldmlBCP47/keyword/key/type').each do |node|
          code = node.attr('name').upcase.to_sym
          name = node.attr('description')
          @currencies[:root][code] = {
            :name => name
          }
        end

        # Get default symbols
        root = File.open(File.join(@input_path, LOCALES_PATH, "root.xml")) { |file| Nokogiri::XML(file) }
        root.xpath('//currencies/currency').each do |node|
          code = node.attr('type').upcase.to_sym
          symbol = node.xpath("./symbol").inner_html
          @currencies[:root][code][:symbol] = symbol
        end

        Dir.foreach(File.join(@input_path, LOCALES_PATH)) do |filename|
          next if File.file?(File.join(@input_path, LOCALES_PATH, filename)) == false
          import_per_locale(File.basename(filename, ".xml"))
        end
      end

      def import_per_locale(current_locale)
        this_currencies = {}
        get_currencies(current_locale).each_pair do |code, data|
          this_currencies[code] ||= {}
          data.each_pair do |k, v|
            this_currencies[code][k] ||= v
          end
        end

        return if this_currencies.size == 0

        FileUtils.mkdir_p File.join(@output_path, current_locale)

        this_currencies = Hash[this_currencies.sort_by{|a,b| a.to_s <=> b.to_s}]
        File.open(File.join(@output_path, current_locale, 'currencies.yml'), 'w') do |output|
          output.write(this_currencies.ya2yaml(:syck_compatible => true, :use_natural_symbols => true))
        end
      end

      def get_currencies(locale)
        locale = locale.to_sym
        return @currencies[locale] if @currencies[locale]

        @currencies[locale] = {}

        root = File.open(File.join(@input_path, LOCALES_PATH, "#{locale}.xml")) { |file| Nokogiri::XML(file) }
        root.xpath('//currencies/currency').each do |node|
          code = node.attr('type').upcase.to_sym

          @currencies[locale][code] ||= {}

          symbol = node.xpath("./symbol")
          @currencies[locale][code][:symbol] = symbol.inner_html if symbol and symbol.inner_html  != ""

          name = node.xpath("./displayName").first
          @currencies[locale][code][:name] = name.inner_html if name and name.inner_html != ""

          if @currencies[locale][code].size == 0
            @currencies[locale].delete(code)
          end
        end

        @currencies[locale]
      end
    end
  end
end