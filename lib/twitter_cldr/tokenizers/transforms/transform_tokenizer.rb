# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Tokenizers
    class TransformTokenizer

      def tokenize(pattern)
        PatternTokenizer.new(nil, tokenizer).tokenize(pattern)
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
            TokenRecognizer.new(:equals, /=/),
            TokenRecognizer.new(:unicode_set, /\[:[#{w}\d\s]+:\]/u),

            TokenRecognizer.new(:comment, /#.*/),

            TokenRecognizer.new(:double_colon, /::/),
            TokenRecognizer.new(:caret, /\^/),
            TokenRecognizer.new(:revisit_mark, /\|/),

            TokenRecognizer.new(:open_curly, /\{/),
            TokenRecognizer.new(:close_curly, /\}/),
            TokenRecognizer.new(:open_paren, /\(/),
            TokenRecognizer.new(:close_paren, /\)/),
            TokenRecognizer.new(:open_bracket, /\[/),
            TokenRecognizer.new(:close_bracket, /\]/),

            TokenRecognizer.new(:dual, /<>/),
            TokenRecognizer.new(:backward, /</),
            TokenRecognizer.new(:forward, />/),

            TokenRecognizer.new(:semicolon, /;/),
            TokenRecognizer.new(:literal, /['"#{w}\d\-_\s\t\/\\]*/u) do |val|
              val.strip
            end,
          ]

          Tokenizer.new(
            /(#{recognizers.map { |rec| rec.regex.source }.join("|")})/,
            recognizers
          )
        end
      end

    end
  end
end