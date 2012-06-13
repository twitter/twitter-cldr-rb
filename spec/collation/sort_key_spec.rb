# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Collation

describe SortKey do

  let(:sort_key) { SortKey.new(collation_elements) }
  let(:collation_elements) { [[61, 12, 22], [34, 29, 28]] }
  let(:sort_key_bytes) { [61, 34, 1, 12, 29, 1, 22, 28] }

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
  end

end
