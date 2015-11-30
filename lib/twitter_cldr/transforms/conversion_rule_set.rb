# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

# http://unicode.org/reports/tr35/tr35-general.html#Transforms
# http://unicode.org/cldr/utility/transform.jsp

module TwitterCldr
  module Transforms

    class ConversionRuleSet
      attr_reader :filter_rule, :rules, :rule_index

      def initialize(filter_rule, rules)
        @rules = rules
        @filter_rule = filter_rule
        @rule_index = build_rule_index(rules)
      end

      def apply_to(cursor)
        until cursor.eos?
          if filter_rule.matches?(cursor)
            rule, side_match = find_matching_rule_at(cursor)

            if rule
              start = side_match.start
              stop = side_match.stop
              replacement = rule.replacement_for(cursor)

              if start == stop
                cursor.text.insert(start + 1, replacement)
                cursor.advance(1)
              else
                cursor.text[start...stop] = replacement
              end

              cursor.advance(
                replacement.size + rule.cursor_offset
              )
            else
              cursor.advance
            end
          else
            cursor.advance
          end
        end
      end

      private

      def find_matching_rule_at(cursor)
        if rules = rule_index.get(cursor.index_values)
          rules.each do |rule|
            if side_match = rule.match(cursor)
              return [rule, side_match]
            end
          end
        end

        if rules = rule_index.get([0])
          rules.each do |rule|
            if side_match = rule.match(cursor)
              return [rule, side_match]
            end
          end
        end

        nil
      end

      def build_rule_index(rules)
        TwitterCldr::Collation::Trie.new.tap do |trie|
          rules.each do |rule|
            if rule.has_codepoints?
              codepoints = rule.codepoints

              if codepoints.size > 0
                rule.codepoints.each do |codepoint|
                  bytes = codepoint.chr('UTF-8').bytes

                  if entry = trie.get(bytes)
                    entry << rule
                  else
                    trie.add(bytes, [rule])
                  end
                end
              end
            else
              if entry = trie.get([0])
                entry << rule
              else
                trie.add([0], [rule])
              end
            end
          end
        end
      end
    end

  end
end
