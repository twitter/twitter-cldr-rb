# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Shared
    module LanguageCodes

      LANGUAGE_CODES_DUMP_PATH = File.join(TwitterCldr::RESOURCES_DIR, 'shared', 'language_codes_table.dump')

      VALID_STANDARDS = [:bcp_47, :iso_639_1, :iso_639_2, :iso_639_3, :name]

      class << self

        def languages
          resource[:name].keys
        end

        def valid_standard?(standard)
          VALID_STANDARDS.include?(standard.to_sym)
        end

        def valid_code?(standard, code)
          resource[validate_standard(standard)].has_key?(code.to_sym)
        end

        def convert(code, from_and_to = {})
          from, to = extract_from_and_to_options(from_and_to)
          resource[from.to_sym].fetch(code.to_sym, {})[to.to_sym]
        end

        def from_language_name(name, standard)
          convert(name, :from => :name, :to => standard)
        end

        def to_language_name(code, standard)
          convert(code, :from => standard, :to => :name).to_s
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

          standard
        end

      end

    end
  end
end