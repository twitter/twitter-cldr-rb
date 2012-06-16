# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Collation

describe Trie do

  let(:trie) { Trie.new }

  let(:values) do
    [
        [[1], '1'],
        [[1, 4], '14'],
        [[1, 5], '15'],
        [[1, 4, 8], '148'],
        [[2], '2'],
        [[2, 7, 5], '275'],
        [[3, 9], '39']
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
    describe 'first (value) and third (prefix size) elements of the returned array' do
      it 'value is 0 nil and prefix size is 0 if the prefix was not found' do
        test_find_prefix(trie, [4], nil, 0)
      end

      it 'stored value and key size as a prefix size if the whole key was found' do
        values.each do |key, value|
          test_find_prefix(trie, key, value)
        end
      end

      it 'stored value and size of the corresponding prefix if only part of the key was found' do
        tests = {
            [1, 9]          => ['1', 1],
            [1, 4, 2]       => ['14', 2],
            [1, 4, 8, 9, 2] => ['148', 3],
            [2, 7, 5, 5]    => ['275', 3]
        }

        tests.each { |key, result| test_find_prefix(trie, key, *result) }
      end

      def test_find_prefix(trie, key, value, size = key.size)
        result = trie.find_prefix(key)

        result[0].should == value
        result[2].should == size
      end
    end

    describe 'second (subtrie) element of the returned array' do
      it 'is a hash of possible suffixes for the prefix that was found' do
        trie.find_prefix([1, 4, 8])[1].should == {}
        trie.find_prefix([2, 7])[1].should == { 5 => ["275", { }] }
      end

      it 'is a hash representing the whole trie if the prefix was not found' do
        trie.find_prefix([404])[1].should == {
            1 => ['1', { 4 => ['14', { 8 => ['148', {}] }], 5 => ['15', {}] }],
            2 => ['2', { 7 => [nil,  { 5 => ['275', {}] }] }],
            3 => [nil, { 9 => ['39', {}] }]
        }
      end
    end

  end

end
