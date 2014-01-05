# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Tokenizers
    class RbnfTokenizer

      def tokenize(pattern)
        PatternTokenizer.new(nil, tokenizer).tokenize(pattern)
      end

      private

      def tokenizer
        # i.e. %spellout-numbering, %%2d-year
        rule_regex = if RUBY_VERSION <= "1.8.7"
          /%%?[\w\-]+/u
        else
          Regexp.new("%%?[[:word:]\-]+")
        end

        recognizers = [
          # special rule descriptors
          TokenRecognizer.new(:negative, /-x/),
          TokenRecognizer.new(:improper_fraction, /x\.x/),
          TokenRecognizer.new(:proper_fraction, /0\.x/),
          TokenRecognizer.new(:master, /x\.0/),

          # normal rule descriptors
          TokenRecognizer.new(:equals, /=/),
          TokenRecognizer.new(:rule, rule_regex),
          TokenRecognizer.new(:right_arrow, />/),
          TokenRecognizer.new(:left_arrow, /</),
          TokenRecognizer.new(:open_bracket, /\[/),
          TokenRecognizer.new(:close_bracket, /\]/),
          TokenRecognizer.new(:decimal, /[0#][0#,\.]+/),

          # ending
          TokenRecognizer.new(:semicolon, /;/),
        ]

        @tokenizer ||= Tokenizer.new(
          /(#{recognizers.map { |rec| rec.regex.source }.join("|")})/,
          recognizers + [
            TokenRecognizer.new(:plaintext, //)  # catch-all
          ]
        )
      end

    end
  end
end