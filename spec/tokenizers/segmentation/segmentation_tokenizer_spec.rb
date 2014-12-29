# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Tokenizers

describe SegmentationTokenizer do
  let(:tokenizer) { SegmentationTokenizer.new }

  def tokenize(str)
    tokenizer.tokenize(str)
  end

  describe "#tokenize" do
    it "should tokenize an expression with a non-break" do
      got = tokenize("$CB ÷ $SP")
      expected = [
        { :value => "$CB", :type => :variable },
        { :value => "÷", :type => :break },
        { :value => "$SP", :type => :variable }
      ]

      check_token_list(got, expected)
    end

    it "should tokenize an expression with a non-break" do
      got = tokenize("$ATerm × $Numeric")
      expected = [
        { :value => "$ATerm", :type => :variable },
        { :value => "×", :type => :no_break },
        { :value => "$Numeric", :type => :variable }
      ]

      check_token_list(got, expected)
    end
  end
end