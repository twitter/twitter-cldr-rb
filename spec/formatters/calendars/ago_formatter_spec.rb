#require "rspec"
require 'spec_helper'

include TwitterCldr::Formatters

describe AgoFormatter do

  before(:each) do
    @formatter = AgoFormatter.new(:locale => :de)
  end

  describe "#format" do
    describe "#ago" do
      it "works for a variety of units" do
        @formatter.format(-3273932, :ago, :year).should == 'Vor 0 Jahren'
        @formatter.format(-3273932, :ago, :month).should == 'Vor 1 Monat'
        @formatter.format(-3273932, :ago, :week).should == 'Vor 5 Wochen'
        @formatter.format(-3273932, :ago, :day).should == 'Vor 37 Tagen'
        @formatter.format(-3273932, :ago, :hour).should == 'Vor 909 Stunden'
        @formatter.format(-3273932, :ago, :minute).should == 'Vor 54565 Minuten'
        @formatter.format(-3273932, :ago, :second).should == 'Vor 3273932 Sekunden'
      end
    end
  end

  describe "#until" do
    it "works for a variety of units" do
      @formatter.format(3273932, :until, :year).should == 'In 0 Jahren'
      @formatter.format(3273932, :until, :month).should == 'In 1 Monat'
      @formatter.format(3273932, :until, :week).should == 'In 5 Wochen'
      @formatter.format(3273932, :until, :day).should == 'In 37 Tagen'
      @formatter.format(3273932, :until, :hour).should == 'In 909 Stunden'
      @formatter.format(3273932, :until, :minute).should == 'In 54565 Minuten'
      @formatter.format(3273932, :until, :second).should == 'In 3273932 Sekunden'
    end
  end
end