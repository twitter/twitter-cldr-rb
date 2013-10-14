# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module RuleBasedNumberFormatter

      def self.for_locale(locale, group = nil)
        locale = TwitterCldr.convert_locale(locale)
        @formatters ||= {}
        require path_for(locale) unless @formatters[locale]
        mod = @formatters[locale]

        if group
          mod.const_get(group.to_s.capitalize.to_sym)
        else
          mod
        end
      rescue LoadError
        nil  # locale doesn't have a formatter
      end

      private

      def self.path_for(locale)
        "twitter_cldr/formatters/numbers/rbnf/#{locale}"
      end

    end
  end
end
