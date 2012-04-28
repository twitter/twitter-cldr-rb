# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Formatters

describe NumberFormatter do
  before(:each) do
    @tokenizer = TwitterCldr::Tokenizers::NumberTokenizer.new(:locale => :sv, :type => :decimal)

    any_instance_of(NumberFormatter) do |formatter|
      mock(formatter).tokenizer { @tokenizer }
    end

    @formatter = NumberFormatter.new(:locale => :sv)
    @formatter.instance_variable_set("@tokenizer", @tokenizer)
  end

  describe "#precision_from" do
    it "should return the correct precision" do
      @formatter.send(:precision_from, 12.123).should == 3
    end

    it "should return zero precision if the number isn't a decimal" do
      @formatter.send(:precision_from, 12).should == 0
    end
  end

  describe "#round_to" do
    it "should round a number to the given precision" do
      @formatter.send(:round_to, 12, 0).should == 12
      @formatter.send(:round_to, 12.2, 0).should == 12
      @formatter.send(:round_to, 12.5, 0).should == 13
      @formatter.send(:round_to, 12.25, 1).should == 12.3
      @formatter.send(:round_to, 12.25, 2).should == 12.25
      @formatter.send(:round_to, 12.25, 3).should == 12.25
    end
  end

  describe "#parse_number" do
    it "should round and split the given number by decimal" do
      @formatter.send(:parse_number, 12, :precision => 0).should == ["12", "0"]
      @formatter.send(:parse_number, 12.2, :precision => 0).should == ["12", "0"]
      @formatter.send(:parse_number, 12.5, :precision => 0).should == ["13", "0"]
      @formatter.send(:parse_number, 12.25, :precision => 1).should == ["12", "3"]
      @formatter.send(:parse_number, 12.25, :precision => 2).should == ["12", "25"]
      @formatter.send(:parse_number, 12.25, :precision => 3).should == ["12", "25"]
    end
  end

  describe "#format" do
    it "should format a basic integer" do
      @formatter.format(12).should == "12"
    end

    it "should format a basic decimal" do
      @formatter.format(12.0).should == "12,0"
    end

    context "should respect the :precision option" do
      it "formats with precision of 0" do
        @formatter.format(12.1, :precision => 0).should == "12"
      end

      it "rounds and formats with precision of 1" do
        @formatter.format(12.25, :precision => 1).should == "12,3"
      end
    end

    it "uses the length of the original decimal as the precision" do
      @formatter.format(12.8543).should == "12,8543"
    end

    it "formats an integer larger than 999" do
      @formatter.format(1337).should == "1 337"
    end

    it "formats an decimal larger than 999.9" do
      @formatter.format(1337.37).should == "1 337,37"
    end
  end
end