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
    context 'when override argument is not specified (uses true as default)' do
      it 'overrides values' do
        trie.get([1, 4]).should == '14'

        trie.add([1, 4], '14-new')
        trie.get([1, 4]).should == '14-new'
      end

      it 'adds new values' do
        trie.get([1, 9]).should be_nil

        trie.add([1, 9], '19')
        trie.get([1, 9]).should == '19'
      end
    end

    context 'when override is true' do
      it 'overrides values' do
        trie.get([1, 4]).should == '14'

        trie.add([1, 4], '14-new', true)
        trie.get([1, 4]).should == '14-new'
      end

      it 'adds new values' do
        trie.get([1, 9]).should be_nil

        trie.add([1, 9], '19', true)
        trie.get([1, 9]).should == '19'
      end
    end

    context 'when override is false' do
      it 'does not override values' do
        trie.get([1, 4]).should == '14'

        trie.add([1, 4], '14-new', false)
        trie.get([1, 4]).should == '14'
      end

      it 'adds new values' do
        trie.get([1, 9]).should be_nil

        trie.add([1, 9], '19', false)
        trie.get([1, 9]).should == '19'
      end
    end
  end

  describe '#find_prefix' do
    describe 'first (value) and third (prefix size) elements of the returned array' do
      it 'value is 0 nil and prefix size is 0 if the prefix was not found' do
        test_find_prefix(trie, [42], nil, 0)
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
        trie.find_prefix([1, 4, 8])[1].should == nil
        trie.find_prefix([2, 7])[1].should == { 5 => ["275", nil] }
      end

      it 'is a hash representing the whole trie if the prefix was not found' do
        trie.find_prefix([404])[1].should == {
            1 => ['1', { 4 => ['14', { 8 => ['148', nil] }], 5 => ['15', nil] }],
            2 => ['2', { 7 => [nil,  { 5 => ['275', nil] }] }],
            3 => [nil, { 9 => ['39', nil] }],
            4 => ['4', nil]
        }
      end
    end

  end

end
