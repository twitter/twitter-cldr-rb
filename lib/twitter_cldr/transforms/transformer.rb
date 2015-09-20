# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Transforms

    # @TODO: remove this when likely subtags code is committed
    Locale = Struct.new(:language, :script, :region, :variant) do
      def maximize
        self
      end
    end

    class Transformer
      CHAIN = [
        :normal_fallback1, :normal_fallback2, :laddered_fallback1,
        :normal_fallback3, :laddered_fallback2
      ]

      class << self
        def find(source_locale, target_locale)
          source_chain = map_chain_for(source_locale)
          target_chain = map_chain_for(target_locale)
          variants = variants_for(source_locale, target_locale)

          find_in_chains(
            source_chain, target_chain, variants
          )
        end

        def exists?(source_locale_str, target_locale_str)
          !!get(source_locale_str, target_locale_str)
        end

        def get(source_locale_str, target_locale_str)
          resource_name = join_locale_strs(source_locale_str, target_locale_str)
          reversed_resource_name = join_locale_strs(target_locale_str, source_locale_str)

          if RuleGroup.exists?(resource_name)
            RuleGroup.load(resource_name).forward_rule_set
          elsif RuleGroup.exists?(reversed_resource_name)
            rule_group = RuleGroup.load(reversed_resource_name)

            if rule_group.bidirectional?
              rule_group.backward_rule_set
            end
          end
        end

        protected

        def find_in_chains(source_chain, target_chain, variants)
          variants.each do |variant|
            target_chain.each do |target|
              source_chain.each do |source|
                source_str = join_subtags(source, variant)
                target_str = join_subtags(target, variant)

                if rule_set = get(source_str, target_str)
                  return rule_set
                end
              end
            end
          end
        end

        def join_locale_strs(source_str, target_str)
          "#{source_str}-#{target_str}"
        end

        def join_subtags(tags, variant)
          result = tags.join('_')
          resut << "_#{variant}" if variant
          result
        end

        def variants_for(source_locale, target_locale)
          [source_locale.variant, target_locale.variant, nil].uniq
        end

        def map_chain_for(locale)
          CHAIN.map { |link| send(link, locale) }
        end

        def normal_fallback1(locale)
          [locale.language, locale.script, locale.region]
        end

        def normal_fallback2(locale)
          [locale.language, locale.script]
        end

        def normal_fallback3(locale)
          [locale.language]
        end

        def laddered_fallback1(locale)
          [locale.language, locale.region]
        end

        def laddered_fallback2(locale)
          [locale.script]
        end
      end
    end

  end
end
