# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

describe TwitterCldr::Utils::RangeSet do
  describe "rangify" do
    it "should identify runs in an array of integers and return an array of ranges" do
      expect(described_class.rangify([1, 2, 3, 6, 7, 8, 11, 14, 17, 18, 19])).
        to eq([1..3, 6..8, 11..11, 14..14, 17..19])
    end

    it "should not rangify zero-length values when told to compress" do
      expect(described_class.rangify([1, 2, 3, 5, 8, 11, 12], true)).
        to eq([1..3, 5, 8, 11..12])
    end
  end

  describe "#to_a" do
    it "should return a copy of the ranges in the set" do
      set = described_class.new([1..10])
      expect(set.to_a.object_id).not_to eq(set.ranges.object_id)
    end

    it "should return compressed ranges when asked" do
      expect(described_class.new([1..10, 12..12]).to_a(true)).to eq([1..10, 12])
    end
  end

  describe "#to_full_a" do
    it "expands all ranges" do
      expect(described_class.new([1..5]).to_full_a).to eq([1, 2, 3, 4, 5])
    end
  end

  describe "#new" do
    it "should flatten leading overlapping ranges" do
      expect(described_class.new([3..10, 1..8]).to_a).to eq([1..10])
    end

    it "should flatten trailing overlapping ranges" do
      expect(described_class.new([1..10, 8..12]).to_a).to eq([1..12])
    end

    it "should flatten completely overlapping ranges" do
      expect(described_class.new([2..3, 1..10]).to_a).to eq([1..10])
    end

    it "should join ranges that are within 1 of each other" do
      expect(described_class.new([1..10, 11..15]).to_a).to eq([1..15])
    end
  end

  describe "#union" do
    it "should aggregate the ranges and flatten when necessary" do
      set = described_class.new([3..10]).union(
        described_class.new([9..11, 1..2, 2..3, 14..18])
      )

      expect(set.to_a).to eq([1..11, 14..18])
    end

    it "should aggregate the ranges correctly even if they're given in reverse order" do
      set = described_class.new([3..10]).union(described_class.new([1..4]))
      expect(set.to_a).to eq([1..10])

      set = described_class.new([1..4]).union(described_class.new([3..10]))
      expect(set.to_a).to eq([1..10])
    end
  end

  describe "#intersection" do
    it "computes the intersection for leading overlapping ranges" do
      set = described_class.new([3..10]).intersection(described_class.new([1..7]))
      expect(set.to_a).to eq([3..7])
    end

    it "computes the intersection for trailing overlapping ranges" do
      set = described_class.new([1..10]).intersection(described_class.new([5..15]))
      expect(set.to_a).to eq([5..10])
    end

    it "computes the intersection for two completely overlapping ranges" do
      set = described_class.new([1..10]).intersection(described_class.new([3..6]))
      expect(set.to_a).to eq([3..6])
    end

    it "returns an empty intersection if no elements exist in both ranges" do
      set = described_class.new([1..10]).intersection(described_class.new([15..20]))
      expect(set.to_a).to eq([])
    end

    it "returns partial intersections when the range set contains multiple matching ranges" do
      set = described_class.new([1..5, 7..10]).intersection(described_class.new([3..8]))
      expect(set.to_a).to eq([3..5, 7..8])
    end

    it "doesn't matter what order the ranges are compared in" do
      set = described_class.new([2..3]).intersection(described_class.new([1..4]))
      expect(set.to_a).to eq([2..3])

      set = described_class.new([1..4]).intersection(described_class.new([2..3]))
      expect(set.to_a).to eq([2..3])
    end
  end

  describe "#subtract" do
    it "subtracts the intersection for leading overlapping ranges" do
      set = described_class.new([3..10]).subtract(described_class.new([1..5]))
      expect(set.to_a).to eq([6..10])
    end

    it "subtracts the intersection for trailing overlapping ranges" do
      set = described_class.new([1..7]).subtract(described_class.new([3..9]))
      expect(set.to_a).to eq([1..2])
    end

    it "subtracts the intersection for completely overlapping ranges (generates two ranges)" do
      set = described_class.new([1..10]).subtract(described_class.new([4..6]))
      expect(set.to_a).to eq([1..3, 7..10])
    end

    it "results in an empty set if the deducted range entirely overlaps the existing ranges" do
      set = described_class.new([3..10]).subtract(described_class.new([1..15]))
      expect(set.to_a).to eq([])
    end

    it "subtracts the intersection when the range set contians multiple matching ranges" do
      set = described_class.new([1..5, 7..10]).subtract(described_class.new([3..8]))
      expect(set.to_a).to eq([1..2, 9..10])
    end

    it "does not change object when subtracting an empty set" do
      set = described_class.new([1..5]).subtract(described_class.new([]))
      expect(set.to_a).to eq([1..5])
    end
  end

  describe "#difference" do
    it "returns the symmetric difference (union - intersection) between completely overlapping ranges" do
      set = described_class.new([1..10]).difference(described_class.new([3..8]))
      expect(set.to_a).to eq([1..2, 9..10])
    end

    it "returns the symmetric difference between leading overlapping ranges" do
      set = described_class.new([3..10]).difference(described_class.new([1..5]))
      expect(set.to_a).to eq([1..2, 6..10])
    end

    it "returns the symmetric difference between trailing overlapping ranges" do
      set = described_class.new([1..5]).difference(described_class.new([3..8]))
      expect(set.to_a).to eq([1..2, 6..8])
    end
  end

  describe "#include?" do
    let(:set) { described_class.new([1..5, 9..16]) }

    it "returns true if the set completely includes the range, false otherwise" do
      expect(set.include?(10..15)).to eq(true)
      expect(set.include?(3..8)).to eq(false)
      expect(set.include?(8..14)).to eq(false)
    end

    it "returns true if the set contains the value, false otherwise" do
      expect(set.include?(3)).to eq(true)
      expect(set.include?(10)).to eq(true)
      expect(set.include?(6)).to eq(false)
      expect(set.include?(8)).to eq(false)
    end
  end

  describe '#<<' do
    let(:set) { described_class.new([5..10]) }

    it "adds a new range to the set when nothing overlaps" do
      set << (1..3)
      expect(set.to_a).to eq([1..3, 5..10])
    end

    it "adds a new range to the set and handles overlapping" do
      set << (3..6)
      expect(set.to_a).to eq([3..10])
    end

    it "adds a new range to the set and handles full overlapping" do
      set << (1..15)
      expect(set.to_a).to eq([1..15])
    end
  end

  describe "#each_range" do
    let(:set) { described_class.new([5..10, 15..20]) }

    it "yields each individual range to the block" do
      expect(set.each_range.to_a).to eq([5..10, 15..20])
    end
  end

  describe "#each" do
    let(:set) { described_class.new([5..10]) }

    it "yields each number the set contains (as opposed to each range)" do
      expect(set.each.to_a).to eq([5, 6, 7, 8, 9, 10])
    end
  end

  describe "#size" do
    it "returns the number of items in the set" do
      set = described_class.from_array([1, 3, 5])
      expect(set.size).to eq(3)
    end

    it "includes all elements in ranges" do
      set = described_class.from_array([1, 2, 3, 5, 6, 7])
      expect(set.size).to eq(6)
    end
  end
end
