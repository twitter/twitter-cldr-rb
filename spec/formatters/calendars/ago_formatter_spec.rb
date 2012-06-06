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
        @formatter.format(-3273932, {:unit => :year, :direction => :ago}).should == 'Vor 0 Jahren'
        @formatter.format(-3273932, {:unit => :month, :direction => :ago}).should == 'Vor 1 Monat'
        @formatter.format(-3273932, {:unit => :week, :direction => :ago}).should == 'Vor 5 Wochen'
        @formatter.format(-3273932, {:unit => :day, :direction => :ago}).should == 'Vor 37 Tagen'
        @formatter.format(-3273932, {:unit => :hour, :direction => :ago}).should == 'Vor 909 Stunden'
        @formatter.format(-3273932, {:unit => :minute, :direction => :ago}).should == 'Vor 54565 Minuten'
        @formatter.format(-3273932, {:unit => :second, :direction => :ago}).should == 'Vor 3273932 Sekunden'
      end
    end
  end

end