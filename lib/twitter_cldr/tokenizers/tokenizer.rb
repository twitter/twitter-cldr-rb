# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Tokenizers

    class TokenRecognizer

      attr_reader :token_type, :regex, :context, :cleaner

      def initialize(token_type, regex, content = nil, &block)
        @token_type = token_type
        @regex = regex
        @context = context
        @cleaner = block
      end

      def recognizes?(text)
        !!(text =~ regex)
      end

      def clean(val)
        if cleaner
          cleaner.call(val)
        else
          val
        end
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

        new(recognizers)
      end

      def initialize(recognizers)
        @recognizers = recognizers
      end

      def recognizer_at(token_type)
        recognizers.find { |r| r.token_type == token_type }
      end

      def insert_before(token_type, *new_recognizers)
        idx = recognizers.find_index { |rec| rec.token_type == token_type }
        recognizers.insert(idx, *new_recognizers)
        clear_splitter
        nil
      end

      def tokenize(text)
        text.split(splitter).inject([]) do |ret, token_text|
          recognizer = recognizers.find do |recognizer|
            recognizer.recognizes?(token_text)
          end

          if recognizer.token_type == :composite
            content = token_text.match(recognizer.content)[1]
            ret << CompositeToken.new(tokenize(content))
          else
            if (cleaned_text = recognizer.clean(token_text)).size > 0
              ret << Token.new(
                :value => cleaned_text,
                :type => recognizer.token_type
              )
            end
          end

          ret
        end
      end

      private

      def splitter
        @splitter ||= Regexp.new(
          "(" + recognizers.map do |recognizer|
            recognizer.regex.source
          end.join("|") + ")"
        )
      end

      def clear_splitter
        @splitter = nil
      end

    end
  end
end