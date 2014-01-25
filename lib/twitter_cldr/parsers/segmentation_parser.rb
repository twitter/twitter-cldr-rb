# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Parsers

    module Segmentation
      autoload :Rule, "twitter_cldr/parsers/segmentation/rule"
    end

    class SegmentationParser < Parser

      private

      def do_parse(options)
        current_regex_tokens = []
        rule = Segmentation::Rule.new

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
        regex_parser.parse(tokens, options)
      end

      def regex_parser
        @@regex_parser ||= UnicodeRegexParser.new
      end

    end
  end
end