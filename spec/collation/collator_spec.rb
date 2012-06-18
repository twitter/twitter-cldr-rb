# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Collation

describe Collator do

  after :all do
    Collator.instance_variable_set(:@trie, nil)
  end

  describe '.trie' do
    it 'returns collation elements trie' do
      Collator.instance_variable_set(:@trie, nil)
      mock(TrieBuilder).load_trie(Collator::FRACTIONAL_UCA_SHORT_RESOURCE) { 'trie' }
      Collator.trie.should == 'trie'
    end

    it 'loads the trie only once' do
      Collator.instance_variable_set(:@trie, nil)
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

end
