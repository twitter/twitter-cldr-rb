# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

require 'fileutils'
require 'securerandom'
require 'tmpdir'

include TwitterCldr::Utils

describe FileSystemTrie do
  let(:tmp_dir) do
    File.join(Dir.tmpdir, SecureRandom.hex)
  end

  let(:trie) { FileSystemTrie.new(tmp_dir) }

  before(:each) do
    FileUtils.mkdir_p(tmp_dir)
  end

  after(:each) do
    FileUtils.rm_rf(tmp_dir)
  end

  describe '#empty?' do
    it 'returns true if the trie is empty' do
      expect(trie).to be_empty
    end

    it 'returns false if the trie is not empty' do
      trie.add(%w(foo bar), 'baz')
      expect(trie).to_not be_empty
    end
  end

  describe '#add' do
    it 'creates a nested folder structure' do
      trie.add(%w(foo bar baz), 'boo')
      path = Pathname(tmp_dir)
        .join('foo/bar/baz')
        .join(FileSystemTrie::VALUE_FILE)

      expect(path).to exist
    end

    it 'adds the entry to the trie' do
      key = %w(foo bar baz)
      trie.add(key, 'boo')
      expect(trie.get(key)).to eq('boo')
    end
  end

  describe '#set' do
    it "adds an entry to the trie if the key doesn't exist" do
      key = %w(foo bar baz)
      trie.set(key, 'boo')
      expect(trie.get(key)).to eq('boo')
    end

    it 'updates the entry in the trie if the key already exists' do
      key = %w(foo bar baz)
      trie.add(key, 'boo')
      expect(trie.get(key)).to eq('boo')
      trie.set(key, 'blarg')
      expect(trie.get(key)).to eq('blarg')
    end
  end

  describe '#get' do
    let(:key) { %w(foo bar baz) }

    before(:each) do
      trie.add(key, 'boo')
    end

    it 'retrieves the value at the given key' do
      expect(trie.get(key)).to eq('boo')
    end
  end

  describe '#get_node' do
    let(:key) { %w(foo bar baz) }

    before(:each) do
      trie.add(key, 'boo')
    end

    it 'retrieves the trie node at the given path' do
      node = trie.get_node(key)
      expect(node).to be_a(FileSystemTrie::Node)
      expect(node.value).to eq('boo')
    end
  end
end
