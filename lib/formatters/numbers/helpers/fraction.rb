module TwitterCldr
  module Formatters
    module Numbers
      class Fraction
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

        def interpolate(string, value, orientation = :right)
          value  = value.to_s
          length = value.length
          start, pad = orientation == :left ? [0, :rjust] : [-length, :ljust]

          string = string.dup
          string = string.ljust(length, '#') if string.length < length
          string[start, length] = value
          string.gsub('#', '')
        end
      end
    end
  end
end