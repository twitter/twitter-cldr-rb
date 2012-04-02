require File.join(File.dirname(File.dirname(File.dirname(__FILE__))), "spec_helper")
include TwitterCldr::Formatters::Plurals

describe Rules do
  describe "#get_resource" do
    it "calls eval on the hash that gets returned, lambdas and all" do
      result = Rules.send(:get_resource, :ru)
      result.should include(:ru)
      result[:ru].should include(:i18n)
      result[:ru][:i18n].should include(:plural)
      result[:ru][:i18n][:plural].should include(:keys)
      result[:ru][:i18n][:plural][:keys].size.should == 4

      result[:ru][:i18n][:plural].should include(:rule)
      result[:ru][:i18n][:plural][:rule].should be_a(Proc)
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
      Rules.rule_for(1, :ru).should == :one
      Rules.rule_for(2, :ru).should == :few
      Rules.rule_for(3, :ru).should == :few
      Rules.rule_for(4, :ru).should == :few
      Rules.rule_for(5, :ru).should == :many
      Rules.rule_for(6, :ru).should == :many
      Rules.rule_for(7, :ru).should == :many
      Rules.rule_for(8, :ru).should == :many
      Rules.rule_for(9, :ru).should == :many
      Rules.rule_for(10, :ru).should == :many
      Rules.rule_for(11, :ru).should == :many

      Rules.rule_for(101, :ru).should == :one
      Rules.rule_for(102, :ru).should == :few
      Rules.rule_for(111, :ru).should == :many
    end

    it "returns :other if there's an error" do
      stub(Rules).get_resource { lambda { raise "Jelly beans" } }
      Rules.rule_for(1, :en).should == :other
      Rules.rule_for(1, :ru).should == :other
    end
  end

  describe "#all_for" do
    it "returns a list of all applicable rules for the given locale" do
      Rules.all_for(:en).each { |rule| [:one, :other].should include(rule) }
      Rules.all_for(:ru).each { |rule| [:one, :few, :many, :other].should include(rule) }
    end

    it "should return an empty array on error" do
      stub(Rules).get_resource { lambda { raise "Jelly beans" } }
      Rules.all_for(:en).should == []
      Rules.all_for(:ru).should == []
    end
  end

  describe "#all" do
    it "gets rules for the default locale (usually supplied by FastGettext)" do
      mock(TwitterCldr).get_locale { :ru }
      rules = Rules.all
      rules.size.should == 4
      rules.each { |rule| [:one, :few, :many, :other].should include(rule) }
    end
  end
end
