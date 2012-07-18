# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Js
    class Compiler
      def initialize(options = {})
        @locales = options[:locales] || TwitterCldr.supported_locales
        @features = options[:features] || renderers.keys
      end

      def compile
        @locales.each do |locale|
          contents = ""

          @features.each do |feature|
            renderer_const = renderers[feature]
            contents << renderer_const.new(:locale => locale).render if renderer_const
          end

          bundle = TwitterCldr::Js::Renderers::Bundle.new
          bundle[:contents] = contents
          yield CoffeeScript.compile(bundle.render, :bare => true), TwitterCldr.twitter_locale(locale) if block_given?
        end
      end

      private

      def renderers
        @renderers ||= {
          :plural_rules => TwitterCldr::Js::Renderers::PluralRules::PluralRulesRenderer,
          :timespan => TwitterCldr::Js::Renderers::Calendars::TimespanRenderer,
          :datetime => TwitterCldr::Js::Renderers::Calendars::DateTimeRenderer
        }
      end
    end
  end
end