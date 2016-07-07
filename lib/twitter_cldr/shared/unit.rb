# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'set'

module TwitterCldr
  module Shared
    class Unit
      class << self
        def create(value, locale = TwitterCldr.locale)
          subtype_for(locale).new(value, locale)
        end

        private

        def resource_for(locale)
          TwitterCldr.get_locale_resource(locale, :units)[locale][:units]
        end

        def subtype_for(locale)
          subtypes[locale] ||= begin
            klass = Class.new(Unit)

            all_unit_types_for(locale).each do |unit_type|
              method_name = unit_type.to_s.gsub('-', '_')
              klass.send(:define_method, method_name) do |*args|
                format(unit_type, *args)
              end
            end

            klass
          end
        end

        def subtypes
          @subtypes ||= {}
        end

        def all_unit_types_for(locale)
          resource = resource_for(locale)
          lengths = resource[:unitLength].keys

          lengths.each_with_object(Set.new) do |length, ret|
            ret.merge(resource[:unitLength][length].keys)
          end
        end
      end

      DEFAULT_FORM = :long

      attr_reader :value, :locale

      def initialize(value, locale = TwitterCldr.locale)
        @value = value
        @locale = locale
      end

      private

      def format(unit_type, options = {})
        form = options.fetch(:form, DEFAULT_FORM)

        if variant = variant_for(form, unit_type)
          variant.sub('{0}', value.to_s)
        end
      end

      def variant_for(form, unit_type)
        variant = resource[:unitLength]
          .fetch(form, {})
          .fetch(unit_type, {})
          .fetch(plural_rule.to_sym, nil)
      end

      def plural_rule
        TwitterCldr::Formatters::Plurals::Rules.rule_for(value, locale)
      end

      def resource
        @resource ||= self.class.send(:resource_for, locale)
      end
    end
  end
end
