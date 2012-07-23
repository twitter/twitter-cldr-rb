# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Collation

describe TrieLoader do

  describe '.load_default_trie' do
    let(:root)        { 42 }
    let(:trie)        { Trie.new(root).tap { |t| t.lock } }
    let(:trie_dump)   { Marshal.dump(trie) }
    let(:loaded_trie) { TrieLoader.load_default_trie }
    let(:locale)      { TrieLoader::DEFAULT_TRIE_LOCALE }

    before(:each) { mock_trie_dump }

    it 'loads a Trie' do
      loaded_trie.should be_instance_of(Trie)
    end

    it 'loads trie root' do
      loaded_trie.instance_variable_get(:@root).should == root
    end

    it 'loads trie as unlocked' do
      loaded_trie.should_not be_locked
    end
  end

  describe '.load_tailored_trie' do
    let(:root)              { 42 }
    let(:original_fallback) { 13 }
    let(:new_fallback)      { 37 }
    let(:trie)              { TrieWithFallback.new(original_fallback).tap { |t| t.lock.instance_variable_set(:@root, root) } }
    let(:locale)            { :ru }
    let(:trie_dump)         { Marshal.dump(trie) }
    let(:loaded_trie)       { TrieLoader.load_tailored_trie(locale, new_fallback) }

    before(:each) { mock_trie_dump }

    it 'loads a TrieWithFallback' do
      loaded_trie.should be_instance_of(TrieWithFallback)
    end

    it 'loads trie root' do
      loaded_trie.instance_variable_get(:@root).should == root
    end

    it 'loads trie as unlocked' do
      loaded_trie.should_not be_locked
    end

    it 'sets trie fallback' do
      loaded_trie.fallback.should == new_fallback
    end
  end

  describe '.dump_path' do
    it 'returns path to a trie dump for a specific locale' do
      TrieLoader.dump_path(:foo).should == File.join(TwitterCldr::RESOURCES_DIR, 'collation', 'tries', 'foo.dump')
    end
  end

  def mock_trie_dump
    mock(File).open(TrieLoader.dump_path(locale), 'r') { |*args| args.last.call(trie_dump) }
  end

end