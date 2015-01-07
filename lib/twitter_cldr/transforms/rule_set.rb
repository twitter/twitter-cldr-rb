# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Transforms

    class RuleSet
      class << self
        def find(source, target)
          if name = resource_name_for(source, target)
            symbol_table = {}
            rules = []

            parse_each(resource_for(name), symbol_table) do |rule|
              if rule.is_a?(Variable)
                symbol_table[rule.name] = rule
              else
                rules << rule
              end
            end

            rule_sets[name] ||= from_rules(name, rules)
          else
            raise ArgumentError,
              "Can't find rule set for '#{source}' and '#{target}' scripts."
          end
        end

        protected

        def from_rules(name, rules)
          filter_rule = filter_rule_from(rules)
          ct_rules = ct_rules_from(rules)
          inverse_filter_rule = inverse_filter_from(rules)
          new(name, filter_rule, ct_rules, inverse_filter_rule)
        end

        def filter_rule_from(rules)
          if rules.first.is_a?(Filter) && !rules.first.inverse?
            rules.first
          end
        end

        # conversion/transform rules
        def ct_rules_from(rules)
          index = rules.first.is_a?(Filter) ? 1 : 0

          [].tap do |ret|
            index.upto(rules.length - 1) do |idx|
              case rules[idx]
                when Conversion, Transform
                  ret << rules[idx]
              end
            end
          end
        end

        def inverse_filter_from(rules)
          if rules.last.is_a?(Filter) && rules.last.inverse?
            rules.last
          end
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
          Transforms.const_get(rule_type.to_s.capitalize)
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

      attr_reader :name, :filter_rule
      attr_reader :ct_rules, :inverse_filter_rule
      attr_reader :rule_index

      def initialize(name, filter_rule, ct_rules, inverse_filter_rule)
        @name = name
        @filter_rule = filter_rule
        @ct_rules = ct_rules
        @inverse_filter_rule = inverse_filter_rule
        @rule_index = build_rule_index(ct_rules)
      end

      def transform(text, direction = :forward)
        cursor = Cursor.new(text.dup, direction)
        filter_rule.apply_to(cursor) if filter_rule

        until cursor.eos?
          if rule = find_matching_rule_at(cursor)
            start = cursor.position
            stop = cursor.position + sizeof(rule.original)
            cursor.text[start...stop] = rule.replacement

            cursor.advance(
              sizeof(rule.replacement) + rule.cursor_offset
            )
          else
            cursor.advance
          end
        end

        cursor.text.to_s
      end

      protected

      def sizeof(str)
        TwitterCldr::Utils::ByteString.sizeof(str)
      end

      def build_rule_index(ct_rules)
        index_hash = Hash.new { |h, k| h[k] = [] }
        ct_rules.inject(index_hash) do |ret, rule|
          if rule.respond_to?(:index_value)
            ret[rule.index_value] << rule
          end
          ret
        end
      end

      def find_matching_rule_at(cursor)
        index_value = cursor.text.getbyte(cursor.position)
        rule_index[index_value].find do |rule|
          rule.match?(cursor)
        end
      end
    end

  end
end
