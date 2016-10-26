# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

# http://unicode.org/reports/tr35/tr35-general.html#Transforms
# http://unicode.org/cldr/utility/transform.jsp

module TwitterCldr
  module Transforms

    class RuleSet
      attr_reader :filter_rule, :inverse_filter_rule
      attr_reader :rules, :transform_id

      def initialize(filter_rule, inverse_filter_rule, ct_rules, transform_id)
        @filter_rule = filter_rule
        @inverse_filter_rule = inverse_filter_rule
        @rules = partition(ct_rules)
        @transform_id = transform_id
      end

      def clone_with_replacement_filter(replacement_filter)
        self.class.new(
          replacement_filter, nil, rules, transform_id
        )
      end

      def transform(text)
        cursor = Cursor.new(text.dup)
        rules.each { |rule| rule.apply_to(cursor) }
        cursor.text
      end

      def invert
        self.class.new(
          inverse_filter_rule, filter_rule,
          rules.reverse.map(&:invert), transform_id
        )
      end

      private

      def partition(ct_rules)
        [].tap do |result|
          until ct_rules.empty?
            trans_rules = take_transforms(ct_rules)
            conv_rules = take_conversions(ct_rules)
            result.concat(trans_rules)

            unless conv_rules.empty?
              result << make_conversion_rule_set(conv_rules)
            end

            # Handles the ConversionRuleSet case, which is neither
            # a transform rule nor a conversion rule.
            # ConversionRuleSets can occasionally exist in the list
            # of rules if, say, the rule set is being inverted and
            # therefore already contains a list of partitioned rules.
            if trans_rules.empty? && conv_rules.empty?
              result << ct_rules.delete_at(0)
            end
          end
        end
      end

      def take_transforms(rules)
        take_rules(rules, &:is_transform_rule?)
      end

      def take_conversions(rules)
        take_rules(rules, &:is_conversion_rule?)
      end

      def take_rules(rules)
        [].tap do |result|
          rules.reject! do |rule|
            if yield(rule)
              result << rule
            else
              break
            end
          end
        end
      end

      def make_conversion_rule_set(rules)
        TwitterCldr::Transforms::ConversionRuleSet.new(
          filter_rule, inverse_filter_rule, rules
        )
      end
    end

  end
end
