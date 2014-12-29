# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Tokenizers

describe TimespanTokenizer do

  describe "#tokens" do
    it "should return the correct list of tokens" do
      tokenizer = TimespanTokenizer.new(nil)
      tokenizer.tokenize("Hace {0} minutos").tap do |tokens|
        tokens[0].tap do |token|
          expect(token.value).to eq("Hace ")
          expect(token.type).to eq(:plaintext)
        end

        tokens[1].tap do |token|
          expect(token.value).to eq("{0}")
          expect(token.type).to eq(:pattern)
        end

        tokens[2].tap do |token|
          expect(token.value).to eq(" minutos")
          expect(token.type).to eq(:plaintext)
        end
      end
    end
  end

end