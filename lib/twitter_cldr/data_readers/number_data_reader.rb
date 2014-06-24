# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module DataReaders
    class NumberDataReader < DataReader

      DEFAULT_NUMBER_SYSTEM = "latn"
      ABBREVIATED_MIN_POWER = 3
      ABBREVIATED_MAX_POWER = 14

      NUMBER_MIN   = 10 ** ABBREVIATED_MIN_POWER
      NUMBER_MAX   = 10 ** (ABBREVIATED_MAX_POWER + 1)

      BASE_PATH   = [:numbers, :formats]
      SYMBOL_PATH = [:numbers, :symbols]

      TYPE_PATHS = {
        :default       => [:decimal, :patterns],
        :decimal       => [:decimal, :patterns],
        :long_decimal  => [:decimal, :patterns, :long],
        :short_decimal => [:decimal, :patterns, :short],
        :currency      => [:currency, :patterns],
        :percent       => [:percent, :patterns]
      }

      ABBREVIATED_TYPES = [:long_decimal, :short_decimal]

      DEFAULT_TYPE = :decimal
      DEFAULT_FORMAT = :default
      DEFAULT_SIGN = :positive

      attr_reader :type, :format

      def initialize(locale, options = {})
        super(locale)
        @type = options[:type] || DEFAULT_TYPE

        unless type && TYPE_PATHS.include?(type.to_sym)
          raise ArgumentError.new("Type #{type} is not supported")
        end

        @format = options[:format] || DEFAULT_FORMAT
      end

      def pattern(number = nil)
        sign = number < 0 ? :negative : :positive 
        path = BASE_PATH + if valid_type_for?(number, type)
          TYPE_PATHS[type]
        else
          TYPE_PATHS[:default]
        end

        pattern = traverse(path)

        if pattern[format]
          pattern = pattern[format]
        end

        if number
          pattern = pattern_for_number(pattern, number)
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

      def tokenizer
        @tokenizer ||= TwitterCldr::Tokenizers::NumberTokenizer.new(self)
      end

      def formatter
        @formatter ||= begin
          klass_name = type.to_s.split("_").map(&:capitalize).join
          klass = TwitterCldr::Formatters.const_get(:"#{klass_name}Formatter")
          klass.new(self)
        end
      end

      private

      def abbreviated?(type)
        ABBREVIATED_TYPES.include?(type)
      end

      def valid_type_for?(number, type)
        if abbreviated?(type)
          self.class.within_abbreviation_range?(number)
        else
          TYPE_PATHS.include?(type)
        end
      end

      def get_key_for(number)
        "1#{"0" * (number.to_i.to_s.size - 1)}".to_i
      end

      def pattern_for_number(pattern, number)
        if pattern.is_a?(Hash)
          pattern[get_key_for(number)] || pattern
        else
          pattern
        end
      end

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

      def self.within_abbreviation_range?(number)
        NUMBER_MIN <= number && number < NUMBER_MAX
      end
    end
  end
end
