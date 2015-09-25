# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Collation

describe Collator do

  let(:trie) { Trie.new }

  before(:each) { clear_tries_cache }
  after(:all)   { clear_tries_cache }

  describe '.default_trie' do
    before(:each) do
      clear_default_trie_cache
      mock(TrieLoader).load_default_trie { trie }
    end

    it 'returns default fractional collation elements trie' do
      expect(Collator.default_trie).to eq(trie)
    end

    it 'loads the trie only once' do
      expect(Collator.default_trie.object_id).to eq(Collator.default_trie.object_id)
    end

    it 'locks the trie' do
      expect(Collator.default_trie).to be_locked
    end
  end

  describe '.tailored_trie' do
    let(:locale) { :ru }

    before(:each) do
      clear_tailored_tries_cache
      stub(Collator).default_trie { trie }
      mock(TrieLoader).load_tailored_trie(locale, Collator.default_trie) { trie }
    end

    it 'returns default fractional collation elements trie' do
      expect(Collator.tailored_trie(locale)).to eq(trie)
    end

    it 'loads the trie only once' do
      expect(Collator.tailored_trie(locale).object_id).to eq(Collator.tailored_trie(locale).object_id)
    end

    it 'locks the trie' do
      expect(Collator.tailored_trie(locale)).to be_locked
    end
  end

  describe '#initialize' do
    before :each do
      any_instance_of(Collator) { |c| stub(c).load_trie { trie } }
    end

    context 'without locale' do
      it 'initializes default collator' do
        expect(Collator.new.locale).to be_nil
      end
    end

    context 'with locale' do
      it 'initialized tailored collator with provided locale' do
        expect(Collator.new(:ru).locale).to eq(:ru)
      end

      it 'converts locale' do
        expect(Collator.new(:no).locale).to eq(:nb)
      end
    end
  end

  describe '#get_collation_elements' do
    let(:collator)           { Collator.new }
    let(:string)             { 'abc' }
    let(:code_points)        { [0x61, 0x62, 0x63] }
    let(:collation_elements) { [[39, 5, 5], [41, 5, 5], [43, 5, 5]] }

    before :each do
      any_instance_of(TwitterCldr::Shared::CodePoint) do |instance|
        stub(instance).combining_class_for { 0 }
      end
    end

    it 'returns collation elements for a string' do
      expect(collator.get_collation_elements(string)).to eq(collation_elements)
    end

    it 'returns collation elements for an array of code points (represented as hex strings)' do
      expect(collator.get_collation_elements(code_points)).to eq(collation_elements)
    end
  end

  describe '#get_sort_key' do
    let(:collator)           { Collator.new }
    let(:string)             { 'abc' }
    let(:code_points)        { [0x61, 0x62, 0x63] }
    let(:collation_elements) { [[39, 5, 5], [41, 5, 5], [43, 5, 5]] }
    let(:sort_key)           { [39, 41, 43, 1, 7, 1, 7] }

    before(:each) { mock(TrieLoader).load_default_trie { trie } }

    describe 'calculating sort key' do
      before(:each) { mock(TwitterCldr::Collation::SortKeyBuilder).build(collation_elements, case_first: nil, maximum_level: nil) { sort_key } }

      it 'calculates sort key for a string' do
        mock(collator).get_collation_elements(string) { collation_elements }
        expect(collator.get_sort_key(string)).to eq(sort_key)
      end

      it 'calculates sort key for an array of code points (represented as hex strings)' do
        mock(collator).get_collation_elements(code_points) { collation_elements }
        expect(collator.get_sort_key(code_points)).to eq(sort_key)
      end
    end

    describe 'uses tailoring options' do
      let(:case_first)    { :upper }
      let(:locale)        { :uk }
      let(:maximum_level) { 2 }
      
      it 'passes case-first sort option to sort key builder' do
        mock(TwitterCldr::Collation::TrieLoader).load_tailored_trie(locale, trie) { Trie.new }
        mock(TwitterCldr::Collation::TrieBuilder).tailoring_data(locale) { { collator_options: { case_first: case_first } } }

        collator = Collator.new(locale)

        mock(collator).get_collation_elements(code_points) { collation_elements }
        mock(TwitterCldr::Collation::SortKeyBuilder).build(collation_elements, case_first: case_first, maximum_level: nil) { sort_key }

        expect(collator.get_sort_key(code_points)).to eq(sort_key)
      end

      it 'passes maximum_level option to sort key builder' do 
        mock(TwitterCldr::Collation::TrieLoader).load_tailored_trie(locale, trie) { Trie.new }
        mock(TwitterCldr::Collation::TrieBuilder).tailoring_data(locale) { { collator_options: { case_first: case_first } } }

        collator = Collator.new(locale)

        mock(collator).get_collation_elements(code_points) { collation_elements }
        mock(TwitterCldr::Collation::SortKeyBuilder).build(collation_elements, case_first: case_first, maximum_level: maximum_level) { sort_key }

        expect(collator.get_sort_key(code_points, maximum_level: maximum_level)).to eq(sort_key)
      end

    end
  end

  describe '#compare' do
    let(:collator)         { Collator.new }
    let(:sort_key)         { [1, 3, 8, 9] }
    let(:another_sort_key) { [6, 8, 9, 2] }

    before(:each) { stub(Collator).default_trie { trie } }

    it 'compares strings by sort keys' do
      stub_sort_key(collator, 'foo', sort_key)
      stub_sort_key(collator, 'bar', another_sort_key)

      expect(collator.compare('foo', 'bar')).to eq(-1)
      expect(collator.compare('bar', 'foo')).to eq(1)
    end

    it 'returns 0 without computing sort keys if the strings are equal' do
      dont_allow(collator).get_sort_key

      expect(collator.compare('foo', 'foo')).to eq(0)
    end
  end

  describe 'sorting' do
    let(:collator)  { Collator.new }
    let(:sort_keys) { [['aaa', [1, 2, 3]], ['abc', [1, 3, 4]], ['bca', [2, 5, 9]]] }
    let(:array)     { %w[bca aaa abc] }
    let(:sorted)    { %w[aaa abc bca] }

    before :each do
      stub(Collator).default_trie { trie }
      sort_keys.each { |s, key| mock_sort_key(collator, s, key) }
    end

    describe '#sort' do
      it 'sorts strings by sort keys' do
        expect(collator.sort(array)).to eq(sorted)
      end

      it 'does not change the original array' do
        expect { collator.sort(array) }.not_to change { array }
      end
    end

    describe '#sort!' do
      it 'sorts strings array by sort keys in-place ' do
        collator.sort!(array)
        expect(array).to eq(sorted)
      end
    end
  end

  describe 'tailoring support' do
    before(:each) do
      stub(TwitterCldr).get_resource(:collation, :tailoring, locale) { YAML.load(tailoring_resource_stub) }

      mock(File).open(TrieBuilder::FRACTIONAL_UCA_SHORT_PATH, 'r') do |*args|
        args.last.call(fractional_uca_short_stub)
      end

      mock(TrieLoader).load_default_trie { TrieBuilder.load_default_trie }
      mock(TrieLoader).load_tailored_trie.with_any_args { |*args| TrieBuilder.load_tailored_trie(*args) }

      stub(TwitterCldr::Normalization).normalize_code_points { |code_points| code_points }
    end

    let(:locale)            { :some_locale }
    let(:default_collator)  { Collator.new }
    let(:tailored_collator) { Collator.new(locale) }

    describe 'tailoring rules support' do
      it 'tailored collation elements are used' do
        expect(default_collator.get_collation_elements([0x490])).to  eq([[0x5C1A, 5, 0x93], [0, 0xDBB9, 9]])
        expect(tailored_collator.get_collation_elements([0x490])).to eq([[0x5C1B, 5, 0x86]])

        expect(default_collator.get_collation_elements([0x491])).to  eq([[0x5C1A, 5, 9], [0, 0xDBB9, 9]])
        expect(tailored_collator.get_collation_elements([0x491])).to eq([[0x5C1B, 5, 5]])
      end

      it 'original contractions for tailored elements are applied' do
        expect(default_collator.get_collation_elements([0x491, 0x306])).to  eq([[0x5C, 0xDB, 9]])
        expect(tailored_collator.get_collation_elements([0x491, 0x306])).to eq([[0x5C, 0xDB, 9]])
      end
    end

    describe 'contractions suppressing support' do
      it 'suppressed contractions are ignored' do
        expect(default_collator.get_collation_elements([0x41A, 0x301])).to  eq([[0x5CCC, 5, 0x8F]])
        expect(tailored_collator.get_collation_elements([0x41A, 0x301])).to eq([[0x5C6C, 5, 0x8F], [0, 0x8D, 5]])
      end

      it 'non-suppressed contractions are used' do
        expect(default_collator.get_collation_elements([0x415, 0x306])).to  eq([[0x5C36, 5, 0x8F]])
        expect(tailored_collator.get_collation_elements([0x415, 0x306])).to eq([[0x5C36, 5, 0x8F]])
      end
    end

    let(:fractional_uca_short_stub) do
<<END
# collation elements from default fractional collation elements table
0301; [, 8D, 05]
0306; [, 91, 05]
041A; [5C 6C, 05, 8F] # К
0413; [5C 1A, 05, 8F] # Г
0415; [5C 34, 05, 8F] # Е

# tailored (in UK locale) with "Г < ґ <<< Ґ"
0491; [5C 1A, 05, 09][, DB B9, 09] # ґ
0490; [5C 1A, 05, 93][, DB B9, 09] # Ґ

# contraction for a tailored collation element
0491 0306; [5C, DB, 09] # ґ̆

# contractions suppressed in tailoring (for RU locale)
041A 0301; [5C CC, 05, 8F] # Ќ
0413 0301; [5C 30, 05, 8F] # Ѓ

# contractions non-suppressed in tailoring
0415 0306; [5C 36, 05, 8F] # Ӗ
END
    end

    let(:tailoring_resource_stub) do
<<END
---
:tailored_table: ! '0491; [5C1B, 5, 5]

  0490; [5C1B, 5, 86]'
:suppressed_contractions: ГК
...
END
    end

  end

  def mock_sort_key(collator, string, sort_key)
    mock(collator).get_sort_key(string) { sort_key }
  end

  def stub_sort_key(collator, string, sort_key)
    stub(collator).get_sort_key(string) { sort_key }
  end

  def clear_tries_cache
    clear_default_trie_cache
    clear_tailored_tries_cache
  end

  def clear_default_trie_cache
    Collator.instance_variable_set(:@default_trie, nil)
  end

  def clear_tailored_tries_cache
    Collator.instance_variable_set(:@tailored_tries_cache, nil)
  end

end
