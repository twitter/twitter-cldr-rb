# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'cldr-plurals/ruby_runtime'

module TwitterCldr
  module Formatters
    module Plurals
      module Rules

        class << self

          def all
            all_for(TwitterCldr.locale)
          end

          def all_for(locale)
            names(locale)
          end

          def rule_for(number, locale = TwitterCldr.locale)
            rule(locale).call(number.to_s, CldrPlurals::RubyRuntime)
          rescue
            :other
          end

          protected

          def get_resource(locale)
            locale = TwitterCldr.convert_locale(locale)
            cache_key = TwitterCldr::Utils.compute_cache_key(locale)
            locale_cache[cache_key] ||= begin
              rsrc = TwitterCldr.get_locale_resource(locale, :plurals)[locale]
              rsrc.merge(:rule => eval(rsrc[:rule]))
            end
          end

          def rule(locale)
            get_resource(locale)[:rule]
          end

          def names(locale)
            get_resource(locale)[:names]
          end

          def locale_cache
            @locale_cache ||= {}
          end

        end

      end
    end
  end
end
