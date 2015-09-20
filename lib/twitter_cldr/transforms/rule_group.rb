# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

# http://unicode.org/reports/tr35/tr35-general.html#Transforms
# http://unicode.org/cldr/utility/transform.jsp

module TwitterCldr
  module Transforms

    class RuleGroup
      class << self
        def load(resource_name)
          rule_groups[resource_name] ||= begin
            resource = resource_for(resource_name)
            direction = direction_from(resource)
            new(parse_resource(resource), direction)
          end
        end

        def exists?(resource_name)
          TwitterCldr.resource_exists?(
            'shared', 'transforms', resource_name
          )
        end

        protected

        def direction_from(resource)
          case transform_from(resource)[:direction]
            when 'both'
              :bidirectional
            else
              :forward
          end
        end

        def rule_groups
          @rule_groups ||= {}
        end

        def parse_resource(resource)
          symbol_table = {}
          rules = []

          parse_each(resource, symbol_table) do |rule|
            if rule.is_a?(VariableRule)
              symbol_table[rule.name] = rule
            else
              rules << rule
            end
          end

          rules
        end

        def parse_each(resource, symbol_table)
          rules_from(resource).each do |rule_text|
            yield parse_rule(rule_text, symbol_table)
          end
        end

        def parse_rule(rule_text, symbol_table)
          rule_type = identify_rule_type(rule_text)
          class_for_rule_type(rule_type).parse(rule_text, symbol_table)
        end

        def class_for_rule_type(rule_type)
          rule_type = rule_type.to_s.capitalize

          case rule_type
            when 'Variable'
              VariableRule
            else
              const = Transforms.const_get(rule_type + 's')
              const.const_get(rule_type + 'Rule')
          end
        end

        def identify_rule_type(rule_text)
          rule_text.strip!

          if rule_text[0..1] == '::'
            :filter
          elsif rule_text[0..0] == '$'
            :variable
          else
            :conversion
          end
        end

        def rules_from(resource)
          transform_from(resource)[:rules]
        end

        def transform_from(resource)
          resource[:transforms].first
        end

        def resource_for(resource_name)
          TwitterCldr.get_resource('shared', 'transforms', resource_name)
        end
      end

      attr_reader :rules, :direction

      def initialize(rules, direction)
        @rules = rules
        @direction = direction
      end

      # all rules are either forward or bidirectional
      def bidirectional?
        direction == :bidirectional
      end

      def forward_rule_set
        @forward_rule_set ||= begin
          ct_rules = rules.select do |rule|
            rule.forward? && rule.is_ct_rule?
          end

          filter_rule = if is_forward_filter?(rules.first)
            rules.first
          end

          RuleSet.new(filter_rule, ct_rules)
        end
      end

      def backward_rule_set
        @backward_rule_set ||= begin
          ct_rules = rules.each_with_object([]) do |rule, ret|
            if rule.is_ct_rule?
              if rule.backward?
                ret << rule
              elsif rule.can_invert?
                ret << rule.invert
              end
            end
          end

          filter_rule = if is_backward_filter?(rules.last)
            rules.last
          end

          RuleSet.new(filter_rule, ct_rules)
        end
      end

      protected

      def is_forward_filter?(rule)
        rule.is_a?(Filters::FilterRule) && !rule.backward?
      end

      def is_backward_filter?(rule)
        rule.is_a?(Filters::FilterRule) && rule.backward?
      end
    end

  end
end
