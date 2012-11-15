# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Tokenizers

describe NumberTokenizer do
  describe "#full_path" do
    it "should fill in the type and return the full path to the requested format" do
      tokenizer = NumberTokenizer.new
      tokenizer.type = :default
      tokenizer.format = :default
      tokenizer.send(:full_path).should == [:numbers, :formats, :decimal, :patterns, :default]
    end
  end

  describe "#tokens" do
    it "gets tokens for a latin language (i.e. Portuguese)" do
      tokenizer = NumberTokenizer.new(:locale => :pt)
      got = tokenizer.tokens
      expected = [{ :value => "", :type => :pattern },
                  { :value => "#,##0.###", :type => :pattern }]
      check_token_list(got, expected)
    end

    it "gets tokens for a non-latin language (i.e. Russian)" do
      tokenizer = NumberTokenizer.new(:locale => :ru)
      got = tokenizer.tokens
      expected = [{ :value => "", :type => :pattern },
                  { :value => "#,##0.###", :type => :pattern }]
      check_token_list(got, expected)
    end

    it "correctly parses suffixes (i.e. Russian currency)" do
      tokenizer = NumberTokenizer.new(:locale => :ru)
      got = tokenizer.tokens(:type => :currency)
      expected = [{ :value => "", :type => :pattern },
                  { :value => "#,##0.00", :type => :pattern },
                  { :value => " ¤", :type => :pattern }]
      check_token_list(got, expected)
    end

    it "correctly parses prefixes (i.e. Italian currency)" do
      tokenizer = NumberTokenizer.new(:locale => :it)
      got = tokenizer.tokens(:type => :currency)
      expected = [{ :value => "¤ ", :type => :pattern },
                  { :value => "#,##0.00", :type => :pattern }]
      check_token_list(got, expected)
    end
  end
end