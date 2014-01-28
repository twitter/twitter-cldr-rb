# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Tokenizers
    class SegmentationTokenizer

      def tokenize(pattern)
        # according to the spec, whitespace should be ignored
        tokenizer.tokenize(pattern).reject do |token|
          token.value.strip.empty?
        end
      end

      private

      def tokenizer
        @tokenizer ||= begin
          recognizers = [
            TokenRecognizer.new(:break, /\303\267/u) do |val|     # ÷ character
              val.strip
            end,

            TokenRecognizer.new(:no_break, /\303\227/u) do |val|  # × character
              val.strip
            end
          ]

          ur_tokenizer = UnicodeRegexTokenizer.new
          ur_tokenizer.insert_before(:string, *recognizers)
          ur_tokenizer
        end
      end

    end
  end
end