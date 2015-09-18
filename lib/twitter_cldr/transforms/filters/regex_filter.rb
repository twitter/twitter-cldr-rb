# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Transforms
    module Filters

      class RegexFilter < FilterRule
        class << self
          def parse(rule_text, symbol_table)
            rule_text = unescape(rule_text[2..-2].strip)
            direction = direction_for(rule_text)

            str = TwitterCldr::Shared::UnicodeRegex.compile(
              clean_rule(rule_text, direction)
            ).to_regexp_str

            new(/#{str}/, direction)
          end

          protected

          def direction_for(rule_text)
            if rule_text.start_with?('(')
              :backward
            else
              :forward
            end
          end

          def clean_rule(rule_text, direction)
            if direction == :backward
              rule_text[1..-2]
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

        def apply_to(cursor)
          cursor.set_ranges(
            cursor.ranges.intersection(
              ranges_for(cursor)
            )
          )
        end

        def forward?
          direction == :forward
        end

        def backward?
          direction == :backward
        end

        protected

        def ranges_for(cursor)
          TwitterCldr::Utils::RangeSet.new(
            [].tap do |ranges|
              cursor.text.scan(regexp) do
                start, finish = Regexp.last_match.offset(0)
                ranges << (start..(finish - 1))
              end
            end
          )
        end
      end

    end
  end
end
