# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Collation

describe Collator do

  let(:trie) { Trie.new }

  before(:each) { Collator.clear_default_fce_trie }
  after(:all)   { Collator.clear_default_fce_trie }

  describe '.clear_default_fce_trie' do
    it 'forces Collator to reload default FCE next time' do
      mock(TrieBuilder).load_trie(Collator::FRACTIONAL_UCA_SHORT_RESOURCE).twice { trie }

      Collator.default_fce_trie
      Collator.clear_default_fce_trie
      Collator.default_fce_trie
    end
  end

  describe '.default_fce_trie' do
    before(:each) do
      Collator.clear_default_fce_trie
      mock(TrieBuilder).load_trie(Collator::FRACTIONAL_UCA_SHORT_RESOURCE) { trie }
    end

    it 'returns default fractional collation elements trie' do
      Collator.default_fce_trie.should == trie
    end

    it 'loads the trie only once' do
      Collator.default_fce_trie.object_id.should == Collator.default_fce_trie.object_id
    end

    it 'locks the trie' do
      Collator.default_fce_trie.should be_locked
    end
  end

  describe '#initialize' do
    before(:each) { stub(TrieBuilder).load_trie { trie } }
    before(:each) { any_instance_of(Collator) { |c| stub(c).load_trie { trie } } }

    it 'initializes default collator if locale is not specified' do
      Collator.new.locale.should be_nil
    end

    it 'initialized tailored collator if locale is provided' do
      Collator.new(:ru).locale.should == :ru
    end

    it 'converts locale' do
      Collator.new(:no).locale.should == :nb
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

    before(:each) { stub(TrieBuilder).load_trie { trie } }
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

    before(:each) { stub(TrieBuilder).load_trie { trie } }

    it 'compares strings by sort keys' do
      stub_sort_key(collator, 'foo', sort_key)
      stub_sort_key(collator, 'bar', another_sort_key)

      collator.compare('foo', 'bar').should == -1
      collator.compare('bar', 'foo').should == 1
    end

    it 'returns 0 without computing sort keys if the strings are equal' do
      dont_allow(collator).get_sort_key

      collator.compare('foo', 'foo').should == 0
    end
  end

  describe '#sort' do
    let(:collator) { Collator.new }

    before(:each) { stub(TrieBuilder).load_trie { trie } }

    it 'sorts strings by sort keys' do
      [['aaa', [1, 2, 3]], ['abc', [1, 3, 4]], ['bca', [2, 5, 9]]].each { |s, key| mock_sort_key(collator, s, key) }

      collator.sort(%w[bca aaa abc]).should == %w[aaa abc bca]
    end
  end

  def mock_sort_key(collator, string, sort_key)
    mock(collator).get_sort_key(string) { sort_key }
  end

  def stub_sort_key(collator, string, sort_key)
    stub(collator).get_sort_key(string) { sort_key }
  end

end
