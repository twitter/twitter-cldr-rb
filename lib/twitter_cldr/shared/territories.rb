# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Shared
    module Territories

      class << self

        def all
          all_for(TwitterCldr.get_locale)
        end

        def all_for(code)
          get_resource(code)[:territories]
        rescue
          {}
        end

        def from_territory_code(territory_code)
          from_territory_code_for_locale(territory_code, TwitterCldr.get_locale)
        end

        # Returns how to say a given territory in a given locale.
        #
        # This method does not work for three-digit United Nation "area
        # codes" (UN M.49; for example, 014 for Eastern Africa and 419 for Latin
        # America).
        def from_territory_code_for_locale(territory_code, locale = TwitterCldr.get_locale)
          get_resource(locale)[:territories][normalize_territory_code(territory_code)]
        rescue
          nil
        end

        # Translates territory_name from source_locale to dest_locale.
        #
        # This method does not work for three-digit United Nation "area
        # codes" (UN M.49; for example, 014 for Eastern Africa and 419 for Latin
        # America).
        def translate_territory(territory_name, source_locale = :en, dest_locale = TwitterCldr.get_locale)
          territory_code, _ = get_resource(source_locale)[:territories].find do |_, other_territory_name|
            other_territory_name.downcase == territory_name.downcase
          end
          get_resource(dest_locale)[:territories][territory_code] if territory_code
        rescue
          nil
        end

        # Normalizes a territory code to a symbol.
        #
        # 1) Converts to string.
        # 2) Downcases.
        # 3) Symbolizes.
        #
        # The downcasing is to convert ISO 3166-1 alpha-2 codes,
        # used (upper-case) for territories in CLDR, to be lowercase, to be
        # consistent with how territory codes are surfaced in TwitterCLDR
        # methods relating to phone and postal codes.
        def normalize_territory_code(territory_code)
          return nil if territory_code.nil?
          territory_code.to_s.downcase.gsub(/^0+/, '').to_sym
        end

        protected

        def get_resource(locale)
          locale = TwitterCldr.convert_locale(locale)
          TwitterCldr.get_locale_resource(locale, :territories)[locale]
        end

      end

    end
  end
end

