# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Tokenizers

    TokenRecognizer = Struct.new(:token_type, :regex, :content) do
      def recognizes?(text)
        !!(text =~ regex)
      end
    end

    class Tokenizer

      attr_reader :splitter, :recognizers

      def self.union(*tokenizers)
        recognizers = tokenizers.inject([]) do |ret, tokenizer|
          ret + tokenizer.recognizers.inject([]) do |recog_ret, recognizer|
            if (block_given? && yield(recognizer)) || !block_given?
              recog_ret << recognizer
            end
            recog_ret
          end
        end

        splitter = Regexp.compile(
          tokenizers.map do |tokenizer|
            tokenizer.splitter.source
          end.join("|")
        )

        new(splitter, recognizers)
      end

      def initialize(splitter, recognizers)
        @splitter = splitter
        @recognizers = recognizers
      end

      def recognizer_at(token_type)
        recognizers.find { |r| r.token_type == token_type }
      end

      def tokenize(text)
        text.split(splitter).inject([]) do |ret, token_text|
          recognizer = recognizers.find do |recognizer|
            recognizer.recognizes?(token_text)
          end

          ret << if recognizer.token_type == :composite
            content = token_text.match(recognizer.content)[1]
            CompositeToken.new(tokenize(content))
          else
            Token.new(
              :value => token_text,
              :type => recognizer.token_type
            )
          end

          ret
        end
      end

    end
  end
end