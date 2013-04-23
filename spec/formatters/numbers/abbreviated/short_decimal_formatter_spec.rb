# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Formatters

describe ShortDecimalFormatter do
  before(:each) do
    @formatter = ShortDecimalFormatter.new(:locale => :en)
  end

  it "formats valid numbers correctly (from 10^3 - 10^15)" do
    @formatter.format(10 ** 3).should match_normalized("1K")
    @formatter.format(10 ** 4).should match_normalized("10K")
    @formatter.format(10 ** 5).should match_normalized("100K")
    @formatter.format(10 ** 6).should match_normalized("1M")
    @formatter.format(10 ** 7).should match_normalized("10M")
    @formatter.format(10 ** 8).should match_normalized("100M")
    @formatter.format(10 ** 9).should match_normalized("1B")
    @formatter.format(10 ** 10).should match_normalized("10B")
    @formatter.format(10 ** 11).should match_normalized("100B")
    @formatter.format(10 ** 12).should match_normalized("1T")
    @formatter.format(10 ** 13).should match_normalized("10T")
    @formatter.format(10 ** 14).should match_normalized("100T")
  end

  it "formats the number as if it were a straight decimal if it exceeds 10^15" do
    @formatter.format(10**15).should == "1,000,000,000,000,000"
  end

  it "formats the number as if it were a straight decimal if it's less than 1000" do
    @formatter.format(500).should == "500"
  end

  it "respects the :precision option" do
    @formatter.format(12345, :precision => 3).should match_normalized("12.345K")
  end
end