# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Shared
    module Territories

      class << self

        def all
          all_for(TwitterCldr.locale)
        end

        def all_for(code)
          get_resource(code)[:territories]
        rescue
          {}
        end

        def from_territory_code(territory_code)
          from_territory_code_for_locale(territory_code, TwitterCldr.locale)
        end

        # Returns how to say a given territory in a given locale.
        #
        # This method does not work for three-digit United Nation "area
        # codes" (UN M.49; for example, 014 for Eastern Africa and 419 for Latin
        # America).
        def from_territory_code_for_locale(territory_code, locale = TwitterCldr.locale)
          get_resource(locale)[:territories][TwitterCldr::Utils::Territories.normalize_territory_code(territory_code)]
        rescue
          nil
        end

        # Translates territory_name from source_locale to dest_locale.
        #
        # This method does not work for three-digit United Nation "area
        # codes" (UN M.49; for example, 014 for Eastern Africa and 419 for Latin
        # America).
        def translate_territory(territory_name, source_locale = :en, dest_locale = TwitterCldr.locale)
          territory_code, _ = get_resource(source_locale)[:territories].find do |_, other_territory_name|
            other_territory_name.downcase == territory_name.downcase
          end
          get_resource(dest_locale)[:territories][territory_code] if territory_code
        rescue
          nil
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

