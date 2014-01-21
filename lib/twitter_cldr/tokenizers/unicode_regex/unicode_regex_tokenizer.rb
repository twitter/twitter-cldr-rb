# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Tokenizers
    class UnicodeRegexTokenizer

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
            TokenRecognizer.new(:multichar_string, /\{[#{w}]+\}/u),

            TokenRecognizer.new(:escaped_character, /\\#{w}/u),
            TokenRecognizer.new(:negate, /\^/),
            TokenRecognizer.new(:ampersand, /&/),
            TokenRecognizer.new(:dash, /-/),

            TokenRecognizer.new(:open_bracket, /\[/),
            TokenRecognizer.new(:close_bracket, /\]/),

            TokenRecognizer.new(:string, //) do |val|
              val.strip
            end
          ]

          Tokenizer.new(recognizers)
        end
      end

    end
  end
end