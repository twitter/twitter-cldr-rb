# encoding: UTF-8

require 'spec_helper'

include TwitterCldr::Formatters

describe PercentFormatter do
  before(:each) do
    @formatter = PercentFormatter.new(:locale => :da)
  end

  it "should format the number correctly" do
    @formatter.format(12).should == "12 %"
  end
end