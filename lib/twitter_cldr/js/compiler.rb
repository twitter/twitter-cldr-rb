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
        @prerender = options[:prerender].nil? ? true : options[:prerender]
      end

      def compile_each(options = {})
        options[:minify] = true unless options.include?(:minify)

        @locales.each do |locale|
          contents = ""

          @features.each do |feature|
            renderer_const = renderers[feature]
            contents << renderer_const.new(:locale => locale, :prerender => @prerender).render if renderer_const
          end

          bundle = TwitterCldr::Js::Renderers::Bundle.new
          bundle[:locale] = locale
          bundle[:contents] = contents
          result = CoffeeScript.compile(bundle.render, :bare => false)

          # required alias definition that adds twitter_cldr to Twitter's static build process
          result.gsub!(/\/\*<<module_def>>\s+\*\//, %Q(/*-module-*/\n/*_lib/twitter_cldr_*/))
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
          :additional_date_format_selector => TwitterCldr::Js::Renderers::Calendars::AdditionalDateFormatSelectorRenderer,
          :numbers => TwitterCldr::Js::Renderers::Numbers::NumbersRenderer,
          :currencies => TwitterCldr::Js::Renderers::Shared::CurrenciesRenderer,
          :lists => TwitterCldr::Js::Renderers::Shared::ListRenderer,
          :bidi => TwitterCldr::Js::Renderers::Shared::BidiRenderer,
          :calendar => TwitterCldr::Js::Renderers::Shared::CalendarRenderer
        }
      end
    end
  end
end