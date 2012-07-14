# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Collation

describe SortKeyBuilder do

  let(:sort_key) { SortKeyBuilder.new(collation_elements) }
  let(:collation_elements) { [[63, 13, 149], [66, 81, 143]] }
  let(:sort_key_bytes) { [63, 66, 1, 13, 81, 1, 149, 143] }

  describe '.build' do
    it 'returns a sort key for a given array of collation elements' do
      sort_key = SortKeyBuilder.new(collation_elements)

      mock(SortKeyBuilder).new(collation_elements) { sort_key }
      mock(sort_key).bytes_array { sort_key_bytes }

      SortKeyBuilder.build(collation_elements).should == sort_key_bytes
    end
  end

  describe '#initialize' do
    it 'assigns collation elements array' do
      SortKeyBuilder.new(collation_elements).collation_elements.should == collation_elements
    end
  end

  describe '#bytes_array' do
    it 'builds sort key bytes' do
      sort_key.bytes_array.should == sort_key_bytes
    end

    it 'builds bytes array only once' do
      mock(sort_key).build_bytes_array { sort_key_bytes }
      sort_key.bytes_array.object_id == sort_key.bytes_array.object_id
    end

    it 'compresses primary weights' do
      SortKeyBuilder.new([[0x7A72,     0, 0], [0x7A73, 0, 0], [0x7A75, 0, 0], [0x908, 0, 0], [0x7A73, 0, 0]]).bytes_array.should ==
                          [0x7A, 0x72,           0x73,           0x75, 0x3,    0x9, 0x08,     0x7A, 0x73, 1, 1]

      SortKeyBuilder.new([[0x7A72,     0, 0], [0x7A73, 0, 0], [0x7A75, 0, 0], [0x9508, 0, 0], [0x7A73, 0, 0]]).bytes_array.should ==
                          [0x7A, 0x72,           0x73,           0x75, 0xFF,   0x95, 0x08,     0x7A, 0x73, 1, 1]
    end

    it 'works when there is an ignorable primary weight in the middle' do
      SortKeyBuilder.new([[0x1312, 0, 0], [0, 0, 0], [0x1415, 0, 0]]).bytes_array.should == [0x13, 0x12, 0x14, 0x15, 1, 1]
    end

    it 'do not compress single byte primary weights' do
      SortKeyBuilder.new([[0x13, 0, 0], [0x13, 0, 0]]).bytes_array.should == [0x13, 0x13, 1, 1]
    end

    it 'resets primary lead bytes counter after a single byte weight' do
      SortKeyBuilder.new([[0x1415, 0, 0], [0x13, 0, 0], [0x13, 0, 0], [0x1412, 0, 0]]).bytes_array.should == [0x14, 0x15, 0x13, 0x13, 0x14, 0x12, 1, 1]
    end

    it 'compresses only allowed primary weights' do
      SortKeyBuilder.new([[0x812, 0, 0], [0x811, 0, 0]]).bytes_array.should == [0x8, 0x12, 0x8, 0x11, 1, 1]
    end

    it 'compresses secondary weights' do
      SortKeyBuilder.new([[0, 5, 0], [0, 5, 0], [0, 141, 0], [0, 5, 0], [0, 5, 0]]).bytes_array.should == [1, 133, 141, 6, 1]
    end

    it 'compresses tertiary weights' do
      SortKeyBuilder.new([[0, 0, 5], [0, 0, 5], [0, 0, 39], [0, 0, 5], [0, 0, 5]]).bytes_array.should == [1, 1, 132, 167, 6]
    end

    it 'compresses secondary and tertiary weights into multiple bytes if necessary' do
      SortKeyBuilder.new([[0, 5, 5]] * 100).bytes_array.should == [1, 69, 40, 1, 48, 48, 18]
    end
  end

end
