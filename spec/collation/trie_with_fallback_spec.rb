# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Collation

describe TrieWithFallback do

  let(:fallback) { Trie.new }
  let(:trie)     { TrieWithFallback.new(fallback) }

  before(:each) { trie.add([1, 2, 3], 'value') }

  describe '#get' do
    it 'returns result if the key is present' do
      dont_allow(fallback).get
      expect(trie.get([1, 2, 3])).to eq('value')
    end

    it 'resorts to the fallback if the key is not present' do
      mock(fallback).get([3, 2, 1]) { 'fallback-value' }
      expect(trie.get([3, 2, 1])).to eq('fallback-value')
    end
  end

  describe '#find_prefix' do
    it 'returns result if the key is present' do
      dont_allow(fallback).find_prefix
      expect(trie.find_prefix([1, 2, 3, 4]).first(2)).to eq(['value', 3])
    end

    it 'resorts to the fallback if the key is not present' do
      mock(fallback).find_prefix([3, 2, 1]) { 'fallback-result' }
      expect(trie.find_prefix([3, 2, 1])).to eq('fallback-result')
    end
  end

  describe 'marshaling' do
    it 'does not dump fallback' do
      expect(Marshal.load(Marshal.dump(TrieWithFallback.new(Trie.new))).fallback).to be_nil
    end
  end

end
