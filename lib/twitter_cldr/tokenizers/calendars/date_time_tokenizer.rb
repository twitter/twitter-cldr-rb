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

      def tokenize(pattern, data_reader)
        PatternTokenizer.new(data_reader, tokenizer).tokenize(pattern)
      end

      protected

      def tokenizer
        @tokenizer ||= Tokenizer.new(
          /(\{\{date\}\}|\{\{time\}\})/, [
            TokenRecognizer.new(:date, /\{\{date\}\}/),
            TokenRecognizer.new(:time, /\{\{time\}\}/),
            TokenRecognizer.new(:plaintext, //)
          ]
        )
      end

      # def tokenizer
      #   @tokenizer ||= begin
      #     date_tk = DateTokenizer.tokenizer
      #     time_tk = TimeTokenizer.tokenizer
      # 
      #     recognizers = [date_tk.recognizer_at(:composite)]
      #     recognizers += [:pattern, :plaintext].map do |token_type|
      #       TokenRecognizer.new(
      #         token_type,
      #         Regexp.union(
      #           date_tk.recognizer_at(token_type),
      #           time_tk.recognizer_at(token_type)
      #         )
      #       )
      #     end
      # 
      #     Tokenizer.new(
      #       Regexp.union(date_tk.regex, time_tk.regex),
      #       recognizers
      #     )
      #   end
      # end

    end
  end
end