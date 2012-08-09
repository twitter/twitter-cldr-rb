# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'lib/twitter_cldr/resources/download'

module TwitterCldr
  module Resources

    class LanguageCodesImporter

      BCP_47_FILE, ISO_639_FILE = %w[bcp-47.txt iso-639.txt]

      INPUT_DATA = {
          BCP_47_FILE  => 'http://www.iana.org/assignments/language-subtag-registry',
          ISO_639_FILE => 'http://www.sil.org/iso639-3/iso-639-3_20120614.tab'
      }

      def initialize(input_path, output_path)
        @input_path  = input_path
        @output_path = output_path
      end

      def import
        prepare_data
        import_data
      end

      private

      def prepare_data
        INPUT_DATA.each do |file, url|
          TwitterCldr::Resources.download_if_necessary(File.join(@input_path, file), url)
        end
      end

      def import_data
        result = import_iso_639
        result = import_bcp_47(result)

        result = Hash[result.each_with_object({}) { |(key, value), memo| memo[key] = Hash[value.sort] }.sort]

        File.open(File.join(@output_path, 'language_codes.yml'), 'w:utf-8') { |output| output.write(YAML.dump(result)) }
      end

      def import_iso_639(result = {})
        File.open(File.join(@input_path, ISO_639_FILE)) do |file|
          lines = file.lines
          lines.next # skip header

          lines.each do |line|
            entry = line.chomp.gsub(/"(.*)"/) { $1.gsub("\t", '') }
            data = Hash[ISO_639_COLUMNS.zip(entry.split("\t"))]

            # either bibliographic and terminologic codes are the same (:bt_equiv is empty)
            # or :iso_639_2 contains terminologic code and :bt_equiv contains bibliographic code
            # skip 'collection' scope
            if (data[:bt_equiv].empty? || !data[:b_code].empty?) && data[:name] != 'Reserved for local use' && data[:scope] != 'C'
              h = result[data[:name].to_sym] ||= {}

              set_iso_639_data(h, :iso_639_1, data[:iso_639_1])

              if data[:bt_equiv].empty?
                set_iso_639_data(h, :iso_639_2, data[:iso_639_2])
              else
                set_iso_639_data(h, :iso_639_2, data[:bt_equiv])
                set_iso_639_data(h, :iso_639_2_term, data[:iso_639_2])
              end

              set_iso_639_data(h, :iso_639_3, data[:iso_639_3])
            end
          end
        end

        result
      end

      def set_iso_639_data(data, key, value)
        data[key] = value unless value.nil? || value.empty?
      end

      def import_bcp_47(result = {})
        File.open(File.join(@input_path, BCP_47_FILE)) do |file|
          lines = file.lines
          lines.next # skip header

          data  = {}
          entry = ''

          lines.each do |line|
            line.chomp!

            if line == '%%'
              process_bcp_47_entry(entry, data)

              process_bcp_47_data(data, result)
            else
              if line.include?(':')
                process_bcp_47_entry(entry, data)
                entry = line
              else
                entry += line
              end
            end
          end

          process_bcp_47_entry(entry, data)
          process_bcp_47_data(data, result)
        end

        result
      end

      def process_bcp_47_entry(entry, data)
        return if entry.nil? || entry.empty?

        key, value = entry.chomp.split(':', 2).map(&:strip)

        if key == 'Description'
          (data['names'] ||= []) << value.to_sym
        else
          data[key.downcase] = value
        end

        entry.clear
      end

      def process_bcp_47_data(data, result)
        if !data.empty? && %w[language extlang].include?(data['type']) && !data['names'].include?('Private use') && data['scope'] != 'collection'
          existing_names = data['names'].select { |name| result.has_key?(name) }

          prefered    = data['preferred-value']
          alternative = [data['prefix'], data['subtag']].compact.join('-')

          bcp_47 = {}

          bcp_47[:bcp_47]     = prefered || alternative
          bcp_47[:bcp_47_alt] = alternative if prefered

          existing_names.each do |name|
            result[name.to_sym].merge!(bcp_47)
          end

          bcp_47.merge!(result[existing_names.first]) unless existing_names.empty?

          (data['names'] - existing_names).each do |name|
            result[name.to_sym] = bcp_47.dup
          end
        end

        data.clear
      end

      ISO_639_COLUMNS = [
          :code,            # Code
          :status,          # Status
          :partner_agency,  # Partner Agency
          :iso_639_3,       # 639_3
          :iso_639_2,       # 639_2 (alpha-3 bibliographic/terminologic code)
          :b_code,          # alpha-3 bibliographic code if iso_639_2 contains terminologic code
          :bt_equiv,        # bt_equiv (alpha-3 bibliographic/terminologic equivalent)
          :iso_639_1,       # 639_1
          :name,            # Reference_Name
          :scope,           # Element_Scope
          :type,            # Language_Type
          :docs             # Documentation
      ]

    end

  end
end