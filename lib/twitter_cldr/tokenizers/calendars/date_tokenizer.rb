# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Tokenizers
    class DateTokenizer

      class << self
        def tokenizer
          @tokenizer ||= Tokenizer.new([
            TokenRecognizer.new(:composite, /^\#\{[^\}]+\}/, /^\#\{([^\}]+)\}/),
            TokenRecognizer.new(:pattern, /^(?:G{1,5}|y+|Y+|Q{1,4}|q{1,5}|M{1,5}|L{1,5}|d{1,2}|F{1}|E{1,5}|e{1,5}|c{1,5}|w{1,2}|W{1})/),
            TokenRecognizer.new(:plaintext, //)
          ], /(\s*\'[\w\s-]+\'\s*|G{1,5}|y+|Y+|Q{1,4}|q{1,5}|M{1,5}|L{1,5}|d{1,2}|F{1}|E{1,5}|e{1,5}|c{1,5}|w{1,2}|W{1}|\#\{[^\}]+\})/)
        end
      end

      attr_reader :data_reader

      def initialize(data_reader)
        @data_reader = data_reader
      end

      def tokenize(pattern)
        tokenizer.tokenize(pattern)
      end

      private

      def tokenizer
        @tokenizer ||= PatternTokenizer.new(data_reader, self.class.tokenizer)
      end

    end
  end
end
