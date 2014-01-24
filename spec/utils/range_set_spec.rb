# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Utils

describe RangeSet do
  describe "#new" do
    it "should flatten leading overlapping ranges" do
      RangeSet.new([3..10, 1..8]).to_a.should == [1..10]
    end

    it "should flatten trailing overlapping ranges" do
      RangeSet.new([1..10, 8..12]).to_a.should == [1..12]
    end

    it "should flatten completely overlapping ranges" do
      RangeSet.new([2..3, 1..10]).to_a.should == [1..10]
    end

    it "should join ranges that are within 1 of each other" do
      RangeSet.new([1..10, 11..15]).to_a.should == [1..15]
    end
  end

  describe "#union" do
    it "should aggregate the ranges and flatten when necessary" do
      set = RangeSet.new([3..10]).union(
        RangeSet.new([9..11, 1..2, 2..3, 14..18])
      )

      set.to_a.should == [1..11, 14..18]
    end
  end

  describe "#intersection" do
    it "computes the intersection for leading overlapping ranges" do
      set = RangeSet.new([3..10]).intersection(RangeSet.new([1..7]))
      set.to_a.should == [3..7]
    end

    it "computes the intersection for trailing overlapping ranges" do
      set = RangeSet.new([1..10]).intersection(RangeSet.new([5..15]))
      set.to_a.should == [5..10]
    end

    it "computes the intersection for two completely overlapping ranges" do
      set = RangeSet.new([1..10]).intersection(RangeSet.new([3..6]))
      set.to_a.should == [3..6]
    end

    it "returns an empty intersection if no elements exist in both ranges" do
      set = RangeSet.new([1..10]).intersection(RangeSet.new([15..20]))
      set.to_a.should == []
    end

    it "returns partial intersections when the range set contains multiple matching ranges" do
      set = RangeSet.new([1..5, 7..10]).intersection(RangeSet.new([3..8]))
      set.to_a.should == [3..5, 7..8]
    end
  end

  describe "#subtract" do
    it "subtracts the intersection for leading overlapping ranges" do
      set = RangeSet.new([3..10]).subtract(RangeSet.new([1..5]))
      set.to_a.should == [6..10]
    end

    it "subtracts the intersection for trailing overlapping ranges" do
      set = RangeSet.new([1..7]).subtract(RangeSet.new([3..9]))
      set.to_a.should == [1..2]
    end

    it "subtracts the intersection for completely overlapping ranges (generates two ranges)" do
      set = RangeSet.new([1..10]).subtract(RangeSet.new([4..6]))
      set.to_a.should == [1..3, 7..10]
    end

    it "subtracts the intersection when the range set contians multiple matching ranges" do
      set = RangeSet.new([1..5, 7..10]).subtract(RangeSet.new([3..8]))
      set.to_a.should == [1..2, 9..10]
    end
  end

  describe "#difference" do
    it "returns the symmetric difference (union - intersection) between completely overlapping ranges" do
      set = RangeSet.new([1..10]).difference(RangeSet.new([3..8]))
      set.to_a.should == [1..2, 9..10]
    end

    it "returns the symmetric difference between leading overlapping ranges" do
      set = RangeSet.new([3..10]).difference(RangeSet.new([1..5]))
      set.to_a.should == [1..2, 6..10]
    end

    it "returns the symmetric difference between trailing overlapping ranges" do
      set = RangeSet.new([1..5]).difference(RangeSet.new([3..8]))
      set.to_a.should == [1..2, 6..8]
    end
  end
end
