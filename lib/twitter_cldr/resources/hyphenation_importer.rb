# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Resources

    class HyphenationImporter
      REPO_URL = 'git@github.com:LibreOffice/dictionaries.git'
      ENCODING_MAP = {
        'microsoft-cp1251' => Encoding::Windows_1251
      }

      # Arguments:
      #
      #   input_path  - path to a directory to clone hyphenation data into
      #   output_path - output directory for generated YAML files
      #   ref         - git ref to use
      #
      def initialize(input_path, output_path, ref)
        @input_path  = input_path
        @output_path = output_path
        @ref = ref
      end

      def import
        FileUtils.mkdir_p(@input_path)
        FileUtils.mkdir_p(@output_path)
        clone_or_fetch_if_necessary

        each_dictionary do |path, locale|
          import_dictionary(path, locale)
        end
      end

      private

      def import_dictionary(path, locale)
        options = {}
        rules = []

        File.foreach(path).with_index do |line, idx|
          if options[:encoding]
            line.force_encoding(options[:encoding])
            line.encode(Encoding::UTF_8)
          end

          line.strip!

          if idx == 0
            options[:encoding] = lookup_encoding(line)
            next
          end

          next if line.empty?
          next if line.start_with?('%')  # ignore comments

          if line =~ /\A[A-Z]+/  # capitals
            option, value = line.split(' ')
            options[option.downcase.to_sym] = value.to_i
            next
          end

          rules << line
        end

        # no need to write this out since everything's been re-encoded in UTF-8
        options.delete(:encoding)

        File.write(
          File.join(@output_path, "#{locale}.yml"),
          YAML.dump({ options: options, rules: rules })
        )
      end

      def lookup_encoding(encoding)
        ENCODING_MAP.fetch(encoding.downcase, encoding)
      end

      def each_dictionary
        Dir.glob(File.join(@input_path, '**/hyph_*.dic')) do |path|
          locale = TwitterCldr::Shared::Locale.parse(File.basename(path)[5..-5])
          yield path, locale.dasherized
        end
      end

      def dictionary_path
        File.join(@input_path, 'dictionaries')
      end

      def clone_or_fetch_if_necessary
        if File.exist?(@input_path)
          unless ref_exists?
            in_repo { `git fetch` }
          end
        else
          `git clone #{REPO_URL} #{@input_path}`
        end
      end

      def ref_exists?
        in_repo do
          `git rev-parse --verify --quiet #{@ref}`
          $?.exitstatus == 0
        end
      end

      def in_repo(&block)
        Dir.chdir(@input_path, &block)
      end
    end

  end
end
