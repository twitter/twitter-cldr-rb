# encoding: UTF-8

module TwitterCldr
  module Shared
    class Currencies
      @@resource = TwitterCldr.resources.resource_for("shared", "currencies")[:shared][:currencies]

      class << self
        def countries
          @@resource.map { |country_name, data| country_name.to_s }
        end

        def currency_codes
          @@resource.map { |country_name, data| data[:code] }
        end

        def for_country(country_name)
          @@resource[country_name.to_sym]
        end

        def for_code(currency_code)
          final = nil
          @@resource.each_pair do |country_name, data|
            if data[:code] == currency_code
              final = data.merge({ :country => country_name.to_s })
              final.delete(:code)
              break
            end
          end
          final
        end
      end
    end
  end
end