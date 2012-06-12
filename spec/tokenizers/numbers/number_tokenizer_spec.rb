# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Tokenizers

describe NumberTokenizer do
  describe "#initialize" do
    it "chooses decimal as the default type if no other type is specified" do
      NumberTokenizer.new.type.should == :decimal
      NumberTokenizer.new(:type => :percent).type.should == :percent
    end
  end

  describe "#full_path_for" do
    it "should fill in the type and return the full path to the requested format" do
      NumberTokenizer.new.send(:full_path_for, :default).should == [:numbers, :formats, :decimal, :patterns, :default]
    end
  end

  describe "#tokens" do
    it "ensures that positive and negative entries are created (as necessary)" do
      tokenizer = NumberTokenizer.new(:locale => :tr)
      tokenizer.tokens
      root = tokenizer.resource[:numbers][:formats][:decimal][:patterns]
      root.should include(:positive)
      root.should include(:negative)
    end

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
      tokenizer = NumberTokenizer.new(:locale => :ru, :type => :currency)
      got = tokenizer.tokens
      expected = [{ :value => "", :type => :pattern },
                  { :value => "#,##0.00", :type => :pattern },
                  { :value => " ¤", :type => :pattern }]
      check_token_list(got, expected)
    end

    it "correctly parses prefixes (i.e. Italian currency)" do
      tokenizer = NumberTokenizer.new(:locale => :it, :type => :currency)
      got = tokenizer.tokens
      expected = [{ :value => "¤ ", :type => :pattern },
                  { :value => "#,##0.00", :type => :pattern }]
      check_token_list(got, expected)
    end
  end
end