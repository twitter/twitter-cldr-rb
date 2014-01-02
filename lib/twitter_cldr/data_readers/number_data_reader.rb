# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module DataReaders
    class NumberDataReader < DataReader

      DEFAULT_NUMBER_SYSTEM = "latn"

      BASE_PATH   = [:numbers, :formats]
      SYMBOL_PATH = [:numbers, :symbols]

      FORMAT_PATHS = {
        :default       => [:decimal, :patterns],
        :decimal       => [:decimal, :patterns],
        :long_decimal  => [:decimal, :patterns, :long],
        :short_decimal => [:decimal, :patterns, :short],
        :currency      => [:currency, :patterns],
        :percent       => [:percent, :patterns]
      }

      def pattern_for(options = {})
        type = options[:type] || :default
        format = options[:format] || :default
        sign = options[:sign] || :positive

        path = BASE_PATH + FORMAT_PATHS[type]
        pattern = traverse(path)

        if pattern[format]
          pattern = pattern[format]
        end

        if pattern.is_a?(String)
          pattern_for_sign(pattern, sign)
        else
          pattern
        end
      end

      def number_system_for(type)
        (traverse(BASE_PATH + [type]) || {}).fetch(:number_system, DEFAULT_NUMBER_SYSTEM)
      end

      def symbols
        @symbols ||= traverse(SYMBOL_PATH)
      end

      private

      def pattern_for_sign(pattern, sign)
        if pattern.include?(";")
          positive, negative = pattern.split(";")
          sign == :positive ? positive : negative
        else
          case sign
            when :negative
              "#{symbols[:minus] || '-'}#{pattern}"
            else
              pattern
          end
        end
      end

      def resource
        @resource ||= begin
          raw = TwitterCldr.get_locale_resource(locale, :numbers)
          raw[TwitterCldr.convert_locale(locale)]
        end
      end

    end
  end
end