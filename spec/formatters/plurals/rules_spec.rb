# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Formatters::Plurals

describe Rules do
  describe "#get_resource" do
    it "calls eval on the hash that gets returned, lambdas and all" do
      result = Rules.send(:get_resource, :ru)

      result.should include(:keys, :rule)
      result[:keys].size.should == 4
      result[:rule].should be_a(Proc)
    end
  end

  describe "#rule_for" do
    it "returns :one for English 1, :other for everything else" do
      Rules.rule_for(1, :en).should == :one
      [5, 9, 10, 20, 60, 99, 100, 103, 141].each do |num|
        Rules.rule_for(num, :en).should == :other
      end
    end

    it "returns the correct values for Russian rules" do
      rules = {
          :one  => [1, 101],
          :few  => [2, 3, 4, 102],
          :many => ((5..11).to_a + [111])
      }

      rules.each do |rule, examples|
        examples.each { |n| Rules.rule_for(n, :ru).should == rule }
      end
    end

    it "returns :other if there's an error" do
      stub(Rules).get_resource { lambda { raise "Jelly beans" } }
      Rules.rule_for(1, :en).should == :other
      Rules.rule_for(1, :ru).should == :other
    end
  end

  describe "#all_for" do
    it "returns a list of all applicable rules for the given locale" do
      Rules.all_for(:en).should =~ [:one, :other]
      Rules.all_for(:ru).should =~ [:one, :few, :many, :other]
    end

    it "returns nil on error" do
      stub(Rules).get_resource { lambda { raise "Jelly beans" } }
      Rules.all_for(:en).should be_nil
      Rules.all_for(:ru).should be_nil
    end
  end

  describe "#all" do
    it "gets rules for the default locale (usually supplied by FastGettext)" do
      mock(TwitterCldr).get_locale { :ru }
      Rules.all.should =~ [:one, :few, :many, :other]
    end
  end
end