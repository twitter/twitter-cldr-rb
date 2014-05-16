# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Formatters::Plurals

describe Rules do
  describe "#get_resource" do
    it "calls eval on the hash that gets returned, lambdas and all" do
      result = Rules.send(:get_resource, :ru)

      expect(result).to include(:keys, :rule)
      expect(result[:keys].size).to eq(3)
      expect(result[:rule]).to be_a(Proc)
    end
  end

  describe "#rule_for" do
    it "returns :one for English 1, :other for everything else" do
      expect(Rules.rule_for(1, :en)).to eq(:one)
      [5, 9, 10, 20, 60, 99, 100, 103, 141].each do |num|
        expect(Rules.rule_for(num, :en)).to eq(:other)
      end
    end

    it "returns the correct values for Russian rules" do
      rules = {
          :one  => [1, 101],
          :many => ((5..11).to_a + [111]),
          :other  => [2, 3, 4, 102]
      }

      rules.each do |rule, examples|
        examples.each { |n| expect(Rules.rule_for(n, :ru)).to eq(rule) }
      end
    end

    it "returns :other if there's an error" do
      stub(Rules).get_resource { lambda { raise "Jelly beans" } }
      expect(Rules.rule_for(1, :en)).to eq(:other)
      expect(Rules.rule_for(1, :ru)).to eq(:other)
    end
  end

  describe "#all_for" do
    it "returns a list of all applicable rules for the given locale" do
      expect(Rules.all_for(:en)).to match_array([:one, :other])
      expect(Rules.all_for(:ru)).to match_array([:one, :many, :other])
    end

    it "returns nil on error" do
      stub(Rules).get_resource { lambda { raise "Jelly beans" } }
      expect(Rules.all_for(:en)).to be_nil
      expect(Rules.all_for(:ru)).to be_nil
    end
  end

  describe "#all" do
    it "gets rules for the default locale (usually supplied by FastGettext)" do
      mock(TwitterCldr).locale { :ru }
      expect(Rules.all).to match_array([:one, :many, :other])
    end
  end
end