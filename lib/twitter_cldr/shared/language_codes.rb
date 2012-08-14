# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Shared
    module LanguageCodes

      LANGUAGE_CODES_DUMP_PATH = File.join(TwitterCldr::RESOURCES_DIR, 'shared', 'language_codes_table.dump')

      NAME_STANDARD = :name # fake standard, mostly for internal use

      VALID_STANDARDS = [:bcp_47, :iso_639_1, :iso_639_2, :iso_639_3, NAME_STANDARD]

      class << self

        def languages
          resource[NAME_STANDARD].keys
        end

        def valid_standard?(standard)
          VALID_STANDARDS.include?(standard.to_sym)
        end

        def valid_code?(code, standard)
          resource[validate_standard(standard)].has_key?(code.to_sym)
        end

        def convert(code, from_and_to = {})
          from, to = extract_from_and_to_options(from_and_to)
          resource[from].fetch(code.to_sym, {})[to]
        end

        def from_language(language, standard)
          convert(language, :from => NAME_STANDARD, :to => standard)
        end

        def to_language(code, standard)
          convert(code, :from => standard, :to => NAME_STANDARD).to_s
        end

        def standards_for(code, standard)
          resource[validate_standard(standard)].fetch(code.to_sym, {}).keys - [NAME_STANDARD] # exclude fake NAME_STANDARD standard
        end

        def standards_for_language(language)
          standards_for(language, NAME_STANDARD)
        end

        private

        def resource
          @resource ||= File.open(LANGUAGE_CODES_DUMP_PATH) { |file| Marshal.load(file.read) }
        end

        def extract_from_and_to_options(from_and_to)
          TwitterCldr::Utils.deep_symbolize_keys(from_and_to).values_at(:from, :to).map do |standard|
            raise ArgumentError, 'options :from and :to are required' if standard.nil?
            validate_standard(standard)
          end
        end

        def validate_standard(standard)
          raise ArgumentError, "standard can't be nil" if standard.nil?
          raise ArgumentError, "#{standard.inspect} is not a valid standard name" unless valid_standard?(standard)

          standard.to_sym
        end

      end

    end
  end
end