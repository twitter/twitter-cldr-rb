# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Formatters

describe DecimalFormatter do
  before(:each) do
    @formatter = DecimalFormatter.new(:locale => :nl)
  end

  describe "#format" do
    it "should format positive decimals correctly" do
      @formatter.format(12.0).should == "12,0"
    end

    it "should format negative decimals correctly" do
      @formatter.format(-12.0).should == "-12,0"
    end

    it "should respect the :precision option" do
      @formatter.format(-12, :precision => 3).should == "-12,000"
    end
  end

  describe "#get_tokens" do
    it "should ask the tokenizer for the tokens for a positive number" do
      mock(@formatter.tokenizer).tokens(:sign => :positive) { true }
      @formatter.send(:get_tokens, 12)
    end

    it "should ask the tokenizer for the tokens for a negative number" do
      mock(@formatter.tokenizer).tokens(:sign => :negative) { true }
      @formatter.send(:get_tokens, -12)
    end
  end
end