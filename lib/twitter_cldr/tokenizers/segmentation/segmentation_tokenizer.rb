# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Tokenizers
    class SegmentationTokenizer

      def tokenize(pattern)
        tokenizer.tokenize(pattern)
      end

      private

      def tokenizer
        @tokenizer ||= begin
          recognizers = [
            TokenRecognizer.new(:break, /\303\267/u),  # ÷ character
            TokenRecognizer.new(:no_break, /\303\227/u),  # × character
          ]

          ur_tokenizer = UnicodeRegexTokenizer.new
          ur_tokenizer.insert_before(:string, *recognizers)
          ur_tokenizer
        end
      end

    end
  end
end