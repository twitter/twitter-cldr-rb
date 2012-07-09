# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr

describe LocalizedArray do
  describe '#code_points_to_string' do
    it 'transforms an array of code points into a string' do
      %w[0074 0077 0069 0074 0074 0065 0072].localize.code_points_to_string.should == 'twitter'
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
end

class FakeCollator
  def sort(array)
    array.sort
  end

  def sort!(array)
    array.sort!
  end
end