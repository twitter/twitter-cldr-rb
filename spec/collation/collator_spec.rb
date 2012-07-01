# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Collation

describe Collator do

  before(:each) { Collator.instance_variable_set(:@trie, nil) }
  after(:all)   { Collator.instance_variable_set(:@trie, nil) }

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

  describe '#get_collation_elements' do
    let(:collator)           { Collator.new }
    let(:string)             { 'abc' }
    let(:code_points_hex)    { %w[0061 0062 0063] }
    let(:code_points)        { code_points_hex.map { |cp| cp.to_i(16) } }
    let(:collation_elements) { [[39, 5, 5], [41, 5, 5], [43, 5, 5]] }

    before :each do
      mock(TwitterCldr::Normalization::NFD).normalize_code_points(code_points_hex) { code_points_hex }
      stub(TwitterCldr::Normalization::Base).combining_class_for { 0 }
    end

    it 'returns collation elements for a string' do
      collator.get_collation_elements(string).should == collation_elements
    end

    it 'returns collation elements for an array of code points (represented as hex strings)' do
      collator.get_collation_elements(code_points_hex).should == collation_elements
    end
  end

  describe '#get_sort_key' do
    let(:collator)           { Collator.new }
    let(:string)             { 'abc' }
    let(:code_points_hex)    { %w[0061 0062 0063] }
    let(:collation_elements) { [[39, 5, 5], [41, 5, 5], [43, 5, 5]] }
    let(:sort_key)           { [39, 41, 43, 1, 7, 1, 7] }

    before(:each) { mock(TwitterCldr::Collation::SortKeyBuilder).build(collation_elements) { sort_key } }

    it 'calculates sort key for a string' do
      mock(collator).get_collation_elements(string) { collation_elements }
      collator.get_sort_key(string).should == sort_key
    end

    it 'calculates sort key for an array of code points (represented as hex strings)' do
      mock(collator).get_collation_elements(code_points_hex) { collation_elements }
      collator.get_sort_key(code_points_hex).should == sort_key
    end
  end

  describe '#compare' do
    let(:collator)         { Collator.new }
    let(:sort_key)         { [1, 3, 8, 9] }
    let(:another_sort_key) { [6, 8, 9, 2] }

    it 'compares strings by sort keys' do
      stub_sort_key(collator, 'foo', sort_key)
      stub_sort_key(collator, 'bar', another_sort_key)

      collator.compare('foo', 'bar').should == -1
      collator.compare('bar', 'foo').should == 1
    end

    it 'returns 0 without computing sort keys if strings are equal' do
      dont_allow(collator).get_sort_key

      collator.compare('foo', 'foo').should == 0
    end

    it 'compares strings by code points if the sort keys are equal' do
      stub(collator).get_sort_key { sort_key }

      collator.compare('bar', 'foo').should == -1
    end
  end

  describe '#sort' do
    let(:collator) { Collator.new }

    it 'sorts strings by sort keys' do
      [['aaa', [1, 2, 3]], ['abc', [1, 3, 4]], ['bca', [2, 5, 9]]].each { |s, key| mock_sort_key(collator, s, key) }

      collator.sort(%w[bca aaa abc]).should == %w[aaa abc bca]
    end

    it 'sorts strings with equal sort keys by code points' do
      [['aaa', [1, 2, 3]], ['abc', [1, 2, 3]], ['bca', [1, 2, 3]]].each { |s, key| mock_sort_key(collator, s, key) }

      collator.sort(%w[bca abc aaa]).should == %w[aaa abc bca]
    end
  end

  def mock_sort_key(collator, string, sort_key)
    mock(collator).get_sort_key(TwitterCldr::Utils::CodePoints.from_string(string)) { sort_key }
  end

  def stub_sort_key(collator, string, sort_key)
    stub(collator).get_sort_key(TwitterCldr::Utils::CodePoints.from_string(string)) { sort_key }
  end

end
