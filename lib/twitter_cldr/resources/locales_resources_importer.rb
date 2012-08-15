# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'cldr/export'

require 'twitter_cldr/resources/download'

module TwitterCldr
  module Resources

    class LocalesResourcesImporter

      COMPONENTS = %w[calendars languages numbers units plurals]

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
        File.open(File.join(@output_path, 'zh-Hant', 'plurals.yml'), 'w:utf-8') do |output|
          data = YAML.load(File.read(File.join(@output_path, 'zh', 'plurals.yml')))
          output.write(YAML.dump(:'zh-Hant' => data[:zh].gsub(':zh', ":'zh-Hant'")))
        end
      end

      def import_components
        Cldr::Export.export(:locales => TwitterCldr.supported_locales, :components => COMPONENTS, :target => @output_path) do |component, locale, path|
          add_buddhist_calendar(component, locale, path)
          process_plurals(component, locale, path)
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

      def process_plurals(component, locale, path)
        return unless component == 'plurals'

        plural_rules = File.read(path)

        File.open(path.gsub(/rb$/, 'yml'), 'w:utf-8') do |output|
          output.write(YAML.dump({ locale => plural_rules }))
        end

        FileUtils.rm(path)
      end

      # TODO: export buddhist calendar from CLDR data instead of using BUDDHIST_CALENDAR constant.
      #
      def add_buddhist_calendar(component, locale, path)
        return unless component == 'calendars' && locale == :th

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