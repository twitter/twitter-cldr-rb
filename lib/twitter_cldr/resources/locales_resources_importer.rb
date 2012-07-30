# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'cldr/download'
require 'cldr/export'

module TwitterCldr
  module Resources

    COMPONENTS = %w[calendars languages numbers units plurals]

    class LocalesResourcesImporter

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
        Cldr.download(nil, @input_path) unless File.directory?(@input_path)
        Cldr::Export::Data.dir = File.join(@input_path, 'common')
      end

      # Copies zh plurals to zh-Hant (they can share, but locale code needs to be different).
      #
      def copy_zh_hant_plurals
        File.open(File.join(@output_path, 'zh-Hant', 'plurals.yml'), 'w:utf-8') do |output|
          output.write(File.read(File.join(@output_path, 'zh', 'plurals.yml')).gsub('zh:', 'zh-Hant:').gsub(':zh', ":'zh-Hant'"))
        end
      end

      def import_components
        Cldr::Export.export(:locales => TwitterCldr.supported_locales, :components => COMPONENTS, :target => @output_path) do |component, locale, path|
          add_buddhist_calendar(component, locale, path)
          process_plurals(component, locale, path)
        end

        copy_zh_hant_plurals
      end

      def process_plurals(component, locale, path)
        return unless component == 'plurals'

        plural_rules = File.read(path)

        File.open(path.gsub(/rb$/, 'yml'), 'w:utf-8') do |output|
          output.write(YAML.dump({ locale.to_s => plural_rules }))
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