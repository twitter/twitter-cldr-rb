# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Transforms
    module Filters

      class RegexFilter < FilterRule
        class << self
          def parse(rule_text, symbol_table)
            rule_text = Rule.remove_comment(rule_text)
            rule_text = rule_text[2..-2].strip
            direction = direction_for(rule_text)

            str = TwitterCldr::Shared::UnicodeRegex.compile(
              clean_rule(rule_text, direction)
            ).to_regexp_str

            new(/#{str}/, direction)
          end

          def accepts?(rule_text)
            !!(rule_text =~ /\A::[\s]*\(?[\s]*\[/)
          end

          private

          def direction_for(rule_text)
            if rule_text.start_with?('(')
              :backward
            else
              :forward
            end
          end

          def clean_rule(rule_text, direction)
            if direction == :backward
              rule_text[1..-2].strip
            else
              rule_text
            end
          end
        end

        attr_reader :regexp, :direction

        def initialize(regexp, direction)
          @regexp = regexp
          @direction = direction
        end

        def resolve(symbol_table)
          self
        end

        def matches?(cursor)
          idx = cursor.text.index(regexp, cursor.position)
          idx == cursor.position
        end

        def forward?
          direction == :forward
        end

        def backward?
          direction == :backward
        end
      end

    end
  end
end
