# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Transforms

    class Conversion < Rule
      autoload :Base,            'twitter_cldr/transforms/conversion/base'
      autoload :Node,            'twitter_cldr/transforms/conversion/node'
      autoload :ResolvedNode,    'twitter_cldr/transforms/conversion/node'
      autoload :DirectionNode,   'twitter_cldr/transforms/conversion/direction_node'
      autoload :Context,         'twitter_cldr/transforms/conversion/context'
      autoload :ResolvedContext, 'twitter_cldr/transforms/conversion/context'
      autoload :Parser,          'twitter_cldr/transforms/conversion/parser'

      class << self
        def parse(rule_text)
          tokens = tokenizer.tokenize(
            unescape(remove_comment(rule_text))
          )

          new(parser.parse(tokens))
        end

        protected

        def parser
          @parser ||= Parser.new
        end

        def remove_comment(rule_text)
          if rule_idx = rule_text.index('#')
            rule_text[0...rule_idx]
          else
            rule_text
          end
        end

        # Warning: not thread-safe
        def parser
          @parser ||= Parser.new
        end

        def tokenizer
          @tokenizer ||= begin
            recognizers = [
              TwitterCldr::Tokenizers::TokenRecognizer.new(:variable, /\$\w[\w\d]*/),
              TwitterCldr::Tokenizers::TokenRecognizer.new(:direction, /[<>]{1,2}/),
              TwitterCldr::Tokenizers::TokenRecognizer.new(:cursor, /\|/),
              TwitterCldr::Tokenizers::TokenRecognizer.new(:before_context, /[{]/),
              TwitterCldr::Tokenizers::TokenRecognizer.new(:after_context, /[}]/),
              TwitterCldr::Tokenizers::TokenRecognizer.new(:semicolon, /;/),
              TwitterCldr::Tokenizers::TokenRecognizer.new(:string, //)
            ]

            TwitterCldr::Tokenizers::Tokenizer.new(recognizers)
          end
        end
      end

      attr_reader :root

      def initialize(root)
        @root = root
      end

      def resolve(symbol_table)
        ResolvedConversion.new(
          root.resolve(symbol_table)
        )
      end
    end

    class ResolvedConversion
      attr_reader :root

      def initialize(root)
        @root = root
      end

      def match(cursor)
        if correct_direction?(cursor.direction)
        end
      end

      protected

      def correct_direction?(direction)
        if direction == :bidirectional
          true
        else
          direction == root.operator
        end
      end
    end

  end
end
