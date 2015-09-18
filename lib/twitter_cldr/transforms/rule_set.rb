# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

# http://unicode.org/reports/tr35/tr35-general.html#Transforms
# http://unicode.org/cldr/utility/transform.jsp

module TwitterCldr
  module Transforms

    class RuleSet
      attr_reader :filter_rule, :ct_rules, :rule_index

      def initialize(filter_rule, ct_rules)
        @filter_rule = filter_rule
        @ct_rules = ct_rules
        @rule_index = build_rule_index(ct_rules)
      end

      def transform(text)
        binding.pry
        cursor = Cursor.new(text.dup)
        filter_rule.apply_to(cursor) if filter_rule

        until cursor.eos?
          if rule = find_matching_rule_at(cursor)
            start = cursor.position
            stop = cursor.position + rule.original.size
            cursor.text[start...stop] = rule.replacement

            cursor.advance(
              rule.replacement.size + rule.cursor_offset
            )
          else
            cursor.advance
          end
        end

        cursor.text
      end

      protected

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
        index_value = cursor.text[cursor.position].bytes.first
        rule_index[index_value].find do |rule|
          rule.match?(cursor)
        end
      end
    end

  end
end
