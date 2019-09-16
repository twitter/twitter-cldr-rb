# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

describe TwitterCldr::Formatters::Plurals::Rules do
  describe "#get_resource" do
    it "calls eval on the hash that gets returned, lambdas and all" do
      result = described_class.send(:get_resource, :ru)

      [:cardinal, :ordinal].each do |type|
        expect(result).to include(type)
        expect(result[type]).to include(:names, :rule)
        expect(result[type][:rule]).to be_a(Proc)
      end

      expect(result[:cardinal][:names].size).to eq(4)
      expect(result[:ordinal][:names].size).to eq(1)
    end
  end

  describe "#rule_for" do
    it "returns :one for English 1, :other for everything else" do
      expect(described_class.rule_for(1, :en)).to eq(:one)
      [5, 9, 10, 20, 60, 99, 100, 103, 141].each do |num|
        expect(described_class.rule_for(num, :en)).to eq(:other)
      end
    end

    it "returns the correct values for Russian rules" do
      rules = {
          one:  [1, 101],
          few: [2, 3, 4],
          many: ((5..11).to_a + [111]),
          other:  [10.0, 100.0, 1000.0]
      }

      rules.each do |rule, examples|
        examples.each { |n| expect(described_class.rule_for(n, :ru)).to eq(rule) }
      end
    end

    it "returns :other if there's an error" do
      allow(described_class).to receive(:get_resource).and_return(lambda { raise "Jelly beans" })
      expect(described_class.rule_for(1, :en)).to eq(:other)
      expect(described_class.rule_for(1, :ru)).to eq(:other)
    end

    it "supports ordinal plurals" do
      expect(described_class.rule_for(1, :en, :ordinal)).to eq(:one)
      expect(described_class.rule_for(2, :en, :ordinal)).to eq(:two)
      expect(described_class.rule_for(3, :en, :ordinal)).to eq(:few)
      expect(described_class.rule_for(4, :en, :ordinal)).to eq(:other)
      expect(described_class.rule_for(11, :en, :ordinal)).to eq(:other)
      expect(described_class.rule_for(13, :en, :ordinal)).to eq(:other)
      expect(described_class.rule_for(22, :en, :ordinal)).to eq(:two)
    end
  end

  describe "#all_for" do
    it "returns a list of all applicable rules for the given locale" do
      expect(described_class.all_for(:en)).to match_array([:one, :other])
      expect(described_class.all_for(:ru)).to match_array([:one, :few, :many, :other])
    end

    it "returns data for zh-Hant" do
      expect(described_class.all_for(:'zh-Hant')).to match_array([:other])
    end

    it "returns ordinal plurals if asked" do
      expect(described_class.all_for(:en, :ordinal)).to match_array([
        :one, :two, :few, :other
      ])
    end

    it "works with upercase region code" do
      expect(described_class.all_for('en-gb')).to match_array([:one, :other])
    end

    it "works with lowercase region code" do
      expect(described_class.all_for('en-gb')).to match_array([:one, :other])
    end
  end

  describe "#all" do
    before(:each) do
      expect(TwitterCldr).to receive(:locale).and_return(:ru)
    end

    it "gets rules for the default locale (usually supplied by FastGettext)" do
      expect(described_class.all).to match_array([:one, :few, :many, :other])
    end

    it "returns ordinal rules for the default locale if asked" do
      expect(described_class.all(:ordinal)).to match_array([:other])
    end
  end
end
