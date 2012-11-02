# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Shared
    module Currencies
      class << self
        def countries
          Kernel.warn("Currencies#countries will be deprecated. Please stop using it.")
          resource_countries.keys.map(&:to_s)
        end

        def currency_codes(locale = :en)
          resource(locale).keys.map{|c| c.to_s}
        end

        def for_country(country_name, locale = :en)
          Kernel.warn("Currencies#for_country will be deprecated. Please stop using it.")
          return nil if !resource_countries[country_name.to_sym]
          for_code(resource_countries[country_name.to_sym][:code], locale)
        end

        def for_code(currency_code, locale = :en)
          currency_code = currency_code.to_sym
          data = resource(locale)[currency_code]
          { :currency => currency_code,
            :name => data[:one],
            :symbol => data[:symbol] } if data
        end

        private

        def resource_countries
          @resource_countries ||= TwitterCldr.get_resource(:shared, :currencies)
        end

        def resource(locale)
          locale = locale.to_sym
          @resource ||= {}
          @resource[locale] ||= TwitterCldr.get_resource(:locales, locale, :currencies)[locale][:currencies]
        end
      end
    end
  end
end
