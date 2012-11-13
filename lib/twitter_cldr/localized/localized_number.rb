# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Localized

    class LocalizedNumber < LocalizedObject
      DEFAULT_TYPE = :decimal
      TYPES = [
        :decimal,
        :short_decimal,
        :long_decimal,
        :currency,
        :percent,
      ]

      attr_reader :type

      def initialize(obj, locale, options = {})
        @options = options.dup

        @type = @options.delete(:type) || DEFAULT_TYPE
        raise ArgumentError.new("type #{@type} is not supported") unless @type && TYPES.include?(@type.to_sym)

        super(obj, locale, @options)
      end

      TYPES.each do |type|
        define_method "to_#{type}" do
          to_type(type)
        end
      end

      def to_s(options = {})
        @formatter.format(@base_obj, options.merge(:type => @type))
      end

      def plural_rule
        TwitterCldr::Formatters::Plurals::Rules.rule_for(@base_obj, @locale)
      end

      protected

      def formatter_const
        TwitterCldr::Formatters.const_get("#{@type.to_s.split("_").map(&:capitalize).join}Formatter")
      end

      def to_type(target_type)
        self.class.new(@base_obj, @locale, @options.merge(:type => target_type))
      end
    end

  end
end