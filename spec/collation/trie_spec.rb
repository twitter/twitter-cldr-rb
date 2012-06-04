# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Collation

describe Trie do

  let(:trie) { Trie.new }

  let(:values) do
    [
        [[1],       '1'],
        [[1, 4],    '14'],
        [[1, 5],    '15'],
        [[1, 4, 8], '148'],
        [[2],       '2'],
        [[2, 7, 5], '275'],
        [[3, 9],    '39']
    ]
  end

  before(:each) do
    values.each { |key, value| trie.add(key, value) }
  end

  describe '#get' do
    it 'returns nil for non existing keys' do
      [[6], [3], [1, 4, 3], [2, 7, 5, 6, 9]].each { |key| trie.get(key).should be_nil }
    end

    it 'returns value and key size for each existing key' do
      values.each { |key, value| trie.get(key).should == value }
    end
  end

  describe '#add' do
    it 'overrides values' do
      trie.get([1, 4]).should == '14'

      trie.add([1, 4], '14-new')
      trie.get([1, 4]).should == '14-new'
    end
  end

  describe '#find_prefix' do
    it 'returns nil as a value and 0 as prefix size if the value is not found' do
      trie.find_prefix([4]).should == [nil, 0]
    end

    it 'returns value and key size for each existing key' do
      values.each { |key, value| trie.find_prefix(key).should == [value, key.size] }
    end

    it 'returns prefix size when the value is found' do
      trie.find_prefix([1, 9]).should          == ['1',   1]
      trie.find_prefix([1, 4, 2]).should       == ['14',  2]
      trie.find_prefix([1, 4, 8, 9, 2]).should == ['148', 3]
      trie.find_prefix([2, 7, 5, 5]).should    == ['275', 3]
    end
  end

end
