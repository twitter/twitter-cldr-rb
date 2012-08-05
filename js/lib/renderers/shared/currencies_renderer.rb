# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Js
    module Renderers
      module Shared
        class CurrenciesRenderer < TwitterCldr::Js::Renderers::Base
          self.template_file = File.expand_path(File.join(File.dirname(__FILE__), "../..", "mustache/shared/currencies.coffee"))

          def currencies
            TwitterCldr::Shared::Currencies.countries.inject({}) do |ret, country_name|
              ret[country_name] = TwitterCldr::Shared::Currencies.for_country(country_name)
              ret
            end.to_json
          end
        end
      end
    end
  end
end