# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Parsers

    class SegmentationParser < Parser

      RuleMatchData = Struct.new(:text, :boundary_offset)

      class Rule
        attr_accessor :string, :id
      end

      class BreakRule < Rule

        attr_reader :left, :right

        def initialize(left, right)
          @left = left
          @right = right
        end

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

        def boundary_symbol
          :break
        end

      end

      class NoBreakRule < Rule

        attr_reader :regex

        def initialize(regex)
          @regex = regex
        end

        def match(str)
          if match = regex.match(str)
            RuleMatchData.new(match[0], match.offset(0).last)
          end
        end

        def boundary_symbol
          :no_break
        end

      end

      private

      def do_parse(options)
        regex_token_lists = []
        current_regex_tokens = []
        boundary_symbol = nil

        while current_token
          case current_token.type
            when :break, :no_break
              boundary_symbol = current_token.type
              regex_token_lists << current_regex_tokens
              current_regex_tokens = []
            else
              current_regex_tokens << current_token
          end

          next_token(current_token.type)
        end

        regex_token_lists << current_regex_tokens

        case boundary_symbol
          when :break
            BreakRule.new(
              parse_regex(add_anchors(regex_token_lists[0]), options),
              parse_regex(add_anchors(regex_token_lists[1]), options)
            )
          when :no_break
            NoBreakRule.new(
              parse_regex(add_anchors(regex_token_lists.flatten), options)
            )
        end
      end

      # only find matches from the beginning of the current string
      def add_anchors(token_list)
        token_list.insert(0, begin_token)
      end

      def begin_token
        self.class.begin_token
      end

      def self.begin_token
        @begin_token ||= TwitterCldr::Tokenizers::Token.new(
          :type => :special_char, :value => "\\A"
        )
      end

      def parse_regex(tokens, options)
        unless tokens.empty?
          TwitterCldr::Shared::UnicodeRegex.new(
            regex_parser.parse(tokens, options)
          )
        end
      end

      def regex_parser
        self.class.regex_parser
      end

      def self.regex_parser
        @regex_parser ||= UnicodeRegexParser.new
      end

    end
  end
end
