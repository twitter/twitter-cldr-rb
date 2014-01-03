# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Tokenizers
    class DateTimeTokenizer

      attr_reader :data_reader

      def initialize(data_reader)
        @data_reader = data_reader
      end

      def tokenize(pattern)
        expand_tokens(
          PatternTokenizer.new(data_reader, tokenizer).tokenize(pattern)
        )
      end

      protected

      def expand_tokens(tokens)
        tokens.inject([]) do |ret, token|
          ret += case token.type
            when :date
              expand_date(token)
            when :time
              expand_time(token)
            else
              [token]
          end
          ret
        end
      end

      def expand_date(token)
        date_reader = data_reader.date_reader
        date_reader.tokenizer.tokenize(date_reader.pattern)
      end

      def expand_time(token)
        time_reader = data_reader.time_reader
        time_reader.tokenizer.tokenize(time_reader.pattern)
      end

      def tokenizer
        @tokenizer ||= Tokenizer.new(
          /(\{\{date\}\}|\{\{time\}\})/, [
            TokenRecognizer.new(:date, /\{\{date\}\}/),
            TokenRecognizer.new(:time, /\{\{time\}\}/),
            TokenRecognizer.new(:plaintext, //)
          ]
        )
      end

    end
  end
end