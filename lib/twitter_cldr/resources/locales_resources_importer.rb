# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'fileutils'
require 'cldr-plurals'
require 'cldr/export'

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
        numbers
        currencies
        plural_rules
        lists
        territories
        rbnf
        units
        fields
      ]

      SHARED_COMPONENTS = %w[
        currency_digits_and_rounding
        rbnf_root
        numbering_systems
        segments_root
        territories_containment
        likely_subtags
        variables
        aliases
        transforms
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

      def move_segments_root_file
        file_path = File.join(output_path, 'shared', 'segments_root.yml')

        if File.file?(file_path)
          FileUtils.move(
            file_path, File.join(
              output_path, 'shared', 'segments', 'segments_root.yml'
            )
          )
        end
      end

      def import_components
        locales = Set.new

        params[:locales].each do |locale|
          export_args = {
            locales: [locale],
            components: components_for(locale),
            target: File.join(output_path, 'locales'),
            merge: true  # fill in the gaps, eg fill in sub-locales like en_GB with en
          }

          Cldr::Export.export(export_args) do |component, locale, path|
            add_buddhist_calendar(component, locale, path)
            process_plurals(component, locale, path)
            downcase_territory_codes(component, locale, path)
            deep_symbolize(path)
            locales.add(locale)
            STDOUT.write "\rImporting #{locale}, #{locales.size} of #{params[:locales].size} total"
          end
        end

        puts ''

        export_args = {
          components: SHARED_COMPONENTS,
          target: File.join(output_path, 'shared'),
          merge: true
        }

        Cldr::Export.export(export_args) do |component, locale, path|
          deep_symbolize(path)
        end

        move_segments_root_file
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

      # CLDR stores territory codes uppercase. For consistency with how we
      # handle territory codes in methods relating to phone and postal codes,
      # we downcase them here.
      #
      # (There is also some trickery relating to three-digit UN "area codes"
      # used by CLDR; see comment of Utils::Territories::deep_normalize_territory_code_keys.)
      def downcase_territory_codes(component, locale, path)
        return unless component == 'Territories'

        data = YAML.load(File.read(path))
        data.keys.each do |l|
          data[l] = TwitterCldr::Shared::Territories.deep_normalize_territory_code_keys(data[l])
        end

        File.open(path, 'w:utf-8') do |output|
          output.write(YAML.dump(data))
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
