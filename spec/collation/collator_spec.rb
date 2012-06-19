# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Collation

describe Collator do

  before :each do
    Collator.instance_variable_set(:@trie, nil)
  end

  after :all do
    Collator.instance_variable_set(:@trie, nil)
  end

  describe '.trie' do
    it 'returns collation elements trie' do
      mock(TrieBuilder).load_trie(Collator::FRACTIONAL_UCA_SHORT_RESOURCE) { 'trie' }
      Collator.trie.should == 'trie'
    end

    it 'loads the trie only once' do
      mock(TrieBuilder).load_trie(Collator::FRACTIONAL_UCA_SHORT_RESOURCE) { 'trie' }

      Collator.trie.object_id.should == Collator.trie.object_id
    end
  end

  describe '#trie' do
    it 'delegates to the class method' do
      mock(Collator).trie { 'trie' }
      Collator.new.trie.should == 'trie'
    end

    it 'calls class method only once' do
      mock(Collator).trie { 'trie' }

      collator = Collator.new
      collator.trie.object_id.should == collator.trie.object_id
    end
  end

  describe '#sort_key' do
    let(:collator)        { Collator.new }
    let(:string)          { 'abc' }
    let(:code_points_hex) { %w[0061 0062 0063] }
    let(:code_points)     { code_points_hex.map { |cp| cp.to_i(16) } }
    let(:sort_key)        { [9986, 10498, 11010, 0, 1282, 1282, 1282, 0, 1282, 1282, 1282] }

    before(:each) { mock(collator).sort_key_for_code_points(code_points) { sort_key } }

    it 'calculates sort key for a string' do
      mock(TwitterCldr::Utils::CodePoints).from_string(string) { code_points_hex }
      collator.sort_key(string).should == sort_key
    end

    it 'calculates sort key for an array of code points (represented as hex strings)' do
      dont_allow(TwitterCldr::Utils::CodePoints).from_string(string)
      collator.sort_key(code_points_hex).should == sort_key
    end
  end

  describe '#compare' do
    let(:collator)         { Collator.new }
    let(:sort_key)         { [1, 3, 8, 9] }
    let(:another_sort_key) { [6, 8, 9, 2] }

    it 'compares strings by sort keys' do
      stub(collator).sort_key('foo') { sort_key }
      stub(collator).sort_key('bar') { another_sort_key }

      collator.compare('foo', 'bar').should == -1
      collator.compare('bar', 'foo').should == 1
    end

    it 'returns 0 without computing sort keys if strings are equal' do
      dont_allow(collator).sort_key

      collator.compare('foo', 'foo').should == 0
    end

    it 'compares strings by code points if the sort keys are equal' do
      stub(collator).sort_key { sort_key }

      collator.compare('bar', 'foo').should == -1
    end
  end

end
