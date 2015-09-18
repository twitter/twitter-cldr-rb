# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Transforms
    module Conversions

      class ConversionRule < Rule
        class << self
          def parse(rule_text, symbol_table)
            cleaned_rule_text = unescape(
              remove_comment(rule_text)
            )

            tokens = replace_symbols(
              tokenizer.tokenize(cleaned_rule_text),
              symbol_table
            )

            parser.parse(tokens)
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

        attr_reader :direction, :left, :right

        def initialize(direction, left, right)
          @direction = direction
          @left = left
          @right = right
        end

        def can_invert?
          direction == :bidirectional
        end

        def forward?
          direction == :bidirectional || direction == :forward
        end

        def backward?
          direction == :backward
        end

        def is_ct_rule?
          true
        end

        def invert
          if can_invert?
            self.class.new(@direction, right, left)
          else
            raise NotInvertibleError,
              "cannot invert this #{self.class.name}"
          end
        end

        def index_value
          left.index_value
        end

        def match?(cursor)
          left.match?(cursor)
        end

        def original
          left.before_context +
            left.key +
            left.after_context
        end

        def replacement
          right.key
        end

        def cursor_offset
          right.cursor_offset
        end
      end

    end
  end
end
