class Cldr
  module Format
    class Decimal
      autoload :Base,     'cldr/format/decimal/base'
      autoload :Fraction, 'cldr/format/decimal/fraction'
      autoload :Integer,  'cldr/format/decimal/integer'
      autoload :Number,   'cldr/format/decimal/number'

      attr_reader :positive, :negative

      def initialize(format, symbols = {})
        @positive, @negative = parse_format(format, symbols)
      end

      def apply(number, options = {})
        number = Float(number)
        format = number.abs == number ? positive : negative
        format.apply(number, options)
      rescue TypeError, ArgumentError
        number
      end

      protected

        def parse_format(format, symbols)
          formats = format.split(symbols[:list] || ';')
          formats << "#{symbols[:minus] || '-'}#{format}" if formats.size == 1
          formats.map { |format| Number.new(format, symbols) }
        end
    end
  end
end