# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Shared
    class Locale

      class << self
        # http://unicode.org/reports/tr35/tr35-9.html#Likely_Subtags
        #
        # 1. Make sure the input locale is in canonical form: uses the right
        #    separator, and has the right casing.
        #
        # 2. Replace any deprecated subtags with their canonical values using
        #    the <alias> data in supplemental metadata. Use the first value in
        #    the replacement list, if it exists.
        #
        # 3. If the tag is grandfathered (see <variable id="$grandfathered"
        #    type="choice"> in the supplemental data), then return it.
        #
        # 4. Remove the script code 'Zzzz' and the region code 'ZZ' if they
        #    occur; change an empty language subtag to 'und'.
        #
        # 5. Get the components of the cleaned-up tag (language¹, script¹, and
        #    region¹), plus any variants if they exist (including keywords).
        def parse(locale_text)
          locale_text = locale_text.strip
          return Locale.new(locale_text) if grandfathered?(locale_text)

          normalize(locale_text).tap do |locale|
            replace_deprecated_subtags(locale)
            remove_placeholder_tags(locale)
          end
        end

        def valid?(locale_text)
          # make sure all subtags have at least one identity, i.e. they exist
          # in one of the language/script/region/variant lists
          identify_subtags(locale_text.strip).all? do |subtag|
            !subtag.last.empty?
          end
        end

        def parse_likely(locale_text)
          if grandfathered?(locale_text)
            new(locale_text.strip)
          else
            LikelySubtags.locale_for(locale_text)
          end
        end

        def split(locale_text)
          locale_text.strip.split(/[-_ ]/)
        end

        def grandfathered?(locale_text)
          grandfathered.include?(locale_text)
        end

        private

        def normalize(locale_text)
          Locale.new(nil).tap do |locale|
            subtags = identify_subtags(locale_text)

            until subtags.empty?
              subtag, identities = subtags.shift
              next if identities.empty?

              identities.each do |identity|
                unless subtag_set?(locale, identity)
                  set_subtag(locale, identity, subtag)
                  break
                end
              end
            end
          end
        end

        def subtag_set?(locale, identity)
          case identity
            when :variant
              false
            else
              !!locale.send(identity)
          end
        end

        def set_subtag(locale, identity, subtag)
          case identity
            when :variant
              locale.variants << normalize_subtag(subtag, identity)
            else
              locale.send(
                :"#{identity}=", normalize_subtag(subtag, identity)
              )
          end
        end

        def identify_subtags(locale_text)
          split(locale_text).map do |subtag|
            identities = identify_subtag(subtag)
            [subtag, identities]
          end
        end

        def identify_subtag(subtag)
          [].tap do |types|
            types << :language if language?(subtag)
            types << :script   if script?(subtag)
            types << :region   if region?(subtag)
            types << :variant  if variant?(subtag)
          end
        end

        def language?(subtag)
          subtag = normalize_subtag(subtag, :language)
          languages.include?(subtag) ||
            aliases_resource[:language].include?(subtag.to_sym)
        end

        def script?(subtag)
          subtag = normalize_subtag(subtag, :script)
          scripts.include?(subtag)
        end

        def region?(subtag)
          subtag = normalize_subtag(subtag, :region)
          territories.include?(subtag) ||
            aliases_resource[:territory].include?(subtag.to_sym)
        end

        def variant?(subtag)
          subtag = normalize_subtag(subtag, :variant)
          variants.include?(subtag)
        end

        def normalize_subtag(subtag, identity)
          case identity
            when :language
              subtag.downcase
            when :script
              subtag.capitalize
            when :region, :variant
              subtag.upcase
          end
        end

        def replace_deprecated_subtags(locale)
          replace_deprecated_language_subtags(locale)
          replace_deprecated_territory_subtags(locale)
        end

        def replace_deprecated_language_subtags(locale)
          language = locale.language ? locale.language.to_sym : nil
          if found_alias = aliases_resource[:language][language]
            locale.language = found_alias
          end
        end

        def replace_deprecated_territory_subtags(locale)
          region = locale.region ? locale.region.to_sym : nil
          if found_alias = aliases_resource[:territory][region]
            locale.region = found_alias
          end
        end

        def remove_placeholder_tags(locale)
          if locale.script == 'Zzzz'
            locale.script = nil
          end

          if locale.region == 'ZZ'
            locale.region = nil
          end

          locale.language ||= 'und'
        end

        def languages
          variables_resource[:language]
        end

        def scripts
          variables_resource[:script]
        end

        def territories
          variables_resource[:territory]
        end

        def variants
          variables_resource[:variant]
        end

        def grandfathered
          variables_resource[:grandfathered]
        end

        def aliases_resource
          @aliases_resource ||=
            TwitterCldr.get_resource('shared', 'aliases')[:aliases]
        end

        def variables_resource
          @variables_resource ||=
            TwitterCldr.get_resource('shared', 'variables')[:variables]
        end
      end

      attr_accessor :language, :script, :region, :variants

      def initialize(language, script = nil, region = nil, variants = [])
        @language = language ? language.to_s : nil
        @script = script ? script.to_s : nil
        @region = region ? region.to_s : nil
        @variants = Array(variants)
      end

      def full_script
        # fall back to abbreviated script if long alias can't be found
        @full_script ||= PropertyValueAliases.long_alias_for('sc', script) || script
      end

      def maximize
        if Locale.grandfathered?(to_s)
          self
        else
          LikelySubtags.locale_for(to_s)
        end
      end

      def dasherized
        join('-')
      end

      def join(delimiter = '_')
        to_a.join(delimiter)
      end

      alias :underscored :join
      alias :to_s :join

      def to_a
        ([language, script, region] + variants).compact
      end

    end
  end
end
