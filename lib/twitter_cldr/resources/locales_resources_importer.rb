# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'cldr/export'

require 'twitter_cldr/resources/download'

module TwitterCldr
  module Resources

    class LocalesResourcesImporter

#      COMPONENTS = %w[calendars languages numbers units plurals lists layout currencies territories]
      COMPONENTS = %w[plurals]

      # Arguments:
      #
      #   input_path  - path to a directory containing CLDR data
      #   output_path - output directory for imported YAML files
      #
      def initialize(input_path, output_path)
        @input_path  = input_path
        @output_path = output_path
      end

      def import
        prepare_ruby_cldr
        import_components
      end

      private

      def prepare_ruby_cldr
        TwitterCldr::Resources.download_cldr_if_necessary(@input_path)
        Cldr::Export::Data.dir = File.join(@input_path, 'common')
      end

      # Copies zh plurals to zh-Hant (they can share, but locale code needs to be different).
      #
      def copy_zh_hant_plurals
        File.open(File.join(@output_path, 'locales', 'zh-Hant', 'plurals.yml'), 'w:utf-8') do |output|
          data = YAML.load(File.read(File.join(@output_path, 'locales', 'zh', 'plurals.yml')))
          output.write(YAML.dump(:'zh-Hant' => data[:zh].gsub(':zh', ":'zh-Hant'")))
        end
      end

      def import_components
        Cldr::Export.export(
          :locales    => TwitterCldr.supported_locales,
          :components => COMPONENTS,
          :target     => File.join(@output_path, 'locales'),
          :merge      => true
        ) do |component, locale, path|
          add_buddhist_calendar(component, locale, path)
          process_plurals(component, locale, path)
          downcase_territory_codes(component, locale, path)
          deep_symbolize(component, locale, path)
        end

        Cldr::Export.export(:components => ["currency_digits_and_rounding"], :target => File.join(@output_path, 'shared')) do |component, locale, path|
          deep_symbolize(component, locale, path)
        end

        copy_zh_hant_plurals
      end

      def deep_symbolize(component, locale, path)
        return unless File.extname(path) == '.yml'
        data = YAML.load(File.read(path))

        File.open(path, 'w:utf-8') do |output|
          output.write(YAML.dump(TwitterCldr::Utils.deep_symbolize_keys(data)))
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
          data[l] = TwitterCldr::Utils::Territories.deep_normalize_territory_code_keys(data[l])
        end

        File.open(path, 'w:utf-8') do |output|
          output.write(YAML.dump(data))
        end
      end

      def process_plurals(component, locale, path)
        return unless component == 'Plurals'

        plural_rules = File.read(path)

        File.open(path.gsub(/rb$/, 'yml'), 'w:utf-8') do |output|
          output.write(YAML.dump({ locale => plural_rules }))
        end

        FileUtils.rm(path)
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
