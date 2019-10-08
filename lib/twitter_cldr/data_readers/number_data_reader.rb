# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module DataReaders
    class NumberDataReader < DataReader

      DEFAULT_NUMBER_SYSTEM = :default
      ABBREVIATED_MIN_POWER = 3
      ABBREVIATED_MAX_POWER = 14

      NUMBER_MIN = 10 ** ABBREVIATED_MIN_POWER
      NUMBER_MAX = 10 ** (ABBREVIATED_MAX_POWER + 1)

      PATTERN_PATH = [:numbers, :formats]
      SYMBOL_PATH  = [:numbers, :symbols]

      TYPES = [:default, :decimal, :currency, :percent]
      FORMATS = [:long, :short, :default]

      DEFAULT_TYPE = :decimal
      DEFAULT_LENGTH = :long
      DEFAULT_FORMAT = :default
      DEFAULT_SIGN = :positive

      attr_reader :type, :format, :length, :number_system

      def self.types
        TYPES
      end

      def initialize(locale, options = {})
        super(locale)
        @type = options[:type] || DEFAULT_TYPE
        @length = options[:length] || DEFAULT_LENGTH

        unless type && TYPES.include?(type.to_sym)
          raise ArgumentError.new("Type #{type} is not supported")
        end

        @format = options[:format] || DEFAULT_FORMAT
        @number_system = options[:number_system] || default_number_system
      end

      def format_number(number, options = {})
        precision = options[:precision] || 0
        pattern_for_number = pattern(number, precision == 0)

        options[:locale] = self.locale

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
        path = PATTERN_PATH + [type, number_system]
        pattern = get_pattern_data(path)

        if pattern.is_a?(Hash)
          if pattern.include?(format)
            pattern = pattern[format]
          else
            FORMATS.each do |fmt|
              if pattern.include?(fmt)
                pattern = pattern[fmt]
                break
              end
            end
          end
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

      def symbols
        @symbols ||= traverse_following_aliases(SYMBOL_PATH + [number_system])
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
        traverse_following_aliases(path)
      end

      def valid_type_for?(number, type)
        TYPES.include?(type)
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

      def traverse_following_aliases(path, hash = resource, &block)
        traverse(path, hash) do |_leg, leg_data|
          if leg_data.is_a?(Symbol) && leg_data.to_s.start_with?('numbers.')
            break traverse_following_aliases(leg_data.to_s.split('.').map(&:to_sym))
          else
            leg_data
          end
        end
      end

      def default_number_system
        @default_number_system ||= resource[:numbers][:default_number_systems][:default].to_sym
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
