# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module Plurals
      module Rules

        class << self

          def all
            all_for(TwitterCldr.get_locale)
          end

          def all_for(locale)
            get_resource(locale)[:keys]
          rescue
            nil
          end

          def rule_for(number, locale = TwitterCldr.get_locale)
            get_resource(locale)[:rule].call(number)
          rescue
            :other
          end

          protected

          def get_resource(locale)
            locale = TwitterCldr.convert_locale(locale)
            eval(TwitterCldr.get_locale_resource(locale, :plurals)[locale])[locale][:i18n][:plural]
          end

        end

      end
    end
  end
end