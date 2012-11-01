# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Shared
    module CurrencyPrecisionAndRounding

      class << self
        def for_code(currency_code)
          (resource[currency_code.upcase.to_sym] || resource[:DEFAULT])
        end

        private

        def resource
          @resource ||= TwitterCldr.get_resource(:shared, :currency_precision_and_rounding)
        end
      end
      
    end
  end
end
