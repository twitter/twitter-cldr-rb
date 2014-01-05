# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Formatters

describe AbbreviatedNumberFormatter do
  let(:formatter) { AbbreviatedNumberFormatter.new(:locale => :en) }

  describe "#transform_number" do
    it "chops off the number to the necessary number of sig figs" do
      formatter.send(:transform_number, 10 ** 3).should == 1
      formatter.send(:transform_number, 10 ** 4).should == 10
      formatter.send(:transform_number, 10 ** 5).should == 100
      formatter.send(:transform_number, 10 ** 6).should == 1
      formatter.send(:transform_number, 10 ** 7).should == 10
      formatter.send(:transform_number, 10 ** 8).should == 100
      formatter.send(:transform_number, 10 ** 9).should == 1
      formatter.send(:transform_number, 10 ** 10).should == 10
      formatter.send(:transform_number, 10 ** 11).should == 100
      formatter.send(:transform_number, 10 ** 12).should == 1
      formatter.send(:transform_number, 10 ** 13).should == 10
      formatter.send(:transform_number, 10 ** 14).should == 100
    end

    it "returns the original number if greater than 10^15" do
      formatter.send(:transform_number, 10 ** 15).should == 10 ** 15
    end

    it "returns the original number if less than 10^3" do
      formatter.send(:transform_number, 999).should == 999
    end
  end
end