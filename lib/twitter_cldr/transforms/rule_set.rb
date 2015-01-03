# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Transforms

    class RuleSet
      class << self
        def find(source, target)
          if name = resource_name_for(source, target)
            rules = parse(resource_for(name))
            symbol_table = build_symbol_table_for(rules)
            rule_sets[name] ||= new(name, resolve(rules, symbol_table))
          else
            raise ArgumentError,
              "Can't find rule set for '#{source}' and '#{target}' scripts."
          end
        end

        protected

        def resolve(rules, symbol_table)
          rules.each_with_object([]) do |rule, ret|
            unless rule.is_a?(Variable)
              ret << rule.resolve(symbol_table)
            end
          end
        end

        def build_symbol_table_for(rules)
          rules.each_with_object({}) do |rule, ret|
            if rule.is_a?(Variable)
              ret[rule.name] = rule
            end
          end
        end

        def parse(resource)
          rules_from(resource).map do |rule_text|
            parse_rule(rule_text)
          end
        end

        def parse_rule(rule_text)
          rule_type = identify_rule_type(rule_text)
          class_for_rule_type(rule_type).parse(rule_text)
        end

        def class_for_rule_type(rule_type)
          Transforms.const_get(rule_type.to_s.capitalize)
        end

        def identify_rule_type(rule_text)
          rule_text.strip!

          if rule_text[0..1] == '::'
            :filter
          elsif rule_text[0] == '$'
            :variable
          else
            :conversion
          end
        end

        def rule_sets
          @rule_sets ||= {}
        end

        def rules_from(resource)
          resource[:transforms].first[:rules]
        end

        # Naïve implementation that doesn't take fallbacks or likely subtags
        # into account.
        # @TODO will need to be improved later.
        def resource_name_for(source, target)
          "#{source}-#{target}"
        end

        def resource_for(resource_name)
          TwitterCldr.get_resource('shared', 'transforms', resource_name)
        end
      end

      attr_reader :name, :rules

      def initialize(name, rules)
        @name = name
        @rules = rules
      end

      def transform(text, direction = :forward)
        cursor = Cursor.new(text, direction)
      end

      protected

      def match_positions(cursor, starting_at)
        starting_at.upto(rules.size) do |idx|
          match_positions_for(rules[idx])
        end
      end

      def match_positions_for(rule)
      end
    end

  end
end
