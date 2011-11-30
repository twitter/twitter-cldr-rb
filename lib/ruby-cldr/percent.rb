# encoding: utf-8

class Cldr
  module Format
    class Percent < Decimal
      def apply(number, options = {})
        super.gsub('¤', options[:percent_sign] || '%')
      end
    end
  end
end