# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Formatters

describe TimespanFormatter do

  before(:each) do
    @formatter = TimespanFormatter.new(:locale => :de)
  end

  describe "#format" do
    describe "#ago" do
      it "works for a variety of units" do
        @formatter.format(-3273932, :year).should == 'Vor 0 Jahren'
        @formatter.format(-3273932, :month).should == 'Vor 1 Monat'
        @formatter.format(-3273932, :week).should == 'Vor 5 Wochen'
        @formatter.format(-3273932, :day).should == 'Vor 37 Tagen'
        @formatter.format(-3273932, :hour).should == 'Vor 909 Stunden'
        @formatter.format(-3273932, :minute).should == 'Vor 54565 Minuten'
        @formatter.format(-3273932, :second).should == 'Vor 3273932 Sekunden'
      end
    end
  end

  describe "#until" do
    it "works for a variety of units" do
      @formatter.format(3273932, :year).should == 'In 0 Jahren'
      @formatter.format(3273932, :month).should == 'In 1 Monat'
      @formatter.format(3273932, :week).should == 'In 5 Wochen'
      @formatter.format(3273932, :day).should == 'In 37 Tagen'
      @formatter.format(3273932, :hour).should == 'In 909 Stunden'
      @formatter.format(3273932, :minute).should == 'In 54565 Minuten'
      @formatter.format(3273932, :second).should == 'In 3273932 Sekunden'
    end
  end
end