# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Collation

describe Collator do

  let(:trie) { Trie.new }

  before(:each) { clear_fce_tries_cache }
  after(:all)   { clear_fce_tries_cache }

  describe '.default_fce_trie' do
    before(:each) do
      clear_default_fce_trie_cache
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

  describe '.tailored_fce_trie' do
    let(:locale) { :ru }

    before(:each) do
      clear_tailored_fce_tries_cache
      stub(Collator).default_fce_trie { trie }
      mock(TrieBuilder).load_tailored_trie(locale, Collator.default_fce_trie) { trie }
    end

    it 'returns default fractional collation elements trie' do
      Collator.tailored_fce_trie(locale).should == trie
    end

    it 'loads the trie only once' do
      Collator.tailored_fce_trie(locale).object_id.should == Collator.tailored_fce_trie(locale).object_id
    end

    it 'locks the trie' do
      Collator.tailored_fce_trie(locale).should be_locked
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

    before(:each) { stub(Collator).default_fce_trie { trie } }

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

  describe 'sorting' do
    let(:collator)  { Collator.new }
    let(:sort_keys) { [['aaa', [1, 2, 3]], ['abc', [1, 3, 4]], ['bca', [2, 5, 9]]] }
    let(:array)     { %w[bca aaa abc] }
    let(:sorted)    { %w[aaa abc bca] }

    before :each do
      stub(Collator).default_fce_trie { trie }
      sort_keys.each { |s, key| mock_sort_key(collator, s, key) }
    end

    describe '#sort' do
      it 'sorts strings by sort keys' do
        collator.sort(array).should == sorted
      end

      it 'does not change the original array' do
        lambda { collator.sort(array) }.should_not change { array }
      end
    end

    describe '#sort!' do
      it 'sorts strings array by sort keys in-place ' do
        collator.sort!(array)
        array.should == sorted
      end
    end
  end

  def mock_sort_key(collator, string, sort_key)
    mock(collator).get_sort_key(string) { sort_key }
  end

  def stub_sort_key(collator, string, sort_key)
    stub(collator).get_sort_key(string) { sort_key }
  end

  def clear_fce_tries_cache
    clear_default_fce_trie_cache
    clear_tailored_fce_tries_cache
  end

  def clear_default_fce_trie_cache
    Collator.instance_variable_set(:@default_fce_trie, nil)
  end

  def clear_tailored_fce_tries_cache
    Collator.instance_variable_set(:@tailored_fce_tries_cache, nil)
  end

end
