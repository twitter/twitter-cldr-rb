# encoding: UTF-8

module TwitterCldr
  module Shared
    class Languages
      class << self
        def all
          all_for(TwitterCldr::get_locale)
        end

        def all_for(code)
          get_resource(TwitterCldr.convert_locale(code.to_sym))[:languages]
        rescue => e
          {}
        end

        def from_code(code)
          from_code_for_locale(code, TwitterCldr::get_locale)
        end

        def from_code_for_locale(code, locale = TwitterCldr::get_locale)
          get_resource(TwitterCldr.convert_locale(locale.to_sym))[:languages][TwitterCldr.convert_locale(code.to_sym)]
        rescue => e
          nil
        end

        def translate_language(language, source_locale = :en, dest_locale = TwitterCldr::get_locale)
          source_locale = TwitterCldr.convert_locale(source_locale.to_sym)
          lang_code = get_resource(source_locale)[:languages].select { |key, val| val.downcase == language.downcase }.flatten.first

          if lang_code
            dest_locale = TwitterCldr.convert_locale(dest_locale.to_sym)
            get_resource(dest_locale)[:languages][lang_code.to_sym]
          else
            nil
          end
        rescue => e
          nil
        end

        protected

        def get_resource(locale)
          locale = TwitterCldr.convert_locale(locale)
          TwitterCldr.resources.resource_for(locale, "languages")[locale]
        end
      end
    end
  end
end