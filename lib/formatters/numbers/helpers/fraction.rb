# -*- encoding : utf-8 -*-
module TwitterCldr
  module Formatters
    module Numbers
      class Fraction < Base
        attr_reader :format, :decimal, :precision

        def initialize(token, symbols = {})
          @format  = token ? token.value.split('.').pop : ''
          @decimal = symbols[:decimal] || '.'
          @precision = @format.length
        end

        def apply(fraction, options = {})
          precision = options[:precision] || self.precision
          if precision > 0
            decimal + interpolate(format(options), fraction, :left)
          else
            ''
          end
        end

        def format(options)
          precision = options[:precision] || self.precision
          precision ? '0' * precision : @format
        end
      end
    end
  end
end
