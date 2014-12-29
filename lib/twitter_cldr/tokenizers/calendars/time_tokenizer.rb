# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Tokenizers
    class TimeTokenizer

      attr_reader :data_reader

      def initialize(data_reader)
        @data_reader = data_reader
      end

      def tokenize(pattern)
        PatternTokenizer.new(data_reader, tokenizer).tokenize(pattern)
      end

      def tokenizer
        @tokenizer ||= Tokenizer.new([
          TokenRecognizer.new(:pattern, /^(a{1}|h{1,2}|H{1,2}|K{1,2}|k{1,2}|m{1,2}|s{1,2}|S+|z{1,4}|Z{1,4})/),
          TokenRecognizer.new(:plaintext, //)
        ], /(\'[\w\s-]+\'|a{1}|h{1,2}|H{1,2}|K{1,2}|k{1,2}|m{1,2}|s{1,2}|S+|z{1,4}|Z{1,4})/)
      end

    end
  end
end