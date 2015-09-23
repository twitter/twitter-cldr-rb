# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Utils

describe RangeHash do
  let(:hash) do
    RangeHash.new.tap do |hash|
      hash[2..5] = 'foo'
      hash[8..12] = 'bar'
      hash[6..7] = 'baz'
    end
  end

  describe '#[]' do
    it 'retrieves the same value within each range' do
      (2..5).each { |i| expect(hash[i]).to eq('foo') }
      (6..7).each { |i| expect(hash[i]).to eq('baz') }
      (8..12).each { |i| expect(hash[i]).to eq('bar') }
    end

    it "returns nil if the item doesn't exist in the hash" do
      expect(hash[1]).to be_nil
    end

    it 'does not allow a range to be passed as the index' do
      expect { hash[2..5] }.to raise_error(ArgumentError)
    end
  end

  describe '#[]=' do
    it 'does not allow reassignment to front-overlapping range' do
      expect { hash[1..4] = 'hello' }.to raise_error(OverlappingRangeError)
    end

    it 'does not allow reassignment to rear-overlapping range' do
      expect { hash[3..6] = 'hello' }.to raise_error(OverlappingRangeError)
    end

    it 'does not allow reassignment to completely overlapping range' do
      expect { hash[1..6] = 'hello' }.to raise_error(OverlappingRangeError)
    end

    it 'allows reassignment to exactly matching ranges' do
      expect { hash[2..5] = 'hello' }.to_not raise_error
      expect(hash[2]).to eq('hello')
    end

    it 'allows inserting at the end' do
      hash[15..20] = 'goo'
      expect(hash[17]).to eq('goo')
    end

    it 'allows inserting at the beginning' do
      hash[0..1] = 'abc'
      expect(hash[0]).to eq('abc')
    end
  end

  describe '#keys' do
    it 'returns all the integer keys (not ranges) in the hash' do
      expect(hash.keys).to eq([2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12])
    end
  end

  describe '#values' do
    it 'returns all the values in the hash' do
      expect(hash.values).to eq(%w(foo bar baz))
    end
  end

  describe '#each' do
    it 'yields each individual key/value pair' do
      expect(hash.each.to_a).to eq([
        [2, 'foo'], [3, 'foo'], [4, 'foo'], [5, 'foo'],
        [6, 'baz'], [7, 'baz'],
        [8, 'bar'], [9, 'bar'], [10, 'bar'], [11, 'bar'], [12, 'bar']
      ])
    end
  end
end
