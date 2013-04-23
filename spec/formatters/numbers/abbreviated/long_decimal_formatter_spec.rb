# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Formatters

describe LongDecimalFormatter do
  before(:each) do
    @formatter = LongDecimalFormatter.new(:locale => :en)
  end

  it "formats valid numbers correctly (from 10^3 - 10^15)" do
    @formatter.format(10 ** 3).should match_normalized("1 thousand")
    @formatter.format(10 ** 4).should match_normalized("10 thousand")
    @formatter.format(10 ** 5).should match_normalized("100 thousand")
    @formatter.format(10 ** 6).should match_normalized("1 million")
    @formatter.format(10 ** 7).should match_normalized("10 million")
    @formatter.format(10 ** 8).should match_normalized("100 million")
    @formatter.format(10 ** 9).should match_normalized("1 billion")
    @formatter.format(10 ** 10).should match_normalized("10 billion")
    @formatter.format(10 ** 11).should match_normalized("100 billion")
    @formatter.format(10 ** 12).should match_normalized("1 trillion")
    @formatter.format(10 ** 13).should match_normalized("10 trillion")
    @formatter.format(10 ** 14).should match_normalized("100 trillion")
  end

  it "formats the number as if it were a straight decimal if it exceeds 10^15" do
    @formatter.format(10**15).should == "1,000,000,000,000,000"
  end

  it "formats the number as if it were a straight decimal if it's less than 1000" do
    @formatter.format(500).should == "500"
  end

  it "respects the :precision option" do
    @formatter.format(12345, :precision => 3).should match_normalized("12.345 thousand")
  end
end