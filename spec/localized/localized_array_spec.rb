# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Localized

describe LocalizedArray do
  describe '#code_points_to_string' do
    it 'transforms an array of code points into a string' do
      [0x74, 0x77, 0x69, 0x74, 0x74, 0x65, 0x72].localize.code_points_to_string.should == 'twitter'
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
        localized.sort.should be_instance_of(LocalizedArray)
      end

      it 'does not change the original array' do
        lambda { localized.sort }.should_not change { localized.base_obj }
      end

      it 'sorts strings in the array with corresponding collator' do
        localized.sort.base_obj.should == sorted
      end
    end

    describe '#sort!' do
      it 'returns self' do
        localized.sort!.object_id.should == localized.object_id
      end

      it 'sorts the array in-place' do
        localized.sort!.base_obj.should == sorted
      end
    end
  end

  describe "#each" do
    it "should iterate over the items in the array and yield each one" do
      arr = [1, 2, 3]
      index = 0

      arr.localize.each do |item|
        arr[index].should == item
        index += 1
      end
    end

    it "should support a few of the other methods in Enumerable" do
      [1, 2, 3].localize.inject(0) { |sum, num| sum += num; sum }.should == 6
      [1, 2, 3].localize.map { |item| item + 1 }.should == [2, 3, 4]
    end
  end

  describe "#to_yaml" do
    it "should be able to successfully roundtrip the array" do
      arr = [:foo, "bar", Object.new]
      result = YAML.load(arr.localize.to_yaml)

      result[0].should == :foo
      result[1].should == "bar"
      result[2].should be_a(Object)
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