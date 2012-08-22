# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Shared
    module Currencies

      class << self

        def countries
          resource.keys.map(&:to_s)
        end

        def currency_codes
          resource.values.map { |data| data[:code] }
        end

        def for_country(country_name)
          currency = resource[country_name.to_sym]
          
          if currency
            currency.merge!(TwitterCldr::Shared::CurrencyPrecisionAndRounding.for_code(currency[:code])) { |key, v1, v2| (v1 || v2) }
            currency
          end
        end

        def for_code(currency_code)
          country_name, data = resource.detect { |_, data| data[:code] == currency_code }
          
          if data
            currency = { 
              :country => country_name.to_s, 
              :currency => data[:currency], 
              :symbol => data[:symbol]
            }
            
            currency.merge!(TwitterCldr::Shared::CurrencyPrecisionAndRounding.for_code(currency_code)) { |key, v1, v2| (v1 || v2) }
            currency
          end
        end

        private

        def resource
          @resource ||= TwitterCldr.get_resource(:shared, :currencies)
        end

      end

    end
  end
end
