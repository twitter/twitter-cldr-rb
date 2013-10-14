# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Tokenizers
    class NumberTokenizer

      attr_reader :data_reader

      def initialize(data_reader)
        @data_reader = data_reader
      end

      def tokenize(pattern)
        tokens = PatternTokenizer.new(data_reader, tokenizer).tokenize(pattern)

        if tokens.first.value == ""
          tokens[1..-1]
        else
          tokens
        end
      end

      private

      def tokenizer
        @tokenizer ||= Tokenizer.new(
          /([^0*#,\.]*)([0#,\.]+)([^0*#,\.]*)$/, [
            TokenRecognizer.new(:pattern, /[0?#,\.]*/),
            TokenRecognizer.new(:plaintext, //)
          ]
        )
      end

    end
  end
end