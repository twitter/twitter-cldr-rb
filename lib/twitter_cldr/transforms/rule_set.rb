# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

# http://unicode.org/reports/tr35/tr35-general.html#Transforms
# http://unicode.org/cldr/utility/transform.jsp

module TwitterCldr
  module Transforms

    class RuleSet
      attr_reader :filter_rule, :rules

      def initialize(filter_rule, ct_rules)
        @filter_rule = filter_rule
        @rules = partition(ct_rules)
      end

      def transform(text)
        cursor = Cursor.new(text.dup)
        rules.each { |rule| rule.apply_to(cursor) }
        cursor.text
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
          filter_rule, rules
        )
      end
    end

  end
end
