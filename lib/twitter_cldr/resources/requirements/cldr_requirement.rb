# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'i18n'
require 'uri'
require 'open-uri'
require 'zip'

module TwitterCldr
  module Resources
    module Requirements

      class CldrRequirement
        CLDR_URL = "https://unicode.org/Public/cldr/%{version}/core.zip"

        attr_reader :version

        def initialize(version)
          @version = version
        end

        def prepare
          # download and unzip if source directory doesn't exist
          unless File.directory?(source_path)
            STDOUT.write("Downloading cldr v#{version}... ")
            download
            puts 'done'
          end

          puts "Using cldr v#{version} from #{source_path}"
        end

        def source_path
          @source_path ||= File.join(TwitterCldr::VENDOR_DIR, "cldr_v#{version}")
        end

        def common_path
          File.join(source_path, 'common')
        end

        def merge_each_ancestor(locale, merge_root: true)
          locales = locale_chain(locale)
          locales << :root if merge_root

          locales.inject({}) do |result, ancestor_locale|
            deep_merge(yield(ancestor_locale), result)
          end
        end

        private

        def locale_chain(locale)
          locale = from_fs(locale)
          ancestry = [locale]

          loop do
            if parent_locales[from_fs(ancestry.last)]
              ancestry << to_fs(parent_locales[from_fs(ancestry.last)])
            elsif I18n::Locale::Tag.tag(ancestry.last).self_and_parents.count > 1
              ancestry << I18n::Locale::Tag.tag(ancestry.last).self_and_parents.last.to_sym
            else
              break
            end
          end

          ancestry
        end

        def to_fs(locale)
          locale.to_s.gsub('_', '-').to_sym
        end

        def from_fs(locale)
          locale.to_s.gsub('-', '_')
        end

        DEEP_MERGER = proc do |key, v1, v2|
          Hash === v1 && Hash === v2 ? v1.merge(v2, &DEEP_MERGER) : (v2 || v1)
        end

        def deep_merge(h1, h2)
          h1.merge(h2, &DEEP_MERGER)
        end

        def cldr_url
          CLDR_URL % { version: version }
        end

        def download
          URI.parse(cldr_url).open do |tempfile|
            FileUtils.mkdir_p(source_path)
            Zip.on_exists_proc = true

            Zip::File.open(tempfile.path) do |file|
              file.each do |entry|
                path = File.join(source_path, entry.name)
                FileUtils.mkdir_p(File.dirname(path))
                file.extract(entry, path)
              end
            end
          end
        end

        def parent_locales
          @parent_locales ||= supplemental_data.xpath('//parentLocales/parentLocale').each_with_object({}) do |node, ret|
            parent = node.attr('parent')
            locales = node.attr('locales').split(' ')

            locales.each do |locale|
              ret[locale] = parent
            end
          end
        end

        def supplemental_data
          @supplemental_data ||= Nokogiri.XML(
            File.read(File.join(common_path, 'supplemental', 'supplementalData.xml'))
          )
        end
      end

    end
  end
end
