# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module DataReaders
    class NumberDataReader < DataReader

      DEFAULT_NUMBER_SYSTEM = "latn"
      ABBREVIATED_MIN_POWER = 3
      ABBREVIATED_MAX_POWER = 14

      NUMBER_MIN = 10 ** ABBREVIATED_MIN_POWER
      NUMBER_MAX = 10 ** (ABBREVIATED_MAX_POWER + 1)

      BASE_PATH   = [:numbers, :formats]
      SYMBOL_PATH = [:numbers, :symbols]

      TYPE_PATHS = {
        default:       [:decimal, :patterns],
        decimal:       [:decimal, :patterns],
        long_decimal:  [:decimal, :patterns, :long],
        short_decimal: [:decimal, :patterns, :short],
        currency:      [:currency, :patterns],
        percent:       [:percent, :patterns]
      }

      ABBREVIATED_TYPES = [:long_decimal, :short_decimal]

      DEFAULT_TYPE = :decimal
      DEFAULT_FORMAT = :default
      DEFAULT_SIGN = :positive

      REDIRECT_REGEX = /\Anumbers\.formats\.\w+\.patterns\.\w+\z/

      attr_reader :type, :format

      def self.types
        TYPE_PATHS.keys
      end

      def initialize(locale, options = {})
        super(locale)
        @type = options[:type] || DEFAULT_TYPE

        unless type && TYPE_PATHS.include?(type.to_sym)
          raise ArgumentError.new("Type #{type} is not supported")
        end

        @format = options[:format] || DEFAULT_FORMAT
      end

      def format_number(number, options = {})
        precision = options[:precision] || 0
        pattern_for_number = pattern(number, precision == 0)

        if pattern_for_number == '0'
          # there's no specific formatting for the number in the current locale
          number.to_s
        else
          tokens = tokenizer.tokenize(pattern_for_number)
          formatter.format(tokens, number, options)
        end
      end

      def pattern(number = nil, decimal = true)
        sign = number < 0 ? :negative : :positive
        path = BASE_PATH + if valid_type_for?(number, type)
          TYPE_PATHS[type]
        else
          TYPE_PATHS[:default]
        end

        pattern = get_pattern_data(path)

        if pattern[format]
          pattern = pattern[format]
        end

        if number
          pattern = pattern_for_number(pattern, number, decimal)
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

      def get_pattern_data(path)
        data = traverse(path)

        if data.is_a?(Symbol) && data.to_s =~ REDIRECT_REGEX
          get_pattern_data(data.to_s.split('.').map(&:to_sym))
        else
          data
        end
      end

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
        "1#{"0" * (number.to_i.abs.to_s.size - 1)}".to_s.to_sym
      end

      def pattern_for_number(pattern, number, decimal)
        if pattern.is_a?(Hash)
          range_pattern = pattern[get_key_for(number)]

          if range_pattern
            pattern_sample = range_pattern.values.first

            if pattern_sample != 0
              rule = pluralization_rule(number, pattern_sample, decimal)
              # fall back to :other and raise an exception if it's missing as well
              range_pattern.fetch(rule, range_pattern.fetch(:other))
            else
              0
            end
          else
            pattern
          end
        else
          pattern
        end
      end

      def truncate_number(number, pattern)
        formatter.truncate_number(number, tokenizer.tokenize(pattern)[1].value.size)
      end

      def pluralization_rule(number, pattern, decimal)
        truncated_number = truncate_number(number, pattern)
        # decimal and fractional numbers might have different pluralization,
        # so it's important to convert to integer if we want a decimal result
        truncated_number = truncated_number.to_i if decimal
        TwitterCldr::Formatters::Plurals::Rules.rule_for(truncated_number, locale)
      end

      def pattern_for_sign(pattern, sign)
        if pattern.include?(";")
          positive, negative = pattern.split(";")
          sign == :positive ? positive : negative
        else
          case sign
            when :negative
              "#{symbols[:minus_sign] || '-'}#{pattern}"
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
        abs_value = number.abs
        NUMBER_MIN <= abs_value && abs_value < NUMBER_MAX
      end
    end
  end
end
