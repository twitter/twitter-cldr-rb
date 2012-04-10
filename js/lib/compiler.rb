module TwitterCldr
  module Js
    class Compiler
      ALL_JS_FEATURES = [:calendars]

      def initialize(options = {})
        @locales = options[:locales] || TwitterCldr.supported_locales
        @features = options[:features] || ALL_JS_FEATURES
      end

      def compile
        @locales.each do |locale|
          contents = ""

          @features.each do |feature|
            renderer_const = self.get_renderer_const(feature)
            contents << renderer_const.new(:locale => locale).render
          end

          bundle = TwitterCldr::Js::Renderers::Bundle.new
          bundle[:contents] = contents
          yield bundle.render, locale if block_given?
        end
      end

      protected

      def get_renderer_const(feature)
        case feature
          when :calendars
            TwitterCldr::Js::Renderers::Calendars::DateTimeRenderer
          else
            nil
        end
      end
    end
  end
end