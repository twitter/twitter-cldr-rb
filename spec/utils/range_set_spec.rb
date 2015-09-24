# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Utils

describe RangeSet do
  describe "rangify" do
    it "should identify runs in an array of integers and return an array of ranges" do
      expect(RangeSet.rangify([1, 2, 3, 6, 7, 8, 11, 14, 17, 18, 19])).
        to eq([1..3, 6..8, 11..11, 14..14, 17..19])
    end

    it "should not rangify zero-length values when told to compress" do
      expect(RangeSet.rangify([1, 2, 3, 5, 8, 11, 12], true)).
        to eq([1..3, 5, 8, 11..12])
    end
  end

  describe "#to_a" do
    it "should return a copy of the ranges in the set" do
      set = RangeSet.new([1..10])
      expect(set.to_a.object_id).not_to eq(set.ranges.object_id)
    end

    it "should return compressed ranges when asked" do
      expect(RangeSet.new([1..10, 12..12]).to_a(true)).to eq([1..10, 12])
    end
  end

  describe "#to_full_a" do
    it "expands all ranges" do
      expect(RangeSet.new([1..5]).to_full_a).to eq([1, 2, 3, 4, 5])
    end
  end

  describe "#new" do
    it "should flatten leading overlapping ranges" do
      expect(RangeSet.new([3..10, 1..8]).to_a).to eq([1..10])
    end

    it "should flatten trailing overlapping ranges" do
      expect(RangeSet.new([1..10, 8..12]).to_a).to eq([1..12])
    end

    it "should flatten completely overlapping ranges" do
      expect(RangeSet.new([2..3, 1..10]).to_a).to eq([1..10])
    end

    it "should join ranges that are within 1 of each other" do
      expect(RangeSet.new([1..10, 11..15]).to_a).to eq([1..15])
    end
  end

  describe "#union" do
    it "should aggregate the ranges and flatten when necessary" do
      set = RangeSet.new([3..10]).union(
        RangeSet.new([9..11, 1..2, 2..3, 14..18])
      )

      expect(set.to_a).to eq([1..11, 14..18])
    end

    it "should aggregate the ranges correctly even if they're given in reverse order" do
      set = RangeSet.new([3..10]).union(RangeSet.new([1..4]))
      expect(set.to_a).to eq([1..10])

      set = RangeSet.new([1..4]).union(RangeSet.new([3..10]))
      expect(set.to_a).to eq([1..10])
    end
  end

  describe "#intersection" do
    it "computes the intersection for leading overlapping ranges" do
      set = RangeSet.new([3..10]).intersection(RangeSet.new([1..7]))
      expect(set.to_a).to eq([3..7])
    end

    it "computes the intersection for trailing overlapping ranges" do
      set = RangeSet.new([1..10]).intersection(RangeSet.new([5..15]))
      expect(set.to_a).to eq([5..10])
    end

    it "computes the intersection for two completely overlapping ranges" do
      set = RangeSet.new([1..10]).intersection(RangeSet.new([3..6]))
      expect(set.to_a).to eq([3..6])
    end

    it "returns an empty intersection if no elements exist in both ranges" do
      set = RangeSet.new([1..10]).intersection(RangeSet.new([15..20]))
      expect(set.to_a).to eq([])
    end

    it "returns partial intersections when the range set contains multiple matching ranges" do
      set = RangeSet.new([1..5, 7..10]).intersection(RangeSet.new([3..8]))
      expect(set.to_a).to eq([3..5, 7..8])
    end

    it "doesn't matter what order the ranges are compared in" do
      set = RangeSet.new([2..3]).intersection(RangeSet.new([1..4]))
      expect(set.to_a).to eq([2..3])

      set = RangeSet.new([1..4]).intersection(RangeSet.new([2..3]))
      expect(set.to_a).to eq([2..3])
    end
  end

  describe "#subtract" do
    it "subtracts the intersection for leading overlapping ranges" do
      set = RangeSet.new([3..10]).subtract(RangeSet.new([1..5]))
      expect(set.to_a).to eq([6..10])
    end

    it "subtracts the intersection for trailing overlapping ranges" do
      set = RangeSet.new([1..7]).subtract(RangeSet.new([3..9]))
      expect(set.to_a).to eq([1..2])
    end

    it "subtracts the intersection for completely overlapping ranges (generates two ranges)" do
      set = RangeSet.new([1..10]).subtract(RangeSet.new([4..6]))
      expect(set.to_a).to eq([1..3, 7..10])
    end

    it "subtracts the intersection when the range set contians multiple matching ranges" do
      set = RangeSet.new([1..5, 7..10]).subtract(RangeSet.new([3..8]))
      expect(set.to_a).to eq([1..2, 9..10])
    end

    it "does not change object when subtracting an empty set" do
      set = RangeSet.new([1..5]).subtract(RangeSet.new([]))
      expect(set.to_a).to eq([1..5])
    end
  end

  describe "#difference" do
    it "returns the symmetric difference (union - intersection) between completely overlapping ranges" do
      set = RangeSet.new([1..10]).difference(RangeSet.new([3..8]))
      expect(set.to_a).to eq([1..2, 9..10])
    end

    it "returns the symmetric difference between leading overlapping ranges" do
      set = RangeSet.new([3..10]).difference(RangeSet.new([1..5]))
      expect(set.to_a).to eq([1..2, 6..10])
    end

    it "returns the symmetric difference between trailing overlapping ranges" do
      set = RangeSet.new([1..5]).difference(RangeSet.new([3..8]))
      expect(set.to_a).to eq([1..2, 6..8])
    end
  end

  describe "#include?" do
    let (:set) { RangeSet.new([1..5, 9..16]) }

    it "returns true if the set completely includes the range, false otherwise" do
      expect(set).to include(10..15)
      expect(set).not_to include(3..8)
      expect(set).not_to include(8..14)
    end

    it "returns true if the set contains the value, false otherwise" do
      expect(set).to include(3)
      expect(set).to include(10)
      expect(set).not_to include(6)
      expect(set).not_to include(8)
    end
  end
end
