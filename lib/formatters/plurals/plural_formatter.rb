# encoding: UTF-8

module TwitterCldr
  module Formatters
    class PluralFormatter < Base

      PLURAL_INTERPOLATION_RE  = /%\{(\w+?):(\w+?)\}/

      attr_accessor :locale

      def initialize(options = {})
        self.locale = extract_locale(options)
      end

      def format(string, replacements)
        string.gsub(PLURAL_INTERPOLATION_RE) do |match|
          number   = replacements[$1.to_sym]
          patterns = replacements[$2.to_sym]
          pattern  = number && patterns && patterns[pluralization_rule(number)]

          pattern && interpolate_pattern(pattern, $1, number) || match
        end
      end

      private

      def pluralization_rule(number)
        TwitterCldr::Formatters::Plurals::Rules.rule_for(number, locale)
      end

      def interpolate_pattern(pattern, placeholder, number)
        pattern.gsub("%{#{placeholder}}", number.to_s)
      end

    end
  end
end