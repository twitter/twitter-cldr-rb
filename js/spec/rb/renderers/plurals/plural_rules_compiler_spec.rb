# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require File.join(File.dirname(File.dirname(File.dirname(__FILE__))), "spec_helper")

include TwitterCldr::Js::Renderers::PluralRules

describe PluralRulesCompiler do
  describe "#rule_to_js" do
    it "handles a single plural rule" do
      PluralRulesCompiler.rule_to_js(":other").should == 'function(n) { return "other" }'
    end

    it "handles a conditional plural rule (eg. English)" do
      PluralRulesCompiler.rule_to_js("n == 1 ? :one : :other").should == 'function(n) { return (function() { if (n == 1) { return "one" } else { return "other" } })(); }'
    end

    it "handles an include? call" do
      PluralRulesCompiler.rule_to_js("[2, 3, 4].include?(n)").should == "function(n) { return [2, 3, 4].indexOf(n) >= 0 }"
    end

    it "handles the modulus operator" do
      PluralRulesCompiler.rule_to_js("n % 10").should == "function(n) { return n % 10 }"
    end

    it "handles < and > operators" do
      PluralRulesCompiler.rule_to_js("n > 10").should == "function(n) { return n > 10 }"
      PluralRulesCompiler.rule_to_js("n < 10").should == "function(n) { return n < 10 }"
    end

    it "handles 'and', 'or', and 'not' operators" do
      PluralRulesCompiler.rule_to_js("n and n").should == "function(n) { return n && n }"
      PluralRulesCompiler.rule_to_js("n or n").should == "function(n) { return n || n }"
      PluralRulesCompiler.rule_to_js("not n").should == "function(n) { return !(n) }"
    end

    it "compounds include? and the modulus operator" do
      PluralRulesCompiler.rule_to_js("[2, 3, 4].include?(n % 10)").should == "function(n) { return [2, 3, 4].indexOf(n % 10) >= 0 }"
    end

    it "compounds include?, modulus, and an if statement" do
      PluralRulesCompiler.rule_to_js("[2, 3, 4].include?(n % 10) ? :one : :other").should == 'function(n) { return (function() { if ([2, 3, 4].indexOf(n % 10) >= 0) { return "one" } else { return "other" } })(); }'
    end

    it "chains two if statements (eg. Polish)" do
      ruby_string = "n == 1 ? :one : [2, 3, 4].include?(n % 10) && ![12, 13, 14].include?(n % 100) && ![22, 23, 24].include?(n % 100) ? :few : :other"
      PluralRulesCompiler.rule_to_js(ruby_string).should == 'function(n) { return (function() { if (n == 1) { return "one" } else { return (function() { if ([2, 3, 4].indexOf(n % 10) >= 0 && !([12, 13, 14].indexOf(n % 100) >= 0) && !([22, 23, 24].indexOf(n % 100) >= 0)) { return "few" } else { return "other" } })(); } })(); }'
    end
  end
end