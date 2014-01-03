# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

require 'pry-nav'

include TwitterCldr::Parsers

describe TwitterCldr::Parsers::NumberParser do
  let(:separators) { ["\\.", ","] }

  before(:each) do
    @parser = NumberParser.new(:es)
  end

  describe "#group_separator" do
    it "returns the correct group separator" do
      @parser.send(:group_separator).should match_normalized(" ")
    end
  end

  describe "#decimal_separator" do
    it "returns the correct decimal separator" do
      @parser.send(:decimal_separator).should == ","
    end
  end

  describe "#identify" do
    it "properly identifies a numeric value" do
      @parser.send(:identify, "7841", *separators).should == { :value => "7841", :type => :numeric }
    end

    it "properly identifies a decimal separator" do
      @parser.send(:identify, ",", *separators).should == { :value => ",", :type => :decimal }
    end

    it "properly identifies a group separator" do
      @parser.send(:identify, ".", *separators).should == { :value => ".", :type => :group }
    end

    it "returns nil if the text doesn't match a number or either separators" do
      @parser.send(:identify, "abc", *separators).should == { :value => "abc", :type => nil }
    end
  end

  describe "#tokenize" do
    it "splits text by numericality and group/decimal separators" do
      @parser.send(:tokenize, "1,33.00", *separators).should == [
        { :value => "1",  :type => :numeric },
        { :value => ",",  :type => :decimal },
        { :value => "33", :type => :numeric },
        { :value => ".",  :type => :group },
        { :value => "00", :type => :numeric }
      ]
    end

    it "returns an empty array for a non-numeric string" do
      @parser.send(:tokenize, "abc", *separators).should be_empty
    end
  end

  describe "#separators" do
    it "returns all separators when strict mode is off" do
      group, decimal = @parser.send(:separators, false)
      group.should == '\.,\s'
      decimal.should == '\.,\s'
    end

    it "returns only locale-specific separators when strict mode is on" do
      group, decimal = @parser.send(:separators, true)
      group.should match_normalized(" ")
      decimal.should == ','
    end
  end

  describe "#punct_valid" do
    it "correctly validates a number with no decimal" do
      tokens = @parser.send(:tokenize, "1.337", *separators).reject { |t| t[:type] == :numeric }
      @parser.send(:punct_valid?, tokens).should be_true
    end

    it "correctly validates a number with a decimal" do
      tokens = @parser.send(:tokenize, "1.337,00", *separators).reject { |t| t[:type] == :numeric }
      @parser.send(:punct_valid?, tokens).should be_true
    end

    it "reports on an invalid number when it has more than one decimal" do
      tokens = @parser.send(:tokenize, "1,337,00", *separators).reject { |t| t[:type] == :numeric }
      @parser.send(:punct_valid?, tokens).should be_false
    end
  end

  describe "#is_numeric?" do
    it "returns true if the text is numeric" do
      NumberParser.is_numeric?("4839", "").should be_true
      NumberParser.is_numeric?("1", "").should be_true
    end

    it "returns false if the text is not purely numeric" do
      NumberParser.is_numeric?("abc", "").should be_false
      NumberParser.is_numeric?("123abc", "").should be_false
    end

    it "returns false if the text is blank" do
      NumberParser.is_numeric?("", "").should be_false
    end

    it "accepts the given characters as valid numerics" do
      NumberParser.is_numeric?("a123a", "a").should be_true
      NumberParser.is_numeric?("1.234,56").should be_true  # default separator chars used here
    end
  end

  describe "#valid?" do
    it "correctly identifies a series of valid cases" do
      ["5", "5,0", "1.337", "1.337,0", "0,05", ",5", "1.337.000,00"].each do |num|
        @parser.valid?(num).should be_true
      end
    end

    it "correctly identifies a series of invalid cases" do
      ["12,0,0", "5,", "5#{[160].pack("U*")}"].each do |num|
        @parser.valid?(num).should be_false
      end
    end
  end

  describe "#parse" do
    it "correctly parses a series of valid numbers" do
      cases = {
        "5" => 5,
        "5,0" => 5.0,
        "1.337" => 1337,
        "1.337,0" => 1337.0,
        "0,05" => 0.05,
        ",5" => 0.5,
        "1.337.000,00" => 1337000.0
      }

      cases.each do |text, expected|
        @parser.parse(text).should == expected
      end
    end

    it "correctly raises an error when asked to parse invalid numbers" do
      cases = ["12,0,0", "5,", "5#{[160].pack("U*")}"]
      cases.each do |text|
        lambda { @parser.parse(text) }.should raise_error(InvalidNumberError)
      end
    end

    context "non-strict" do
      it "succeeds in parsing even if inexact punctuation is used" do
        @parser.parse("5 100", :strict => false).should == 5100
      end
    end
  end

  describe "#try_parse" do
    it "parses correctly with a valid number" do
      @parser.try_parse("1.234").should == 1234
    end

    it "parses correctly with a valid number and yields to the given block" do
      pre_result = nil
      @parser.try_parse("1.234") do |result|
        pre_result = result
        9
      end.should == 9
      pre_result.should == 1234
    end

    it "falls back on the default value if the number is invalid" do
      @parser.try_parse("5,").should be_nil
      @parser.try_parse("5,", 0).should == 0
    end

    it "falls back on the block if the number is invalid" do
      @parser.try_parse("5,") { |result| 9 }.should == 9
    end

    it "doesn't catch anything but an InvalidNumberError" do
      lambda { @parser.try_parse(Object.new) }.should raise_error(NoMethodError)
    end
  end
end