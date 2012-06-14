# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Collation

describe SortKey do

  let(:sort_key) { SortKey.new(collation_elements) }
  let(:collation_elements) { [[63, 5, 149], [63, 5, 143]] }
  let(:sort_key_bytes) { [63, 63, 1, 5, 5, 1, 149, 143] }

  describe '.build' do
    it 'returns a sort key for a given array of collation elements' do
      sort_key = SortKey.new(collation_elements)

      mock(SortKey).new(collation_elements) { sort_key }
      mock(sort_key).bytes_array { sort_key_bytes }

      SortKey.build(collation_elements).should == sort_key_bytes
    end
  end

  describe '#initialize' do
    it 'assigns collation elements array' do
      SortKey.new(collation_elements).collation_elements.should == collation_elements
    end
  end

  describe '#bytes_array' do
    it 'builds sort key bytes' do
      sort_key.bytes_array.should == sort_key_bytes
    end

    it 'builds bytes array only once' do
      mock(sort_key).build { sort_key_bytes }
      sort_key.bytes_array.object_id == sort_key.bytes_array.object_id
    end

    it 'compresses tertiary weights' do
      SortKey.new([[0, 0, 5], [0, 0, 5], [0, 0, 39], [0, 0, 5], [0, 0, 5]]).bytes_array.should == [1, 1, 132, 167, 6]
    end
  end

end
