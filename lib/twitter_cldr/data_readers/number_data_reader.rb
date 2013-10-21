# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

include TwitterCldr::Tokenizers
include TwitterCldr::Formatters

module TwitterCldr
  module DataReaders
    class NumberDataReader < DataReader

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

      DEFAULT_TYPE = :decimal
      DEFAULT_FORMAT = :default
      DEFAULT_SIGN = :positive

      attr_reader :type, :format, :sign

      def initialize(locale, options = {})
        super(locale)
        @type = options[:type] || DEFAULT_TYPE

        unless type && TYPE_PATHS.include?(type.to_sym)
          raise ArgumentError.new("Type #{type} is not supported")
        end

        @format = options[:format] || DEFAULT_FORMAT
        @sign = options[:sign] || DEFAULT_SIGN
      end

      def pattern
        path = BASE_PATH + TYPE_PATHS[type]
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

      def symbols
        @symbols ||= traverse(SYMBOL_PATH)
      end

      def tokenizer
        @tokenizer ||= NumberTokenizer.new(self)
      end

      def formatter
        @formatter ||= begin
          klass_name = type.to_s.split("_").map(&:capitalize).join
          klass = TwitterCldr::Formatters.const_get(:"#{klass_name}Formatter")
          klass.new(self)
        end
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