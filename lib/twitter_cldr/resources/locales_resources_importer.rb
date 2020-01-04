# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'fileutils'
require 'cldr-plurals'
require 'cldr/export'
require 'parallel'
require 'etc'
require 'set'

module TwitterCldr
  module Resources

    class LocalesResourcesImporter < Importer

      requirement :cldr, Versions.cldr_version
      output_path './'
      locales TwitterCldr.supported_locales
      ruby_engine :mri

      LOCALE_COMPONENTS = %w[
        layout
        calendars
        languages
        currencies
        plural_rules
        lists
        rbnf
        units
        fields
      ]

      # transforms are done by the TransformsImporter
      SHARED_COMPONENTS = %w[
        currency_digits_and_rounding
        rbnf_root
        numbering_systems
        territories_containment
        likely_subtags
        metazones
      ]

      private

      def execute
        import_components
      end

      def after_prepare
        Cldr::Export::Data.dir = requirements[:cldr].common_path
      end

      def output_path
        params.fetch(:output_path)
      end

      def import_components
        locales = Set.new

        finish = -> (locale, *) do
          locales.add(locale)
          STDOUT.write "\rImported #{locale}, #{locales.size} of #{params[:locales].size} total"
        end

        Parallel.each(params[:locales], in_processes: Etc.nprocessors, finish: finish) do |locale|
          export_args = {
            locales: [locale],
            components: components_for(locale),
            target: File.join(output_path, 'locales'),
            merge: true  # fill in the gaps, eg fill in sub-locales like en_GB with en
          }

          Cldr::Export.export(export_args) do |component, locale, path|
            add_buddhist_calendar(component, locale, path)
            process_plurals(component, locale, path)
            deep_symbolize(path)
          end
        end

        puts ''

        shared_output_path = File.join(output_path, 'shared')
        FileUtils.mkdir_p(shared_output_path)

        export_args = {
          components: SHARED_COMPONENTS,
          target: shared_output_path,
          merge: true
        }

        Cldr::Export.export(export_args) do |component, locale, path|
          deep_symbolize(path)
        end
      end

      def components_for(locale)
        if File.exist?(File.join(requirements[:cldr].source_path, 'common', 'rbnf', "#{locale}.xml"))
          LOCALE_COMPONENTS
        else
          LOCALE_COMPONENTS - ['rbnf']
        end
      end

      def deep_symbolize(path)
        return unless File.extname(path) == '.yml'
        data = YAML.load(File.read(path))

        File.open(path, 'w:utf-8') do |output|
          output.write(
            TwitterCldr::Utils::YAML.dump(
              TwitterCldr::Utils.deep_symbolize_keys(data),
              use_natural_symbols: true
            )
          )
        end
      end

      def process_plurals(component, locale, path)
        return unless component == 'PluralRules'

        output_file = File.join(File.dirname(path), 'plurals.yml')

        plurals = YAML.load(File.read(path))[locale.to_s].inject({}) do |ret, (rule_type, rule_data)|
          rule_list = CldrPlurals::Compiler::RuleList.new(locale)

          rule_data.each_pair do |name, rule_text|
            rule_list.add_rule(name.to_sym, rule_text) unless name == 'other'
          end

          ret[rule_type.to_sym] = {
            rule: rule_list.to_code(:ruby),
            names: rule_list.rules.map(&:name) + [:other]
          }

          ret
        end

        File.open(output_file, 'w:utf-8') do |output|
          output.write(YAML.dump(locale => plurals))
        end
      end

      # TODO: export buddhist calendar from CLDR data instead of using BUDDHIST_CALENDAR constant.
      #
      def add_buddhist_calendar(component, locale, path)
        return unless component == 'Calendars' && locale == :th

        data = YAML.load(File.read(path))
        data['th']['calendars']['buddhist'] = BUDDHIST_CALENDAR

        File.open(path, 'w:utf-8') { |output| output.write(YAML.dump(data))}
      end

      BUDDHIST_CALENDAR = {
        'formats' => {
          'date' => {
            'default' => :'calendars.buddhist.formats.date.medium',
            'full'    => { 'pattern' => 'EEEEที่ d MMMM G y' },
            'long'    => { 'pattern' => 'd MMMM พ.ศ. #{y + 543}' },
            'medium'  => { 'pattern' => 'd MMM #{y + 543}' },
            'short'   => { 'pattern' => 'd/M/#{y + 543}' }
          }
        }
      }

    end

  end
end
