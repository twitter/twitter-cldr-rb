# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

include TwitterCldr::DataReaders

module TwitterCldr
  module Localized
    class LocalizedNumber < LocalizedObject

      attr_reader :type, :format

      def initialize(obj, locale, options = {})
        @type = options[:type] || NumberDataReader::DEFAULT_TYPE
        @format = options[:format] || NumberDataReader::DEFAULT_FORMAT
        super
      end

      class << self
        def types
          NumberDataReader::TYPE_PATHS.keys
        end
      end

      types.each do |type|
        define_method "to_#{type}" do
          to_type(type)
        end
      end

      def to_s(options = {})
        data_reader = NumberDataReader.new(locale, {
          :type => @type,
          :format => @format
        })

        tokens = data_reader.tokenizer.tokenize(data_reader.pattern(base_obj))
        data_reader.formatter.format(tokens, base_obj, options)
      end

      def plural_rule
        TwitterCldr::Formatters::Plurals::Rules.rule_for(base_obj, locale)
      end

      protected

      def abbreviated?
        case type
          when :short_decimal, :long_decimal
            true
          else
            false
        end
      end

      def to_type(target_type)
        self.class.new(base_obj, locale, {
          :type => target_type,
          :format => @format
        })
      end

    end
  end
end