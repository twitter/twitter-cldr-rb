# encoding: utf-8

module TwitterCldr
  module Format
    class Currency < Decimal
      def apply(number, options = {})
        super.gsub('¤', options[:currency] || '$')
      end
    end
  end
end