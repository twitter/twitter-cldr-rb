# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

include TwitterCldr::Shared

module TwitterCldr
  module Parsers

    class SegmentationParser < Parser

      RuleMatchData = Struct.new(:text, :boundary_offset)

      Rule = Struct.new(:left, :right, :boundary_symbol, :string, :id) do
        def match(str)
          if left && left_match = left.match(str)
            match_pos = left_match.offset(0).last

            if right
              if right_match = right.match(str[match_pos..-1])
                RuleMatchData.new(
                  left_match[0] + right_match[0],
                  match_pos
                )
              end
            else
              RuleMatchData.new(str, str.size)
            end
          end
        end
      end

      private

      def do_parse(options)
        current_regex_tokens = []
        rule = Rule.new

        while current_token
          case current_token.type
            when :break, :no_break
              rule.boundary_symbol = current_token.type
              rule.left = parse_regex(
                current_regex_tokens, options
              )
              current_regex_tokens.clear
            else
              current_regex_tokens << current_token
          end

          next_token(current_token.type)
        end

        rule.right = parse_regex(
          current_regex_tokens, options
        )

        rule
      end

      def parse_regex(tokens, options)
        unless tokens.empty?
          UnicodeRegex.new(
            regex_parser.parse(tokens, options)
          )
        end
      end

      def regex_parser
        @@regex_parser ||= UnicodeRegexParser.new
      end

    end
  end
end
