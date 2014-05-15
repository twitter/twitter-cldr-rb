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
        [[1, 4, 8], '148'],
        [[1, 5],    '15' ],
        [[2],       '2'  ],
        [[2, 7, 5], '275'],
        [[3, 9, 2], '392'],
        [[4],       '4'  ]
    ]
  end

  before(:each) { values.each { |key, value| trie.add(key, value) } }

  describe '#initialize' do
    it 'initializes an empty trie by default' do
      expect(Trie.new).to be_empty
    end

    it 'initializes with a root node' do
      trie = Trie.new(Trie::Node.new(nil, 1 => Trie::Node.new(nil, { 2 => Trie::Node.new('12')}), 2 => Trie::Node.new('2')))

      expect(trie.to_hash).to eq({
          1 => [nil, { 2 => ['12', {}] }],
          2 => ['2', {}]
      })
    end
  end

  describe '#lock and #locked?' do
    it 'trie is unlocked by default' do
      expect(trie).not_to be_locked
    end

    it '#lock locks the trie' do
      trie.lock
      expect(trie).to be_locked
    end

    it '#lock returns the trie' do
      expect(trie.lock).to eq(trie)
    end
  end

  describe '#starters' do
    it 'returns all unique first elements of the keys in the trie' do
      expect(trie.starters).to match_array([1, 2, 3, 4])
    end
  end

  describe '#each_starting_with' do
    it 'iterates over all key-value pairs for which key starts with a given value' do
      res = {}
      trie.each_starting_with(1) { |k, v| res[k] = v }

      expect(res).to eq({ [1] => '1', [1, 4] => '14', [1, 5] => '15', [1, 4, 8] => '148' })
    end

    it 'works when argument is not a starter' do
      res = {}
      trie.each_starting_with(42) { |k, v| res[k] = v }

      expect(res).to eq({})
    end
  end

  describe '#get' do
    it 'returns nil for non existing keys' do
      [[6], [3], [1, 4, 3], [2, 7, 5, 6, 9]].each { |key| expect(trie.get(key)).to be_nil }
    end

    it 'returns value for each existing key' do
      values.each { |key, value| expect(trie.get(key)).to eq(value) }
    end
  end

  describe '#add' do
    it 'does not override values' do
      expect(trie.get([1, 4])).to eq('14')

      trie.add([1, 4], '14-new')
      expect(trie.get([1, 4])).to eq('14')
    end

    it 'adds new values' do
      expect(trie.get([1, 9])).to be_nil

      trie.add([1, 9], '19')
      expect(trie.get([1, 9])).to eq('19')
    end

    it 'raises RuntimeError if called on a locked trie' do
      expect { trie.lock.add([1, 3], 'value') }.to raise_error(RuntimeError)
    end
  end

  describe '#set' do
    it 'overrides values' do
      expect(trie.get([1, 4])).to eq('14')

      trie.set([1, 4], '14-new')
      expect(trie.get([1, 4])).to eq('14-new')
    end

    it 'adds new values' do
      expect(trie.get([1, 9])).to be_nil

      trie.set([1, 9], '19')
      expect(trie.get([1, 9])).to eq('19')
    end

    it 'raises RuntimeError if called on a locked trie' do
      expect { trie.lock.set([1, 3], 'value') }.to raise_error(RuntimeError)
    end
  end

  describe '#find_prefix' do
    let(:root_subtrie) {
      {
          1 => ['1', { 4 => ['14', { 8 => ['148', {}] }], 5 => ['15', {}] }],
          2 => ['2', { 7 => [nil, { 5 => ['275', {}] }] }],
          3 => [nil, { 9 => [nil, { 2 => ['392', {}] }] }],
          4 => ['4', {}]
      }
    }

    describe 'first two elements of the returned array (value and prefix size)' do
      it 'are nil and 0 if the prefix was not found' do
        expect(trie.find_prefix([42]).first(2)).to eq([nil, 0])
      end

      it 'are the stored value and the key size if the whole key was found' do
        values.each do |key, value|
          expect(trie.find_prefix(key).first(2)).to eq([value, key.size])
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
          expect(trie.find_prefix(key).first(2)).to eq(result)
        end
      end

      def test_find_prefix(trie, key, value, size = key.size)
        expect(trie.find_prefix(key).first(2)).to eq([value, size])
      end
    end

    describe 'last element of the returned array (suffixes subtrie)' do
      let(:non_existing_key)     { [5, 2, 7] }
      let(:key_with_suffixes)    { [2] }
      let(:key_without_suffixes) { [1, 4, 8] }

      it 'is always a locked trie' do
        [trie, trie.lock].each do |some_trie|
          [non_existing_key, key_with_suffixes, key_without_suffixes].each do |key|
            expect(some_trie.find_prefix(key).last).to be_locked
          end
        end
      end

      it 'is a locked empty subtrie if the prefix that was found does not have any suffixes' do
        expect(trie.find_prefix(key_without_suffixes).last.to_hash).to be_empty
      end

      it 'is a subtrie of possible suffixes for the prefix that was found' do
        expect(trie.find_prefix(key_with_suffixes).last.to_hash).to eq({ 7 => [nil, { 5 => ["275", {}] }] })
      end

      it 'is a hash representing the whole trie if the prefix was not found' do
        expect(trie.get(non_existing_key)).to be_nil

        expect(trie.find_prefix(non_existing_key).last.to_hash).to eq(root_subtrie)
      end

    end

    context 'argument does not match any value, but is a prefix of a longer key' do
      context 'argument has a shorter key as a prefix' do
        it 'returns value for the key, its size and suffixes subtrie' do
          expect(trie.get([2])).not_to be_nil
          expect(trie.get([2, 7, 5])).not_to be_nil

          result = trie.find_prefix([2, 7])

          expect(result.first(2)).to eq(['2', 1])
          expect(result.last.to_hash).to eq({ 7 => [nil, { 5 => ["275", {}] }] })
        end
      end

      context 'argument does not have a shorter key as a prefix' do
        it 'returns nil, 0 and suffixes subtrie for the root node' do
          expect(trie.get([3])).to be_nil
          expect(trie.get([3, 9])).to be_nil
          expect(trie.get([3, 9, 2])).not_to be_nil

          result = trie.find_prefix([3, 9])

          expect(result.first(2)).to eq([nil, 0])
          expect(result.last.to_hash).to eq(root_subtrie)
        end
      end
    end

  end

  describe 'marshaling' do
    it 'dumps trie structure' do
      trie = Trie.new
      trie.add([13, 37], 1337)
      trie.add([42], 42)

      expect(Marshal.load(Marshal.dump(trie)).to_hash).to eq({ 42 => [42, {}], 13 => [nil, { 37 => [1337, {}] }] })
    end

    it 'does not dump locked state' do
      expect(Marshal.load(Marshal.dump(Trie.new.lock))).not_to be_locked
    end
  end

  describe Trie::Node do

    let(:node)          { Trie::Node.new }
    let(:child)         { Trie::Node.new('child') }
    let(:another_child) { Trie::Node.new('another-child') }

    let(:root_node) do
      Trie::Node.new(
          'node-0',
          1 => Trie::Node.new(
              'node-1',
              1 => Trie::Node.new('node-11'),
              2 => Trie::Node.new('node-12')
          ),
          2 => Trie::Node.new(
              'node-2',
              1 => Trie::Node.new(
                  'node-21',
                  1 => Trie::Node.new('node-211')
              )
          )
      )
    end

    let(:subtrie_hash) do
      {
          1 => [
              'node-1',
              {
                  1 => ['node-11', {}],
                  2 => ['node-12', {}]
              }
          ],
          2 => [
              'node-2',
              {
                  1 => [
                      'node-21',
                      {
                          1 => ['node-211', {}]
                      }
                  ]
              }
          ]
      }
    end

    describe '#initialize' do
      it 'initializes node with nil value and empty children hash by default' do
        expect(node.value).to be_nil
        expect(node).not_to have_children
      end

      it 'initializes node with provided value and children hash' do
        expect(root_node.value).to eq('node-0')
        expect(root_node).to have_children
      end
    end

    describe '#child and #set_child' do
      it '#child returns nil if a child with a given key does not exist' do
        expect(node.child(42)).to be_nil
      end

      it '#set_child saves a child by key and #child returns the child by key' do
        node.set_child(42, child)
        expect(node.child(42)).to eq(child)
      end

      it '#set_child overrides a child by key' do
        node.set_child(42, child)
        node.set_child(42, another_child)

        expect(node.child(42)).not_to eq(child)
        expect(node.child(42)).to eq(another_child)
      end

      it '#set_child returns the child that was saved' do
        expect(node.set_child(42, child)).to eq(child)
      end
    end

    describe '#each_key_and_child' do
      it 'iterates over all (key, child) pairs' do
        node.set_child(42, child)
        node.set_child(13, another_child)
        res = {}
        node.each_key_and_child { |key, child| res[key] = child }

        expect(res).to eq({ 42 => child, 13 => another_child })
      end
    end

    describe '#keys' do
      it 'returns all children keys' do
        node.set_child(42, child)
        node.set_child(13, another_child)

        expect(node.keys).to match_array([13, 42])
      end
    end

    describe '#has_children?' do
      it 'returns false if the node has no children' do
        expect(node).not_to have_children
      end

      it 'returns true if the node has children' do
        node.set_child(42, child)
        expect(node).to have_children
      end
    end

    describe '#to_trie' do
      it 'returns a trie' do
        expect(node.to_trie).to be_instance_of(Trie)
      end

      it 'returns a locked trie' do
        expect(node.to_trie).to be_locked
      end

      it 'current node is a root of a new trie' do
        expect(root_node.to_trie.to_hash).to eq(subtrie_hash)
      end

      it 'sets new trie root value to nil' do
        expect(root_node.value).not_to be_nil
        expect(root_node.to_trie.instance_variable_get(:@root).value).to be_nil
      end
    end

    describe '#subtrie_hash' do
      it 'returns an empty hash if the node has no children' do
        expect(node.subtrie_hash).to eq({})
      end

      it 'returns a nested hash of children values' do
        expect(root_node.subtrie_hash).to eq(subtrie_hash)
      end
    end

  end

end