# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Tokenizers
    class UnicodeSetTokenizer

      extend Forwardable
      def_delegator :tokenizer, :insert_before

      def tokenize(pattern)
        tokenizer.tokenize(pattern)
      end

      private

      def tokenizer
        @tokenizer ||= begin
          w = if RUBY_VERSION <= "1.8.7"
            "\w"
          else
            "[:word:]"
          end

          recognizers = [
            # The variable name can contain letters and digits, but must start with a letter.
            TokenRecognizer.new(:variable, /\$[#{w}][#{w}\d]*/u),
            TokenRecognizer.new(:character_set, /\[:[\w]+:\]|\\p\{[\w]+\}/),  # [:Lu:] or \p{Lu}
            TokenRecognizer.new(:negated_character_set, /\[:\^[\w]+:\]|\\P\{[\w]+\}/),  #[:^Lu:] or \P{Lu}
            TokenRecognizer.new(:unicode_char, /\\u[a-fA-F0-9]{1,6}/),

            TokenRecognizer.new(:negate, /\^/),
            TokenRecognizer.new(:star, /\*/),
            TokenRecognizer.new(:question_mark, /\?/),
            TokenRecognizer.new(:pipe, /\|/),
            TokenRecognizer.new(:intersection, /&/),
            TokenRecognizer.new(:dash, /-/),

            TokenRecognizer.new(:open_curly, /\{/),
            TokenRecognizer.new(:close_curly, /\}/),
            TokenRecognizer.new(:open_paren, /\(/),
            TokenRecognizer.new(:close_paren, /\)/),
            TokenRecognizer.new(:open_bracket, /\[/),
            TokenRecognizer.new(:close_bracket, /\]/),

            TokenRecognizer.new(:literal, //) do |val|
              val.strip
            end
          ]

          Tokenizer.new(recognizers)
        end
      end

    end
  end
end