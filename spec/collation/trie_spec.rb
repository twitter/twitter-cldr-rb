# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Collation

describe Trie do

  let(:trie) { Trie.new }

  let(:values) do
    [
        [[1],       '1'  ],
        [[1, 4],    '14' ],
        [[1, 5],    '15' ],
        [[1, 4, 8], '148'],
        [[2],       '2'  ],
        [[2, 7, 5], '275'],
        [[3, 9],    '39' ],
        [[4],       '4'  ]
    ]
  end

  before(:each) { values.each { |key, value| trie.add(key, value) } }

  describe '#starters' do
    it 'returns all unique first elements of the keys in the trie' do
      trie.starters.sort.should == [1, 2, 3, 4]
    end
  end

  describe '#each_starting_with' do
    it 'iterates over all key-value pairs for which key starts with a given value' do
      res = {}
      trie.each_starting_with(1) { |k, v| res[k] = v }

      res.should == { [1] => '1', [1, 4] => '14', [1, 5] => '15', [1, 4, 8] => '148' }
    end

    it 'works when argument is not a starter' do
      res = {}
      trie.each_starting_with(42) { |k, v| res[k] = v }

      res.should == {}
    end
  end

  describe '#get' do
    it 'returns nil for non existing keys' do
      [[6], [3], [1, 4, 3], [2, 7, 5, 6, 9]].each { |key| trie.get(key).should be_nil }
    end

    it 'returns value for each existing key' do
      values.each { |key, value| trie.get(key).should == value }
    end
  end

  describe '#add' do
    it 'does not override values' do
      trie.get([1, 4]).should == '14'

      trie.add([1, 4], '14-new')
      trie.get([1, 4]).should == '14'
    end

    it 'adds new values' do
      trie.get([1, 9]).should be_nil

      trie.add([1, 9], '19')
      trie.get([1, 9]).should == '19'
    end
  end

  describe '#set' do
    it 'overrides values' do
      trie.get([1, 4]).should == '14'

      trie.set([1, 4], '14-new')
      trie.get([1, 4]).should == '14-new'
    end

    it 'adds new values' do
      trie.get([1, 9]).should be_nil

      trie.set([1, 9], '19')
      trie.get([1, 9]).should == '19'
    end
  end

  describe '#find_prefix' do
    describe 'first two elements of the returned array' do
      it 'value is 0 nil and prefix size is 0 if the prefix was not found' do
        trie.find_prefix([42]).first(2).should == [nil, 0]
      end

      it 'stored value and key size as a prefix size if the whole key was found' do
        values.each do |key, value|
          trie.find_prefix(key).first(2).should == [value, key.size]
        end
      end

      it 'stored value and size of the corresponding prefix if only part of the key was found' do
        tests = {
            [1, 9]          => ['1', 1],
            [1, 4, 2]       => ['14', 2],
            [1, 4, 8, 9, 2] => ['148', 3],
            [2, 7, 5, 5]    => ['275', 3]
        }

        tests.each do |key, result|
          trie.find_prefix(key).first(2).should == result
        end
      end

      def test_find_prefix(trie, key, value, size = key.size)
        trie.find_prefix(key).first(2).should == [value, size]
      end
    end

    describe 'last element of the returned array' do
      it 'is an empty sub-trie if the prefix that was found does not have any suffixes' do
        subtrie = trie.find_prefix([1, 4, 8]).last

        subtrie.is_a?(Trie)
        subtrie.to_hash.should be_empty
      end

      it 'is a sub-trie of possible suffixes for the prefix that was found' do
        subtrie = trie.find_prefix([2, 7]).last

        subtrie.is_a?(Trie)
        subtrie.to_hash.should == { 5 => ["275", {}] }
      end

      it 'is a hash representing the whole trie if the prefix was not found' do
        subtrie = trie.find_prefix([404]).last

        subtrie.to_hash.should == {
            1 => ['1', { 4 => ['14', { 8 => ['148', {}] }], 5 => ['15', {}] }],
            2 => ['2', { 7 => [nil, { 5 => ['275', {}] }] }],
            3 => [nil, { 9 => ['39', {}] }],
            4 => ['4', {}]
        }
      end
    end

  end

end

describe Trie::Node do

  let(:node)          { Trie::Node.new }
  let(:child)         { Trie::Node.new('child') }
  let(:another_child) { Trie::Node.new('another-child') }

  describe '#initialize' do
    it 'uses nil as default node value' do
      node.value.should be_nil
    end

    it 'saves provided value as a node value' do
      child.value.should == 'child'
    end
  end

  describe '#value' do
    it 'is nil by default' do
      node.value.should be_nil
    end

    it 'stores the value' do
      node.value = 42
      node.value.should == 42
    end
  end

  describe '#child and #set_child' do
    it '#child returns nil if a child with a given key does not exist' do
      node.child(42).should be_nil
    end

    it '#set_child saves a child by key and #child returns the child by key' do
      node.set_child(42, child)
      node.child(42).should == child
    end

    it '#set_child overrides a child by key' do
      node.set_child(42, child)
      node.set_child(42, another_child)

      node.child(42).should_not == child
      node.child(42).should == another_child
    end

    it '#set_child returns the child that was saved' do
      node.set_child(42, child).should == child
    end
  end

  describe '#children' do
    it 'returns an empty hash if the node has no children' do
      node.children.should == {}
    end

    it 'returns a hash of children' do
      node.set_child(42, child)
      node.set_child(88, another_child)

      node.children.should == { 42 => child, 88 => another_child }
    end
  end

  describe '#children_hash' do
    it 'returns an empty hash if the node has no children' do
      node.children_hash.should == {}
    end

    it 'returns a nested hash of children values' do
      child.set_child(12, another_child)
      node.set_child(1, child)
      node.set_child(2, another_child)

      node.children_hash.should == { 1 => ['child', { 12 => ['another-child', {}] }], 2 => ['another-child', {}] }
    end
  end

end
