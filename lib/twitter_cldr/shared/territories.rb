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

        def from_code(code)
          from_code_for_locale(code, TwitterCldr.get_locale)
        end

        def from_code_for_locale(code, locale = TwitterCldr.get_locale)
          get_resource(locale)[:territories][TwitterCldr.convert_locale(code)]
        rescue
          nil
        end

        def translate_territory(territory, source_locale = :en, dest_locale = TwitterCldr.get_locale)
          territory_code = get_resource(source_locale)[:territories].detect { |_, val| val.downcase == territory.downcase }.first
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

