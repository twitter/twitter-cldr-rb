# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Localized

describe LocalizedArray do
  describe '#code_points_to_string' do
    it 'transforms an array of code points into a string' do
      expect([0x74, 0x77, 0x69, 0x74, 0x74, 0x65, 0x72].localize.code_points_to_string).to eq('twitter')
    end
  end

  describe 'strings sorting' do
    let(:locale)    { :da }
    let(:array)     { %w[bca aaa abc] }
    let(:sorted)    { %w[aaa abc bca] }
    let(:localized) { array.localize(locale) }

    before(:each) { mock(TwitterCldr::Collation::Collator).new(locale) { FakeCollator.new } }

    describe '#sort' do
      it 'returns a new LocalizedArray' do
        expect(localized.sort).to be_instance_of(LocalizedArray)
      end

      it 'does not change the original array' do
        expect { localized.sort }.not_to change { localized.base_obj }
      end

      it 'sorts strings in the array with corresponding collator' do
        expect(localized.sort.base_obj).to eq(sorted)
      end
    end

    describe '#sort!' do
      it 'returns self' do
        expect(localized.sort!.object_id).to eq(localized.object_id)
      end

      it 'sorts the array in-place' do
        expect(localized.sort!.base_obj).to eq(sorted)
      end
    end
  end

  describe "#each" do
    it "should iterate over the items in the array and yield each one" do
      arr = [1, 2, 3]
      index = 0

      arr.localize.each do |item|
        expect(arr[index]).to eq(item)
        index += 1
      end
    end

    it "should support a few of the other methods in Enumerable" do
      expect([1, 2, 3].localize.inject(0) { |sum, num| sum += num; sum }).to eq(6)
      expect([1, 2, 3].localize.map { |item| item + 1 }).to eq([2, 3, 4])
    end
  end

  describe "#to_yaml" do
    it "should be able to successfully roundtrip the array" do
      arr = [:foo, "bar", Object.new]
      result = YAML.load(arr.localize.to_yaml)

      expect(result[0]).to eq(:foo)
      expect(result[1]).to eq("bar")
      expect(result[2]).to be_a(Object)
    end
  end
end

class FakeCollator
  def sort(array)
    array.sort
  end

  def sort!(array)
    array.sort!
  end
end