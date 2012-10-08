# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Js
    class Compiler
      attr_reader :locales

      def initialize(options = {})
        @locales = options[:locales] || TwitterCldr.supported_locales
        @features = options[:features] || renderers.keys
      end

      def compile_each(options = {})
        options[:minify] = true unless options.include?(:minify)

        @locales.each do |locale|
          contents = ""

          @features.each do |feature|
            renderer_const = renderers[feature]
            contents << renderer_const.new(:locale => locale).render if renderer_const
          end

          bundle = TwitterCldr::Js::Renderers::Bundle.new
          bundle[:contents] = contents
          result = CoffeeScript.compile(bundle.render, :bare => true)
          result = Uglifier.compile(result) if options[:minify]

          yield result, TwitterCldr.twitter_locale(locale)
        end
      end

      private

      def renderers
        @renderers ||= {
          :plural_rules => TwitterCldr::Js::Renderers::PluralRules::PluralRulesRenderer,
          :timespan => TwitterCldr::Js::Renderers::Calendars::TimespanRenderer,
          :datetime => TwitterCldr::Js::Renderers::Calendars::DateTimeRenderer,
          :numbers => TwitterCldr::Js::Renderers::Numbers::NumbersRenderer,
          :currencies => TwitterCldr::Js::Renderers::Shared::CurrenciesRenderer,
          :lists => TwitterCldr::Js::Renderers::ListRenderer
        }
      end
    end
  end
end