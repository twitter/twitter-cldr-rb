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
        tokens[1].tap do |token|
          token.value.should == "Hace "
          token.type.should == :plaintext
        end

        tokens[2].tap do |token|
          token.value.should == "{0}"
          token.type.should == :pattern
        end

        tokens[3].tap do |token|
          token.value.should == " minutos"
          token.type.should == :plaintext
        end
      end
    end
  end

end