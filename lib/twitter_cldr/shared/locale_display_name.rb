module TwitterCldr
  module Shared
    class LocaleDisplayName
      attr_reader :locale, :dest_locale

      class << self
        def from_code(code)
          from_code_for_locale(code, TwitterCldr.locale)
        end

        def from_code_for_locale(code, locale)
          new(code, locale).display_name
        end
      end

      def initialize(locale, dest_locale = TwitterCldr.locale)
        @locale = locale
        @dest_locale = dest_locale
      end

      # `display_name` implements the CLDR Locale Display Name algorithm as
      # defined in the Unicode CLDR specification.
      #
      # @see https://www.unicode.org/reports/tr35/tr35-general.html#locale_display_name_algorithm
      def display_name
        input_locale = TwitterCldr::Shared::Locale.parse(locale)
        base_code, lbn =
          input_locale
            .permutations('-')
            .map { |code| [code, TwitterCldr::Shared::Languages.from_code_for_locale(code, dest_locale)] }
            .find { |_, name| !name.nil? }
        base_locale = TwitterCldr::Shared::Locale.parse(base_code)

        lqs = []

        if !base_locale.region && (input_region = input_locale.region)
          lqs << TwitterCldr::Shared::Territories.from_territory_code_for_locale(input_region, dest_locale)
        end

        # We do not support scripts, variants, or t/u extensions at this time

        return lbn if lqs.empty?

        pattern = locale_pattern
        pattern.gsub("{0}", lbn).gsub("{1}", lqs.join(locale_separator))
      end

      def locale_pattern
        get_resource[:locale_display_pattern][:locale_pattern]
      end

      def locale_separator
        get_resource[:locale_display_pattern][:locale_separator]
      end

      def locale_key_type_pattern
        get_resource[:locale_display_pattern][:locale_key_type_pattern]
      end

      private

      def get_resource
        converted_locale = TwitterCldr.convert_locale(dest_locale)
        TwitterCldr.get_locale_resource(converted_locale, :locale_display_pattern)[converted_locale]
      end
    end
  end
end
