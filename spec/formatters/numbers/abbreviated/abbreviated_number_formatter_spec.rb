# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'
require 'pry'
require 'pry-nav'

include TwitterCldr::Formatters

describe AbbreviatedNumberFormatter do
  before(:each) do
    @formatter = AbbreviatedNumberFormatter.new(:locale => :en)
  end

  describe "#transform_number" do
    it "chops off the number to the necessary number of sig figs" do
      @formatter.send(:transform_number, 10 ** 3).should == 1
      @formatter.send(:transform_number, 10 ** 4).should == 10
      @formatter.send(:transform_number, 10 ** 5).should == 100
      @formatter.send(:transform_number, 10 ** 6).should == 1
      @formatter.send(:transform_number, 10 ** 7).should == 10
      @formatter.send(:transform_number, 10 ** 8).should == 100
      @formatter.send(:transform_number, 10 ** 9).should == 1
      @formatter.send(:transform_number, 10 ** 10).should == 10
      @formatter.send(:transform_number, 10 ** 11).should == 100
      @formatter.send(:transform_number, 10 ** 12).should == 1
      @formatter.send(:transform_number, 10 ** 13).should == 10
      @formatter.send(:transform_number, 10 ** 14).should == 100
    end

    it "returns the original number if greater than 10^15" do
      @formatter.send(:transform_number, 10 ** 15).should == 10 ** 15
    end

    it "returns the original number if less than 10^3" do
      @formatter.send(:transform_number, 999).should == 999
    end
  end

  describe "#get_key" do
    it "builds a power-of-ten key based on the number of digits in the input" do
      (3..15).each { |i| @formatter.send(:get_key, "1337#{"0" * (i - 3)}").should == 10 ** i }
    end
  end

  describe "#get_tokens" do
    before(:each) do
      stub(@formatter).get_type { :awesome_type }
    end

    it "gets tokens for a valid number (between 10^3 and 10^15)" do
      mock(@formatter.tokenizer).tokens({
        :sign => :positive,
        :type => :awesome_type,
        :format => 10 ** 4
      }) { "I'm just right!" }

      @formatter.get_tokens(12345).should == "I'm just right!"
    end

    it "returns tokens for decimals if the number is too large" do
      mock(@formatter.tokenizer).tokens({
        :sign => :positive,
        :type => :decimal,
        :format => nil
      }) { "I'm too big!" }

      @formatter.get_tokens(1234567891011122).should == "I'm too big!"
    end

    it "returns tokens for decimals if the number is too small" do
      mock(@formatter.tokenizer).tokens({
        :sign => :positive,
        :type => :decimal,
        :format => nil
      }) { "I'm too small!" }

      @formatter.get_tokens(123).should == "I'm too small!"
    end
  end
end