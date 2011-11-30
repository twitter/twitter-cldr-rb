# encoding: utf-8

class Cldr
  module Format
    class Currency < Decimal
      def apply(number, options = {})
        super.gsub('¤', options[:currency] || '$')
      end
    end
  end
end