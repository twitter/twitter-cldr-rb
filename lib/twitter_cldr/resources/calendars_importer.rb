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

    class CalendarsImporter < Importer

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
          GregorianCalendar.new(ancestor_locale, requirements[:cldr]).to_h
        end

        output_file = File.join(output_path, locale.to_s, 'calendars.yml')

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


    class GregorianCalendar
      attr_reader :locale, :cldr_req

      def initialize(locale, cldr_req)
        @locale = locale
        @cldr_req = cldr_req
      end

      def to_h
        {
          calendars: {
            gregorian: {
              months:   contexts('month'),
              days:     contexts('day'),
              eras:     eras,
              quarters: contexts('quarter'),
              periods:  contexts('dayPeriod', group: "alt"),
              fields:   fields,
              formats: {
                date:     formats('date'),
                time:     formats('time'),
                datetime: formats('dateTime')
              },
              additional_formats: additional_formats
            }
          }
        }
      end

      private

      def calendar
        @calendar ||= doc.xpath('//ldml/dates/calendars/calendar[@type="gregorian"]').first
      end

      def contexts(kind, options = {})
        return {} unless calendar

        calendar.xpath("#{kind}s/#{kind}Context").each_with_object({}) do |node, result|
          context = node.attribute('type').value.to_sym
          result[context] = widths(node, kind, context, options)
        end
      end

      def widths(node, kind, context, options = {})
        node.xpath("#{kind}Width").each_with_object({}) do |node, result|
          width = node.attribute('type').value.to_sym
          result[width] = elements(node, kind, context, width, options)
        end
      end

      def elements(node, kind, context, width, options = {})
        aliased = node.xpath('alias').first

        if aliased
          alias_path = "#{node.path}/#{aliased.attribute('path').value}"
          elements(doc.xpath(alias_path).first, kind, context, width, options)
        else
          node.xpath(kind).each_with_object({}) do |node, result|
            key = node.attribute('type').value
            key = key =~ /^\d*$/ ? key.to_i : key.to_sym

            if options[:group] && found_group = node.attribute(options[:group])
              result[found_group.value] ||= {}
              result[found_group.value][key] = node.content
            else
              result[key] = node.content
            end
          end
        end
      end

      def periods
        am = calendar.xpath("am").first
        pm = calendar.xpath("pm").first

        {}.tap do |result|
          result[:am] = am.content if am
          result[:pm] = pm.content if pm
        end
      end

      def eras
        return {} unless calendar

        base_path = "#{calendar.path}/eras"
        keys = doc.xpath("#{base_path}/*").map { |node| node.name }

        keys.each_with_object({}) do |name, result|
          path = "#{base_path}/#{name}/*"
          key  = name.gsub('era', '').gsub(/s$/, '').downcase.to_sym
          result[key] = doc.xpath(path).each_with_object({}) do |node, ret|
            type = node.attribute('type').value.to_i rescue 0
            ret[type] = node.content
            ret
          end
        end
      end

      def formats(type)
        return {} unless calendar

        formats = calendar.xpath("#{type}Formats/#{type}FormatLength").each_with_object({}) do |node, result|
          key = node.attribute('type').value.to_sym rescue :format
          result[key] = pattern(node, type)
        end
        if default = default_format(type)
          formats = default.merge(formats)
        end
        formats
      end

      def additional_formats
        return {} unless calendar

        calendar.xpath("dateTimeFormats/availableFormats/dateFormatItem").each_with_object({}) do |node, result|
          key = node.attribute('id').value
          result[key] = node.content
        end
      end

      def default_format(type)
        if node = calendar.xpath("#{type}Formats/default").first
          key = node.attribute('choice').value.to_sym
          { :default => :"calendars.gregorian.formats.#{type.downcase}.#{key}" }
        end
      end

      def pattern(node, type)
        node.xpath("#{type}Format/pattern").each_with_object({}) do |node, result|
          pattern = node.content
          pattern = pattern.gsub('{0}', '{{time}}').gsub('{1}', '{{date}}') if type == 'dateTime'
          result[:pattern] = pattern
        end
      end

      def fields
        doc.xpath("//ldml/dates/fields/field").each_with_object({}) do |node, result|
          key  = node.attribute('type').value.to_sym
          name = node.xpath('displayName').first
          result[key] = name.content if name
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
