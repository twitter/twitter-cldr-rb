# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Shared
    module Languages

      class << self

        def all
          all_for(TwitterCldr.get_locale)
        end

        def all_for(code)
          get_resource(code)[:languages]
        rescue
          {}
        end

        def from_code(code)
          from_code_for_locale(code, TwitterCldr.get_locale)
        end

        def from_code_for_locale(code, locale = TwitterCldr.get_locale)
          get_resource(locale)[:languages][TwitterCldr.convert_locale(code)]
        rescue
          nil
        end

        def translate_language(language, source_locale = :en, dest_locale = TwitterCldr.get_locale)
          lang_code = get_resource(source_locale)[:languages].detect { |_, val| val.downcase == language.downcase }.first
          get_resource(dest_locale)[:languages][lang_code] if lang_code
        rescue
          nil
        end

        protected

        def get_resource(locale)
          locale = TwitterCldr.convert_locale(locale)
          TwitterCldr.get_locale_resource(locale, :languages)[locale]
        end

      end

    end
  end
end